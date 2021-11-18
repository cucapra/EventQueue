#include "Generator/EQueueGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     


using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace std;

void unkOpRegionBuilder(ValueRange args) {
   assert(args.size() == 3 && "expected 3 block arguments");
   Value a(args[0]), b(args[1]), c(args[2]);
   linalg_yield( ValueRange{unk_op("mac", ValueRange{c, a, b},  a.getType())} );
 }
 

void MLIRGenImpl::linalgGenerator(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());


  auto f32Type = builder.getF32Type();

  auto func =
      makeFunction("graph", {}, {});
  theModule.push_back(func);
  
  ScopedContext scope(builder, func.getLoc());
  
  SmallVector<int64_t, 1> peShape;
  peShape.push_back(accel_config.array_height);//12
  peShape.push_back(accel_config.array_width);//14
  Value proc, mem, comp;
  proc = create_proc("AIEngine");
  mem = create_mem(ArrayRef<int64_t>{ 3 }, 32, "RegisterFile", 1);
  Value dma = builder.create<equeue::CreateDMAOp>(func.getLoc()).getResult();
  comp = create_comp(ArrayRef<std::string>{"proc", "mem", "dma"}, ValueRange{proc, mem, dma});
  comp = std_splat( comp, VectorType::get(peShape, comp.getType()) );
  //comp = create_comp("pe_array", comp);

  Value sram(create_mem(ArrayRef<int64_t>{ 4096 }, 32, "SRAM", 16));
  Value processor(create_proc("MicroPlate") );
  Value accel = create_comp(ArrayRef<std::string>{"pe_array","proc", "mem"},
  ValueRange{comp, processor, sram, dma} );
  
  /// -------------------
  /// --    control    --
  /// -------------------
  int B=1, H, W, KH, KW, C, F, S, EH, EW;
  H = layer_config.ifmap_height;
  W = layer_config.ifmap_width;
  KH = layer_config.filter_height;
  KW = layer_config.filter_width;
  C = layer_config.channel;
  F = layer_config.num_filter;
  S = layer_config.stride;
  EH = (H-KH+S)/S;
  EW = (H-KW+S)/S;

  
  //XXX(Zhijing): not sure why we cannot use aliasing here
  Value signal = start_op();
  LaunchOpBuilder(signal, processor, ValueRange{accel}, 
    [&](ValueRange ins){
      accel = ins[0];
      sram = get_comp(accel, "mem");
      void (*func)(ValueRange);
      func = &(unkOpRegionBuilder);
      
      Value ibuffer = alloc_op(sram, ArrayRef<int64_t>{ B, H, W, C }, 32, f32Type);//b,h,w,c
      add_comp(accel, ArrayRef<std::string>{"ibuffer"}, ValueRange{ibuffer});
      Value wbuffer = alloc_op(sram, ArrayRef<int64_t>{ KH, KW, C, F }, 32, f32Type);//kh, kw, c, f
      add_comp(accel, ArrayRef<std::string>{"wbuffer"}, ValueRange{wbuffer});
      
      Value obuffer = alloc_op(sram, ArrayRef<int64_t>{ B, EH, EW, F }, 32, f32Type);//b, h, w, f
      add_comp(accel, ArrayRef<std::string>{"obuffer"}, ValueRange{obuffer});

          auto subview_ibuffer = std_sub_view(ibuffer,
          llvm::ArrayRef<int64_t>({0,0,0,0}),//offset
          llvm::ArrayRef<int64_t>({B,EH,EW,C}), //size = b, eh, ew, c
          llvm::ArrayRef<int64_t>({1,S,S,S}), //stride
          ValueRange{}, ValueRange{}, ValueRange{});//not sure why we need this after static assignment
          //ifmap[batch, h, w, c]
          //filter[h, w, c, num]
          //ofmap[batch, h, w, num]
          
              auto par = IteratorType::Parallel;
              auto red = IteratorType::Reduction;

              AffineExpr b, f, h, w, kh, kw, c;
              bindDims(builder.getContext(), b, f, h, w, kh, kw, c);
              unsigned numDims = c.cast<AffineDimExpr>().getPosition() + 1;
              StructuredIndexed I(subview_ibuffer), W(wbuffer), O(obuffer);
              mlir::edsc::makeGenericLinalgOp(
                {par, par, par, par, par, par, par}, {
                  I({b,
                     // Roundtrip to flattened form to serve as canonicalization and ensure
                     // consistent ordering of subexpressions.
                     simplifyAffineExpr(h, numDims, 0),
                     simplifyAffineExpr(w, numDims, 0),
                     c}), W({kh, kw, c, f})}, 
                  {O({b, h, w, f})},
              func);    
      return_op(ValueRange{});
  });
  std_ret();
  
  
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}





