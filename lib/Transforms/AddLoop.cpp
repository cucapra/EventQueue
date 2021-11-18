#include "EQueue/Utils.h"
#define DEBUG_TYPE "mem-copy"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

struct AddLoop : public PassWrapper<AddLoop, FunctionPass>  {


  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("region index in post order to decide where to insert loop"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> loops {*this, "loops", llvm::cl::desc("loop size"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> empty {*this, "empty", llvm::cl::desc("1/0 to decide if include the whole region"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> from {*this, "from", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> to {*this, "to", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  AddLoop() = default;
  AddLoop(const AddLoop& pass) {}
  
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
    if(from.size()&&to.size()) assert(from[i]<=to[i]);
    auto region = regions[indices[i]];
    auto iter = region->front().begin();
    if(from.size()){
      for(int j = 1; j < from[i]; j++){
        iter++;
      }
    }
    builder.setInsertionPoint(&region->front(), iter);

    ScopedContext scope(builder, region->getLoc());
    Value lb = std_constant_index(0), ub = std_constant_index(loops[i]);
    affineLoopBuilder({lb}, {ub}, {1}, [&](ValueRange ivs){
    });
    Operation *affineOp;
    for(auto u:lb.getUsers()){
      affineOp = u;
    }
    auto iter2 = --region->front().end();
    if(to.size()){
      int j = 0;
      iter2=iter;
      if(from.size()){
        j = from[i];
      }
      for(; j < to[i]; j++){
        iter2++;
      }
    }
    //iter2->dump();
    if(empty.size() && empty[i]==0){
      for(auto it = ++Block::iterator( affineOp ); it!=iter2;){
          auto it2=it;
          it++;
          it2->moveBefore(&*(--affineOp->getRegion(0).front().end()));//affine.yield
      }
    }
  }

}


void equeue::registerAddLoopPass() {
    PassRegistration<AddLoop>(
      "add-loop",
      "...");
}
