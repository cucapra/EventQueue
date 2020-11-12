#ifndef EQUEUE_PASSES
#define EQUEUE_PASSES

include "mlir/Pass/PassBase.td"

def StructureMatching : FunctionPass<"match-equeue-structure"> {
  let summary = "Match equeue structure to parallel loops";
  let constructor = "mlir::createStructureMatchingPass()";
  let options = [
    ListOption<"structNames", "struct-names", "std::string",
               "structure names to be updated",
               "llvm::cl::ZeroOrMore, llvm::cl::MiscFlags::CommaSeparated">
  ];
}

#endif // EQUEUE_PASSES
