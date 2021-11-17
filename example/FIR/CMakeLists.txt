add_mlir_dialect_library(FIR
        FIR.cpp
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/EQueue
        ${PROJECT_SOURCE_DIR}/include/EDSC
        ${PROJECT_SOURCE_DIR}/include/Generator

        DEPENDS
        MLIREQueueOpsIncGen
        EQueueEDSC
        
				LINK_LIBS PUBLIC
				MLIRIR
	)
