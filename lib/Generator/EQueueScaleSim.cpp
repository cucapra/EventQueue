#include "Generator/EQueueGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     


using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace std;

void MLIRGenImpl::scaleSimGenerator(){
  layerConfig layer_config;
  accelConfig accel_config;
  // output feature map
  int E_h = (layer_config.ifmap_height - layer_config.filter_height - layer_config.stride) / layer_config.stride;
  int E_w = (layer_config.ifmap_width - layer_config.filter_width - layer_config.stride) / layer_config.stride;
  // pixels of a conv window
  int px_per_conv = layer_config.filter_height * layer_config.filter_width * layer_config.channel;
  // ofmap px
  int px_ofmap = E_h * E_w * layer_config.num_filter;
  int e2 = E_h * E_w;
  
  // fold is number of times it takes to finish computation on some dimensions
  int num_h_fold = 1;
  int max_parallel_conv = 1;
  if(accel_config.array_height < px_per_conv){
    num_h_fold = ceil( (float)px_per_conv / (float)accel_config.array_height);
  }else{
    max_parallel_conv = accel_config.array_height / px_per_conv;
  }

  int max_cols_per_v_fold = max_parallel_conv * accel_config.array_width;
  int num_v_fold = ceil( (float)layer_config.num_filter / (float)max_cols_per_v_fold);
  
  llvm::outs()<<num_v_fold<<" "<<num_h_fold<<"\n";
  auto remaining_cols = layer_config.num_filter;
  for(int i = 0; i < num_v_fold; i++){//seq_for
    int col_this_fold = min(remaining_cols, max_parallel_conv * accel_config.array_width);
    int rem_h = px_per_conv;
    for(int j = 0; j < num_h_fold; j++){
      int row_this_fold = min(rem_h, accel_config.array_height);
    }
  }
  
  
  
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());
  
  auto f32Type = builder.getF32Type();
  // (XXX)Zhijing: not sure if we need this part
  auto ifmapType = MemRefType::get({layer_config.channel, layer_config.ifmap_height, layer_config.ifmap_width}, f32Type);
  auto filterType = MemRefType::get({layer_config.num_filter, layer_config.channel, layer_config.ifmap_width, layer_config.filter_width}, f32Type);
  auto ofmapType = MemRefType::get({layer_config.num_filter, E_h, E_w}, f32Type);
  auto f =
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);
  ScopedContext scope(builder, f.getLoc());
  
  Value proc, mem, comp;
  for(int i = 0; i < accel_config.array_height; i++){
    for(int j = 0; j < accel_config.array_width; j++){
      proc = create_proc("proc", "AIEngine");
      mem = create_mem("mem", ArrayRef<int64_t>{ 3 }, "f32", "RegisterFile", 3);
      if(i==0&&j==0) {
        comp = create_comp("pe_"+to_string(i)+","+to_string(j), ValueRange{mem, proc}) ;
      } else {
        comp = create_comp("pe_"+to_string(i)+","+to_string(j), ValueRange{mem, proc, comp});
      }
    }
  }
  Value sram(create_mem("mem", ArrayRef<int64_t>{ accel_config.ifmap_sram * 1024 }, "f32", "SRAM", 16));
  Value dma(create_dma("dma"));
  Value processor(create_proc("proc", "MicroPlate") );
  Value accel( create_comp("accel", ValueRange{ comp, processor, sram, dma}) );
  Value signal = start_op();
  auto res = LaunchOpBuilder(signal, processor, ValueRange{accel, f.getArgument(0), f.getArgument(1)}, 
    [&](ValueRange ins){
      accel = ins[0];
      Value ifmap = ins[0];
      Value filter = ins[0];
      Value ofmap;
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{layer_config.channel, layer_config.ifmap_height, layer_config.ifmap_width}, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{layer_config.num_filter, layer_config.channel, layer_config.ifmap_width, layer_config.filter_width}, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{layer_config.num_filter, E_h, E_w}, "f32", f32Type);      
      
      Value start_cpy = start_op();
      Value pe = accel;
      SmallVector<SmallVector<Value, 20>, 20> pes, mems, procs;
      SmallVector<SmallVector<Value, 20>, 20> wbuffer2s, obuffer2s, ibuffer2s;
      Value wbuffer2, obuffer2, ibuffer2;
      //par for
      for(int i = layer_config.filter_height; i >= 0; i--){
        SmallVector<Value, 20> line_pe, line_mem, line_proc;
        SmallVector<Value, 20> line_wbuffer, line_obuffer, line_ibuffer;
        for(int j = layer_config.filter_width; j >= 0; j--){
          pe = get_comp(pe, "pe_"+to_string(i)+","+to_string(j));
          mem = get_comp(pe, "mem");
          proc = get_comp(pe, "proc");
          wbuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 1 }, "f32", f32Type);
          obuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 1 }, "f32", f32Type);
          ibuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 1 }, "f32", f32Type);// ArrayRef<int64_t>{ 4 }
          //TODO: offset, ignore it at this moment
          //instead of having it on memcpy_op, we need "view"
          signal = memcpy_op(start_cpy, wbuffer, wbuffer2, dma);
          
          
          line_pe.push_back(pe);
          line_mem.push_back(mem);
          line_proc.push_back(proc);
          line_wbuffer.push_back(wbuffer2);
          line_obuffer.push_back(obuffer2);
          line_ibuffer.push_back(ibuffer2);
        }
        pes.push_back(line_pe);
        mems.push_back(line_mem);
        procs.push_back(line_proc);
        wbuffer2s.push_back(line_wbuffer);
        obuffer2s.push_back(line_obuffer);
        ibuffer2s.push_back(line_ibuffer);
      }
      return_op(ValueRange{});
  });
  /*
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
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 7,7 }, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 3,3 }, "f32", f32Type);
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
      Value ub = std_constant_index(3);//ifmap height
      Value step = std_constant_index(1);
      
      SmallVector<Value, 5> pe_signals(5,step);
      Value row_done;
      auto col_signal = loopNestBuilder(lb, ub, step, {signal}, [&](Value iv0, ValueRange args0) {
        
        for(int i = 0; i<5; i++){
          pe_signals[i] = memcpy_op(args0[0], ibuffer, ibuffer2s[i], dma);
          Value const0 = std_constant_float(llvm::APFloat(0.0f), f32Type);
          write_op(const0, obuffer2s[i]);
        }
        
        signal = control_and(pe_signals);
        lb = std_constant_index(0);
        ub = std_constant_index(3);//ifmap width
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
                ifmap = read_op(ins2[0], iv2);
                filter = read_op(ins2[1], iv2);
                Value mul = std_mulf(ifmap, filter);
                ofmap = read_op(ins2[2]);
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
                Value psum1 = read_op(ins2[0]);
                Value psum2 = read_op(ins2[1]);
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
      Value output = read_op(obuffer);
      dealloc_op(ValueRange{wbuffer, obuffer, ibuffer});
      return_op(ValueRange{output});
  });
  await_op(ValueRange{res[0]});
  builder.create<ReturnOp>(f.getLoc(), llvm::makeArrayRef(res[1]));
  */
  //std_ret().addoperands(res[0]);
  /// ------ end ---------
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}
