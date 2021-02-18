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

#define DEBUG_TYPE "structure-matching"

using namespace std;
using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;


static mlir::Operation* walkRegions(MutableArrayRef<Region> regions) {
  for (Region &region : regions){
   
    for (Block &block : region) {
      for (Operation &operation : block){
        // llvm::outs() << operation << "\n";
        if (isa<mlir::AffineForOp>(operation)){
          return &operation;
        }
        mlir::Operation* sub_op_res = walkRegions(operation.getRegions());
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
    // struct ForOpConversion : public OpRewritePattern<mlir::AffineForOp>
    // {
    //     using OpRewritePattern<mlir::AffineForOp>::OpRewritePattern;
    //     // Region *inline_region;
    //     ForOpConversion(MLIRContext *context) : OpRewritePattern<mlir::AffineForOp>(context){}

    //     LogicalResult matchAndRewrite(mlir::AffineForOp op,
    //                                   PatternRewriter &rewriter) const override
    //     {
    //         //auto region = op.region();
    //         llvm::outs() << *op << "\n";
    //         //rewriter.inlineRegionBefore(region2, launch_pe->region(), launch_pe->region.end());
    //         //} */
    //         auto new_op = op.clone();
    //         bool const_bound = op.hasConstantLowerBound() && op.hasConstantUpperBound();
    //         // next
    //         if (!const_bound  || op.getConstantUpperBound() - op.getConstantLowerBound() > op.getStep()){
    //             llvm::outs() << "hello" << "\n";
    //             return failure();
    //         }else {
                    
    //         auto loc = op.getLoc();
    //         auto parent = op.getParentOp();
    //         Value zero = rewriter.create<ConstantIndexOp>(loc, 0);
    //         // op.getInductionVar().replaceAllUsesWith(zero);
    //         // llvm::outs() << *op.getParentOp()  << "\n";
    //         // rewriter.cloneRegionBefore(op.getRegion(), *(op.getParentRegion()), op.getParentRegion()->end());
    //         // for (auto &sub_op: op.getRegion().getOps()){
    //         //     sub_op.moveBefore(op);
    //         // }
    //         auto subOps = op.getRegion().getOps<AffineForOp>();
    //         mlir::AffineForOp affineFor;
    //         for (auto af : subOps){
    //             if (!affineFor):
    //                 affineFor = af;
    //                 break;
    //         }
            
    //         mlir::Operation new_op = affineFor.clone();

    //         // for (auto &line: parent->getRegion(0).back()){
    //         //     llvm::outs() << line << "\n";
    //         //     line.moveBefore(op);
    //         // }
    //         // parent->getRegion(0).back().erase();
    //         rewriter.replaceOp(op, new_op.getResults());
    //         // llvm::outs() << *parent << "\n";

    //         }

    //         return success();        
    //     }
    // };

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

            auto operation = walkRegions(regions);
            while (operation != nullptr) {
                llvm::outs()<< *operation << "\n"; 
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
                      llvm::outs() << res << "\n";
                      ub_value = res;
                  }else{
                    llvm::outs() << "continued at upper bound" << "\n";
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
                        llvm::outs() << res << "\n";
                  }else{
                      llvm::outs() << "continued at lb bound" << "\n";
                    operation = walkRegions(operation->getRegions());
                    continue;
                  }
                }

               
                if (ub_value - lb_value > op.getStep()){
                    // llvm::outs() << "hello" << "\n";
                    llvm::outs() << "condition not meet, continue" << "\n";
                    operation = walkRegions(operation->getRegions());
                    continue;
                }   
              
                llvm::outs() << "can be removed" << "\n";

                auto parent = op.getParentOp();
                // auto blk = parent->getRegion(0).front();
                ScopedContext scope(builder, parent->getLoc());
                auto loc = op.getLoc();
                // Value zero = builder.create<ConstantIndexOp>(loc, 0);
                builder.setInsertionPointToStart(&op.getRegion().front());
                Value lb_index = std_constant_index(lb_value);
                op.getInductionVar().replaceAllUsesWith(lb_index);
                auto counter = 0;
                builder.setInsertionPoint(op);
                BlockAndValueMapping map;
                for (auto &sub_op : op.getRegion().front().without_terminator()){
                    auto cl = builder.clone(sub_op, map);
                    if (sub_op.getNumResults() >= 1 ){
                        map.map(sub_op.getResults(), cl->getResults());
                    }
                    counter ++;
                }
                // op.getRegion().cloneInto()
                regions = parent->getRegions();
                op.erase();
                operation = walkRegions(regions);          
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