#ifndef EQUEUE_PASSES_H
#define EQUEUE_PASSES_H
#include "mlir/Pass/Pass.h"
#include "llvm/ADT/ArrayRef.h"

#include <string>

namespace equeue {
std::unique_ptr<mlir::OperationPass<mlir::FuncOp>> createStructureMatchingPass(llvm::ArrayRef<std::string> structNames = {});


//===----------------------------------------------------------------------===//
// Registration
//===----------------------------------------------------------------------===//

/// Generate the code for registering passes.
#define GEN_EQUEUE_PASS_REGISTRATION
#include "EQueue/EQueuePasses.h.inc"

} // end namespace equeue

#endif // EQUEUE_STRUCTURE_MATCHING_H
