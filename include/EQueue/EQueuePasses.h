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


using namespace mlir;
namespace equeue {
    


// class FuncOp;
void registerStructureMatchingPass();
void registerSplitLaunchPass();
void registerTilingPass();
void registerParallelizePass();
void registerAllocatePass();
void registerReassignBufferPass();
void registerMemCopyPass();
void registerMemCopyToLaunchPass();
void registerMergeMemCopyLaunchPass();
void registerLoopRemovingPass();
void registerSimplifyAffineLoopPass();
void registerLoopReorderPass();
void registerAddLoopPass();
void registerMergeLoopPass();
void registerModifyLoopPass();
void registerSystolicArrayPass();
void registerEqueueReadWritePass();
void registerParallelToEQueuePass();
void registerLowerExtractionPass();
/// Generate the code for registering passes.
} // end namespace equeue

#endif // EQUEUE_PASSES_H

