#ifndef EQUEUEDIALECT_GENERATOR_H
#define EQUEUEDIALECT_GENERATOR_H

#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EDSC/Intrinsics.h"

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

#include "mlir/Dialect/Affine/EDSC/Intrinsics.h"
#include "mlir/Dialect/Linalg/EDSC/Builders.h"
#include "mlir/Dialect/Linalg/EDSC/Intrinsics.h"
#include "mlir/Dialect/SCF/EDSC/Intrinsics.h"
#include "mlir/Dialect/StandardOps/EDSC/Intrinsics.h"
#include "mlir/Dialect/Vector/EDSC/Intrinsics.h"

#include "llvm/Support/raw_ostream.h"
#include <math.h> 

struct layerConfig {
  int batch = 1;
  int channel = 3;
  int ifmap_height = 7;//7
  int ifmap_width = 7;//7
  int num_filter = 5;//10
  int filter_height = 3;
  int filter_width = 3;
  int stride = 1;
} ;


enum DataFlow {WS, OS, IS, RS};

struct accelConfig {
  int array_height = 5;//12
  int array_width = 5;//14
  int ifmap_sram = 108;
  int filter_sram = 108;
  int ofmap_sram = 108;
  DataFlow dataflow = OS;
} ;


class MLIRGenImpl {
public:
  MLIRGenImpl(mlir::MLIRContext &context) : builder(&context) {}
  void simpleGenerator();
  void scaleSimGenerator();
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
