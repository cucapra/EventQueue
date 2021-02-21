#include "Generator/EQueueGenerator.h"
#include "llvm/ADT/SmallVector.h"
#include <string>     


using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace std;
void MLIRGenImpl::firSingleKernelGenerator(){
  theModule = mlir::ModuleOp::create(builder.getUnknownLoc());

  //auto indexType = IndexType::get(&context);
  auto f32Type = builder.getF32Type();
  auto ifmapType = RankedTensorType::get({7,7}, f32Type);
  auto filterType = RankedTensorType::get({5,5}, f32Type);
  auto ofmapType = RankedTensorType::get({3,3}, f32Type);
  auto f =
      makeFunction("graph", {ofmapType}, {ifmapType, filterType});
  theModule.push_back(f);

  
  theModule.print(llvm::outs());
  llvm::outs()<<"\n";
}




