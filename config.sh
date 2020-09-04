#change LLVM_DIR and MLIR_DIR to ones local directory
cmake -GNinja \
		-DLLVM_DIR=~/Desktop/llvm-project/build/lib/cmake/llvm \
		-DMLIR_DIR=~/Desktop/llvm-project/build/lib/cmake/mlir \
		..
	      	#-DCMAKE_C_COMPILER=clang-8 \
		#-DCMAKE_CXX_COMPILER=clang++-8 \
		#-DCMAKE_BUILD_TYPE=Debug \



#cmake -GNinja -DBUILD_SHARED_LIBS=ON -DLLVM_ENABLE_PROJECTS="clang;lld" -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="AIE;RISCV;ARC" -DLLVM_TARGETS_TO_BUILD="" -DCMAKE_C_COMPILER=/tools/batonroot/rodin/devkits/lnx64/gcc-7.1.0/bin/gcc  -DCMAKE_CXX_COMPILER=/tools/batonroot/rodin/devkits/lnx64/gcc-7.1.0/bin/g++ -DLLVM_TOOL_MLIR_BUILD=OFF ../llvm
