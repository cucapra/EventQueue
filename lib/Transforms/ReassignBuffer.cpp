#include "EQueue/Utils.h"
#define DEBUG_TYPE "reassign-buffer"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

///./bin/equeue-opt ../test/LoweringPipeline/affine_tile.mlir -allocate-mem="structs-names=pe_array@mem indices=0 mem-names=ibuffer sizes=1"

/// ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=ibuffer dest=pe_array@pe_ibuffer dma=dma indices=8"
///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/allocate_wbuffer.mlir -mem-copy="src=wbuffer,ibuffer dest=pe_array@pe_wbuffer,pe_array@pe_ibuffer dma=dma,dma indices=8,12" 

struct ReassignBuffer : public PassWrapper<ReassignBuffer, FunctionPass>  {
  ListOption<std::string> old_buffer_names {*this, "old-buffer", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> new_buffer_names {*this, "new-buffer", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("indices in post order to decide where to insert memcpy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
 
  ReassignBuffer() = default;
  ReassignBuffer(const ReassignBuffer& pass) {}



  //Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  
  void runOnFunction() override;
  
  GenericStructure generic;
  //llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  //llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  //llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

} // end anonymous namespace
void getReadWriteOp(Operation *userOp, Region* region, SmallVector<Operation *, 16>& readWriteOps, llvm::DenseMap<mlir::Value, mlir::Value> &valueIds){
  for(auto u: userOp->getResult(0).getUsers()){
    if(dyn_cast<linalg::ReshapeOp>(u) || dyn_cast<SubViewOp>(u) ){
      getReadWriteOp(u, region, readWriteOps, valueIds);
    }
    if(dyn_cast<xilinx::equeue::AddCompOp>(u)){
      for(auto iter = valueIds.begin(); iter != valueIds.end(); iter++){
        if(iter->second==userOp->getResult(0) && iter->second!=iter->first){
          getReadWriteOp(iter->first.getDefiningOp(), region, readWriteOps, valueIds);
        }
      }
    }
    else if(dyn_cast<xilinx::equeue::MemReadOp>(u) || dyn_cast<xilinx::equeue::MemWriteOp>(u)){
      if(u->getParentRegion()==region)
        readWriteOps.push_back(u);
    }
  }
}
    
void ReassignBuffer::runOnFunction() {

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


  std::vector<std::vector<std::string>> old_buffers;
  trancate(old_buffers, old_buffer_names);


  std::vector<std::vector<std::string>> new_buffers;
  trancate(new_buffers, new_buffer_names);
  
  xilinx::equeue::LaunchOp launchOp;
  for(xilinx::equeue::LaunchOp op : f.getOps<xilinx::equeue::LaunchOp>()){
    launchOp = op;
    break;
  }
  auto accel = launchOp.getRegion().front().getArgument(0);
  auto accel_original = launchOp.getLaunchOperands()[0];

  for(auto i = 0; i < indices.size(); i++){
    
    auto region = regions[indices[i]];
    auto new_buffer = new_buffers[i];
    auto old_buffer = old_buffers[i];
    //region->front().dump();
    SmallVector<Operation *, 16> readWriteOps;
    Value old_defining = generic.getField(builder, old_buffer, 0, accel_original);
    Operation* userOp = old_defining.getDefiningOp();
    getReadWriteOp(userOp, region, readWriteOps, generic.valueIds);

        
    for(auto rw_op: readWriteOps){
      Value mem;
      builder.setInsertionPoint(rw_op);
      mem = generic.getField(builder, region, new_buffer, 0, accel, accel_original);
      if(dyn_cast<xilinx::equeue::MemReadOp>(rw_op)){
        rw_op->setOperand(0, mem);
      }else{
        rw_op->setOperand(1, mem);
      }
    }
 
  }

}


void equeue::registerReassignBufferPass() {
    PassRegistration<ReassignBuffer>(
      "reassign-buffer",
      "...");
}
