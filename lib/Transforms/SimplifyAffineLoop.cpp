#include "EQueue/Utils.h"

#define DEBUG_TYPE "simplify-affine-loop"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/match_struct.mlir --loop-parallel="indices=7" > ../test/LoweringPipeline/parallel.mlir

namespace {
/// Convert all parallel affine.for op into 1-D affine.parallel op.
struct SimplifyAffineLoop : public PassWrapper<SimplifyAffineLoop, FunctionPass> {
  SimplifyAffineLoop()=default;
  SimplifyAffineLoop(const SimplifyAffineLoop& pass) {}

  
  void runOnFunction() override;
};
} // namespace

void SimplifyAffineLoop::runOnFunction() {
  FuncOp f = getFunction();
  MLIRContext *context = &getContext();
  OpBuilder builder(context);
  SmallVector<AffineForOp, 20> loops;

  f.walk([&](AffineForOp loop) {
    loops.push_back(loop);
  });
  std::reverse(loops.begin(), loops.end());


  for (AffineForOp loop : loops){
    if(loop.getInductionVar().use_empty()){
      ScopedContext scope(builder, loop.getParentRegion()->getLoc());
      builder.setInsertionPointToStart(&loop.getParentRegion()->front());
      Value iv = std_constant_index(0);
      loop.setLowerBound(ValueRange{iv}, loop.getLowerBoundMap());
      loop.setUpperBound(ValueRange{iv}, loop.getUpperBoundMap());
      /*auto minOp = loop.upperBound().getDefiningOp<AffineMinOp>());
      if(minOp){
        auto minMap = minOp->getAffineMap();
        for(auto v:minOp->getDimOperands()){
          v.dump();
        }
      }*/
    }
  }
  //parallel opertation has to be post order

}

void equeue::registerSimplifyAffineLoopPass() {
    PassRegistration<SimplifyAffineLoop>(
      "simplify-affine-loop",
      "...");
}
