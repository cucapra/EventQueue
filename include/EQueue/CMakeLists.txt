include_directories(${PROJECT_SOURCE_DIR})
add_mlir_dialect(EQueueOps equeue)
add_mlir_doc(EQueueDialect -gen-dialect-doc EQueueDialect EQueue/)
add_mlir_doc(EQueueOps -gen-op-doc EQueueOps EQueue/)


set(LLVM_TARGET_DEFINITIONS EQueuePasses.td)
mlir_tablegen(EQueuePasses.h.inc -gen-pass-decls)
add_public_tablegen_target(EQueuePassIncGen)

add_mlir_doc(Passes -gen-pass-doc EQueuePasses EQueue/)
