#include "EQueue/Utils.h"
#define DEBUG_TYPE "merge-loop"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

struct MergeLoop : public PassWrapper<MergeLoop, FunctionPass>  {


  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("loop index in post order to decide merge loop, size >=2"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  MergeLoop() = default;
  MergeLoop(const MergeLoop& pass) {}
  
  void runOnFunction() override;
};

} // end anonymous namespace

void MergeLoop::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  SmallVector<AffineForOp, 20> loops;
  //LoopLikeOpInterface
  f.walk([&](AffineForOp loop) {
    loops.push_back(loop);
  });
  //if(isa<AffineForOp>(loops[0])){
    int64_t bound = 1;
    for(auto index:indices){
      bound*=ceil((float)(loops[index].getConstantUpperBound()-loops[index].getConstantLowerBound())/(float)(loops[index].getStep()));
      loops[index].setConstantUpperBound(1);
    }
    loops[indices[0]].setConstantUpperBound(bound);
  
  //}

}


void equeue::registerMergeLoopPass() {
    PassRegistration<MergeLoop>(
      "merge-loop",
      "...");
}
