

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
#include <iostream>
#include <sstream>
#include <algorithm>
#include <iterator>
#include "EQueue/EQueuePasses.h"

#include "EQueue/EQueueOps.h"

#define DEBUG_TYPE "loop-removing"

using namespace std;
using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;


static mlir::Operation* walkRegions(MutableArrayRef<Region> regions, Operation *op=nullptr, bool isAfter=true) {
  for (Region &region : regions){
   
    for (Block &block : region) {
      for (Operation &operation : block){
        if(op && &operation == op){
          isAfter = true;
        }
        else if (isa<mlir::AffineForOp>(operation) && isAfter){
          return &operation;
        }
        mlir::Operation* sub_op_res = walkRegions(operation.getRegions(), op, isAfter);
        if (sub_op_res != nullptr){
           return sub_op_res;
        }
      }
    }
  }
  return nullptr;
 }


namespace
{

    struct LoopRemovingPass : public PassWrapper<LoopRemovingPass, FunctionPass>
    {
        // LoopRemovingPass() = default;
        // LoopRemovingPass(const LoopRemovingPass &pass) {}

        // Option<std::string> structOption{*this, "struct-name",
        //                                  llvm::cl::desc("...")};

        void runOnFunction() override
        {
            auto f = getFunction();
            OpBuilder builder(&getContext());
            std::vector<mlir::AffineForOp> affineFors;
            MutableArrayRef<Region> regions = f.getRegion();
            SmallVector<Operation *, 6> bands;
            for (xilinx::equeue::LaunchOp launchop: f.getOps<xilinx::equeue::LaunchOp>()){
              for (Operation &op : launchop.getOps()) {
                if (isa<mlir::AffineForOp>(&op)){
                    bands.push_back(&op);
                  }
              }
            }
            //llvm::outs()<<"========\n";
            int i = 1;
  
            auto operation = bands[0];
            while (operation != nullptr) {
                //llvm::outs()<< *operation << "\n"; 
                mlir::AffineForOp op = dyn_cast<mlir::AffineForOp>(operation);

                // if condition not met, go into its region
                bool const_lw_bound = op.hasConstantLowerBound();
                bool const_up_bound = op.hasConstantUpperBound();
                bool const_bound = op.hasConstantLowerBound() && op.hasConstantUpperBound();
                AffineBound lb = op.getLowerBound();
                AffineBound ub = op.getUpperBound();
                int64_t lb_value;
                int64_t ub_value;
                bool has_lb_v = false;
                bool has_up_v = false;

                if (const_up_bound){
                      ub_value = op.getConstantUpperBound();
                }else{
                  auto operand = ub.getOperand(0);
                  auto def_op = operand.getDefiningOp();
                  if (def_op != nullptr && isa<mlir::ConstantIndexOp>(def_op)){
                      auto value_attr = def_op->getAttr("value");
                      auto map = ub.getMap();
                      SmallVector<Attribute, 1> result;
                      map.constantFold({value_attr}, result);
                      auto res = result[0].cast<IntegerAttr>().getInt();
                      //llvm::outs() << res << "\n";
                      ub_value = res;
                  }else{
                    //llvm::outs() << "continued at upper bound" << "\n";
                    operation = walkRegions(operation->getRegions());
                    continue;
                  }
                }

                if (const_lw_bound){
                    lb_value = op.getConstantLowerBound();
                }else{
                    auto operand = lb.getOperand(0);
                    auto def_op = operand.getDefiningOp();
                    if (def_op != nullptr && isa<mlir::ConstantIndexOp>(def_op)){
                        auto value_attr = def_op->getAttr("value");
                        auto map = lb.getMap();
                        SmallVector<Attribute, 1> result;
                        map.constantFold({value_attr}, result);
                        auto res = result[0].cast<IntegerAttr>().getInt();
                        lb_value = res;
                        //llvm::outs() << res << "\n";
                  }else{
                    //llvm::outs() << "continued at lb bound" << "\n";
                    operation = walkRegions(operation->getRegions());
                    continue;
                  }
                }

               
                if (ub_value - lb_value > op.getStep()){
                    //llvm::outs() << "condition not meet, continue" << "\n";
                    operation = walkRegions(operation->getRegions());
                    if(operation ==nullptr && i < bands.size() ){
                      operation = bands[i];
                      i++;
                      //llvm::outs()<<i<<" "<<bands.size()<<"\n";
                    }
                    //llvm::outs()<<operation<<"\n";
                    continue;
                }   
              
                //llvm::outs() << "can be removed" << "\n";

                auto parent = op.getParentOp();
                // auto blk = parent->getRegion(0).front();
                ScopedContext scope(builder, parent->getLoc());
                auto loc = op.getLoc();
                // Value zero = builder.create<ConstantIndexOp>(loc, 0);
                //builder.setInsertionPointToStart(&op.getRegion().front());
                builder.setInsertionPoint(op);
                Value lb_index = std_constant_index(lb_value);
                op.getInductionVar().replaceAllUsesWith(lb_index);
                auto counter = 0;
                builder.setInsertionPoint(op);
                BlockAndValueMapping map;
                for (auto &sub_op : op.getRegion().front().without_terminator()){
                    auto cl = builder.clone(sub_op, map);
                    for(int i = 0; i < sub_op.getNumResults(); i++){
                      Value res0 = sub_op.getResult(i);
                      Value res1 = cl->getResult(i);
                      map.map(res0, res1);
                    }
                    counter ++;
                }
                op.erase();
                // op.getRegion().cloneInto()
                regions = parent->getRegions();
                operation = walkRegions(regions, lb_index.getDefiningOp(), false);   
                //if(operation) llvm::outs()<<"===="<<*operation<<"\n";       
                //llvm::outs()<<"parent: "<<*parent<<"\n";
            }
        }
        
        // auto f = getFunction();
        // OwningRewritePatternList patterns;
        // patterns.insert<ForOpConversion>(&getContext());
    
        // ConversionTarget target(getContext());
        // target.addLegalDialect<xilinx::equeue::EQueueDialect, StandardOpsDialect>();

        // if (failed(applyPartialConversion(f, target, patterns)))
        //     signalPassFailure();
        // }
    };

} // namespace



void equeue::registerLoopRemovingPass()
{
    PassRegistration<LoopRemovingPass>(
        "loop-remove",
        "remove extra loops");
}
