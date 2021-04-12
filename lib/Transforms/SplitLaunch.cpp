
#include "EQueue/Utils.h"

#define DEBUG_TYPE "structure-matching"



///sh run.sh; ./bin/equeue-opt ../test/LoweringPipeline/memcpy.mlir -match-equeue-structure="indices=8 structs-names=pe_array@proc from=0 to=5" > ../test/LoweringPipeline/match_struct.mlir


struct SplitLaunch: public PassWrapper<SplitLaunch, FunctionPass> {

  ListOption<unsigned> indices {*this, "indices", llvm::cl::desc("launch index in post order to decide which launch to split"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
  ListOption<unsigned> at {*this, "at", llvm::cl::desc("block iterator in post order to decide splitting point"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};

  SplitLaunch()=default; 
  SplitLaunch(const SplitLaunch& pass) {}
  
  void runOnFunction() override;
};

void SplitLaunch::runOnFunction() {
    auto f = getFunction();
    MLIRContext *context = &getContext();
    OpBuilder builder(context);

    
    //pre-order transversal
    llvm::SmallVector<xilinx::equeue::LaunchOp, 20> launchOps;
    f.walk([&](xilinx::equeue::LaunchOp op) {
      launchOps.push_back(op);
    });
    



    for (auto i = 0; i < indices.size(); i++){
      
      auto launchOp = launchOps[indices[i]];

      auto region = &launchOp.getRegion();
      auto launch_next = region->front().begin();//++Block::iterator(launch_operation);
      auto start_it = launch_next, end_it=launch_next;
      if(at.size()>0){
        for(int j = 0; j < at[i]; j++){
          end_it++;
        }
      }else{
        end_it = --region->back().end();
      }
      SmallVector<Operation *, 16> operands;
      for(auto iter = start_it; iter!=end_it; iter++){
        operands.push_back(&*iter);
      }


      SmallVector<Value, 16> results;
      for(auto iter = start_it; iter!=end_it; iter++ ){
        for(auto v: iter->getResults() ){
          // if not all user of the result is in launch block
          if(llvm::all_of(v.getUsers(), [&](Operation *user){
            return llvm::any_of(operands, [&](Operation *inlaunch_user){
              return user==inlaunch_user;
            });
          }) == false){ 
            results.push_back(v);
          }
        }
      }
      builder.setInsertionPoint(&launchOp.getParentRegion()->front(), Block::iterator(launchOp));
      ScopedContext scope(builder, region->getLoc());

      Value signal = start_op();
      auto proc = launchOp.getOperand(1);
      ValueRange invaluerange;//TODO: analyze live in
      ValueRange pe_res = LaunchOpBuilder(signal, proc, invaluerange, [&](ValueRange ins){
        return_op(ValueRange{results});
      });
      auto *launch_operation = pe_res[0].getDefiningOp();
      for(auto iter = start_it; iter!=end_it; ){
        auto iter2=iter;
        iter++;
        iter2->moveBefore(&*(--launch_operation->getRegion(0).front().end()));//equeue.return
      }
      
      for(int i = 1; i < pe_res.size(); i++){
        results[i-1].replaceUsesWithIf(pe_res[i], [&](OpOperand &operand){
          return &launch_operation->getRegion(0).front()!=operand.getOwner()->getBlock();
        });
      }
      
    }

} // end anonymous namespace

void equeue::registerSplitLaunchPass() {
    PassRegistration<SplitLaunch>(
      "split-launch",
      "split launch block");
}
