#include "EQueue/EQueuePasses.h"
#include "EQueue/EQueueOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Analysis/AffineAnalysis.h"
#include "mlir/Analysis/AffineStructures.h"
#include "mlir/Analysis/LoopAnalysis.h"
#include "mlir/Analysis/Utils.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Affine/Passes.h"
#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/Block.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Utils.h"
#include "mlir/Transforms/Passes.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
#include "llvm/ADT/SmallSet.h"
#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EQueue/EQueuePasses.h"
#include "EDSC/Intrinsics.h"
#include "mlir/Dialect/StandardOps/EDSC/Intrinsics.h"
#include "mlir/Dialect/Vector/EDSC/Intrinsics.h"
#include <map>
#include <queue>
using namespace mlir;
using namespace mlir::equeue;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
#define DEBUG_TYPE "mem-copy"

namespace { 

///./bin/equeue-opt ../test/LoweringPipeline/affine_tile.mlir -allocate-mem="structs-names=pe_array@mem indices=0 mem-names=ibuffer sizes=1"

/// ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=ibuffer dest=pe_array@pe_ibuffer dma=dma indices=8"
///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=wbuffer,ibuffer dest=pe_array@pe_wbuffer,pe_array@pe_ibuffer dma=dma,dma indices=8,12" 

struct MemoryCopy : public PassWrapper<MemoryCopy, FunctionPass>  {

  ListOption<std::string> src_names {*this, "src", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> dest_names {*this, "dest", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> dma_names {*this, "dma", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("give index in post order to decide where to insert memcpy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  MemoryCopy() = default;
  MemoryCopy(const MemoryCopy& pass) {}



  Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
  
  llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

} // end anonymous namespace

static std::vector<std::string> split(const std::string& str, const std::string& delim)
{
    std::vector<std::string> tokens;
    size_t prev = 0, pos = 0;
    do
    {
        pos = str.find(delim, prev);
        if (pos == std::string::npos) pos = str.length();
        std::string token = str.substr(prev, pos-prev);
        if (!token.empty()) tokens.push_back(token);
        prev = pos + delim.length();
    }
    while (pos < str.length() && prev < str.length());
    return tokens;
}

template <typename FuncT1, typename FuncT2>
void static walkRegions(MutableArrayRef<Region> regions, const FuncT1 &func1, const FuncT2 &func2) {
  for (Region &region : regions){
    func2(region);
    for (Block &block : region) {
      func1(block);
      // Traverse all nested regions.
      for (Operation &operation : block)
        walkRegions(operation.getRegions(), func1, func2);
    }
  }
}

void MemoryCopy::buildIdMap(mlir::FuncOp &toplevel){
  walkRegions(*toplevel.getCallableRegion(), [&](Block &block) {
    // build iter init_value map
    auto pop = block.getParentOp();
    if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(pop) ) {
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
        
        
        if(auto Op = llvm::dyn_cast<mlir::SplatOp>(operation)){
          vectorIds.insert({operation.getResult(0), valueIds[operation.getOperand(0)]});
        }
      }
    }
  }, [&](Region &region){ return; } );
}


Value MemoryCopy::getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent){
  ScopedContext scope(builder, region->getLoc());
  
  Value new_original_parent = comps_tree[original_parent][structs[j]];
  auto original_type = new_original_parent.getType();
  Value new_parent = get_comp(parent, structs[j], original_type);
  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector
    new_original_parent = new_original_parent.getDefiningOp()->getOperand(0);
    Value ivs = cast<AffineForOp>(new_parent.getParentRegion()->getParentOp()).getInductionVar();
    new_parent = std_extract_element(new_parent, ivs);
  }
  if(j!=structs.size()-1){
    return getField(builder, region, idx, structs, j+1, new_parent, new_original_parent);
  }else{
    return new_parent;
  }
}

void MemoryCopy::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  //TODO: build value map first
  buildIdMap(f);
  
  
  //pre-order transversal
  llvm::SmallVector<Region *, 20> regions;
  walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
    regions.push_back(&region);
  });


  //the first region is funcop region
  regions.erase(regions.begin());

  std::vector<std::vector<std::string>> srcs;
  for(auto structs_name: src_names){
    auto trancated_name = split(structs_name, "@");
    srcs.push_back(trancated_name);
  }
  std::vector<std::vector<std::string>> dests;
  for(auto structs_name: dest_names){
    auto trancated_name = split(structs_name, "@");
    dests.push_back(trancated_name);
  }
  std::vector<std::vector<std::string>> dmas;
  for(auto structs_name: dma_names){
    auto trancated_name = split(structs_name, "@");
    dmas.push_back(trancated_name);
  }
  xilinx::equeue::LaunchOp launchOp;
  for(xilinx::equeue::LaunchOp op : f.getOps<xilinx::equeue::LaunchOp>()){
    launchOp = op;
    break;
  }
  auto accel = launchOp.getRegion().front().getArgument(0);
  auto accel_original = launchOp.getLaunchOperands()[0];
//replaceAllUsesInRegionWith
  for(auto i = 0; i < indices.size(); i++){

    auto region = regions[indices[i]];
    auto src_structs = srcs[i];
    auto dest_structs = dests[i];
    auto dma_structs = dmas[i];
    builder.setInsertionPointToStart(&region->front());

    auto src = getField(builder, region, i, src_structs, 0, accel, accel_original);
    auto dest = getField(builder, region, i, dest_structs, 0, accel, accel_original);
    auto dma = getField(builder, region, i, dma_structs, 0, accel, accel_original);
    ScopedContext scope(builder, region->getLoc());
    Value start_cpy = start_op();
    memcpy_op(start_cpy, src, dest, dma);
 
  }

}


void equeue::registerMemCopyPass() {
    PassRegistration<MemoryCopy>(
      "mem-copy",
      "...");
}
