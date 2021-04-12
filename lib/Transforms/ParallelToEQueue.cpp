#include "EQueue/Utils.h"
#include "llvm/ADT/SmallSet.h"
#define DEBUG_TYPE "parallel-to-equeue"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

struct ParallelToEQueue : public PassWrapper<ParallelToEQueue, FunctionPass>  {


  ParallelToEQueue() = default;
  ParallelToEQueue(const ParallelToEQueue& pass) {}
  
  void runOnFunction() override;
};

} // end anonymous namespace

void getPermutation(std::vector<std::vector<int>> &new_ivs, std::vector<int> line_ivs, int i, llvm::SmallVector<int, 20> &ubs){

  if(i < ubs.size()){
    for(int j = 0; j < ubs[i]; j++){
      line_ivs.push_back(j);
      getPermutation(new_ivs, line_ivs, i+1, ubs);
      line_ivs.pop_back();
    }
  }
  else{
    new_ivs.push_back(line_ivs);
  }
}

void ParallelToEQueue::runOnFunction() {

  FuncOp f = getFunction();
  OpBuilder builder(&getContext());
  
  llvm::SmallSet<Region *, 20> regions;

  //if(!indices.empty()) parallelIndices = indices.vec();
  f.walk([&](Operation* op) {
    if(isa<xilinx::equeue::MemCopyOp>(op) || isa<xilinx::equeue::LaunchOp>(op)){
      if(isa<AffineParallelOp>(op->getParentOp()) && regions.count(op->getParentRegion())==0){
        regions.insert(op->getParentRegion());
      }
    }
  });
  
  for(auto region: regions){
    auto op = &region->front().front();

    llvm::SmallVector<int, 20> ubs;
    llvm::SmallVector<Value, 20> ivs;
    while(auto Op = dyn_cast<AffineParallelOp>(op->getParentOp())){
      auto range = Op.getConstantRanges().getValue();
      for(auto r: range){
        ubs.push_back(r);
      }
      for(auto iv:Op.getIVs()){
        ivs.push_back(iv);
      }
      op = op->getParentOp();
    }

    std::vector<std::vector<int>> new_ivs;
    std::vector<int> line_ivs;
    getPermutation(new_ivs, line_ivs, 0, ubs);

    
    for(int i = 0; i < op->getBlock()->getNumArguments(); i++){
      Value arg = op->getBlock()->getArgument(i);
      region->front().addArgument(arg.getType());
    }
    builder.setInsertionPointToStart( op->getParentOp()->getBlock() );
    ScopedContext scope(builder, op->getParentRegion()->getLoc());

    for(auto bounds: new_ivs){
      BlockAndValueMapping map;
      for(int i = 0; i < bounds.size(); i++){
        Value c = std_constant_index(bounds[i]);
        map.map(ivs[i], c);  
        
      }
      region->cloneInto(op->getParentRegion(), map);
    }
    //auto tmp = op->getParentOp();
    Block* firstBlock = nullptr;

    for(auto& block: *op->getParentRegion()){
      if(!firstBlock){
        firstBlock = &block;
        continue;
      }

      for(auto iter = block.begin(); iter!=block.end(); ){
        auto iter2=iter;
        iter++;
        if(isa<AffineYieldOp>(*iter2)){
          break;
        }
        iter2->moveBefore(&firstBlock->back());//affine.yield
      }
    }

    builder.setInsertionPoint(&firstBlock->back());
    Value signal=Value(), prev_signal=Value();
    for(auto &op: firstBlock->getOperations()){
      if(isa<xilinx::equeue::LaunchOp>(op) || isa<xilinx::equeue::MemCopyOp>(op)){
        signal=op.getResult(0);
        if(prev_signal==Value()){
          prev_signal = signal;
        }else{
          prev_signal = control_and(ValueRange{prev_signal, signal});

        }
      }
    }
    await_op(ValueRange{prev_signal});

    

    auto iter = op->getParentRegion()->begin();
    iter++;
    for(; iter!= op->getParentRegion()->end();){
      auto iter2 = iter;
      iter++;
      iter2->erase();
    }

    //op->getParentRegion()->front().dump();
    op->erase();
    
    
  }

}


void equeue::registerParallelToEQueuePass() {
    PassRegistration<ParallelToEQueue>(
      "parallel-to-equeue",
      "...");
}
