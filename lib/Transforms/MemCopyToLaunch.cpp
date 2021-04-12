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

struct MemCopyToLaunch : public PassWrapper<MemCopyToLaunch, FunctionPass>  {

  //ListOption<std::string> src_names {*this, "src", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<std::string> dest_names {*this, "dest", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<std::string> dma_names {*this, "dma", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("indices in pre order to decide where to insert memcpy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<unsigned> insertion_points {*this, "insertions", llvm::cl::desc("insertion points"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<unsigned> is_src {*this, "to-launch", llvm::cl::desc("1 to denote load/store change to memcpy src, 0 otherwise"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<unsigned> is_src {*this, "is-src", llvm::cl::desc("1 to denote load/store change to memcpy src, 0 otherwise"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
 
  MemCopyToLaunch() = default;
  MemCopyToLaunch(const MemCopyToLaunch& pass) {}



  //Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  //void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
  
  //GenericStructure generic;
  //llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  //llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  //llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

} // end anonymous namespace

    
void MemCopyToLaunch::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  //TODO: build value map first
  //generic.buildIdMap(f);
  SmallVector<xilinx::equeue::MemCopyOp, 16> memcpyOps;
  
  f.walk([&](xilinx::equeue::MemCopyOp op) {
    memcpyOps.push_back(op);
  });
  
  for(auto i = 0; i < indices.size(); i++){

    auto memcpyOp = memcpyOps[indices[i]];
    builder.setInsertionPoint(memcpyOp);
    auto signal = memcpyOp.getOperand(0);
    auto src = memcpyOp.getSrcBuffer();
    auto dest = memcpyOp.getDestBuffer();
    auto dma = memcpyOp.getDMAHandler();
    SmallVector<int64_t,16> size;
    if(memcpyOp.getAttr("size")){
      for(auto s: memcpyOp.getAttr("size").cast<DenseIntElementsAttr>().getValues<int64_t>()){
        size.push_back(s);
      }
    }
    ScopedContext scope(builder, memcpyOp.getParentRegion()->getLoc());
    ValueRange pe_res = LaunchOpBuilder(signal, dma, ValueRange{src, dest}, [&](ValueRange ins){
      if(size.empty()){
        
        auto tensor = read_op(src);
        write_op(tensor, src);
      }else{
        auto tensor = read_op(src, size);
        write_op(tensor, src, size);
      }
      return_op(ValueRange{});
    });
    memcpyOp.erase();
  }

}


void equeue::registerMemCopyToLaunchPass() {
    PassRegistration<MemCopyToLaunch>(
      "memcpy-to-launch",
      "...");
}
