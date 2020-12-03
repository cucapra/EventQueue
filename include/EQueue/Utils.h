#ifndef EQUEUE_UTILS_H
#define EQUEUE_UTILS_H

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
inline std::vector<std::string> split(const std::string& str, const std::string& delim)
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

inline void trancate(std::vector<std::vector<std::string>> &structs_list,  mlir::detail::PassOptions::ListOption<std::string> &structs_names){
  for(auto structs_name: structs_names){
    auto trancated_name = split(structs_name, "@");
    structs_list.push_back(trancated_name);
  }
}

template <typename FuncT1, typename FuncT2>
inline void walkRegions(MutableArrayRef<Region> regions, const FuncT1 &func1, const FuncT2 &func2) {
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

struct GenericStructure {

  GenericStructure()=default; 
  void buildIdMap(mlir::FuncOp &toplevel);
  ValueRange getField(OpBuilder builder, Region *region, unsigned idx, std::vector<std::string>& structs, unsigned j, Value parent, Value original_parent );
  //void runOnFunction() override;

  llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  llvm::DenseMap<mlir::Value, mlir::Value> vectorIds;
  llvm::DenseMap< Value, std::map<std::string, Value> > comps_tree;

};


#endif
