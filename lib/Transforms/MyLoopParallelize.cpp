
#include "mlir/Pass/Pass.h"

#include "EQueue/EQueuePasses.h"
#include "EQueue/EQueueOps.h"
#include "mlir/Analysis/AffineStructures.h"
#include "mlir/Analysis/LoopAnalysis.h"
#include "mlir/Analysis/Utils.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Affine/Passes.h"
#include "mlir/Dialect/Affine/Passes.h.inc"
#include "mlir/Dialect/Affine/Utils.h"
#include "mlir/Transforms/LoopUtils.h"
#include "llvm/Support/Debug.h"
#include "llvm/ADT/SmallSet.h"

#define DEBUG_TYPE "affine-parallel"

using namespace mlir;

namespace {
/// Convert all parallel affine.for op into 1-D affine.parallel op.
struct MyParallelize : public PassWrapper<MyParallelize, FunctionPass> {
  MyParallelize()=default;
  MyParallelize(const MyParallelize& pass) {}
  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("give index in order to decide whether parallelize them or not"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  void runOnFunction() override;
};
} // namespace

void MyParallelize::runOnFunction() {
  FuncOp f = getFunction();
  SmallVector<AffineForOp, 20> loops;

  llvm::SmallSet<unsigned, 16> parallelIndices;
  for(auto index : indices){
    parallelIndices.insert(index);
  }
  //if(!indices.empty()) parallelIndices = indices.vec();
  f.walk([&](AffineForOp loop) {
    loops.push_back(loop);
  });
  std::reverse(loops.begin(), loops.end());
  auto counter = 0;
  SmallVector<AffineForOp, 20> parallelizableLoops;
  for (AffineForOp loop : loops){
    if (isLoopParallel(loop) && parallelIndices.count(counter) )
      parallelizableLoops.push_back(loop);
    counter++;
  }
  //parallel opertation has to be post order
  std::reverse(parallelizableLoops.begin(), parallelizableLoops.end());
  for (AffineForOp loop : parallelizableLoops){
    affineParallelize(loop);
  }
}

void equeue::registerParallelizePass() {
    PassRegistration<MyParallelize>(
      "loop-parallel",
      "...");
}
