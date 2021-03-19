#include "EQueue/Utils.h"
#define DEBUG_TYPE "mem-copy"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

struct AddLoop : public PassWrapper<AddLoop, FunctionPass>  {


  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("region index in post order to decide where to insert memcpy"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> loops {*this, "loops", llvm::cl::desc("parallel loops in post order to tell loop size"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> orders {*this, "orders", llvm::cl::desc("0/1 in post order to decide insert from the region front or back"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  AddLoop() = default;
  AddLoop(const AddLoop& pass) {}

  void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
};

} // end anonymous namespace

void AddLoop::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  
  
  //post-order transversal
  llvm::SmallVector<Region *, 20> regions;
  walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
    regions.push_back(&region);
  });
  //the first region is funcop region
  regions.erase(regions.begin());
//replaceAllUsesInRegionWith
  for(auto i = 0; i < indices.size(); i++){

    auto region = regions[indices[i]];
    builder.setInsertionPointToStart(&region->front());

    ScopedContext scope(builder, region->getLoc());
    Value lb = std_constant_index(0), ub = std_constant_index(loops[i]);
    affineLoopBuilder({lb}, {ub}, {1}, [&](ValueRange ivs){

    });
 
  }

}


void equeue::registerAddLoopPass() {
    PassRegistration<AddLoop>(
      "add-loop",
      "...");
}
