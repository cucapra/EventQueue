
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Dialect/SCF/EDSC/Builders.h"
#include "mlir/Transforms/DialectConversion.h"


#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EQueue/EQueuePasses.h"
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

#define DEBUG_TYPE "structure-matching"

using namespace mlir;
using namespace mlir::edsc;
using namespace mlir::edsc::intrinsics;
using namespace mlir::edsc::ops;
using namespace xilinx::equeue;

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

  Value getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent);
  void buildIdMap(mlir::FuncOp &toplevel);
  
  void runOnFunction() override;
  
  llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;
};

static std::vector<std::string> split(const std::string& str, const std::string& delim)
{
    std::vector<std::string> tokens;
    size_t prev = 0, pos = 0;
    do
    {
        pos = str.find(delim, prev);
        if (pos == std::string::npos) pos = str.length();
        std::string token = str.substr(prev, pos-prev);
        if (!token.empty()) tokens.push_back(token);
        prev = pos + delim.length();
    }
    while (pos < str.length() && prev < str.length());
    return tokens;
}

template <typename FuncT1, typename FuncT2>
void static walkRegions(MutableArrayRef<Region> regions, const FuncT1 &func1, const FuncT2 &func2) {
  for (Region &region : regions){
    func2(region);
    for (Block &block : region) {
      func1(block);
      // Traverse all nested regions.
      for (Operation &operation : block)
        walkRegions(operation.getRegions(), func1, func2);
    }
  }
}

void StructureMatchingPass::buildIdMap(mlir::FuncOp &toplevel){
  walkRegions(*toplevel.getCallableRegion(), [&](Block &block) {
    // build iter init_value map
    auto pop = block.getParentOp();
    if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(pop) ) {
      auto arg_it = block.args_begin();
      for ( Value operand : Op.getLaunchOperands() ){
        valueIds.insert({*arg_it, valueIds[operand]});
        arg_it += 1;
      }
    } else {
      for (BlockArgument argument : block.getArguments())
        valueIds.insert({argument, argument});
    }
    for (Operation &operation : block) {
      //get_comp operation
      if(auto Op = llvm::dyn_cast<xilinx::equeue::GetCompOp>(operation)){
          Value create_comp = valueIds[Op.getCompHandler()];
          auto name = Op.getName().str();
          Value comp = comps_tree[create_comp][name];
          valueIds.insert({operation.getResult(0), comp});
      }else if(auto Op = llvm::dyn_cast<mlir::ExtractElementOp>(operation)){
          valueIds.insert({operation.getResult(0), vectorIds[valueIds[operation.getOperand(0)]]});
      }else{
        std::string comp_string;
        unsigned offset = 0;
        Value comp;
        if(auto Op = llvm::dyn_cast<xilinx::equeue::CreateCompOp>(operation)){
          comp_string = Op.getNames().str();
          comp = Op.getResult();
          
          std::map<std::string, Value> comps;
          comps_tree.insert(std::make_pair(comp, comps));
        }else if(auto Op = llvm::dyn_cast<xilinx::equeue::AddCompOp>(operation)){
          comp_string = Op.getNames().str();
          comp = valueIds[Op.getOperand(0)];
          offset=1;
        }

        auto comp_names = split(comp_string, " ");
        
        for(int i = 0; i < comp_names.size(); i++){
          auto operand = operation.getOperand(i+offset);
          comps_tree[comp].insert(std::make_pair(comp_names[i], valueIds[operand]));
          //llvm::outs()<<comp_names[i]<<" "<<operand<<"\n";
        }
        
      
        for (Value result : operation.getResults()){
          valueIds.insert({result, result});
        }
        
        
        if(auto Op = llvm::dyn_cast<mlir::SplatOp>(operation)){
          vectorIds.insert({operation.getResult(0), valueIds[operation.getOperand(0)]});
        }
      }
    }
  }, [&](Region &region){ return; } );
}



Value StructureMatchingPass::getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent){
  ScopedContext scope(builder, region->getLoc());
  
  Value new_original_parent = comps_tree[original_parent][structs[j]];
  auto original_type = new_original_parent.getType();
  Value new_parent = get_comp(parent, structs[j], original_type);
  if(auto vector_type = original_type.dyn_cast<VectorType>()){//vector
    new_original_parent = new_original_parent.getDefiningOp()->getOperand(0);
    Value ivs = cast<AffineForOp>(new_parent.getParentRegion()->getParentOp()).getInductionVar();
    new_parent = std_extract_element(new_parent, ivs);
  }
  if(j!=structs.size()-1){
    return getField(builder, region, idx, structs, j+1, new_parent, new_original_parent);
  }else{
    return new_parent;
  }
}

void StructureMatchingPass::runOnFunction() {
    auto f = getFunction();
    MLIRContext *context = &getContext();
    OpBuilder builder(context);
    buildIdMap(f);
    
    //pre-order transversal
    llvm::SmallVector<Region *, 20> regions;
    walkRegions(*f.getCallableRegion(), [&](Block &block) { }, [&](Region &region) { 
      regions.push_back(&region);
    });
  
    //the first region is funcop region
    regions.erase(regions.begin());
    
    std::vector<std::vector<std::string>> structs_list;
    for(auto structs_name: structs_names){
      auto trancated_name = split(structs_name, "@");
      structs_list.push_back(trancated_name);
    }
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
      auto proc = getField(builder, region, i, structs, 0, accel, accel_original);
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
