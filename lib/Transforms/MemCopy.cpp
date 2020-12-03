#include "EQueue/Utils.h"
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



  //Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
  
  GenericStructure generic;
  //llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  //llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  //llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

} // end anonymous namespace

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
//replaceAllUsesInRegionWith
  for(auto i = 0; i < indices.size(); i++){

    auto region = regions[indices[i]];
    auto src_structs = srcs[i];
    auto dest_structs = dests[i];
    auto dma_structs = dmas[i];
    builder.setInsertionPointToStart(&region->front());

    auto src = generic.getField(builder, region, i, src_structs, 0, accel, accel_original)[0];
    auto dest = generic.getField(builder, region, i, dest_structs, 0, accel, accel_original)[0];
    auto dma = generic.getField(builder, region, i, dma_structs, 0, accel, accel_original)[0];
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
