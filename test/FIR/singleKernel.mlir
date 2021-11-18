

module {
  func @graph(%arg0: tensor<512xi32>) {
    %0 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<32> : tensor<1xi64>, type = "SINK"} : () -> i32
    %1 = "equeue.alloc"(%0) {data_bit = 32 : i64, shape = dense<512> : tensor<1xi64>} : (i32) -> memref<512xf32>
    %2 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<32> : tensor<1xi64>, type = "SINK"} : () -> i32
    %3 = "equeue.alloc"(%2) {data_bit = 32 : i64, shape = dense<481> : tensor<1xi64>} : (i32) -> memref<481xf32>
    %4 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %5 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<32> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %6 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<32> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %7 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %8 = "equeue.create_comp_field"(%4, %5, %6, %7) {names = "proc data taps acc "} : (i32, i32, i32, i32) -> i32
    %9 = "equeue.connection"() {bandwidth = 1024 : i64, type = "Streaming"} : () -> i32
    %10 = "equeue.connection"() {bandwidth = 1024 : i64, type = "Streaming"} : () -> i32
    "equeue.write"(%arg0, %1, %9) {bank = 0 : i64, size = dense<512> : tensor<1xi64>} : (tensor<512xi32>, memref<512xf32>, i32) -> ()
    %11 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%11, %4, %8) ( {
    ^bb0(%arg1: i32):  // no predecessors
      %12 = "equeue.get_comp_field"(%arg1) {name = "data"} : (i32) -> i32
      %13 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>} : (i32) -> memref<16xf32>
      %14 = "equeue.get_comp_field"(%arg1) {name = "taps"} : (i32) -> i32
      %15 = "equeue.alloc"(%14) {data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>} : (i32) -> memref<8xf32>
      %16 = "equeue.get_comp_field"(%arg1) {name = "acc"} : (i32) -> i32
      %17 = "equeue.alloc"(%16) {data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>} : (i32) -> memref<4xf32>
      "equeue.add_comp_field"(%arg1, %13, %15, %17) {names = "ifmap filter ofmap "} : (i32, memref<16xf32>, memref<8xf32>, memref<4xf32>) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    "equeue.await"(%done) : (!equeue.signal) -> ()
    %done_0 = "equeue.launch"(%11, %4, %9, %10, %8, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %12 = "equeue.get_comp_field"(%arg3) {name = "ifmap"} : (i32) -> memref<16xi32>
      %13 = "equeue.get_comp_field"(%arg3) {name = "filter"} : (i32) -> memref<8xi32>
      %14 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %15 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %16 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %17 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %18 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %19 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %20 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %21 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %22 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %23 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %24 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %25 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %26 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %27 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%27, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %28 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %29 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %30 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %31 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %32 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %33 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %34 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %35 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %36 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %37 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %38 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %39 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %40 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %41 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %42 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %43 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %44 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%44, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %45 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %46 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %47 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %48 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %49 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %50 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %51 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %52 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %53 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %54 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %55 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %56 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %57 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %58 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %59 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %60 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %61 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%61, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %62 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %63 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %64 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %65 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %66 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %67 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %68 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %69 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %70 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %71 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %72 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %73 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %74 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %75 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %76 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %77 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %78 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%78, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %79 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %80 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %81 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %82 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %83 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %84 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %85 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %86 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %87 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %88 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %89 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %90 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %91 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %92 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %93 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %94 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %95 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%95, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %96 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %97 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %98 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %99 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %100 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %101 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %102 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %103 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %104 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %105 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %106 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %107 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %108 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %109 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %110 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %111 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %112 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%112, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %113 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %114 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %115 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %116 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %117 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %118 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %119 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %120 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %121 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %122 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %123 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %124 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %125 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %126 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %127 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %128 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %129 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%129, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %130 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %131 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %132 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %133 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %134 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %135 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %136 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %137 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %138 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %139 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %140 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %141 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %142 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %143 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %144 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %145 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %146 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%146, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %147 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %148 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %149 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %150 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %151 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %152 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %153 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %154 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %155 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %156 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %157 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %158 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %159 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %160 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %161 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %162 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %163 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%163, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %164 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %165 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %166 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %167 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %168 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %169 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %170 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %171 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %172 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %173 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %174 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %175 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %176 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %177 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %178 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %179 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %180 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%180, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %181 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %182 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %183 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %184 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %185 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %186 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %187 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %188 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %189 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %190 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %191 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %192 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %193 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %194 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %195 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %196 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %197 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%197, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %198 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %199 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %200 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %201 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %202 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %203 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %204 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %205 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %206 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %207 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %208 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %209 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %210 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %211 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %212 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %213 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %214 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%214, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %215 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %216 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %217 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %218 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %219 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %220 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %221 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %222 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %223 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %224 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %225 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %226 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %227 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %228 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %229 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %230 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %231 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%231, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %232 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %233 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %234 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %235 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %236 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %237 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %238 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %239 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %240 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %241 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %242 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %243 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %244 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %245 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %246 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %247 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %248 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%248, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %249 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %250 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %251 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %252 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %253 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %254 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %255 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %256 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %257 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %258 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %259 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %260 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %261 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %262 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %263 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %264 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %265 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%265, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %266 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %267 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %268 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %269 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %270 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %271 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %272 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %273 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %274 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %275 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %276 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %277 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %278 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %279 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %280 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %281 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %282 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%282, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %283 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %284 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %285 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %286 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %287 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %288 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %289 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %290 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %291 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %292 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %293 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %294 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %295 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %296 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %297 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %298 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %299 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%299, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %300 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %301 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %302 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %303 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %306 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %309 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %312 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%316, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %317 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %327 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %330 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %333 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%333, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %334 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %335 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %336 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %337 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %338 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %339 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %340 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %341 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %342 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %343 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %344 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %345 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %346 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %347 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %348 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %349 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %350 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%350, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %351 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %352 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %353 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %354 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %355 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %356 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %357 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %358 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %359 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %360 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %361 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %362 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %363 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %364 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %365 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %366 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %367 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%367, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %368 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %369 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %370 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %371 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %372 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %373 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %374 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %375 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %376 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %377 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %378 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %379 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %380 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %381 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %382 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %383 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %384 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%384, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %385 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %386 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %387 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %388 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %389 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %390 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %391 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %392 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %393 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %394 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %395 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %396 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %397 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %398 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %399 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %400 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %401 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%401, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %402 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %403 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %404 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %405 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %406 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %407 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %408 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %409 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %410 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %411 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %412 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %413 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %414 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %415 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %416 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %417 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %418 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%418, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %419 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %420 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %421 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %422 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %423 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %424 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %425 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %426 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %427 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %428 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %429 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %430 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %431 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %432 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %433 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %434 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %435 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%435, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %436 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %437 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %438 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %439 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %440 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %441 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %442 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %443 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %444 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %445 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %446 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %447 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %448 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %449 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %450 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %451 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %452 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%452, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %453 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %454 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %455 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %456 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %457 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %458 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %459 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %460 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %461 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %462 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %463 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %464 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %465 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %466 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %467 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %468 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %469 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%469, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %470 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %471 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %472 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %473 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %474 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %475 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %476 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %477 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %478 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %479 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %480 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %481 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %482 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %483 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %484 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %485 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %486 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%486, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %487 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %488 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %489 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %490 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %491 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %492 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %493 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %494 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %495 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %496 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %497 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %498 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %499 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %500 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %501 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %502 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %503 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%503, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %504 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %505 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %506 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %507 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %508 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %509 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %510 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %511 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %512 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %513 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %514 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %515 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %516 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %517 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %518 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %519 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %520 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%520, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %521 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %522 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %523 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %524 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %525 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %526 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %527 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %528 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %529 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %530 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %531 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %532 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %533 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %534 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %535 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %536 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %537 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%537, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %538 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %539 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %540 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %541 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %542 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %543 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %544 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %545 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %546 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %547 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %548 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %549 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %550 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %551 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %552 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %553 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %554 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%554, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %555 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %556 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %557 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %558 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %559 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %560 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %561 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %562 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %563 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %564 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %565 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %566 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %567 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %568 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %569 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %570 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %571 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%571, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %572 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %573 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %574 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %575 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %576 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %577 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %578 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %579 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %580 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %581 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %582 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %583 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %584 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %585 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %586 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %587 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %588 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%588, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %589 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %590 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %591 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %592 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %593 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %594 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %595 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %596 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %597 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %598 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %599 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %600 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %601 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %602 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %603 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %604 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %605 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%605, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %606 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %607 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %608 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %609 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %610 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %611 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %612 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %613 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %614 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %615 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %616 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %617 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %618 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %619 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %620 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %621 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %622 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%622, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %623 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %624 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %625 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %626 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %627 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %628 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %629 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %630 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %631 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %632 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %633 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %634 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %635 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %636 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %637 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %638 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %639 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%639, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %640 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %641 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %642 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %643 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %644 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %645 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %646 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %647 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %648 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %649 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %650 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %651 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %652 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %653 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %654 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %655 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %656 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%656, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %657 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %658 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %659 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %660 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %661 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %662 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %663 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %664 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %665 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %666 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %667 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %668 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %669 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %670 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %671 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %672 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %673 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%673, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %674 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %675 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %676 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %677 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %678 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %679 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %680 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %681 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %682 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %683 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %684 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %685 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %686 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %687 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %688 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %689 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %690 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%690, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %691 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %692 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %693 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %694 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %695 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %696 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %697 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %698 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %699 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %700 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %701 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %702 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %703 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %704 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %705 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %706 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %707 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%707, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %708 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %709 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %710 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %711 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %712 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %713 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %714 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %715 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %716 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %717 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %718 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %719 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %720 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %721 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %722 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %723 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %724 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%724, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %725 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %726 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %727 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %728 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %729 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %730 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %731 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %732 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %733 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %734 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %735 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %736 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %737 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %738 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %739 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %740 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %741 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%741, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %742 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %743 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %744 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %745 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %746 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %747 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %748 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %749 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %750 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %751 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %752 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %753 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %754 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %755 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %756 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %757 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %758 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%758, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %759 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %760 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %761 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %762 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %763 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %764 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %765 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %766 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %767 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %768 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %769 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %770 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %771 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %772 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %773 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %774 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %775 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%775, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %776 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %777 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %778 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %779 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %780 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %781 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %782 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %783 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %784 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %785 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %786 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %787 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %788 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %789 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %790 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %791 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %792 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%792, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %793 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %794 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %795 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %796 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %797 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %798 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %799 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %800 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %801 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %802 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %803 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %804 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %805 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %806 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %807 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %808 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %809 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%809, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %810 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %811 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %812 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %813 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %814 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %815 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %816 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %817 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %818 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %819 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %820 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %821 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %822 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %823 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %824 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %825 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %826 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%826, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %827 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %828 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %829 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %830 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %831 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %832 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %833 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %834 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %835 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %836 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %837 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %838 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %839 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %840 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %841 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %842 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %843 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%843, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %844 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %845 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %846 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %847 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %848 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %849 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %850 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %851 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %852 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %853 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %854 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %855 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %856 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %857 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %858 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %859 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %860 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%860, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %861 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %862 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %863 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %864 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %865 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %866 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %867 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %868 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %869 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %870 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %871 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %872 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %873 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %874 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %875 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %876 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %877 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%877, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %878 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %879 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %880 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %881 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %882 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %883 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %884 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %885 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %886 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %887 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %888 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %889 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %890 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %891 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %892 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %893 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %894 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%894, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %895 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %896 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %897 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %898 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %899 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %900 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %901 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %902 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %903 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %904 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %905 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %906 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %907 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %908 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %909 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %910 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %911 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%911, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %912 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %913 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %914 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %915 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %916 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %917 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %918 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %919 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %920 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %921 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %922 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %923 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %924 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %925 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %926 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %927 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %928 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%928, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %929 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %930 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %931 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %932 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %933 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %934 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %935 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %936 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %937 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %938 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %939 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %940 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %941 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %942 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %943 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %944 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %945 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%945, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %946 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %947 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %948 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %949 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %950 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %951 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %952 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %953 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %954 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %955 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %956 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %957 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %958 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %959 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %960 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %961 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %962 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%962, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %963 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %964 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %965 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %966 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %967 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %968 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %969 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %970 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %971 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %972 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %973 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %974 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %975 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %976 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %977 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %978 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %979 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%979, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %980 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %981 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %982 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %983 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %984 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %985 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %986 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %987 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %988 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %989 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %990 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %991 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %992 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %993 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %994 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %995 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %996 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%996, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %997 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %998 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %999 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1000 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1001 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1002 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1003 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1004 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1005 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1006 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1007 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1008 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1009 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1010 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1011 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1012 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1013 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1013, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1014 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1015 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1016 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1017 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1018 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1019 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1020 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1021 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1022 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1023 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1024 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1025 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1026 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1027 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1028 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1029 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1030 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1030, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1031 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1032 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1033 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1034 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1035 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1036 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1037 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1038 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1039 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1040 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1041 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1042 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1043 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1044 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1045 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1046 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1047 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1047, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1048 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1049 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1050 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1051 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1052 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1053 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1054 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1055 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1056 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1057 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1058 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1059 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1060 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1061 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1062 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1063 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1064 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1064, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1065 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1066 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1067 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1068 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1069 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1070 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1071 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1072 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1073 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1074 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1075 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1076 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1077 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1078 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1079 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1080 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1081 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1081, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1082 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1083 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1084 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1085 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1086 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1087 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1088 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1089 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1090 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1091 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1092 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1093 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1094 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1095 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1096 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1097 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1098 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1098, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1099 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1100 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1101 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1102 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1103 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1104 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1105 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1106 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1107 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1108 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1109 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1110 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1111 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1112 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1113 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1114 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1115 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1115, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1116 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1117 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1118 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1119 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1120 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1121 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1122 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1123 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1124 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1125 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1126 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1127 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1128 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1129 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1130 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1131 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1132 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1132, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1133 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1134 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1135 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1136 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1137 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1138 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1139 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1140 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1141 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1142 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1143 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1144 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1145 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1146 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1147 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1148 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1149 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1149, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1150 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1151 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1152 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1153 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1154 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1155 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1156 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1157 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1158 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1159 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1160 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1161 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1162 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1163 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1164 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1165 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1166 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1166, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1167 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1168 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1169 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1170 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1171 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1172 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1173 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1174 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1175 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1176 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1177 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1178 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1179 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1180 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1181 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1182 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1183 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1183, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1184 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1185 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1186 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1187 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1188 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1189 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1190 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1191 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1192 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1193 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1194 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1195 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1196 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1197 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1198 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1199 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1200 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1200, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1201 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1202 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1203 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1204 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1205 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1206 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1207 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1208 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1209 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1210 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1211 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1212 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1213 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1214 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1215 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1216 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1217 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1217, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1218 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1219 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1220 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1221 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1222 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1223 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1224 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1225 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1226 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1227 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1228 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1229 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1230 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1231 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1232 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1233 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1234 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1234, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1235 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1236 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1237 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1238 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1239 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1240 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1241 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1242 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1243 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1244 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1245 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1246 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1247 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1248 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1249 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1250 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1251 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1251, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1252 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1253 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1254 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1255 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1256 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1257 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1258 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1259 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1260 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1261 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1262 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1263 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1264 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1265 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1266 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1267 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1268 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1268, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1269 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1270 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1271 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1272 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1273 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1274 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1275 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1276 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1277 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1278 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1279 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1280 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1281 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1282 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1283 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1284 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1285 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1285, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1286 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1287 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1288 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1289 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1290 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1291 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1292 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1293 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1294 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1295 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1296 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1297 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1298 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1299 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1300 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1301 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1302 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1302, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1303 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1304 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1305 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1306 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1307 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1308 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1309 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1310 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1311 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1312 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1313 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1314 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1315 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1316 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1317 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1318 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1319 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1319, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1320 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1321 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1322 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1323 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1324 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1325 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1326 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1327 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1328 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1329 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1330 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1331 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1332 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1333 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1334 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1335 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1336 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1336, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1337 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1338 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1339 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1340 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1341 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1342 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1343 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1344 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1345 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1346 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1347 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1348 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1349 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1350 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1351 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1352 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1353 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1353, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1354 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1355 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1356 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1357 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1358 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1359 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1360 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1361 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1362 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1363 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1364 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1365 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1366 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1367 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1368 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1369 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1370 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1370, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1371 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1372 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1373 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1374 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1375 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1376 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1377 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1378 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1379 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1380 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1381 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1382 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1383 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1384 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1385 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1386 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1387 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1387, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1388 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1389 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1390 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1391 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1392 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1393 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1394 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1395 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1396 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1397 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1398 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1399 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1400 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1401 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1402 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1403 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1404 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1404, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1405 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1406 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1407 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1408 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1409 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1410 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1411 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1412 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1413 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1414 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1415 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1416 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1417 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1418 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1419 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1420 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1421 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1421, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1422 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1423 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1424 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1425 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1426 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1427 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1428 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1429 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1430 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1431 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1432 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1433 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1434 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1435 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1436 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1437 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1438 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1438, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1439 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1440 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1441 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1442 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1443 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1444 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1445 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1446 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1447 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1448 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1449 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1450 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1451 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1452 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1453 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1454 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1455 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1455, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1456 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1457 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1458 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1459 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1460 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1461 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1462 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1463 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1464 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1465 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1466 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1467 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1468 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1469 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1470 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1471 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1472 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1472, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1473 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1474 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1475 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1476 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1477 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1478 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1479 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1480 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1481 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1482 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1483 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1484 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1485 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1486 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1487 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1488 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1489 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1489, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1490 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1491 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1492 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1493 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1494 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1495 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1496 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1497 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1498 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1499 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1500 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1501 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1502 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1503 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1504 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1505 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1506 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1506, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1507 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1508 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1509 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1510 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1511 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1512 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1513 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1514 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1515 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1516 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1517 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1518 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1519 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1520 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1521 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1522 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1523 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1523, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1524 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1525 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1526 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1527 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1528 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1529 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1530 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1531 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1532 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1533 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1534 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1535 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1536 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1537 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1538 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1539 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1540 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1540, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1541 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1542 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1543 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1544 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1545 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1546 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1547 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1548 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1549 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1550 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1551 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1552 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1553 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1554 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1555 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1556 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1557 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1557, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1558 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1559 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1560 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1561 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1562 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1563 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1564 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1565 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1566 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1567 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1568 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1569 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1570 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1571 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1572 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1573 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1574 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1574, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1575 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1576 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1577 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1578 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1579 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1580 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1581 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1582 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1583 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1584 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1585 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1586 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1587 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1588 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1589 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1590 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1591 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1591, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1592 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1593 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1594 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1595 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1596 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1597 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1598 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1599 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1600 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1601 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1602 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1603 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1604 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1605 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1606 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1607 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1608 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1608, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1609 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1610 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1611 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1612 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1613 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1614 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1615 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1616 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1617 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1618 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1619 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1620 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1621 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1622 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1623 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1624 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1625 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1625, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1626 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1627 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1628 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1629 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1630 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1631 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1632 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1633 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1634 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1635 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1636 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1637 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1638 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1639 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1640 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1641 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1642 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1642, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1643 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1644 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1645 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1646 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1647 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1648 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1649 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1650 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1651 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1652 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1653 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1654 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1655 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1656 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1657 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1658 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1659 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1659, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1660 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1661 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1662 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1663 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1664 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1665 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1666 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1667 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1668 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1669 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1670 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1671 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1672 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1673 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1674 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1675 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1676 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1676, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1677 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1678 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1679 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1680 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1681 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1682 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1683 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1684 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1685 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1686 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1687 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1688 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1689 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1690 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1691 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1692 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1693 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1693, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1694 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1695 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1696 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1697 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1698 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1699 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1700 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1701 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1702 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1703 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1704 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1705 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1706 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1707 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1708 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1709 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1710 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1710, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1711 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1712 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1713 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1714 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1715 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1716 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1717 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1718 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1719 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1720 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1721 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1722 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1723 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1724 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1725 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1726 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1727 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1727, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1728 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1729 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1730 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1731 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1732 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1733 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1734 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1735 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1736 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1737 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1738 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1739 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1740 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1741 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1742 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1743 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1744 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1744, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1745 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1746 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1747 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1748 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1749 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1750 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1751 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1752 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1753 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1754 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1755 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1756 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1757 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1758 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1759 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1760 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1761 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1761, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1762 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1763 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1764 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1765 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1766 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1767 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1768 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1769 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1770 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1771 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1772 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1773 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1774 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1775 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1776 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1777 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1778 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1778, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1779 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1780 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1781 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1782 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1783 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1784 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1785 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1786 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1787 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1788 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1789 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1790 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1791 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1792 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1793 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1794 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1795 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1795, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1796 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1797 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1798 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1799 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1800 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1801 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1802 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1803 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1804 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1805 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1806 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1807 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1808 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1809 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1810 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1811 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1812 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1812, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1813 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1814 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1815 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1816 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1817 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1818 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1819 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1820 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1821 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1822 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1823 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1824 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1825 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1826 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1827 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1828 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1829 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1829, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1830 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1831 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1832 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1833 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1834 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1835 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1836 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1837 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1838 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1839 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1840 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1841 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1842 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1843 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1844 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1845 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1846 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1846, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1847 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1848 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1849 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1850 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1851 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1852 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1853 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1854 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1855 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1856 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1857 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1858 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1859 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1860 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1861 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1862 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1863 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1863, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1864 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1865 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1866 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1867 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1868 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1869 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1870 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1871 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1872 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1873 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1874 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1875 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1876 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1877 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1878 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1879 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1880 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1880, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1881 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1882 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1883 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1884 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1885 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1886 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1887 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1888 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1889 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1890 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1891 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1892 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1893 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1894 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1895 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1896 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1897 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1897, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1898 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1899 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1900 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1901 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1902 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1903 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1904 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1905 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1906 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1907 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1908 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1909 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1910 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1911 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1912 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1913 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1914 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1914, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1915 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1916 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1917 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1918 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1919 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1920 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1921 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1922 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1923 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1924 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1925 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1926 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1927 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1928 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1929 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1930 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1931 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1931, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1932 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1933 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1934 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1935 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1936 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1937 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1938 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1939 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1940 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1941 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1942 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1943 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1944 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1945 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1946 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1947 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1948 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1948, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1949 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1950 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1951 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1952 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1953 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1954 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1955 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1956 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1957 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1958 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1959 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1960 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1961 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1962 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1963 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1964 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1965 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1965, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1966 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1967 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1968 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1969 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1970 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1971 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1972 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1973 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1974 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1975 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1976 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1977 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1978 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1979 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1980 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1981 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1982 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1982, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %1983 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1984 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1985 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1986 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1987 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1988 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1989 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1990 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1991 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1992 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1993 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1994 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1995 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1996 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1997 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1998 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %1999 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%1999, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2000 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2001 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2002 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2003 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2004 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2005 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2006 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2007 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2008 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2009 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2010 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2011 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2012 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2013 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2014 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2015 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2016 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2016, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2017 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2018 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2019 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2020 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2021 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2022 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2023 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2024 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2025 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2026 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2027 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2028 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2029 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2030 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2031 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2032 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2033 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2033, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2034 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2035 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2036 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2037 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2038 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2039 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2040 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2041 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2042 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2043 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2044 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2045 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2046 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2047 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2048 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2049 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2050 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2050, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2051 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2052 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2053 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2054 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2055 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2056 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2057 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2058 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2059 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2060 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2061 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2062 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2063 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2064 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2065 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2066 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2067 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2067, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2068 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2069 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2070 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2071 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2072 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2073 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2074 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2075 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2076 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2077 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2078 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2079 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2080 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2081 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2082 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2083 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2084 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2084, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2085 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2086 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2087 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2088 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2089 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2090 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2091 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2092 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2093 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2094 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2095 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2096 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2097 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2098 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2099 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2100 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2101 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2101, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2102 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2103 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2104 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2105 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2106 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2107 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2108 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2109 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2110 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2111 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2112 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2113 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2114 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2115 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2116 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2117 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2118 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2118, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2119 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2120 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2121 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2122 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2123 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2124 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2125 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2126 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2127 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2128 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2129 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2130 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2131 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2132 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2133 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2134 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2135 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2135, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2136 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2137 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2138 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2139 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2140 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2141 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2142 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2143 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2144 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2145 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2146 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2147 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2148 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2149 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2150 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2151 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2152 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2152, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2153 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2154 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2155 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2156 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2157 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2158 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2159 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2160 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2161 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2162 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2163 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2164 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2165 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2166 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2167 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2168 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2169 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2169, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2170 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2171 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2172 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2173 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2174 = "equeue.unkOp"(%14, %12, %13) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2175 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2176 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2177 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2178 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2179 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2180 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2181 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2182 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2183 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2184 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2185 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2186 = "equeue.read"(%arg4, %arg1) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%2186, %12) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %2187 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2188 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2189 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %2190 = "equeue.unkOp"(%14, %12, %13) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    "equeue.await"(%done_0) : (!equeue.signal) -> ()
    return
  }
}
