#include "EQueue/EQueueDialectGenerator.h"

using std_constant_float = ValueBuilder<ConstantFloatOp>;

void MLIRGenImpl::simpleGenerator(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({16,16}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({12,12}, f32Type);
  auto f =
      makeFunction("simple_func", {ofmapType}, {ifmapType, filterType});
  //Value f7( std_constant_float(llvm::APFloat(7.0f), f32Type) );
  theModule.push_back(f);

  //OpBuilder b(f.getBody());
  //builder = b;
  ScopedContext scope(builder, f.getLoc());
  Value f7(ValueBuilder<ConstantFloatOp>(llvm::APFloat(7.0f), f32Type));
  Value dma = builder.create<xilinx::equeue::CreateDMAOp>(f.getLoc(), "DMA").getResult();
  //Value dma(ValueBuilder<xilinx::equeue::CreateDMAOp>());
  llvm::outs()<<dma<<"\n";

  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}
