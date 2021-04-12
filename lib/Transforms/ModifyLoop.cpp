#include "EQueue/Utils.h"
#define DEBUG_TYPE "modify-loop"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

struct ModifyLoop : public PassWrapper<ModifyLoop, FunctionPass>  {


  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("loop index in post order to decide merge loop, size >=2"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
    ListOption<unsigned> value {*this, "value", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ModifyLoop() = default;
  ModifyLoop(const ModifyLoop& pass) {}
  
  void runOnFunction() override;
};

} // end anonymous namespace

void ModifyLoop::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  SmallVector<AffineForOp, 20> loops;
  //LoopLikeOpInterface
  f.walk([&](AffineForOp loop) {
    loops.push_back(loop);
  });
  //if(isa<AffineForOp>(loops[0])){
    int i = 0; 
    for(auto index:indices){
      loops[index].setConstantUpperBound(value[i]);
      i++;
    }
  
  //}

}


void equeue::registerModifyLoopPass() {
    PassRegistration<ModifyLoop>(
      "modify-loop",
      "...");
}
