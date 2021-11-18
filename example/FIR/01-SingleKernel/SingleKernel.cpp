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
  auto ifmapType = RankedTensorType::get({N}, i32Type);
  auto ofmapType = RankedTensorType::get({N-32+1}, i32Type);
  auto f =
      makeFunction("graph", {}, {ifmapType});
  theModule.push_back(f);
  ScopedContext scope(builder, f.getLoc());
  
  Value sin = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sin = alloc_op(sin, ArrayRef<int64_t>{N}, 32, i32Type);  
  Value sout = create_mem(ArrayRef<int64_t>{32}, 32, "SINK");
  sout = alloc_op(sout, ArrayRef<int64_t>{N-32+1}, 32, i32Type); 
  
  Value proc = create_proc("AIEngine");
  Value data = create_mem(ArrayRef<int64_t>{32}, 32, "RegisterFile");//delay line
  Value taps = create_mem(ArrayRef<int64_t>{32}, 32, "RegisterFile");//coeff
  Value acc = create_mem(ArrayRef<int64_t>{4}, 32, "RegisterFile");//coeff
  
  Value aie = create_comp(ArrayRef<std::string>{"proc", "data", "taps", "acc"}, ValueRange{proc, data, taps, acc});
  
  Value sin_connection = connection("Streaming", 1024);
  Value sout_connection = connection("Streaming", 1024);
  write_op(f.getArgument(0), sin, sin_connection, ArrayRef<int64_t>{N});
  
  Value signal = start_op();
  auto res = LaunchOpBuilder(signal, proc, ValueRange{aie}, [&](ValueRange ins){
      
      Value ifmap = alloc_op(get_comp(ins[0], "data"), ArrayRef<int64_t>{ 16 }, 32, i32Type);
      Value filter = alloc_op(get_comp(ins[0], "taps"), ArrayRef<int64_t>{ 8 }, 32, i32Type);
      Value ofmap = alloc_op(get_comp(ins[0], "acc"), ArrayRef<int64_t>{ 4 }, 32, i32Type);
      add_comp(ins[0], ArrayRef<std::string>{"ifmap", "filter", "ofmap"}, ValueRange{ifmap, filter, ofmap});
      return_op(ValueRange{});
  });
  await_op(ValueRange{res[0]});
  res = LaunchOpBuilder(signal, proc, ValueRange{sin_connection, sout_connection, aie, sin, sout}, [&](ValueRange ins){
    
    auto memrefType = MemRefType::get({16}, i32Type);
    Value ifmap = get_comp(ins[2], "ifmap", memrefType);
    memrefType = MemRefType::get({8}, i32Type);
    Value filter = get_comp(ins[2], "filter", memrefType);
    memrefType = MemRefType::get({4}, i32Type);
    Value ofmap = get_comp(ins[2], "ofmap", memrefType);
    
    memrefType = MemRefType::get({4}, i32Type);
    for(int i = 0; i < N/32; i++){
      for(int j = 0; j < 32/4; j++){
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
        Value ifmap_tensor = read_op(ins[3], ins[0], ArrayRef<int64_t>{4});
        write_op(ifmap_tensor, ifmap, ArrayRef<int64_t>{4});
        
        unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
        unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
        unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
        unused = unk_op("mac4", ValueRange{ofmap, ifmap, filter},  memrefType);
      }
    }
    return_op(ValueRange{});
  });
  await_op(ValueRange{res[0]});
  std_ret();
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}

