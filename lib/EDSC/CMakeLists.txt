add_mlir_dialect_library(EQueueEDSC
        Intrinsics.cpp
        ADDITIONAL_HEADER_DIRS
        ${PROJECT_SOURCE_DIR}/include/EDSC
        ${PROJECT_SOURCE_DIR}/include/EQueue

        DEPENDS
        MLIREQueueOpsIncGen

				LINK_LIBS PUBLIC
				MLIRIR
	)
