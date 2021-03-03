#include "Generator/EQueueGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     


using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace std;
void MLIRGenImpl::firSingleKernel(){
  int N = 512;
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto i32Type = IntegerType::get(32, builder.getContext());
  auto f =
      makeFunction("graph", {}, {});
  theModule.push_back(f);
  ScopedContext scope(builder, f.getLoc());
  
  Value sin = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sin = alloc_op(sin, ArrayRef<int64_t>{N}, 32, i32Type);  
  Value sout = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sout = alloc_op(sout, ArrayRef<int64_t>{N-32+1}, 32, i32Type); 
  
  Value proc = create_proc("AIEngine");
  Value data = create_mem(ArrayRef<int64_t>{32}, 32, "RegisterFile");//delay line
  Value taps = create_mem(ArrayRef<int64_t>{32}, 32, "RegisterFile");//coeff
  
  
  Value sin_connection = connection("Streaming", 1024);
  Value sout_connection = connection("Streaming", 1024);
  Value signal = start_op();
  //builder.create<xilinx::equeue::ControlStartOp>(f.getLoc()).getResult();
  auto res = LaunchOpBuilder(signal, proc, ValueRange{sin_connection, sout_connection, data, taps, sin, sout}, [&](ValueRange ins){

    Value ifmap = alloc_op(ins[2], ArrayRef<int64_t>{ 32 }, 32, i32Type);
    Value filter = alloc_op(ins[3], ArrayRef<int64_t>{ 32 }, 32, i32Type);
    Value ofmap = alloc_op(ins[3], ArrayRef<int64_t>{ 1 }, 32, i32Type);
    
    auto memrefType = MemRefType::get({4}, i32Type);
    //four lanes for complex 16 bits x complex 16 bits
    Value unused = unk_op("mul4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    
    
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    
    
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    
    //update data register
    //XXX(zj): wired to have connection on both read and write 
    Value ifmap_tensor = read_op(ins[4], ins[0], ArrayRef<int64_t>{4});
    write_op(ifmap_tensor, ifmap);
    
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
    write_op(read_op(ofmap), ins[5], ins[1]);
    
    return_op(ValueRange{});
  });
  await_op(ValueRange{res[0]});
  std_ret();
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}

void MLIRGenImpl::firMultiKernel(){
  int N = 512;
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto i32Type = IntegerType::get(32, builder.getContext());
  auto f =
      makeFunction("graph", {}, {});
  theModule.push_back(f);
  ScopedContext scope(builder, f.getLoc());
  
  Value sin = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sin = alloc_op(sin, ArrayRef<int64_t>{N}, 32, i32Type);  
  Value sout = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sout = alloc_op(sout, ArrayRef<int64_t>{N-32+1}, 32, i32Type);  
  
  Value streaming = create_comp(ArrayRef<std::string>{"stream0"}, ValueRange{connection("Streaming", 1024)});
  for (int i = 1; i < 8; i++){
    add_comp(streaming, ArrayRef<std::string>{"stream"+to_string(i)}, ValueRange{connection("Streaming", 1024)} );
  }
  
  SmallVector<Value, 4> aie;
  for (int i = 0 ; i < 4; i++){
    Value proc = create_proc("AIEngine");
    Value data = create_mem(ArrayRef<int64_t>{16}, 32, "RegisterFile");//delay line
    Value taps = create_mem(ArrayRef<int64_t>{8}, 32, "RegisterFile");//coeff
    Value acc = create_mem(ArrayRef<int64_t>{4}, 2*48, "RegisterFile");//coeff
    aie.push_back(create_comp(ArrayRef<std::string>{"proc", "data", "taps", "acc"}, ValueRange{proc, data, taps, acc}) );
  }
  
  
  Value signal = start_op();
  for(int i = 0; i < 4; i++){
    Value proc = get_comp(aie[i], "proc");
    auto res = LaunchOpBuilder(signal, proc, ValueRange{aie[i]}, [&](ValueRange ins){
      
      Value ifmap = alloc_op(get_comp(ins[0], "data"), ArrayRef<int64_t>{ 16 }, 32, i32Type);
      Value filter = alloc_op(get_comp(ins[0], "taps"), ArrayRef<int64_t>{ 8 }, 32, i32Type);
      Value ofmap = alloc_op(get_comp(ins[0], "acc"), ArrayRef<int64_t>{ 4 }, 2*48, i32Type);
      add_comp(ins[0], ArrayRef<std::string>{"ifmap", "filter", "ofmap"}, ValueRange{ifmap, filter, ofmap});
      return_op(ValueRange{});
    });
    await_op(ValueRange{res[0]});//for simplicity
  }
  signal = start_op();
  SmallVector<Value, 4> done_signal;
  for(int i = 0; i < 4; i++){
    Value proc = get_comp(aie[i], "proc");
    Value cin=sin;
    Value cout;
    if(i==3){
      cout = sout;
    }else{
      auto memrefType = MemRefType::get({4}, i32Type);
      cout = get_comp(aie[i], "ofmap", memrefType);
    }
    if (i==0){
      ValueRange res = LaunchOpBuilder(signal, proc, ValueRange{streaming, aie[i], cin, cout}, [&](ValueRange ins){
        Value stream_ifmap = get_comp(streaming, "stream"+to_string(i));
        Value stream_ofmap_out = get_comp(streaming, "stream"+to_string(4+i));
        auto memrefType = MemRefType::get({16}, i32Type);
        Value ifmap = get_comp(ins[1], "ifmap", memrefType);
        memrefType = MemRefType::get({8}, i32Type);
        Value filter = get_comp(ins[1], "filter", memrefType);
        memrefType = MemRefType::get({4}, i32Type);
        Value ofmap = get_comp(ins[1], "ofmap", memrefType);
        //four lanes for complex 16 bits x complex 8 bits
        // result in acc48, not sure what this type is and how large it should take
        for(int i = 0; i < 4; i++){
          // ofmap = psum = acc 
          Value unused;
          unused = unk_op("mul4", ValueRange{ofmap, ifmap, filter},  memrefType);
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          
          
          Value ifmap_tensor = read_op(ins[2], stream_ifmap, ArrayRef<int64_t>{4});
           
          write_op(ifmap_tensor, ifmap);
          
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          
          Value ofmap_tensor = read_op(ofmap);
          write_op(ofmap_tensor, ins[3], stream_ofmap_out);
        }
        return_op(ValueRange{});
      });
      done_signal.push_back(res[0]);
    }else{
      ValueRange res = LaunchOpBuilder(signal, proc, ValueRange{streaming, aie[i], aie[i-1], cin, cout}, [&](ValueRange ins){
        Value stream_ifmap = get_comp(streaming, "stream"+to_string(i));
        Value stream_ofmap_in = get_comp(streaming, "stream"+to_string(4+i-1));
        Value stream_ofmap_out = get_comp(streaming, "stream"+to_string(4+i));
        auto memrefType = MemRefType::get({16}, i32Type);
        Value ifmap = get_comp(ins[1], "ifmap", memrefType);
        memrefType = MemRefType::get({8}, i32Type);
        Value filter = get_comp(ins[1], "filter", memrefType);
        memrefType = MemRefType::get({4}, i32Type);
        Value ofmap = get_comp(ins[1], "ofmap", memrefType);
        Value ofmap_in = get_comp(ins[2], "ofmap", memrefType);
        
        
        //four lanes for complex 16 bits x complex 8 bits
        // result in acc48, not sure what this type is and how large it should take
        for(int i = 0; i < 4; i++){
          
          Value ofmap_in_tensor = read_op(ofmap_in, stream_ofmap_in);
          write_op(ofmap_in_tensor, ofmap);
          
          // ofmap = psum = acc 
          Value unused;
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          
          
          Value ifmap_tensor = read_op(ins[3], stream_ifmap, ArrayRef<int64_t>{4});
          write_op(ifmap_tensor, ifmap);
          
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
          Value ofmap_tensor = read_op(ofmap);
          write_op(ofmap_tensor, ins[4], stream_ofmap_out);
        }
        return_op(ValueRange{});
      });
      done_signal.push_back(res[0]);
    }
  }
  await_op(ValueRange{done_signal[0], done_signal[1], done_signal[2], done_signal[3]});
  std_ret();
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}





