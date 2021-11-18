add_mlir_dialect_library(MLIREQueue
        EQueueDialect.cpp
        EQueueOps.cpp
				CommandProcessor.cpp
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/EQueue

        DEPENDS
        MLIREQueueOpsIncGen

				LINK_LIBS PUBLIC
				MLIRIR
	)
