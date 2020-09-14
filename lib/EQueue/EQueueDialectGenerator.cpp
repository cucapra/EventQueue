#include "EQueue/EQueueDialectGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     
using std_constant_float = ValueBuilder<ConstantFloatOp>;
using create_dma = ValueBuilder<xilinx::equeue::CreateDMAOp>;
using create_mem = ValueBuilder<xilinx::equeue::CreateMemOp>;
using create_proc = ValueBuilder<xilinx::equeue::CreateProcOp>;
using create_comp = ValueBuilder<xilinx::equeue::CreateCompOp>;
using namespace std;
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
      comp = create_comp("comp_"+to_string(i), ValueRange{mem,proc} );
    }
    else {
      comp = create_comp("comp_"+to_string(i), ValueRange{mem,proc, kernel[i-1]} );
    }
    kernel.push_back(comp);
  }
  
  llvm::outs()<<kernel[0]<<"\n";
  Value dma(create_dma("DMA"));
  llvm::outs()<<dma<<"\n";

  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}
