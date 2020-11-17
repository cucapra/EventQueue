
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Dialect/SCF/EDSC/Builders.h"
#include "mlir/Transforms/DialectConversion.h"


#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EDSC/Intrinsics.h"

#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Verifier.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Passes.h"

#include "mlir/Dialect/Affine/EDSC/Intrinsics.h"
#include "mlir/Dialect/Linalg/EDSC/Builders.h"
#include "mlir/Dialect/Linalg/EDSC/Intrinsics.h"
#include "mlir/Dialect/SCF/EDSC/Intrinsics.h"
#include "mlir/Dialect/StandardOps/EDSC/Intrinsics.h"
#include "mlir/Dialect/Vector/EDSC/Intrinsics.h"
#include "mlir/Analysis/Liveness.h"


#include <string>
#include "EQueue/EQueuePasses.h"
#include "EQueue/EQueueOps.h"

#define DEBUG_TYPE "structure-matching"

using namespace mlir;
using namespace mlir::scf;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;


namespace {
struct StructureMatchingPass: public PassWrapper<StructureMatchingPass, FunctionPass> {
  StructureMatchingPass()=default; 
 
  std::string structName="pe_array";
  
  void runOnFunction() override {

    auto f = getFunction();

    // Populate the worklist with the operations that need shape inference:
    // these are operations that return a dynamic shape.

    mlir::Operation *launchOp=nullptr;
    mlir::Operation *parallelOp=nullptr;
    f.walk([&](mlir::Operation *op) {
      if (!launchOp && isa<LaunchOp>(op))
        launchOp = op;
      if (!parallelOp && isa<scf::ParallelOp>(op))
        parallelOp = op;
    });
    //TODO: GET ACCEL
    auto &region = launchOp->getRegion(0);
    auto &block = region.front();
    Value accel = launchOp->getOperand(2);
    accel.getDefiningOp();
    Value match_comp;
    for(auto comp_op: accel.getDefiningOp()->getOperands()){
    //llvm::outs()<<comp_op.getDefiningOp()->getAttr("name").cast<StringAttr>().getValue()<<"\n";
      if(comp_op.getDefiningOp()->getAttr("name").cast<StringAttr>().getValue()==structName){
        match_comp = comp_op.getDefiningOp()->getOperand(0);
        //llvm::outs()<<"found\n"<<match_comp<<"\n";
        break;
      }
    }
    
    OpBuilder builder(&getContext());
    builder.setInsertionPointToStart(&block);
    ScopedContext scope(builder, accel.getLoc());
    //llvm::outs()<<match_comp.getType()<<"\n";
    Value pe_array(get_comp(accel, structName, match_comp.getType()));
    
    auto &region2 = parallelOp->getRegion(0);
    auto &block2 = region2.front();
    //llvm::outs()<<*block2.begin()<<"\n";
    Liveness liveness(parallelOp);
    auto &allInValues = liveness.getLiveOut(&block2);
    llvm::SmallVector<Value, 16> invalues;
    for(auto invalue: allInValues){
      //llvm::outs()<<invalue<<"\n";
      invalues.push_back(invalue);
    }
    ValueRange invaluerange(invalues);
    builder.setInsertionPointToStart(&block2);
    if(auto pop = llvm::dyn_cast<ParallelOp>(parallelOp) ){
    
      ValueRange indexing = pop.getInductionVars();
      Value pe(std_extract_element(pe_array, indexing));
      //TODO: analyze and get core
      Value proc = get_comp(pe,"proc");
      Value signal = start_op();
      ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
        return_op(ValueRange{});
      });
      //builder.setInsertionPoint(pe_res[0].getDefiningOp());
    }
  }
};
} // end anonymous namespace

void equeue::registerEQueuePasses() {
    PassRegistration<StructureMatchingPass>(
      "match-equeue-structure",
      "add structure to parallel op");
}
