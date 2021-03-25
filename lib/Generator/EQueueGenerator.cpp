#include "Generator/EQueueGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     


using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace std;
/*
void MLIRGenImpl::simpleGenerator(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({7,7}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({3,3}, f32Type);
  auto f =
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);

  //OpBuilder b(f.getBody());
  ScopedContext scope(builder, f.getLoc());
  
  Value proc, mem, comp;
  for(int i = 0; i < 5; i++){
    proc = create_proc("proc", "AIEngine");
    mem = create_mem("mem", ArrayRef<int64_t>{ 11 }, "f32", "RegisterFile", 1);
    if(i==0) {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc}) ;
    } else {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc, comp});
    }
  }
  Value sram(create_mem("mem", ArrayRef<int64_t>{ 1024 }, "f32", "SRAM", 16));
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
      Value filter = ins[1];
      Value ofmap;
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 7,7 }, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 3,3 }, "f32", f32Type);
      write_op(ifmap, ibuffer);
      write_op(filter, wbuffer);
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
  //std_ret().addoperands(res[0]);
  /// ------ end ---------
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}


void MLIRGenImpl::linalgGenerator1(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({7,7}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({3,3}, f32Type);
  auto f =
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);
  
  ScopedContext scope(builder, f.getLoc());
  
  Value proc, mem, comp;
  for(int i = 0; i < 5; i++){
    proc = create_proc("proc", "AIEngine");
    mem = create_mem("mem", ArrayRef<int64_t>{ 11 }, "f32", "RegisterFile", 1);
    if(i==0) {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc}) ;
    } else {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc, comp});
    }
  }
  Value sram(create_mem("mem", ArrayRef<int64_t>{ 1024 }, "f32", "SRAM", 16));
  Value dma(create_dma("dma"));
  Value processor(create_proc("proc", "MicroPlate") );
  Value accel( create_comp("accel", ValueRange{ comp, processor, sram, dma}) );
  
  /// -------------------
  /// --    control    --
  /// -------------------
  
  //XXX(Zhijing): not sure why we cannot use aliasing here
  Value signal = start_op();
  //builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  auto res = LaunchOpBuilder(signal, processor, ValueRange{accel, f.getArgument(0), f.getArgument(1)}, 
    [&](ValueRange ins){
      accel = ins[0];
      Value ifmap = ins[1];
      Value filter = ins[2];
      Value ofmap;
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 7,7 }, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 3,3 }, "f32", f32Type);
      write_op(ifmap, ibuffer);
      write_op(filter, wbuffer);

      Value start_cpy = start_op();
      Value pe = accel;
      SmallVector<Value, 5> pes, mems, procs;
      SmallVector<Value, 5> wbuffer2s, obuffer2s, ibuffer2s;
      
      Value wbuffer2, obuffer2, ibuffer2;
      //par for
      Value prev_signal;
      for(int i = 4; i >= 0; i--){
        pe = get_comp(pe, "pe_"+to_string(i));
        mem = get_comp(pe, "mem");
        proc = get_comp(pe, "proc");
        wbuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 5 }, "f32", f32Type);
        ibuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 5 }, "f32", f32Type);// ArrayRef<int64_t>{ 4 }
        obuffer2 = alloc_op(mem, ArrayRef<int64_t>{ 1 }, "f32", f32Type);
        signal = memcpy_op(start_cpy, wbuffer, wbuffer2, dma);
        signal = memcpy_op(signal, ibuffer, ibuffer2, dma);
        
        
        pes.push_back(pe);
        mems.push_back(mem);
        procs.push_back(proc);
        wbuffer2s.push_back(wbuffer2);
        ibuffer2s.push_back(ibuffer2);
        obuffer2s.push_back(obuffer2);
        if(i==4){
          prev_signal = signal;
        }else{
          prev_signal = control_and(ValueRange{signal, prev_signal});
        }
      }
      await_op(ValueRange{prev_signal});
      
      Value lb = std_constant_index(0);
      Value ub = std_constant_index(3);//ifmap height
      Value step = std_constant_index(1);
      
      SmallVector<Value, 5> pe_signals(5,step);
      Value row_done;
      
      start_cpy = start_op();
      auto col_signal = loopNestBuilder(lb, ub, step, {start_cpy}, [&](Value iv0, ValueRange args0) {
        
        for(int i = 0; i<5; i++){
          auto offset = std_constant_index(i);
          pe_signals[i] = memcpy_op(args0[0], ibuffer, ibuffer2s[i], dma, ValueRange{offset});
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
            
            /// ------------------------------
            /// compute one output and write back to SRAM
            /// ------------------------------
            
            //seq for loop, memcpy ibuffer2
            ValueRange pe_res = LaunchOpBuilder(signal, proc, ValueRange{ibuffer2, wbuffer2, obuffer2}, 
              [&](ValueRange ins2){
              
              auto ifmapType = MemRefType::get({1,1,5,1}, f32Type);
              auto filterType = MemRefType::get({1,5,1,1}, f32Type);
              AffineExpr p, q, m, n;
              bindDims(builder.getContext(), p, q, m, n);
              SmallVector<linalg::ReassociationExprs, 1> maps = {linalg::ReassociationExprs({p, q, m, n})};
              auto reshaped_ifmap = linalg_reshape(ifmapType, ins2[0], maps);
              auto subview_ifmap = std_sub_view(reshaped_ifmap,
              llvm::ArrayRef<int64_t>({0,0,0,0}),//offset
              llvm::ArrayRef<int64_t>({1,1,1,1}), //size
              llvm::ArrayRef<int64_t>({1,1,1,1}), //stride
              ValueRange{}, ValueRange{}, ValueRange{});//not sure why we need this after static assignment
              auto reshaped_filter = linalg_reshape(filterType, ins2[1], maps);
              auto ofmapType = MemRefType::get({1,1,1,1}, f32Type);
              auto reshaped_ofmap = linalg_reshape(ofmapType, ins2[2], maps);
              //ifmap[batch, h, w, c]
              //filter[h, w, c, num]
              //ofmap[batch, h, w, num]
              linalg_generic_conv_nhwc(subview_ifmap, reshaped_filter, reshaped_ofmap, {1,1}, {0,0});

              
              auto par = IteratorType::Parallel;
              auto red = IteratorType::Reduction;

              AffineExpr b, f, h, w, kh, kw, c;
              bindDims(builder.getContext(), b, f, h, w, kh, kw, c);
              unsigned numDims = c.cast<AffineDimExpr>().getPosition() + 1;
              StructuredIndexed I(subview_ifmap), W(reshaped_filter), O(reshaped_ofmap);
              mlir::edsc::makeGenericLinalgOp(
                {par, par, par, par, red, red, red}, {
                  I({b,
                     // Roundtrip to flattened form to serve as canonicalization and ensure
                     // consistent ordering of subexpressions.
                     simplifyAffineExpr(h, numDims, 0),
                     simplifyAffineExpr(w, numDims, 0),
                     c}), W({kh, kw, c, f})}, 
                  {O({b, h, w, f})},
              mlir::edsc::ops::macRegionBuilder);            

              return_op(ValueRange{});
            });
          
            pe_signals[i]=pe_res[0];
            
            //partial sum
            if(i > 0){
              signal = control_and(ValueRange{pe_signals[i], pe_signals[i-1]});
              signal = LaunchOpBuilder(signal, proc, ValueRange{obuffer2s[i-1], obuffer2s[i]}, 
              [&](ValueRange ins2){
                Value psum1 = read_op(ins2[0]);
                Value psum2 = read_op(ins2[1]);
                ofmap = std_addf(psum1, psum2);
                write_op(ofmap, ins2[1]);
                return_op(ValueRange{});
              })[0];
              prev_signal = control_and(ValueRange{signal, prev_signal});
            }else{
              prev_signal = pe_res[0];
            }
          }//par for
          auto copy_back = memcpy_op(prev_signal, obuffer2s[4], obuffer, dma);
          await_op(ValueRange{copy_back});
          auto done_copy_back = start_op();
          return scf::ValueVector{done_copy_back};
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
  /// ------ end ---------
  
  
  
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}



void MLIRGenImpl::linalgGenerator2(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({7,7}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({3,3}, f32Type);
  auto f =
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);
  
  ScopedContext scope(builder, f.getLoc());
  
  Value proc, mem, comp;
  for(int i = 0; i < 5; i++){
    proc = create_proc("proc", "AIEngine");
    mem = create_mem("mem", ArrayRef<int64_t>{ 11 }, "f32", "RegisterFile", 1);
    if(i==0) {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc}) ;
    } else {
      comp = create_comp("pe_"+to_string(i), ValueRange{mem, proc, comp});
    }
  }
  Value sram(create_mem("mem", ArrayRef<int64_t>{ 1024 }, "f32", "SRAM", 16));
  Value dma(create_dma("dma"));
  Value processor(create_proc("proc", "MicroPlate") );
  Value accel( create_comp("accel", ValueRange{ comp, processor, sram, dma}) );
  
  /// -------------------
  /// --    control    --
  /// -------------------
  
  //XXX(Zhijing): not sure why we cannot use aliasing here
  Value signal = start_op();
  //builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  auto res = LaunchOpBuilder(signal, processor, ValueRange{accel, f.getArgument(0), f.getArgument(1)}, 
    [&](ValueRange ins){
      accel = ins[0];
      Value ifmap = ins[1];
      Value filter = ins[2];
      Value ofmap;
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 7,7 }, "f32", f32Type);
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, "f32", f32Type);
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 3,3 }, "f32", f32Type);
      write_op(ifmap, ibuffer);
      write_op(filter, wbuffer);

      for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
          
          auto ifmapType = MemRefType::get({1, 7, 7, 1}, f32Type);
          auto filterType = MemRefType::get({5, 5, 1, 1}, f32Type);
          auto ofmapType = MemRefType::get({1, 3, 3, 1}, f32Type);
          AffineExpr p, q, m, n;
          bindDims(builder.getContext(), p, q, m, n);
          SmallVector<linalg::ReassociationExprs, 2> maps = {linalg::ReassociationExprs({p}), linalg::ReassociationExprs({q, m, n})};
          SmallVector<linalg::ReassociationExprs, 2> maps2 = {linalg::ReassociationExprs({p,q}), linalg::ReassociationExprs({m, n})};
          
          auto reshaped_ifmap = linalg_reshape(ifmapType, ibuffer, maps2);
          auto reshaped_filter = linalg_reshape(filterType, wbuffer, maps);
          auto reshaped_ofmap = linalg_reshape(ofmapType, obuffer, maps2);
          
          auto subview_ifmap = std_sub_view(reshaped_ifmap,
          llvm::ArrayRef<int64_t>({0,i,j,0}),//offset
          llvm::ArrayRef<int64_t>({1,1,1,1}), //size
          llvm::ArrayRef<int64_t>({1,1,1,1}), //stride
          ValueRange{}, ValueRange{}, ValueRange{});//not sure why we need this after static assignment
          auto subview_ofmap = std_sub_view(reshaped_ofmap,
          llvm::ArrayRef<int64_t>({0,i,j,0}),//offset
          llvm::ArrayRef<int64_t>({1,1,1,1}), //size
          llvm::ArrayRef<int64_t>({1,1,1,1}), //stride
          ValueRange{}, ValueRange{}, ValueRange{});//not sure why we need this after static assignment
          //ifmap[batch, h, w, c]
          //filter[h, w, c, num]
          //ofmap[batch, h, w, num]
          linalg_generic_conv_nhwc(subview_ifmap, reshaped_filter, subview_ofmap, {1,1}, {0,0});
        }
      }
      Value output = read_op(obuffer);
      dealloc_op(ValueRange{wbuffer, obuffer, ibuffer});
      return_op(ValueRange{output});
  });
  await_op(ValueRange{res[0]});
  builder.create<ReturnOp>(f.getLoc(), llvm::makeArrayRef(res[1]));
  /// ------ end ---------
  
  
  
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}


*/
void MLIRGenImpl::linalgGenerator3(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  //auto ifmapType = MemRefType::get({7,7}, f32Type);//RankedTensorType::get({7,7}, f32Type);
  //auto filterType = MemRefType::get({5,5}, f32Type);//RankedTensorType::get({5,5}, f32Type);
  //auto ofmapType = MemRefType::get({3,3}, f32Type);//RankedTensorType::get({3,3}, f32Type);
  auto f =
      makeFunction("graph", {}, {});
  theModule.push_back(f);
  
  ScopedContext scope(builder, f.getLoc());
  
  SmallVector<int64_t, 1> peShape;
  peShape.push_back(5);
  Value proc, mem, comp;
  proc = create_proc("AIEngine");
  mem = create_mem(ArrayRef<int64_t>{ 11 }, 32, "RegisterFile", 1);
  comp = create_comp(ArrayRef<std::string>{"proc", "mem"}, ValueRange{proc, mem});
  comp = std_splat( comp, VectorType::get(peShape, comp.getType()) );
  //comp = create_comp("pe_array", comp);

  Value sram(create_mem(ArrayRef<int64_t>{ 1024 }, 32, "SRAM", 16));
  Value dma = builder.create<xilinx::equeue::CreateDMAOp>(f.getLoc()).getResult();
  Value processor(create_proc("MicroPlate") );
  Value accel = create_comp(ArrayRef<std::string>{"pe_array","proc", "mem", "dma"},
  ValueRange{comp, processor, sram, dma} );
  
  /// -------------------
  /// --    control    --
  /// -------------------
  
  //XXX(Zhijing): not sure why we cannot use aliasing here
  Value signal = start_op();
  //builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  //auto res = 
  LaunchOpBuilder(signal, processor, ValueRange{accel}, 
    [&](ValueRange ins){
      accel = ins[0];
      //Value ibuffer = ins[1];
      //Value wbuffer = ins[2];
      //Value obuffer = ins[3];
      processor = get_comp(accel, "proc");
      dma = get_comp(accel, "dma");
      sram = get_comp(accel, "mem");
      
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ 7,7 }, 32, f32Type);
      add_comp(accel, ArrayRef<std::string>{"ibuffer"}, ValueRange{ibuffer});
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ 5,5 }, 32, f32Type);
      add_comp(accel, ArrayRef<std::string>{"wbuffer"}, ValueRange{wbuffer});
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ 3,3 }, 32, f32Type);
      add_comp(accel, ArrayRef<std::string>{"obuffer"}, ValueRange{obuffer});
      
          auto ifmapType = MemRefType::get({1, 7, 7, 1}, f32Type);//b,h,w,c
          auto filterType = MemRefType::get({5, 5, 1, 10}, f32Type);//kh, kw, c, f
          auto ofmapType = MemRefType::get({1, 3, 3, 10}, f32Type);//b, h, w, f
          AffineExpr p, q, m, n;
          bindDims(builder.getContext(), p, q, m, n);
          SmallVector<linalg::ReassociationExprs, 2> maps = {linalg::ReassociationExprs({p}), linalg::ReassociationExprs({q, m, n})};
          SmallVector<linalg::ReassociationExprs, 2> maps2 = {linalg::ReassociationExprs({p,q}), linalg::ReassociationExprs({m, n})};
          
          auto reshaped_ifmap = linalg_reshape(ifmapType, ibuffer, maps2);
          auto reshaped_filter = linalg_reshape(filterType, wbuffer, maps);
          auto reshaped_ofmap = linalg_reshape(ofmapType, obuffer, maps2);
          auto subview_ifmap = std_sub_view(reshaped_ifmap,
          llvm::ArrayRef<int64_t>({0,0,0,0}),//offset
          llvm::ArrayRef<int64_t>({1,3,3,1}), //size
          llvm::ArrayRef<int64_t>({1,1,1,1}), //stride
          ValueRange{}, ValueRange{}, ValueRange{});//not sure why we need this after static assignment
          
          //ifmap[batch, h, w, c]
          //filter[h, w, c, num]
          //ofmap[batch, h, w, num]
          
              auto par = IteratorType::Parallel;
              auto red = IteratorType::Reduction;

              AffineExpr b, f, h, w, kh, kw, c;
              bindDims(builder.getContext(), b, f, h, w, kh, kw, c);
              unsigned numDims = c.cast<AffineDimExpr>().getPosition() + 1;
              StructuredIndexed I(subview_ifmap), W(reshaped_filter), O(reshaped_ofmap);
              mlir::edsc::makeGenericLinalgOp(
                {par, par, par, par, par, par, par}, {
                  I({b,
                     // Roundtrip to flattened form to serve as canonicalization and ensure
                     // consistent ordering of subexpressions.
                     simplifyAffineExpr(h, numDims, 0),
                     simplifyAffineExpr(w, numDims, 0),
                     c}), W({kh, kw, c, f})}, 
                  {O({b, h, w, f})},
              mlir::edsc::ops::macRegionBuilder);    
          
      //Value output = read_op(obuffer);
      //dealloc_op(ValueRange{wbuffer, obuffer, ibuffer});
      //return_op(ValueRange{output});
      return_op(ValueRange{});
  });
  std_ret();
  //await_op(ValueRange{res[0]});
  //builder.create<ReturnOp>(f.getLoc(), llvm::makeArrayRef(res[1]));
  /// ------ end ---------
  
  
  
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}




