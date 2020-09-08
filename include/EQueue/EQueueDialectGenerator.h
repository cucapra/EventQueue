#ifndef EQUEUEDIALECT_GENERATOR_H
#define EQUEUEDIALECT_GENERATOR_H

#include "mlir/EDSC/Builders.h"
#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Passes.h"



#include "llvm/Support/raw_ostream.h"

using namespace mlir;
using namespace mlir::edsc;


void simpleGenerator(mlir::MLIRContext &context);



#endif
