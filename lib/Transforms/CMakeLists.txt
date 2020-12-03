add_mlir_dialect_library(EQueueTransforms
  StructureMatching.cpp
  MyLoopTiling.cpp
  MyLoopParallelize.cpp
  AllocateMem.cpp
  MemCopy.cpp
  Utils.cpp
  
  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include/EQueue


  DEPENDS
  MLIREQueueOpsIncGen
  EQueueEDSC

  LINK_LIBS PUBLIC
  MLIRIR
  MLIRAnalysis
  MLIRLinalgOps
  MLIRSCF
  MLIRPass
)
