./bin/equeue-opt --convert-linalg-to-affine-loops --loop-remove ../test/LoweringPipeline2/linalg.mlir


./bin/equeue-opt ../test/LoweringPipeline2/affine.mlir -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" > ../test/LoweringPipeline2/allocate_buffer.mlir

./bin/equeue-opt ../test/LoweringPipeline2/allocate_buffer.mlir --add-loop="indices=5 loops=5"  --loop-parallel="indices=7,5" --equeue-read-write > ../test/LoweringPipeline2/par.mlir
#TODO:might want to merge parallel loops after this

./bin/equeue-opt ../test/LoweringPipeline2/par.mlir -mem-copy="src=ibuffer,wbuffer,pe_array[4]@pe_obuffer dest=pe_array[0]@pe_ibuffer,pe_array@pe_wbuffer,obuffer dma=dma,dma,dma indices=5,6,5 insertions=3,0,12  is-src=0,0,1" >../test/LoweringPipeline2/memcpy.mlir

./bin/equeue-opt ../test/LoweringPipeline2/memcpy.mlir --match-equeue-structure="indices=8,8 structs-names=pe_array@proc,pe_array@proc from=0,5 to=6,6"


0
1
2
—————— store a table 
3
4
5
______


WS pass : 20 passes
(arg1, arg2) : (a1, a2, a3)

easy to use
accurate
