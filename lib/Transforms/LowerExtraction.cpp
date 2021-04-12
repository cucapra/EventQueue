#include "EQueue/Utils.h"
#include "llvm/ADT/SmallSet.h"
#include <queue>
#define DEBUG_TYPE "lower-extraction"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;

namespace { 

void getPermutation(std::vector<std::string> &new_ivs, std::string line_ivs, int i, llvm::ArrayRef<int64_t> &ubs){

  if(i < ubs.size()){
    for(int j = 0; j < ubs[i]; j++){
      line_ivs = line_ivs+"_"+std::to_string(j);
      getPermutation(new_ivs, line_ivs, i+1, ubs);
      line_ivs = line_ivs.substr(0, line_ivs.size()-1-std::to_string(j).size());
    }
  }
  else{
    new_ivs.push_back(line_ivs);
  }
}

Value duplicate(Operation *to_dup, PatternRewriter &rewriter, Location loc){
  rewriter.setInsertionPoint(to_dup);
  Operation* dup = rewriter.clone(*to_dup);
  //dup->setLoc(loc);
  for(int i = 0; i < dup->getNumOperands(); i++){
    Value new_operand = duplicate(dup->getOperand(i).getDefiningOp(), rewriter, loc);
    dup->setOperand(i, new_operand);
  }
  return dup->getResult(0);
}

struct SplatOpConversion : public OpRewritePattern<SplatOp> {
  using OpRewritePattern<SplatOp>::OpRewritePattern;
  SplatOpConversion(MLIRContext *context):OpRewritePattern<SplatOp>(context){
  }
  
  LogicalResult matchAndRewrite(SplatOp op,
                                PatternRewriter &rewriter) const override {
                                
    auto loc = op.getLoc();
    
    auto shape = op.getType().cast<VectorType>().getShape();
    std::vector<std::string> shape_string;
    std::string line = "";
    getPermutation(shape_string, line, 0, shape);

    Value one_comp = op.getOperand();

    for (auto iter = op.getResult().getUsers().begin(); iter != op.getResult().getUsers().end(); ){
      auto user = *iter;
      iter++;
      
      ScopedContext scope(rewriter, op.getParentRegion()->getLoc());
      rewriter.setInsertionPointAfter(user);
      int i = 0;
      auto comp_list = dyn_cast<xilinx::equeue::CreateCompOp>(user).getCompStrList();
      for(; i < user->getNumOperands(); i++){
        if( user->getOperand(i)==op.getResult()){
          user->setOperand(i, one_comp);
          break;
        }
      }

      Value first_comp = Value();
      for(auto s: shape_string){
        auto new_comp_list = comp_list;
        new_comp_list[i]+=s;

        if(first_comp == Value()){

          first_comp = create_comp(new_comp_list, user->getOperands());


        }else{

          Operation *to_dup = user->getOperand(i).getDefiningOp();

          Value dupped = duplicate(to_dup, rewriter, to_dup->getLoc());
          user->setOperand(i, dupped);

          rewriter.setInsertionPointAfter(first_comp.getDefiningOp());
          add_comp(first_comp, new_comp_list, user->getOperands());
        }
      }
      rewriter.replaceOp(user, first_comp);
    }

    
    

    rewriter.eraseOp(op);
    return success();
  }
};

struct ExtractOpConversion : public OpRewritePattern<ExtractElementOp> {
  using OpRewritePattern<ExtractElementOp>::OpRewritePattern;
  

  ExtractOpConversion(MLIRContext *context):OpRewritePattern<ExtractElementOp>(context){

  }
  
  LogicalResult matchAndRewrite(ExtractElementOp op, PatternRewriter &rewriter) const override{
    for(Value index: op.getIndices()){
      if(!index.getDefiningOp()) return failure();
      
      //affineApply
      if(!isa<ConstantIndexOp>(index.getDefiningOp())) return failure();
    }
    Value v = op.getOperand(0);
    while(isa<xilinx::equeue::LaunchOp>(v.getDefiningOp())){
      auto launch_op = v.getDefiningOp();
      int i = 1;
      for(; i < launch_op->getNumResults(); i++){
        if( launch_op->getResult(i)==v) break;
      }
      v = launch_op->getRegion(0).front().getTerminator()->getOperand(i-1);
    }

    xilinx::equeue::GetCompOp extract_from = cast<xilinx::equeue::GetCompOp>(v.getDefiningOp());
    std::string new_comp = extract_from.getName().str();
    for(Value index: op.getIndices()){
      new_comp += "_"+std::to_string(cast<ConstantIndexOp>(index.getDefiningOp()).getValue());
    }
    
    ScopedContext scope(rewriter, op.getParentRegion()->getLoc());
    rewriter.setInsertionPoint(op);
    Value indexed_comp = get_comp(extract_from.getCompHandler(), new_comp);
    op.getResult().replaceAllUsesWith(indexed_comp);
    rewriter.eraseOp(op);
    return success();
  }

};



struct LowerExtractionPass: public PassWrapper<LowerExtractionPass, FunctionPass> {

  LowerExtractionPass()=default; 
  LowerExtractionPass(const LowerExtractionPass& pass) {}
  

  void runOnFunction() override;
};

void LowerExtractionPass::runOnFunction() {



    MLIRContext *context = &getContext();
   
    OwningRewritePatternList patterns;
    patterns.insert<SplatOpConversion>(context);
    patterns.insert<ExtractOpConversion>(context);


    
    ConversionTarget target(getContext());
    target.addLegalDialect<xilinx::equeue::EQueueDialect>();
    if (failed(applyPartialConversion(getFunction(), target,  std::move(patterns)))){
      signalPassFailure();
    }
    auto f = getFunction();
    f.walk([&](xilinx::equeue::LaunchOp op) {
      llvm::SmallSet<unsigned, 6> indices;
      for(auto res: op.getResults()){
        if(res.use_empty()){
          unsigned idx = res.getResultNumber();
          if(idx>0) indices.insert(idx);
        }
      }
                    //llvm::outs()<<"done\n";

      if(!indices.empty()){
        //op.dump();
        Operation* yieldOp = op.getRegion().front().getTerminator();
        //yieldOp->dump();
        for(auto i : indices){
          yieldOp->eraseOperand(i-1);

        }
        Value start = op.getStartSignal();
        Value device = op.getDeviceHandler();
        ValueRange operands = op.getLaunchOperands();
        OpBuilder builder(context);
        ScopedContext scope(builder, op.getParentRegion()->getLoc());
        builder.setInsertionPoint(op.getOperation());
        ValueRange newOp_res = LaunchOpBuilder( start, device, operands, 
        [&](ValueRange ins){
          return_op( yieldOp->getOperands());
          //tmp.op.dump();
        });

        auto newOp = newOp_res[0].getDefiningOp();
        //newOp->dump();
        BlockAndValueMapping mapper;
        newOp->getRegion(0).getBlocks().clear();
        op.getRegion().cloneInto(&newOp->getRegion(0), mapper);
        int j = 0;
        //rewriter.replaceOp(op, newOp.getResults());
        for(int idx = 0; idx < op.getNumResults(); idx++){
          if(indices.count(idx)) continue;

          op.getResult(idx).replaceAllUsesWith(newOp->getResult(j));

          j++;
        }

        //op.getOperation()->replaceAllUsesWith(newOp->getResults());
        op.erase();

      }
    });
    
}

} // end anonymous namespace

void equeue::registerLowerExtractionPass() {
    PassRegistration<LowerExtractionPass>(
      "lower-extraction",
      "...");
}
