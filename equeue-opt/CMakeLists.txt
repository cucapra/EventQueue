get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
set(LIBS
        ${dialect_libs}
        ${conversion_libs}
        MLIROptLib
        MLIREQueue
        EQueueEDSC
        SystolicArray
        FIR
        )
add_llvm_executable(equeue-opt equeue-opt.cpp)
llvm_update_compile_flags(equeue-opt)
target_link_libraries(equeue-opt PRIVATE ${LIBS})
