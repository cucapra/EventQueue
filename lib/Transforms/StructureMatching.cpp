
#include "EQueue/Utils.h"

#define DEBUG_TYPE "structure-matching"



///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/memcpy.mlir -match-equeue-structure="indices=8 structs-names=pe_array@proc from=0 to=5" > ../test/LoweringPipeline/match_struct.mlir


struct StructureMatchingPass: public PassWrapper<StructureMatchingPass, FunctionPass> {

  ListOption<std::string> structs_names {*this, "structs-names", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("region index in post order to decide where to insert launch"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> from {*this, "from", llvm::cl::desc("block iterator in post order to decide start copy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> to {*this, "to", llvm::cl::desc("block iterator in post order to decide end copy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  StructureMatchingPass()=default; 
  StructureMatchingPass(const StructureMatchingPass& pass) {}
  
  void runOnFunction() override;
  GenericStructure generic;
};

void StructureMatchingPass::runOnFunction() {
    auto f = getFunction();
    MLIRContext *context = &getContext();
    OpBuilder builder(context);
    generic.buildIdMap(f);
    
    //pre-order transversal
    llvm::SmallVector<Region *, 20> regions;
    walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
      regions.push_back(&region);
    });
  
    //the first region is funcop region
    regions.erase(regions.begin());

    
    std::vector<std::vector<std::string>> structs_list;
    trancate(structs_list, structs_names);

    xilinx::equeue::LaunchOp launchOp;
    for(xilinx::equeue::LaunchOp op : f.getOps<xilinx::equeue::LaunchOp>()){
      launchOp = op;
      break;
    }
    auto accel = launchOp.getRegion().front().getArgument(0);
    auto accel_original = launchOp.getLaunchOperands()[0];
    for (auto i = 0; i < indices.size(); i++){

      auto region = regions[indices[i]];

      auto structs = structs_list[i];
      auto launch_next = region->front().begin();//++Block::iterator(launch_operation);
      auto start_it = launch_next, end_it=launch_next;
      if(from.size()>0){
        for(int j = 0; j < to[i]; j++){
          if(j<from[i]) start_it++;
          end_it++;
        }
      }else{
        end_it = --region->back().end();
      }
      builder.setInsertionPoint(&*start_it);
      
      SmallVector<Operation *, 16> operands;
      for(auto iter = start_it; iter!=end_it; iter++){
        operands.push_back(&*iter);
      }
      
      SmallVector<Value, 16> results;
      for(auto iter = start_it; iter!=end_it; iter++ ){
        for(auto v: iter->getResults() ){
          // if not all user of the result is in launch block
          if(llvm::all_of(v.getUsers(), [&](Operation *user){
            return llvm::any_of(operands, [&](Operation *inlaunch_user){
              return user==inlaunch_user;
            });
          }) == false){ 
            results.push_back(v);
          }
        }
      }
      
      auto proc = generic.getField(builder, region, structs, 0, accel, accel_original);
      ScopedContext scope(builder, region->getLoc());
      Value signal = start_op();
      ValueRange invaluerange;//TODO: analyze live in
      ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
        return_op(ValueRange{results});
      });
      auto *launch_operation = pe_res[0].getDefiningOp();
      
      for(auto iter = start_it; iter!=end_it; ){
        auto iter2=iter;
        iter++;
        iter2->moveBefore(&*(--launch_operation->getRegion(0).front().end()));//equeue.return
      }
      
      for(int i = 1; i < pe_res.size(); i++){
        results[i-1].replaceUsesWithIf(pe_res[i], [&](OpOperand &operand){
          return &launch_operation->getRegion(0).front()!=operand.getOwner()->getBlock();
        });
      }
      
    }

} // end anonymous namespace

void equeue::registerStructureMatchingPass() {
    PassRegistration<StructureMatchingPass>(
      "match-equeue-structure",
      "add structure to parallel op");
}
