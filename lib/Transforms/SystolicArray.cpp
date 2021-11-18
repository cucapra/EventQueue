
#include "EQueue/Utils.h"

#define DEBUG_TYPE "systolic-array"


namespace {
// add read from i and write to i+1 pass
// i.e.
// buffer[i] = get_comp(...)
// value[i] = read(buffer[i])
// buffer[i+1] = get_comp()
// write(value[i], buffer[i+1])

//latter we will add two launch operation and split loop

struct SystolicArrayPass: public PassWrapper<SystolicArrayPass, FunctionPass> {

//XXX(Zhijing): maybe remove ofmap
  ListOption<std::string> buffer_names {*this, "buffer-names", llvm::cl::desc("pe_array@(ibuffer&wbuffer=>obuffer) "), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<std::string> launcher_names {*this, "launcher-names", llvm::cl::desc("pe_array@proc"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  
  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("parallel for index in post order to decide where to put systolic array structure"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  SystolicArrayPass()=default; 
  SystolicArrayPass(const SystolicArrayPass& pass) {}
  
  void runOnFunction() override;
  GenericStructure generic;
};

void SystolicArrayPass::runOnFunction() {
    auto f = getFunction();
    MLIRContext *context = &getContext();
    OpBuilder builder(context);
    generic.buildIdMap(f);
    
    //pre-order transversal
    llvm::SmallVector<AffineParallelOp, 20> parOps;
    walkRegions(*f.getCallableRegion(), [&](Block &block) { 
      for(auto op: block.getOps<AffineParallelOp>()){
        parOps.push_back(op);
      }
    }, [&](Region &region) { });
  
    
    std::vector<std::vector<std::string>> buffer_list;
    trancate(buffer_list, buffer_names);
    std::vector<std::vector<std::string>> launcher_list;
    trancate(launcher_list, launcher_names);

    equeue::LaunchOp launchOp;
    for(equeue::LaunchOp op : f.getOps<equeue::LaunchOp>()){
      launchOp = op;
      break;
    }
    /*
    auto accel = launchOp.getRegion().front().getArgument(0);
    auto accel_original = launchOp.getLaunchOperands()[0];
    for (auto i = 0; i < indices.size(); i++){
      auto parOp = parOps[indices[i]];
      mlir::Region* region = parOp.getRegion();
      auto launcher = launcher_list[i];
      builder.setInsertionPointAfter(&parOp);
      auto proc = generic.getField(builder, region, structs, 0, accel, accel_original)[0];
      //llvm::outs()<<proc<<"\n";
      ScopedContext scope(builder, region->getLoc());
      Value signal = start_op();
      ValueRange invaluerange;//TODO: find in values of launch block
      ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
        filter = read_op(ins[0]);
        return_op(ValueRange{filter});
      });
      }
      //////===============================
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
    }*/
    
    //OwningRewritePatternList patterns;
    //patterns.insert<ParallelOpConversion>(original_region, context);
    
    //ConversionTarget target(getContext());
    //target.addLegalDialect<equeue::EQueueDialect, StandardOpsDialect>();

    //if (failed(applyPartialConversion(f, target, patterns)))
    //  signalPassFailure();
  }

} // end anonymous namespace

void equeue::registerSystolicArrayPass() {
    PassRegistration<SystolicArrayPass>(
      "systolic-array-structure",
      "add systolic array structure to certain loop");
}
