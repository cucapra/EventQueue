
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
#include "mlir/IR/Visitors.h"
#include "mlir/IR/BlockSupport.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Passes.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Transforms/Utils.h"

#include "mlir/Dialect/Affine/EDSC/Intrinsics.h"
#include "mlir/Dialect/Linalg/EDSC/Builders.h"
#include "mlir/Dialect/Linalg/EDSC/Intrinsics.h"
#include "mlir/Dialect/SCF/EDSC/Intrinsics.h"
#include "mlir/Dialect/StandardOps/EDSC/Intrinsics.h"
#include "mlir/Dialect/Vector/EDSC/Intrinsics.h"
#include "mlir/Analysis/Liveness.h"

#include <map>
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
struct ParallelOpConversion : public OpRewritePattern<xilinx::equeue::LaunchOp> {
  using OpRewritePattern<xilinx::equeue::LaunchOp>::OpRewritePattern;
  Region *inline_region;
  ParallelOpConversion(Region *region, MLIRContext *context):OpRewritePattern<xilinx::equeue::LaunchOp>(context){
    inline_region=region;
  }
  
  LogicalResult matchAndRewrite(xilinx::equeue::LaunchOp op,
                                PatternRewriter &rewriter) const override {
    //auto region = op.region();
    
    auto launchOp = op.clone();

    
    rewriter.inlineRegionBefore(*inline_region, launchOp.region(), launchOp.region().end());
    rewriter.replaceOp(op, launchOp.getResults());
    
      //rewriter.inlineRegionBefore(region2, launch_pe->region(), launch_pe->region.end());
    //} */   
    return success();
  }
};

struct StructureMatchingPass: public PassWrapper<StructureMatchingPass, FunctionPass> {
  StructureMatchingPass()=default; 
 
  std::string structName="pe_array";
  
  void runOnFunction() override {
    
    auto f = getFunction();
    MLIRContext *context = &getContext();
    
    
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
      if(comp_op.getDefiningOp()->getAttr("name").cast<StringAttr>().getValue()==structName){
        match_comp = comp_op.getDefiningOp()->getOperand(0);
        break;
      }
    }
    OpBuilder builder(&getContext());
    builder.setInsertionPointToStart(&block);
    ScopedContext scope(builder, accel.getLoc());
    Value pe_array(get_comp(accel, structName, match_comp.getType()));
    

    auto *original_region = &parallelOp->getRegion(0);
    
    Liveness liveness(parallelOp);
    auto &allInValues = liveness.getLiveOut(&parallelOp->getRegion(0).front());
    llvm::SmallVector<Value, 16> invalues;
    for(auto invalue: allInValues){
      invalues.push_back(invalue);
    }
    ValueRange invaluerange(invalues);
    builder.setInsertionPointToStart(&parallelOp->getRegion(0).front());
    
    ValueRange indexing = dyn_cast<ParallelOp>(parallelOp).getInductionVars();

    Value pe = std_extract_element(pe_array, indexing);
    //TODO: analyze and get core      
    Value proc = get_comp(pe,"proc");
    Value signal = start_op();
    ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
      return_op(ValueRange{});
    });
    auto *launch_pe = pe_res[0].getDefiningOp();
    auto launch_next = ++Block::iterator(launch_pe);
    auto *split_block = parallelOp->getRegion(0).front().splitBlock(launch_next);
    auto *final_block = split_block->splitBlock(&split_block->back());
    split_block->moveBefore(&launch_pe->getRegion(0).back());    
    (++Region::iterator(split_block))->front().moveBefore(split_block, split_block->end());
    (++Region::iterator(split_block))->erase();
    
    final_block->front().moveBefore(&parallelOp->getRegion(0).front(),
      parallelOp->getRegion(0).front().end());
    final_block->erase();
    //OwningRewritePatternList patterns;
    //patterns.insert<ParallelOpConversion>(original_region, context);
    
    //ConversionTarget target(getContext());
    //target.addLegalDialect<xilinx::equeue::EQueueDialect, StandardOpsDialect>();

    //if (failed(applyPartialConversion(f, target, patterns)))
    //  signalPassFailure();
  }
};
} // end anonymous namespace

void equeue::registerEQueuePasses() {
    PassRegistration<StructureMatchingPass>(
      "match-equeue-structure",
      "add structure to parallel op");
}
