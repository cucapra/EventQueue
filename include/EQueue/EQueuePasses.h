#ifndef EQUEUE_PASSES_H
#define EQUEUE_PASSES_H
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Support/LLVM.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/StringRef.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "EQueue/EQueueOps.h"
#include <memory>
#include <string>


namespace mlir{
namespace equeue {
    


// class FuncOp;
void registerEQueuePasses();
void registerTilingPass();
void registerParallelizePass();
void registerAllocatePass();
void registerMemCopyPass();
void registerLoopRemovingPass();
void registerAddLoopPass();
void registerSystolicArrayPass();
void registerEqueueReadWritePass();
/// Generate the code for registering passes.
}
} // end namespace mlir

#endif // EQUEUE_STRUCTURE_MATCHING_H

