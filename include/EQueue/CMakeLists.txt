include_directories(${PROJECT_SOURCE_DIR})
add_mlir_dialect(EQueueOps equeue)
add_mlir_doc(EQueueDialect -gen-dialect-doc EQueueDialect EQueue/)
add_mlir_doc(EQueueOps -gen-op-doc EQueueOps EQueue/)


