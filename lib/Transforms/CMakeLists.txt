add_mlir_dialect_library(EQueueTransforms
  StructureMatching.cpp
  SplitLaunch.cpp
  MyLoopTiling.cpp
  LoopRemoving.cpp
  SimplifyAffineLoop.cpp
  LoopReorder.cpp
  MyLoopParallelize.cpp
  AllocateMem.cpp
  ReassignBuffer.cpp
  MemCopy.cpp
  MemCopyToLaunch.cpp
  MergeMemCopyLaunch.cpp
  AddLoop.cpp
  MergeLoop.cpp
  ModifyLoop.cpp
  SystolicArray.cpp
  EqueueReadWrite.cpp
  ParallelToEQueue.cpp
  LowerExtraction.cpp
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
