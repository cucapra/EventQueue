
#include "EQueue/Utils.h"

#define DEBUG_TYPE "equeue-read-write"



namespace {
struct EQueueReadOpConversion : public OpRewritePattern<AffineLoadOp> {
  using OpRewritePattern<AffineLoadOp>::OpRewritePattern;
  EQueueReadOpConversion(MLIRContext *context):OpRewritePattern<AffineLoadOp>(context){
  }
  
  LogicalResult matchAndRewrite(AffineLoadOp op,
                                PatternRewriter &rewriter) const override {
                                
    auto loc = op.getLoc();
    Value readOp = rewriter.create<xilinx::equeue::MemReadOp>(loc, op.getOperand(0), ArrayRef<int64_t>{1});
    rewriter.replaceOp(op, readOp);
    return success();
  }
};

struct EQueueWriteOpConversion : public OpRewritePattern<AffineStoreOp> {
  using OpRewritePattern<AffineStoreOp>::OpRewritePattern;
  EQueueWriteOpConversion(MLIRContext *context):OpRewritePattern<AffineStoreOp>(context){
  }
  
  LogicalResult matchAndRewrite(AffineStoreOp op,
                                PatternRewriter &rewriter) const override {
                                
    auto loc = op.getLoc();
    rewriter.create<xilinx::equeue::MemWriteOp>(loc, op.getOperand(0),op.getOperand(1));
    rewriter.eraseOp(op);
    return success();
  }
};


struct EqueueReadWritePass: public PassWrapper<EqueueReadWritePass, FunctionPass> {

  EqueueReadWritePass()=default; 
  EqueueReadWritePass(const EqueueReadWritePass& pass) {}
  
  void runOnFunction() override;
};

void EqueueReadWritePass::runOnFunction() {


    MLIRContext *context = &getContext();
   
    OwningRewritePatternList patterns;
    patterns.insert<EQueueReadOpConversion>(context);
    patterns.insert<EQueueWriteOpConversion>(context);
    
    ConversionTarget target(getContext());
    target.addLegalDialect<xilinx::equeue::EQueueDialect, StandardOpsDialect>();

    if (failed(applyPartialConversion(getFunction(), target,  std::move(patterns))))
      signalPassFailure();
  }

} // end anonymous namespace

void equeue::registerEqueueReadWritePass() {
    PassRegistration<EqueueReadWritePass>(
      "equeue-read-write",
      "affine load and store to equeue read and write");
}
