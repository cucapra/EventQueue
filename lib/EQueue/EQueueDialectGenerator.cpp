#include "EQueue/EQueueDialectGenerator.h"

FuncOp makeFunction(mlir::MLIRContext &ctx, StringRef name, ArrayRef<Type> results = {},
                           ArrayRef<Type> args = {}) {
  
  auto function = FuncOp::create(UnknownLoc::get(&ctx), name,
                                 FunctionType::get(args, results, &ctx));
  function.addEntryBlock();
  return function;
}

void simpleGenerator(mlir::MLIRContext &context){
  auto indexType = IndexType::get(&context);
  auto f32Type = FloatType::getF32(&context);
  auto f =
      makeFunction(context, "simple_func", {}, {indexType, f32Type});
  f.print(llvm::outs());
}
