#include "EQueue/Utils.h"
using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;


void GenericStructure::buildIdMap(mlir::FuncOp &toplevel){
  walkRegions(*toplevel.getCallableRegion(), [&](Block &block) {
    // build iter init_value map
    auto pop = block.getParentOp();
    if( auto Op = llvm::dyn_cast<mlir::scf::ForOp>(pop) ) {
      auto arg_it = Op.getRegionIterArgs().begin();
      for ( Value operand : Op.getIterOperands() ){
        valueIds.insert({*arg_it, *arg_it});
        arg_it += 1;
      }
    } else if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(pop) ) {
      auto arg_it = block.args_begin();
      for ( Value operand : Op.getLaunchOperands() ){
        valueIds.insert({*arg_it, valueIds[operand]});
        arg_it += 1;
      }
    } else {
      for (BlockArgument argument : block.getArguments())
        valueIds.insert({argument, argument});
    }
    for (Operation &operation : block) {
      //get_comp operation
      if(auto Op = llvm::dyn_cast<xilinx::equeue::GetCompOp>(operation)){
          Value create_comp = valueIds[Op.getCompHandler()];
          auto name = Op.getName().str();
          Value comp = comps_tree[create_comp][name];
          valueIds.insert({operation.getResult(0), comp});
      }else if(auto Op = llvm::dyn_cast<mlir::ExtractElementOp>(operation)){
          valueIds.insert({operation.getResult(0), vectorIds[valueIds[operation.getOperand(0)]]});
      }else{
        std::string comp_string;
        unsigned offset = 0;
        Value comp;
        if(auto Op = llvm::dyn_cast<xilinx::equeue::CreateCompOp>(operation)){
          comp_string = Op.getNames().str();
          comp = Op.getResult();
          
          std::map<std::string, Value> comps;
          comps_tree.insert(std::make_pair(comp, comps));
        }else if(auto Op = llvm::dyn_cast<xilinx::equeue::AddCompOp>(operation)){
          comp_string = Op.getNames().str();
          comp = valueIds[Op.getOperand(0)];
          offset=1;
        }

        auto comp_names = split(comp_string, " ");
        
        for(int i = 0; i < comp_names.size(); i++){
          auto operand = operation.getOperand(i+offset);
          comps_tree[comp].insert(std::make_pair(comp_names[i], valueIds[operand]));
          //llvm::outs()<<comp_names[i]<<" "<<operand<<"\n";
        }
        
      
        for (Value result : operation.getResults()){
          valueIds.insert({result, result});
        }
        if(isa<mlir::scf::ForOp>(operation)||isa<xilinx::equeue::LaunchOp>(operation)) {
          int i = 0;
          if(isa<xilinx::equeue::LaunchOp>(operation)) i = 1;
          auto yieldOp = operation.getRegion(0).front().getTerminator();
          for(auto yieldRes: yieldOp->getOperands()){

            valueIds[operation.getResult(i)]=valueIds[yieldRes];
            i++;
          }
        }
        
        if(auto Op = llvm::dyn_cast<mlir::SplatOp>(operation)){
          vectorIds.insert({operation.getResult(0), valueIds[operation.getOperand(0)]});
        }
      }
    }
  }, [&](Region &region){ return; } );
}



Value GenericStructure::getField(OpBuilder builder, Region *region, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent){
  ScopedContext scope(builder, region->getLoc());
  std::size_t start = structs[j].find("[");
  std::size_t end = structs[j].rfind("]");
  std::string structure;
  if (start!=std::string::npos){
    assert(end!=std::string::npos && end > start);
    structure = structs[j].substr(0, start);
  }else{
    structure = structs[j];
  }
  Value new_original_parent = comps_tree[original_parent][structure];

  auto original_type = new_original_parent.getType();
  Value new_parent = get_comp(parent, structure, original_type);
  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector

    new_original_parent = new_original_parent.getDefiningOp()->getOperand(0);
    llvm::SmallVector<Value, 16> index;
    //if(start==std::string::npos){
    auto loopOp = new_parent.getParentRegion()->getParentOp();
    for(int k=0; k < vector_type.getShape().size(); ){
      if( isa<AffineForOp>(loopOp) ){
          index.push_back(cast<AffineForOp>(loopOp).getInductionVar());
          k++;
      }else if(isa<AffineForOp>(loopOp)){
        auto ivs = cast<AffineParallelOp>(loopOp).getIVs();
        for(auto iv: ivs){
          index.push_back(iv);
        }
        k+=ivs.size();
      }
      loopOp = loopOp->getParentOp();
    }
          
    //}else{
    if(start!=std::string::npos){
      auto specified_index = split(structs[j].substr(start+1,end-start-1), "][");
      for(int k = 0; k < specified_index.size(); k++){
        std::string sp = specified_index[k];
        if(sp!=":"&&sp[0]!='+'&&sp[0]!='-'){
          index[k]=std_constant_index(stoi(specified_index[k]));
        }else if(sp[0]=='+'){
          auto expr = getAffineDimExpr(0, builder.getContext()) + stoi(sp.substr(1));
          AffineMap m = AffineMap::get(/*dimCount=*/1, /*symbolCount=*/0, expr);
          index[k] =  affine_apply(m, ValueRange{index[k]} );
        }else if(sp[0]=='-'){
          auto expr = getAffineDimExpr(0, builder.getContext()) - stoi(sp.substr(1));
          AffineMap m = AffineMap::get(/*dimCount=*/1, /*symbolCount=*/0, expr);
          index[k] =  affine_apply(m, ValueRange{index[k]} );
        }
      }
    }
    new_parent = std_extract_element(new_parent, index);
  }
  if(j!=structs.size()-1){
    return getField(builder, region, structs, j+1, new_parent, new_original_parent);
  }else{
    return new_parent;//ArrayRef<Value>({new_parent, new_original_parent, parent, original_parent});
  }
}


Value GenericStructure::getField(OpBuilder builder, std::vector<std::string>& structs, unsigned j, Value original_parent){
  //ScopedContext scope(builder, region->getLoc());
  std::size_t start = structs[j].find("[");
  std::size_t end = structs[j].find("]");
  std::string structure;
  if (start!=std::string::npos){
    assert(end!=std::string::npos && end > start);
    structure = structs[j].substr(0, start);
  }else{
    structure = structs[j];
  }
  /*llvm::outs()<<structure<<"=======\n";
  for(auto iter = comps_tree[original_parent].begin(); iter!=comps_tree[original_parent].end(); iter++){
    llvm::outs()<<iter->first<<":::"<<iter->second<<"\n";
  }*/
  Value new_original_parent = comps_tree[original_parent][structure];
  auto original_type = new_original_parent.getType();

  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector
    new_original_parent = new_original_parent.getDefiningOp()->getOperand(0);
  }
  if(j!=structs.size()-1){
    return getField(builder, structs, j+1, new_original_parent);
  }else{
    return new_original_parent;//ArrayRef<Value>({new_parent, new_original_parent, parent, original_parent});
  }
}




