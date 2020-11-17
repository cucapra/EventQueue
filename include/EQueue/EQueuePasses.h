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

class FuncOp;
void registerEQueuePasses();
}
} // end namespace mlir

#endif // EQUEUE_STRUCTURE_MATCHING_H

