

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

#define DEBUG_TYPE "loop-reorder"

using namespace std;
using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;



namespace
{

    struct LoopReorderPass : public PassWrapper<LoopReorderPass, FunctionPass>
    {
        LoopReorderPass()=default;
        LoopReorderPass(const LoopReorderPass& pass) {}
        ListOption<unsigned> orders{*this, "orders", llvm::cl::desc("new orders of loop"), llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated};
        void runOnFunction() override
        {
            auto f = getFunction();
            OpBuilder builder(&getContext());
            ScopedContext scope(builder, f.getLoc());
            std::vector<mlir::AffineForOp> affineFors;
            f.walk([&](AffineForOp loop) {
              affineFors.push_back(loop);
            });
            std::reverse(affineFors.begin(), affineFors.end());

            SmallVector<AffineBound,16> lower_bounds;
            SmallVector<AffineBound,16> upper_bounds;
            SmallVector<Value,16> ind_vars;
            SmallVector<Value,16> consts;
            builder.setInsertionPointToStart(&f.getRegion().front());
            for(auto order: orders){
              lower_bounds.push_back(affineFors[order].getLowerBound());
              upper_bounds.push_back(affineFors[order].getUpperBound());
              ind_vars.push_back(affineFors[order].getInductionVar());
              Value c = std_constant_index(0);
              consts.push_back(c);
              ind_vars.rbegin()->replaceAllUsesWith(c);
            }
            for(int i = 0; i < orders.size(); i++){
              affineFors[i].setLowerBound(lower_bounds[i].getOperands(), lower_bounds[i].getMap());
              affineFors[i].setUpperBound(upper_bounds[i].getOperands(), upper_bounds[i].getMap());
              consts[orders[i]].replaceAllUsesWith(ind_vars[i]);
              consts[orders[i]].getDefiningOp()->erase();
            }
            
            
            
        
        }
    };

} // namespace



void equeue::registerLoopReorderPass()
{
    PassRegistration<LoopReorderPass>(
        "loop-reorder",
        "reorder loops");
}
