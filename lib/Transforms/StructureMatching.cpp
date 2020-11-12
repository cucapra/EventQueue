
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Dialect/SCF/EDSC/Builders.h"
#include "mlir/Transforms/DialectConversion.h"

#include "EQueue/EQueuePasses.h"
#define DEBUG_TYPE "structure-matching"

using namespace mlir;
using namespace mlir::scf;


namespace {
class StructureMatchingPass
    : public PassWrapper<StructureMatchingPass, FunctionPass> {
  ArrayRef<std::string> structNames;
public:
  StructureMatchingPass() = default;
  StructureMatchingPass(ArrayRef<std::string> names) { structNames = names; }
  void runOnFunction() override {

    auto f = getFunction();

    // Populate the worklist with the operations that need shape inference:
    // these are operations that return a dynamic shape.
    llvm::SmallPtrSet<mlir::Operation *, 16> opWorklist;
    f.walk([&](mlir::Operation *op) {
      if (isa<scf::ParallelOp>(op))
        opWorklist.insert(op);
    });

    // Iterate on the operations in the worklist until all operations have been
    // inferred or no change happened (fix point).
    for(auto iter = opWorklist.begin(); iter!=opWorklist.end(); iter++){
      LLVM_DEBUG(llvm::dbgs() << "parallel for loop: " << *(*iter) << "\n");
    }
  }
};
} // end anonymous namespace

/// Create a Shape Inference pass.
std::unique_ptr<mlir::OperationPass<mlir::FuncOp>> equeue::createStructureMatchingPass(ArrayRef<std::string> structNames) {
  return std::make_unique<StructureMatchingPass>(structNames);
}
