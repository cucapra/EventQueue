#include "EQueue/EQueueDialectGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     
using std_constant_float = ValueBuilder<ConstantFloatOp>;
using create_dma = ValueBuilder<xilinx::equeue::CreateDMAOp>;
using create_mem = ValueBuilder<xilinx::equeue::CreateMemOp>;
using create_proc = ValueBuilder<xilinx::equeue::CreateProcOp>;
using create_comp = ValueBuilder<xilinx::equeue::CreateCompOp>;
using get_comp = ValueBuilder<xilinx::equeue::GetCompOp>;
//using launch_op = OperationBuilder<xilinx::equeue::LaunchOp>;
using return_op = OperationBuilder<xilinx::equeue::ReturnOp>;
//using start_op = ValueBuilder<xilinx::equeue::ControlStartOp>;
using namespace std;





ValueRange LaunchOpBuilder(Value start, Value device,
  ValueRange operands, function_ref<void(ValueRange)> bodyBuilder) {
  // Fetch the builder and location.
  assert(ScopedContext::getContext() && "EDSC ScopedContext not set up");
  OpBuilder &builder = ScopedContext::getBuilderRef();
  Location loc = ScopedContext::getLocation();

  // Create the actual loop and call the body builder, if provided, after
  // updating the scoped context.
  return builder.create<xilinx::equeue::LaunchOp>(loc, start, device, operands, 
    [&](OpBuilder &nestedBuilder, Location nestedLoc, ValueRange deviceControl) {
      if (bodyBuilder) {
        ScopedContext nestedContext(nestedBuilder, nestedLoc);
        OpBuilder::InsertionGuard guard(nestedBuilder);
        bodyBuilder(deviceControl);
      }
    }
  ).getResults();
}



void MLIRGenImpl::simpleGenerator(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({16,16}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({12,12}, f32Type);
  auto f =
      makeFunction("simple_func", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);

  //OpBuilder b(f.getBody());
  ScopedContext scope(builder, f.getLoc());
  
  //Value dma = builder.create<xilinx::equeue::CreateDMAOp>(f.getLoc(), "DMA").getResult();
  SmallVector<Value, 5> kernel;
  for(int i = 0; i < 5; i++){
    Value proc(create_proc("proc_"+to_string(i), "AIEngine") );
    Value mem(create_mem("mem_"+to_string(i), ArrayRef<int64_t>{ 5 }, "f32", "RegisterFile") );
    Value comp;
    if(i==0) {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem,proc} );
    }
    else {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem,proc, kernel[i-1]} );
    }
    kernel.push_back(comp);
  }
  Value SRAM(create_mem("SRAM", ArrayRef<int64_t>{ 64 }, "f32", "SRAM"));
  Value dma(create_dma("DMA"));
  Value processor(create_proc("proc", "MicroBlaze") );
  Value accel( create_comp("accel", ValueRange{ kernel.back(), processor, SRAM, dma}) );
  Value DRAM(create_mem("DRAM", ArrayRef<int64_t>{ 64 }, "f32", "DRAM"));
  dma = create_dma("DMA");
  processor = create_proc("proc", "Armx86");
  Value device( create_comp("device", ValueRange{ accel, processor, DRAM, dma}) );
  //XXX(Zhijing): not sure why controlStart doesn't work here.
  Value signal = builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  

  return_op(ValueRange{device});
  LaunchOpBuilder(signal, processor, ValueRange{device}, 
    [&](ValueRange de){
      return_op(ValueRange{de});
  });

  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}
