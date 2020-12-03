
#include "EQueue/Utils.h"

#define DEBUG_TYPE "structure-matching"



///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/memcpy.mlir -match-equeue-structure="indices=8 structs-names=pe_array@proc" > ../test/LoweringPipeline/match_struct.mlir
namespace {
struct ParallelOpConversion : public OpRewritePattern<xilinx::equeue::LaunchOp> {
  using OpRewritePattern<xilinx::equeue::LaunchOp>::OpRewritePattern;
  Region *inline_region;
  ParallelOpConversion(Region *region, MLIRContext *context):OpRewritePattern<xilinx::equeue::LaunchOp>(context){
    inline_region=region;
  }
  
  LogicalResult matchAndRewrite(xilinx::equeue::LaunchOp op,
                                PatternRewriter &rewriter) const override {
                                
    auto launchOp = op.clone();

    rewriter.inlineRegionBefore(*inline_region, launchOp.region(), launchOp.region().end());
    rewriter.replaceOp(op, launchOp.getResults());
    
      //rewriter.inlineRegionBefore(region2, launch_pe->region(), launch_pe->region.end());
    //} */   
    return success();
  }
};



struct StructureMatchingPass: public PassWrapper<StructureMatchingPass, FunctionPass> {

  ListOption<std::string> structs_names {*this, "structs-names", llvm::cl::desc("..."), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("give index in post order to decide where to insert launch"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  StructureMatchingPass()=default; 
  StructureMatchingPass(const StructureMatchingPass& pass) {}
  
  void runOnFunction() override;
  GenericStructure generic;
};

void StructureMatchingPass::runOnFunction() {
    auto f = getFunction();
    MLIRContext *context = &getContext();
    OpBuilder builder(context);
    generic.buildIdMap(f);
    
    //pre-order transversal
    llvm::SmallVector<Region *, 20> regions;
    walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
      regions.push_back(&region);
    });
  
    //the first region is funcop region
    regions.erase(regions.begin());
    
    std::vector<std::vector<std::string>> structs_list;
    trancate(structs_list, structs_names);

    xilinx::equeue::LaunchOp launchOp;
    for(xilinx::equeue::LaunchOp op : f.getOps<xilinx::equeue::LaunchOp>()){
      launchOp = op;
      break;
    }
    auto accel = launchOp.getRegion().front().getArgument(0);
    auto accel_original = launchOp.getLaunchOperands()[0];
    for (auto i = 0; i < indices.size(); i++){
      
      auto region = regions[indices[i]];
      auto structs = structs_list[i];
      builder.setInsertionPointToStart(&region->front());
      auto proc = generic.getField(builder, region, i, structs, 0, accel, accel_original)[0];
      //llvm::outs()<<proc<<"\n";
      ScopedContext scope(builder, region->getLoc());
      Value signal = start_op();
      ValueRange invaluerange;//TODO: find in values of launch block
      ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
        return_op(ValueRange{});
      });
      auto *launch_operation = pe_res[0].getDefiningOp();
      auto launch_next = ++Block::iterator(launch_operation);
      auto *split_block = region->front().splitBlock(launch_next);
      auto *final_block = split_block->splitBlock(&split_block->back());
      split_block->moveBefore(&launch_operation->getRegion(0).back());    
      (++Region::iterator(split_block))->front().moveBefore(split_block, split_block->end());
      (++Region::iterator(split_block))->erase();
      
      final_block->front().moveBefore(&region->front(),
        region->front().end());
      final_block->erase();
    }
    
    //OwningRewritePatternList patterns;
    //patterns.insert<ParallelOpConversion>(original_region, context);
    
    //ConversionTarget target(getContext());
    //target.addLegalDialect<xilinx::equeue::EQueueDialect, StandardOpsDialect>();

    //if (failed(applyPartialConversion(f, target, patterns)))
    //  signalPassFailure();
  }

} // end anonymous namespace

void equeue::registerEQueuePasses() {
    PassRegistration<StructureMatchingPass>(
      "match-equeue-structure",
      "add structure to parallel op");
}
