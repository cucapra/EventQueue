#include "EQueue/Utils.h"
#define DEBUG_TYPE "merge-memcopy-launch"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 


struct MergeMemCopyLaunch : public PassWrapper<MergeMemCopyLaunch, FunctionPass>  {

  ListOption<unsigned> launch_indices {*this, "launch", llvm::cl::desc("indices of launch (post order)"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> memcpy_indices {*this, "memcpy", llvm::cl::desc("indices of memcpy (post order)"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  //ListOption<unsigned> ignore {*this, "ignore", llvm::cl::desc("1 to ignore read, 2 to ignore write, 0 for nothing"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  MergeMemCopyLaunch() = default;
  MergeMemCopyLaunch(const MergeMemCopyLaunch& pass) {}
  
  void runOnFunction() override;
  
  GenericStructure generic;
};

} // end anonymous namespace

Value getReadOp(Region* region, Value src, llvm::DenseMap<mlir::Value, mlir::Value> &valueIds){
  for(auto iter = valueIds.begin(); iter != valueIds.end(); iter++){
    if(iter->second==valueIds[src] && iter->second!=iter->first){
      //iter->first: getCompOp
      for(auto u: iter->first.getDefiningOp()->getResult(0).getUsers()){
        if(u->getParentRegion()==region && dyn_cast<equeue::MemReadOp>(u)){
          return u->getResult(0);
        }
      }
    }
  }
  return Value();
}

void MergeMemCopyLaunch::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  generic.buildIdMap(f);
  
  SmallVector<equeue::MemCopyOp, 16> memcpyOps;
  f.walk([&](equeue::MemCopyOp op) {
    memcpyOps.push_back(op);
  });
  SmallVector<equeue::LaunchOp, 16> launchOps;
  f.walk([&](equeue::LaunchOp op) {
    launchOps.push_back(op);
  });
  
  for(auto i = 0; i < launch_indices.size(); i++){

    auto memcpyOp = memcpyOps[memcpy_indices[i]];
    auto launchOp = launchOps[launch_indices[i]];
    
    auto signal = launchOp.getOperand(0);
    auto src = memcpyOp.getSrcBuffer();
    auto dest = memcpyOp.getDestBuffer();
    auto dma = memcpyOp.getDMAHandler();
    SmallVector<int64_t,16> size;
    if(memcpyOp.getAttr("size")){
      for(auto s: memcpyOp.getAttr("size").cast<DenseIntElementsAttr>().getValues<int64_t>()){
        size.push_back(s);
      }
    }
    
    ScopedContext scope(builder, launchOp.getRegion().getLoc());
    Value tensor = getReadOp(&launchOp.getRegion(), src, generic.valueIds);
    if( tensor ==Value() ){
      builder.setInsertionPointToStart(&launchOp.getRegion().front());
      if(size.empty()){
        tensor = read_op(src);
      }else{
        tensor = read_op(src, size);
      }
    }
    //}
    builder.setInsertionPoint(&*(--launchOp.getRegion().front().end() ) );
    if(size.empty()){
      write_op(tensor, src);
    }else{
      write_op(tensor, src, size);
    }
    
    memcpyOp.erase();
  }

}


void equeue::registerMergeMemCopyLaunchPass() {
    PassRegistration<MergeMemCopyLaunch>(
      "merge-memcpy-launch",
      "...");
}
