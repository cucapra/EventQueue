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

./bin/equeue-opt -generate=2 > ../test/LoweringPipeline/linalg.mlir

============================
simulate - weight stationary
============================

./bin/equeue-opt --convert-linalg-to-affine-loops  --equeue-read-write ../test/LoweringPipeline/linalg.mlir > ../test/LoweringPipeline/affine.mlir

./bin/equeue-opt --loop-reorder="orders=0,1,4,5,6,2,3" -merge-loop="indices=2,3,4" -merge-loop="indices=0,1" --loop-remove -cse -loop-tile="tile-sizes=14,12,1" --simplify-affine-loop -simplify-affine-structures  -affine-loop-unroll="unroll-factor=1" ../test/LoweringPipeline/affine.mlir > ../test/LoweringPipeline/reorder.mlir

===============
simulate
=================

 ./bin/equeue-opt ../test/LoweringPipeline/reorder.mlir -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" > ../test/LoweringPipeline/allocate_buffer.mlir

./bin/equeue-opt ../test/LoweringPipeline/allocate_buffer.mlir --reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer indices=11,11,11" > ../test/LoweringPipeline/reassign_buffer.mlir

================================================
simulate 
===============================================

./bin/equeue-opt ../test/LoweringPipeline/reassign_buffer.mlir --add-loop="indices=8 loops=9" --add-loop="indices=9 loops=10" -mem-copy="src=pe_array@pe_wbuffer dest=pe_array[+1]@pe_wbuffer dma=pe_array@dma indices=10 insertions=0" -simplify-affine-structures > ../test/LoweringPipeline/weight.mlir

./bin/equeue-opt ../test/LoweringPipeline/weight.mlir --match-equeue-structure="indices=13 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_ibuffer dest=pe_array[+1]@pe_ibuffer dma=pe_array@proc indices=13 insertions=0" -merge-memcpy-launch="launch=0 memcpy=1" > ../test/LoweringPipeline/ifmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ifmap.mlir --split-launch="indices=0 at=13" --reassign-buffer="old-buffer=pe_array@pe_obuffer new-buffer=pe_array[+1][:]@pe_obuffer indices=13" -cse > ../test/LoweringPipeline/ofmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ofmap.mlir --add-loop="indices=8 loops=9 empty=0 to=1" -modify-loop="indices=11 value=44" --loop-parallel="indices=9,10,12,13" > ../test/LoweringPipeline/par.mlir

#is it the right way?

./bin/equeue-opt ../test/LoweringPipeline/par.mlir -parallel-to-equeue -affine-loop-unroll="unroll-full" -affine-loop-unroll="unroll-full" -lower-extraction > tmp2.mlir
./bin/equeue-opt tmp2.mlir -simplify-affine-structures -lower-extraction -lower-affine -cse > tmp3.mlir

============================
simulate - input stationary
============================

./bin/equeue-opt --convert-linalg-to-affine-loops  --equeue-read-write ../test/LoweringPipeline/linalg.mlir > ../test/LoweringPipeline/affine.mlir

./bin/equeue-opt ../test/LoweringPipeline/affine.mlir --loop-reorder="orders=0,2,3,4,5,6,1"  -merge-loop="indices=1,2,3" -merge-loop="indices=4,5" --loop-remove -cse -loop-tile="tile-sizes=14,12,1"  --simplify-affine-loop -simplify-affine-structures  -affine-loop-unroll="unroll-factor=1" > ../test/LoweringPipeline/reorder.mlir

===============
simulate
=================

 ./bin/equeue-opt ../test/LoweringPipeline/reorder.mlir -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" > ../test/LoweringPipeline/allocate_buffer.mlir

./bin/equeue-opt ../test/LoweringPipeline/allocate_buffer.mlir --reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer indices=11,11,11" > ../test/LoweringPipeline/reassign_buffer.mlir

================================================
simulate 
===============================================

./bin/equeue-opt ../test/LoweringPipeline/reassign_buffer.mlir --add-loop="indices=8 loops=14" --add-loop="indices=9 loops=12" -mem-copy="src=pe_array@pe_ibuffer dest=pe_array[+1]@pe_ibuffer dma=pe_array@dma indices=10 insertions=0" -simplify-affine-structures > ../test/LoweringPipeline/ifmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ifmap.mlir --match-equeue-structure="indices=13 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_wbuffer dest=pe_array[:][+1]@pe_wbuffer dma=pe_array@proc indices=13 insertions=0" -merge-memcpy-launch="launch=0 memcpy=1" > ../test/LoweringPipeline/weight.mlir

./bin/equeue-opt ../test/LoweringPipeline/weight.mlir --split-launch="indices=0 at=12" --reassign-buffer="old-buffer=pe_array@pe_obuffer new-buffer=pe_array[+1][:]@pe_obuffer indices=13" -cse > ../test/LoweringPipeline/ofmap.mlir

#26+10-1
./bin/equeue-opt ../test/LoweringPipeline/ofmap.mlir --add-loop="indices=8 loops=12 empty=0 to=1" -modify-loop="indices=11 value=35" --loop-parallel="indices=9,10,12,13" > ../test/LoweringPipeline/par.mlir

#is it the right way?

./bin/equeue-opt ../test/LoweringPipeline/par.mlir -parallel-to-equeue -affine-loop-unroll="unroll-full" -affine-loop-unroll="unroll-full" -lower-extraction > tmp2.mlir
./bin/equeue-opt tmp2.mlir -simplify-affine-structures -lower-extraction -lower-affine -cse > tmp3.mlir







================================================
simulate - output stationary
===============================================

./bin/equeue-opt --convert-linalg-to-affine-loops  --equeue-read-write ../test/LoweringPipeline/linalg.mlir > ../test/LoweringPipeline/affine.mlir

./bin/equeue-opt ../test/LoweringPipeline/affine.mlir -merge-loop="indices=3,4" -merge-loop="indices=0,1,2" --loop-remove -cse -loop-tile="tile-sizes=14,12,1" --simplify-affine-loop -simplify-affine-structures  -affine-loop-unroll="unroll-factor=1"  > ../test/LoweringPipeline/reorder.mlir

===============
simulate
=================

 ./bin/equeue-opt ../test/LoweringPipeline/reorder.mlir -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" > ../test/LoweringPipeline/allocate_buffer.mlir

./bin/equeue-opt ../test/LoweringPipeline/allocate_buffer.mlir --reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer indices=11,11,11" > ../test/LoweringPipeline/reassign_buffer.mlir

================================================
simulate 
===============================================


./bin/equeue-opt ../test/LoweringPipeline/reassign_buffer.mlir --match-equeue-structure="indices=11 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_wbuffer dest=pe_array[+1]@pe_wbuffer dma=pe_array@proc indices=11 insertions=0" -merge-memcpy-launch="launch=0 memcpy=0" > ../test/LoweringPipeline/weight.mlir

./bin/equeue-opt ../test/LoweringPipeline/weight.mlir -mem-copy="src=pe_array@pe_ibuffer dest=pe_array[+1][:]@pe_ibuffer dma=pe_array@proc indices=11 insertions=0" -merge-memcpy-launch="launch=0 memcpy=0" > ../test/LoweringPipeline/ifmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ifmap.mlir --split-launch="indices=0 at=17" -cse > ../test/LoweringPipeline/ofmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ofmap.mlir --merge-loop="indices=8,9,10" -modify-loop="indices=8 value=91" --loop-parallel="indices=9,10" > ../test/LoweringPipeline/par.mlir











#--loop-remove
./bin/equeue-opt --loop-reorder="orders=0,1,2,3,6,4,5"  ../test/LoweringPipeline/affine.mlir > ../test/LoweringPipeline/reorder.mlir

./bin/equeue-opt -lower-affine ../test/LoweringPipeline/reorder.mlir > tmp.mlir

============================
simulate
============================
./bin/equeue-opt --loop-reorder="orders=0,1,2,3,6,4,5"  -merge-loop="indices=2,3,4" -merge-loop="indices=0,1" ../test/LoweringPipeline/affine.mlir



./bin/equeue-opt --merge-loop="indices=1,2" --loop-remove ../test/LoweringPipeline/reorder.mlir > ../test/LoweringPipeline/merge.mlir

./bin/equeue-opt ../test/LoweringPipeline/merge.mlir -allocate-mem="structs-names=pe_array@mem,pe_array@mem,pe_array@mem indices=0,0,0 mem-names=pe_ibuffer,pe_wbuffer,pe_obuffer sizes=1,1,1" > ../test/LoweringPipeline/allocate_buffer.mlir



./bin/equeue-opt ../test/LoweringPipeline/allocate_buffer.mlir --reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer indices=10,10,10" > ../test/LoweringPipeline/reassign_buffer.mlir

======================
simulate reassign_buffer..
restart from allocate_buffer
======================




./bin/equeue-opt ../test/LoweringPipeline/reassign_buffer.mlir --add-loop="indices=8 loops=9" --add-loop="indices=9 loops=10" -mem-copy="src=pe_array@pe_wbuffer dest=pe_array[+1]@pe_wbuffer dma=pe_array@proc indices=10 insertions=0" -simplify-affine-structures -memcpy-to-launch="indices=0" > ../test/LoweringPipeline/weight.mlir

./bin/equeue-opt ../test/LoweringPipeline/weight.mlir --match-equeue-structure="indices=13 structs-names=pe_array@proc" -mem-copy="src=pe_array@pe_ibuffer dest=pe_array[+1]@pe_ibuffer dma=pe_array@proc indices=13 insertions=0" -merge-memcpy-launch="launch=1 memcpy=0" > ../test/LoweringPipeline/ifmap.mlir

./bin/equeue-opt ../test/LoweringPipeline/ifmap.mlir --split-launch="indices=1 at=15" --reassign-buffer="old-buffer=pe_array@pe_obuffer new-buffer=pe_array[+1][:]@pe_obuffer indices=15" -cse > ../test/LoweringPipeline/ofmap.mlir
#./bin/equeue-opt ../test/LoweringPipeline/ifmap.mlir --split-launch="indices=1 at=7" --reassign-buffer="old-buffer=ibuffer,wbuffer,obuffer,obuffer new-buffer=pe_array@pe_ibuffer,pe_array@pe_wbuffer,pe_array@pe_obuffer,pe_array[+1][:]@pe_obuffer indices=14,14,14,15"


./bin/equeue-opt ../test/LoweringPipeline/ofmap.mlir --add-loop="indices=8 loops=9 empty=0 to=1" --add-loop="indices=8 loops=44 empty=0 from=4" --loop-parallel="indices=9,10,12,13" > ../test/LoweringPipeline/par.mlir
--loop-parallel="indices=11,12"
#--loop-parallel="indices=0,1,2,3,4,5,9,10,12,13,14,15,16,17,18,19"

./bin/equeue-opt ../test/LoweringPipeline/par.mlir -parallel-to-equeue -affine-loop-unroll="unroll-full" -affine-loop-unroll="unroll-full" -lower-extraction > tmp2.mlir
./bin/equeue-opt tmp2.mlir -simplify-affine-structures -lower-extraction -lower-affine -cse > tmp3.mlir
./bin/equeue-opt tmp2.mlir -simplify-affine-structures -lower-extraction -affine-loop-unroll="unroll-full" -cse > tmp4.mlir
TODO: remove redundant cosntant, merge adjacent parallel
