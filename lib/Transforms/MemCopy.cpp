#include "EQueue/Utils.h"
#define DEBUG_TYPE "mem-copy"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

///./bin/equeue-opt ../test/LoweringPipeline/affine_tile.mlir -allocate-mem="structs-names=pe_array@mem indices=0 mem-names=ibuffer sizes=1"

/// ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=ibuffer dest=pe_array@pe_ibuffer dma=dma indices=8"
///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=wbuffer,ibuffer dest=pe_array@pe_wbuffer,pe_array@pe_ibuffer dma=dma,dma indices=8,12" 

struct MemoryCopy : public PassWrapper<MemoryCopy, FunctionPass>  {

  ListOption<std::string> src_names {*this, "src", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> dest_names {*this, "dest", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> dma_names {*this, "dma", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("indices in post order to decide where to insert memcpy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> insertion_points {*this, "insertions", llvm::cl::desc("insertion points"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> is_src {*this, "is-src", llvm::cl::desc("1 to denote load/store change to memcpy src, 0 otherwise"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
 
  MemoryCopy() = default;
  MemoryCopy(const MemoryCopy& pass) {}



  //Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
  
  GenericStructure generic;
  //llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  //llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  //llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

} // end anonymous namespace
void getReadWriteOp(Operation *userOp, SmallVector<Operation *, 16>& readWriteOps){
      for(auto u: userOp->getResult(0).getUsers()){
        if(dyn_cast<linalg::ReshapeOp>(u) || dyn_cast<SubViewOp>(u) ){
          getReadWriteOp(u, readWriteOps);
        }
        else if(dyn_cast<xilinx::equeue::MemReadOp>(u) || dyn_cast<xilinx::equeue::MemWriteOp>(u)){
          readWriteOps.push_back(u);
        }
      }
}
    
void MemoryCopy::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  //TODO: build value map first
  generic.buildIdMap(f);
  
  
  //pre-order transversal
  llvm::SmallVector<Region *, 20> regions;
  walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
    regions.push_back(&region);
  });
  //the first region is funcop region
  regions.erase(regions.begin());

  std::vector<std::vector<std::string>> srcs;
  trancate(srcs, src_names);

  std::vector<std::vector<std::string>> dests;
  trancate(dests, dest_names);

  std::vector<std::vector<std::string>> dmas;
  trancate(dmas, dma_names);

  xilinx::equeue::LaunchOp launchOp;
  for(xilinx::equeue::LaunchOp op : f.getOps<xilinx::equeue::LaunchOp>()){
    launchOp = op;
    break;
  }
  auto accel = launchOp.getRegion().front().getArgument(0);
  auto accel_original = launchOp.getLaunchOperands()[0];

  for(auto i = 0; i < indices.size(); i++){

    auto region = regions[indices[i]];
    auto src_structs = srcs[i];
    auto dest_structs = dests[i];
    auto dma_structs = dmas[i];
    auto iter = region->front().begin();
    if(insertion_points.size() > 0){
      for(int j = 0; j < insertion_points[i]; j++){
        iter++;
      }
    }

    SmallVector<Operation *, 16> readWriteOps;
    if(is_src.size()==0 || is_src[i]){
      Value dest_defining = generic.getField(builder, region, dest_structs, 0, accel_original);
      Operation* userOp = dest_defining.getDefiningOp();
      getReadWriteOp(userOp, readWriteOps);
    }else{
      Value src_defining = generic.getField(builder, region, src_structs, 0, accel_original);
      Operation* userOp = src_defining.getDefiningOp();
      getReadWriteOp(userOp, readWriteOps);
    }
        
    for(auto rw_op: readWriteOps){
      Value mem;
      builder.setInsertionPoint(rw_op);
      if(is_src.size()==0 || is_src[i]){
        mem = generic.getField(builder, region, src_structs, 0, accel, accel_original);
      }else{
        mem = generic.getField(builder, region, dest_structs, 0, accel, accel_original);
      }
      if(dyn_cast<xilinx::equeue::MemReadOp>(rw_op)){
        rw_op->setOperand(0, mem);
      }else{
        rw_op->setOperand(1, mem);
      }
    }
    builder.setInsertionPoint(&region->front(), iter);
    auto src = generic.getField(builder, region, src_structs, 0, accel, accel_original);
    auto dest = generic.getField(builder, region, dest_structs, 0, accel, accel_original);
    auto dma = generic.getField(builder, region, dma_structs, 0, accel, accel_original);
    ScopedContext scope(builder, region->getLoc());
    Value start_cpy = start_op();
    memcpy_op(start_cpy, src, dest, dma);
 
  }
  llvm::outs()<<launchOp<<"\n";

}


void equeue::registerMemCopyPass() {
    PassRegistration<MemoryCopy>(
      "mem-copy",
      "...");
}
