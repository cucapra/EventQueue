#ifndef EQUEUEDIALECT_GENERATOR_H
#define EQUEUEDIALECT_GENERATOR_H

#include "mlir/EDSC/Builders.h"
#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Verifier.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Passes.h"
#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"


#include "llvm/Support/raw_ostream.h"

using namespace mlir;
using namespace mlir::edsc;
class MLIRGenImpl {
public:
  MLIRGenImpl(mlir::MLIRContext &context) : builder(&context) {}
  void simpleGenerator();
private:

  mlir::ModuleOp theModule;
  mlir::OpBuilder builder;

  FuncOp makeFunction(StringRef name, ArrayRef<Type> results = {},
                             ArrayRef<Type> args = {}) {
    
    auto function = FuncOp::create(builder.getUnknownLoc(), name,
                                   builder.getFunctionType(args, results));
    auto &entryBlock = * function.addEntryBlock();

    // Set the insertion point in the builder to the beginning of the function
    // body, it will be used throughout the codegen to create operations in this
    // function.
    builder.setInsertionPointToStart(&entryBlock);

    return function;
  }
};




#endif
