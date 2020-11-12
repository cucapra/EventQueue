add_mlir_dialect_library(EQueueTransforms
  StructureMatching.cpp
  
  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include/EQueue


  DEPENDS
  EQueuePassIncGen

  LINK_LIBS PUBLIC
  MLIRIR
)
