/*#include "EQueue/EQueuePasses.h"
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
using namespace mlir::edsc::intrinsics;*/
#include "EQueue/Utils.h"

#define DEBUG_TYPE "allocate-mem"

namespace {

///./bin/equeue-opt ../test/LoweringPipeline/affine_tile.mlir -allocate-mem="structs-names=pe_array@mem indices=0 mem-names=ibuffer sizes=1"
///  ./bin/equeue-opt ../test/LoweringPipeline/affine_tile.mlir -allocate-mem="structs-names=mem,pe_array@mem indices=0,0 mem-names=ibuffer,pe_ibuffer sizes=49,1"  > ../test/LoweringPipeline/allocate_ibuffer.mlir
/// ./bin/equeue-opt ../test/LoweringPipeline/allocate_ibuffer.mlir -allocate-mem="structs-names=mem,pe_array@mem indices=0,0 mem-names=wbuffer,pe_wbuffer sizes=25,1"

struct AllocateMemory : public PassWrapper<AllocateMemory, FunctionPass>  {

  ListOption<std::string> structs_names {*this, "structs-names", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  ListOption<std::string> mem_names {*this, "mem-names", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  ListOption<unsigned> sizes {*this, "sizes", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("give index in post order decide where to insert allocation"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  AllocateMemory() = default;
  AllocateMemory(const AllocateMemory& pass) {}
  
  void allocation(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  void deallocation(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);


  void runOnFunction() override;
  
  GenericStructure generic;
  llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;

};

} // end anonymous namespace

void AllocateMemory::allocation(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent){
  ScopedContext scope(builder, region->getLoc());
  
  Value new_original_parent = comps_tree[original_parent][structs[j]];
  auto original_type = new_original_parent.getType();
  Value new_parent = get_comp(parent, structs[j], original_type);

  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector
    new_original_parent = new_original_parent.getDefiningOp()->getOperand(0);
    
    SmallVector<int64_t, 4> lowerBounds(vector_type.getRank(), 0);
    SmallVector<int64_t, 4> steps(vector_type.getRank(), 1);
    buildAffineLoopNest(
        builder, new_parent.getDefiningOp()->getLoc(), lowerBounds, vector_type.getShape(), steps,
        [&](OpBuilder &nestedBuilder, Location loc, ValueRange ivs) {
  
          new_parent = nestedBuilder.create<mlir::ExtractElementOp>(loc, new_parent, ivs).getResult();
        });

    AffineForOp affineOp = cast<AffineForOp>(new_parent.getParentRegion()->getParentOp());
    region = &affineOp.getLoopBody();
    builder.setInsertionPointAfter(&affineOp.getLoopBody().front().front());

  }
  if(j!=structs.size()-1){
    allocation(builder, region, idx, structs, j+1, new_parent, new_original_parent);
  }else{
    Value buffer = alloc_op(new_parent, ArrayRef<int64_t>{ sizes[idx] }, 32, builder.getF32Type());
    add_comp(parent, mem_names[idx], buffer);
    comps_tree[original_parent].insert(std::make_pair(mem_names[idx], buffer));
  }
}



void AllocateMemory::deallocation(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent){
  ScopedContext scope(builder, region->getLoc());

  original_parent = comps_tree[original_parent][structs[j]];
  auto original_type = original_parent.getType();
  parent = get_comp(parent, structs[j], original_type);


  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector
    original_parent = original_parent.getDefiningOp()->getOperand(0);
    
    SmallVector<int64_t, 4> lowerBounds(vector_type.getRank(), 0);
    SmallVector<int64_t, 4> steps(vector_type.getRank(), 1);
    buildAffineLoopNest(
        builder, parent.getDefiningOp()->getLoc(), lowerBounds, vector_type.getShape(), steps,
        [&](OpBuilder &nestedBuilder, Location loc, ValueRange ivs) {
  
          parent = nestedBuilder.create<mlir::ExtractElementOp>(loc, parent, ivs).getResult();
        });

    AffineForOp affineOp = cast<AffineForOp>(parent.getParentRegion()->getParentOp());
    region = &affineOp.getLoopBody();
    builder.setInsertionPointAfter(&affineOp.getLoopBody().front().front());

  }

  if(j!=structs.size()-1){
    deallocation(builder, region, idx, structs, j+1, parent, original_parent);
  }else{
    dealloc_op(ValueRange{parent});
  }
}



void AllocateMemory::runOnFunction() {
  auto f = getFunction();
  MLIRContext *context = &getContext();
  OpBuilder builder(context);
  generic.buildIdMap(f);
  valueIds = generic.valueIds;
  vectorIds = generic.vectorIds;
  comps_tree = generic.comps_tree;
  
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
    
  for(auto i = 0; i < indices.size(); i++){
    auto structs = structs_list[i];
    auto region = regions[indices[i]];
    builder.setInsertionPointToStart(&region->front());
    
    
    allocation(builder, region, i, structs, 0, accel, accel_original);
    
    structs[structs.size()-1]=mem_names[i];
    auto iter = Block::iterator(region->back().getTerminator());
    iter--;
    builder.setInsertionPointAfter(&*iter );
    deallocation(builder, region, i, structs, 0, accel, accel_original);
 
  }

}


void equeue::registerAllocatePass() {
    PassRegistration<AllocateMemory>(
      "allocate-mem",
      "...");
}
