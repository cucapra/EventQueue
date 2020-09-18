#include "EQueue/EQueueDialectGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     

using create_dma = ValueBuilder<xilinx::equeue::CreateDMAOp>;
using create_mem = ValueBuilder<xilinx::equeue::CreateMemOp>;
using create_proc = ValueBuilder<xilinx::equeue::CreateProcOp>;
using create_comp = ValueBuilder<xilinx::equeue::CreateCompOp>;
using get_comp = ValueBuilder<xilinx::equeue::GetCompOp>;

using alloc_op = ValueBuilder<xilinx::equeue::MemAllocOp>;
using dealloc_op = OperationBuilder<xilinx::equeue::MemDeallocOp>;
using read_op = ValueBuilder<xilinx::equeue::MemReadOp>;
using write_op = OperationBuilder<xilinx::equeue::MemWriteOp>;
using memcpy_op = ValueBuilder<xilinx::equeue::MemCopyOp>;


//using launch_op = OperationBuilder<xilinx::equeue::LaunchOp>;
using return_op = OperationBuilder<xilinx::equeue::ReturnOp>;

using start_op = ValueBuilder<xilinx::equeue::ControlStartOp>;
using control_and = ValueBuilder<xilinx::equeue::ControlAndOp>;
using control_or = ValueBuilder<xilinx::equeue::ControlOrOp>;
using await_op = OperationBuilder<xilinx::equeue::AwaitOp>;
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
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);

  //OpBuilder b(f.getBody());
  ScopedContext scope(builder, f.getLoc());
  
  Value proc, mem, comp;
  for(int i = 0; i < 5; i++){
    proc = create_proc("proc", "AIEngine");
    mem = create_mem("mem", ArrayRef<int64_t>{ 11 }, "f32", "RegisterFile");
    if(i==0) {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc}) ;
    } else {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc, comp});
    }
  }
  Value sram(create_mem("mem", ArrayRef<int64_t>{ 1024 }, "f32", "SRAM"));
  Value dma(create_dma("dma"));
  Value processor(create_proc("proc", "MicroPlate") );
  Value accel( create_comp("accel", ValueRange{ comp, processor, sram, dma}) );
  //Value DRAM(create_mem("DRAM", ArrayRef<int64_t>{ 64 }, "f32", "DRAM"));
  //dma = create_dma("DMA");
  //processor = create_proc("proc", "Armx86");
  //Value device( create_comp("device", ValueRange{ accel, processor, DRAM, dma}) );
  
  /// -------------------
  /// --    control    --
  /// -------------------
  
  //XXX(Zhijing): not sure why we cannot use aliasing here
  Value signal = start_op();
  //builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  auto res = LaunchOpBuilder(signal, processor, ValueRange{accel, f.getArgument(0), f.getArgument(1)}, 
    [&](ValueRange ins){
      accel = ins[0];
      Value ifmap = ins[0];
      Value filter = ins[0];
      Value ofmap;
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 16,16 }, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 12,12 }, "f32", f32Type);
      write_op(ifmap, ibuffer);
      
      //Value start_cpy = builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
      Value start_cpy = start_op();
      Value pe = accel;
      SmallVector<Value, 5> pes, mems, procs;
      SmallVector<Value, 5> wbuffer2s, obuffer2s, ibuffer2s;
      
      Value wbuffer2, obuffer2, ibuffer2;
      //par for
      for(int i = 4; i >= 0; i--){
        pe = get_comp(pe, "pe_"+to_string(i));
        mem = get_comp(pe, "mem");
        proc = get_comp(pe, "proc");
        wbuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 5 }, "f32", f32Type);
        obuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 1 }, "f32", f32Type);
        ibuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 5 }, "f32", f32Type);// ArrayRef<int64_t>{ 4 }
        //TODO: offset, ignore it at this moment
        //instead of having it on memcpy_op, we need "view"
        signal = memcpy_op(start_cpy, wbuffer, wbuffer2, dma);
        
        
        pes.push_back(pe);
        mems.push_back(mem);
        procs.push_back(proc);
        wbuffer2s.push_back(wbuffer2);
        obuffer2s.push_back(obuffer2);
        ibuffer2s.push_back(ibuffer2);
      }
      
      Value lb = std_constant_index(0);
      Value ub = std_constant_index(12);
      Value step = std_constant_index(1);
      
      SmallVector<Value, 5> pe_signals(5,step);
      Value row_done;
      auto col_signal = loopNestBuilder(lb, ub, step, {signal}, [&](Value iv0, ValueRange args0) {
        
        for(int i = 0; i<5; i++){
          pe_signals[i] = memcpy_op(signal, ibuffer, ibuffer2s[i], dma);
          Value const0 = std_constant_float(llvm::APFloat(0.0f), f32Type);
          write_op(const0, obuffer2s[i]);
        }
        signal = control_and(pe_signals);
        lb = std_constant_index(0);
        ub = std_constant_index(12);
        step = std_constant_index(1);
        auto row_signal = loopNestBuilder(lb, ub, step, {signal}, [&](Value iv1, ValueRange args1) {
          for(int i = 0; i < 5; i++){
            pe = pes[i];
            mem = mems[i];
            proc = procs[i];
            wbuffer2 = wbuffer2s[i];
            obuffer2 = obuffer2s[i];
            ibuffer2 = ibuffer2s[i];
            
            
            //TODO: offset problem
            //actually append to the end and pop the oldest
            signal = memcpy_op(args1[0], ibuffer, ibuffer2, dma, ValueRange{iv1});
            //signal = memcpy_op(signal, ibuffer, ibuffer2, dma);
            
            /// ------------------------------
            /// compute one output and write back to SRAM
            /// ------------------------------
            
            //seq for loop, memcpy ibuffer2
            ValueRange pe_res = LaunchOpBuilder(signal, proc, ValueRange{ibuffer2, wbuffer2, obuffer2}, 
              [&](ValueRange ins2){
              lb = std_constant_index(0);
              ub = std_constant_index(5);
              step = std_constant_index(1);
              loopNestBuilder(lb, ub, step, {}, [&](Value iv2, ValueRange args2) {
                ifmap = read_op(ins2[0], f32Type, iv2);
                filter = read_op(ins2[1], f32Type, iv2);
                Value mul = std_mulf(ifmap, filter);
                ofmap = read_op(ins2[2], f32Type);
                ofmap = std_addf(ofmap, mul);
                write_op(ofmap, ins2[2]);
                return scf::ValueVector{};
              });
              return_op(ValueRange{});
            });
          
            pe_signals[i]=pe_res[0];
            
            //partial sum
            if(i > 0){
              signal = control_and(ValueRange{pe_signals[i], pe_signals[i-1]});
              row_done = LaunchOpBuilder(signal, proc, ValueRange{obuffer2s[i-1], obuffer2s[i]}, 
              [&](ValueRange ins2){
                Value psum1 = read_op(ins2[0], f32Type);
                Value psum2 = read_op(ins2[1], f32Type);
                ofmap = std_addf(psum1, psum2);
                write_op(ofmap, ins2[1]);
                return_op(ValueRange{});
              })[0];
            }//if
          }//par for
          row_done = memcpy_op(row_done, obuffer2s[4], obuffer, dma);
          return scf::ValueVector{row_done};
        });//seq for (row)
        return row_signal;
      });//seq for (col)
      await_op(ValueRange{col_signal[0]});
      Value output = read_op(obuffer, f32Type);
      dealloc_op(ValueRange{wbuffer, obuffer, ibuffer});
      return_op(ValueRange{output});
  });
  builder.create<ReturnOp>(f.getLoc(), llvm::makeArrayRef(res[1]));
  //std_ret().addoperands(res[0]);
  /// ------ end ---------
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}
