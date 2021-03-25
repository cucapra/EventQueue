

module {
  func @graph(%arg0: tensor<512xi32>) {
    %0 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<512> : tensor<1xi64>, type = "SINK"} : () -> i32
    %1 = "equeue.alloc"(%0) {data_bit = 32 : i64, shape = dense<512> : tensor<1xi64>} : (i32) -> memref<512xf32>
    %2 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<481> : tensor<1xi64>, type = "SINK"} : () -> i32
    %3 = "equeue.alloc"(%2) {data_bit = 32 : i64, shape = dense<481> : tensor<1xi64>} : (i32) -> memref<481xf32>
    %4 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    %5 = "equeue.create_comp_field"(%4) {names = "stream0 "} : (i32) -> i32
    %6 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %6) {names = "stream1 "} : (i32, i32) -> ()
    %7 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %7) {names = "stream2 "} : (i32, i32) -> ()
    %8 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %8) {names = "stream3 "} : (i32, i32) -> ()
    %9 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %9) {names = "stream4 "} : (i32, i32) -> ()
    %10 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %10) {names = "stream5 "} : (i32, i32) -> ()
    %11 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %11) {names = "stream6 "} : (i32, i32) -> ()
    %12 = "equeue.connection"() {bandwidth = 32 : i64, type = "Streaming"} : () -> i32
    "equeue.add_comp_field"(%5, %12) {names = "stream7 "} : (i32, i32) -> ()
    %13 = "equeue.get_comp_field"(%5) {name = "stream0"} : (i32) -> i32
    "equeue.write"(%arg0, %1, %13) {bank = 0 : i64, size = dense<512> : tensor<1xi64>} : (tensor<512xi32>, memref<512xf32>, i32) -> ()
    %14 = "equeue.get_comp_field"(%5) {name = "stream1"} : (i32) -> i32
    "equeue.write"(%arg0, %1, %14) {bank = 0 : i64, size = dense<512> : tensor<1xi64>} : (tensor<512xi32>, memref<512xf32>, i32) -> ()
    %15 = "equeue.get_comp_field"(%5) {name = "stream2"} : (i32) -> i32
    "equeue.write"(%arg0, %1, %15) {bank = 0 : i64, size = dense<512> : tensor<1xi64>} : (tensor<512xi32>, memref<512xf32>, i32) -> ()
    %16 = "equeue.get_comp_field"(%5) {name = "stream3"} : (i32) -> i32
    "equeue.write"(%arg0, %1, %16) {bank = 0 : i64, size = dense<512> : tensor<1xi64>} : (tensor<512xi32>, memref<512xf32>, i32) -> ()
    %17 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %18 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %19 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %20 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %21 = "equeue.create_comp_field"(%17, %18, %19, %20) {names = "proc data taps acc "} : (i32, i32, i32, i32) -> i32
    %22 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %23 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %24 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %25 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %26 = "equeue.create_comp_field"(%22, %23, %24, %25) {names = "proc data taps acc "} : (i32, i32, i32, i32) -> i32
    %27 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %28 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %29 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %30 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %31 = "equeue.create_comp_field"(%27, %28, %29, %30) {names = "proc data taps acc "} : (i32, i32, i32, i32) -> i32
    %32 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %33 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %34 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %35 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %36 = "equeue.create_comp_field"(%32, %33, %34, %35) {names = "proc data taps acc "} : (i32, i32, i32, i32) -> i32
    %37 = "equeue.control_start"() : () -> !equeue.signal
    %38 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %done = "equeue.launch"(%37, %38, %21) ( {
    ^bb0(%arg1: i32):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "data"} : (i32) -> i32
      %299 = "equeue.alloc"(%298) {data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>} : (i32) -> memref<16xf32>
      %300 = "equeue.get_comp_field"(%arg1) {name = "taps"} : (i32) -> i32
      %301 = "equeue.alloc"(%300) {data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>} : (i32) -> memref<8xf32>
      %302 = "equeue.get_comp_field"(%arg1) {name = "acc"} : (i32) -> i32
      %303 = "equeue.alloc"(%302) {data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>} : (i32) -> memref<4xf32>
      "equeue.add_comp_field"(%arg1, %299, %301, %303) {names = "ifmap filter ofmap "} : (i32, memref<16xf32>, memref<8xf32>, memref<4xf32>) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    "equeue.await"(%done) : (!equeue.signal) -> ()
    %39 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %done_0 = "equeue.launch"(%37, %39, %26) ( {
    ^bb0(%arg1: i32):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "data"} : (i32) -> i32
      %299 = "equeue.alloc"(%298) {data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>} : (i32) -> memref<16xf32>
      %300 = "equeue.get_comp_field"(%arg1) {name = "taps"} : (i32) -> i32
      %301 = "equeue.alloc"(%300) {data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>} : (i32) -> memref<8xf32>
      %302 = "equeue.get_comp_field"(%arg1) {name = "acc"} : (i32) -> i32
      %303 = "equeue.alloc"(%302) {data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>} : (i32) -> memref<4xf32>
      "equeue.add_comp_field"(%arg1, %299, %301, %303) {names = "ifmap filter ofmap "} : (i32, memref<16xf32>, memref<8xf32>, memref<4xf32>) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    "equeue.await"(%done_0) : (!equeue.signal) -> ()
    %40 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %done_1 = "equeue.launch"(%37, %40, %31) ( {
    ^bb0(%arg1: i32):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "data"} : (i32) -> i32
      %299 = "equeue.alloc"(%298) {data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>} : (i32) -> memref<16xf32>
      %300 = "equeue.get_comp_field"(%arg1) {name = "taps"} : (i32) -> i32
      %301 = "equeue.alloc"(%300) {data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>} : (i32) -> memref<8xf32>
      %302 = "equeue.get_comp_field"(%arg1) {name = "acc"} : (i32) -> i32
      %303 = "equeue.alloc"(%302) {data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>} : (i32) -> memref<4xf32>
      "equeue.add_comp_field"(%arg1, %299, %301, %303) {names = "ifmap filter ofmap "} : (i32, memref<16xf32>, memref<8xf32>, memref<4xf32>) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    "equeue.await"(%done_1) : (!equeue.signal) -> ()
    %41 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_2 = "equeue.launch"(%37, %41, %36) ( {
    ^bb0(%arg1: i32):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "data"} : (i32) -> i32
      %299 = "equeue.alloc"(%298) {data_bit = 32 : i64, shape = dense<16> : tensor<1xi64>} : (i32) -> memref<16xf32>
      %300 = "equeue.get_comp_field"(%arg1) {name = "taps"} : (i32) -> i32
      %301 = "equeue.alloc"(%300) {data_bit = 32 : i64, shape = dense<8> : tensor<1xi64>} : (i32) -> memref<8xf32>
      %302 = "equeue.get_comp_field"(%arg1) {name = "acc"} : (i32) -> i32
      %303 = "equeue.alloc"(%302) {data_bit = 32 : i64, shape = dense<4> : tensor<1xi64>} : (i32) -> memref<4xf32>
      "equeue.add_comp_field"(%arg1, %299, %301, %303) {names = "ifmap filter ofmap "} : (i32, memref<16xf32>, memref<8xf32>, memref<4xf32>) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    "equeue.await"(%done_2) : (!equeue.signal) -> ()
    %42 = "equeue.control_start"() : () -> !equeue.signal
    %43 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %44 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_3 = "equeue.launch"(%42, %43, %5, %21, %1, %44) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %45 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %46 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_4 = "equeue.launch"(%42, %45, %5, %26, %21, %1, %46) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %47 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %48 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_5 = "equeue.launch"(%42, %47, %5, %31, %26, %1, %48) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %49 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_6 = "equeue.launch"(%42, %49, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %50 = "equeue.control_start"() : () -> !equeue.signal
    %51 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %52 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_7 = "equeue.launch"(%50, %51, %5, %21, %1, %52) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %53 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %54 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_8 = "equeue.launch"(%50, %53, %5, %26, %21, %1, %54) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %55 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %56 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_9 = "equeue.launch"(%50, %55, %5, %31, %26, %1, %56) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %57 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_10 = "equeue.launch"(%50, %57, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %58 = "equeue.control_start"() : () -> !equeue.signal
    %59 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %60 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_11 = "equeue.launch"(%58, %59, %5, %21, %1, %60) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %61 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %62 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_12 = "equeue.launch"(%58, %61, %5, %26, %21, %1, %62) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %63 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %64 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_13 = "equeue.launch"(%58, %63, %5, %31, %26, %1, %64) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %65 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_14 = "equeue.launch"(%58, %65, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %66 = "equeue.control_start"() : () -> !equeue.signal
    %67 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %68 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_15 = "equeue.launch"(%66, %67, %5, %21, %1, %68) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %69 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %70 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_16 = "equeue.launch"(%66, %69, %5, %26, %21, %1, %70) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %71 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %72 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_17 = "equeue.launch"(%66, %71, %5, %31, %26, %1, %72) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %73 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_18 = "equeue.launch"(%66, %73, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %74 = "equeue.control_start"() : () -> !equeue.signal
    %75 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %76 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_19 = "equeue.launch"(%74, %75, %5, %21, %1, %76) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %77 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %78 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_20 = "equeue.launch"(%74, %77, %5, %26, %21, %1, %78) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %79 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %80 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_21 = "equeue.launch"(%74, %79, %5, %31, %26, %1, %80) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %81 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_22 = "equeue.launch"(%74, %81, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %82 = "equeue.control_start"() : () -> !equeue.signal
    %83 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %84 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_23 = "equeue.launch"(%82, %83, %5, %21, %1, %84) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %85 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %86 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_24 = "equeue.launch"(%82, %85, %5, %26, %21, %1, %86) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %87 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %88 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_25 = "equeue.launch"(%82, %87, %5, %31, %26, %1, %88) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %89 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_26 = "equeue.launch"(%82, %89, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %90 = "equeue.control_start"() : () -> !equeue.signal
    %91 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %92 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_27 = "equeue.launch"(%90, %91, %5, %21, %1, %92) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %93 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %94 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_28 = "equeue.launch"(%90, %93, %5, %26, %21, %1, %94) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %95 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %96 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_29 = "equeue.launch"(%90, %95, %5, %31, %26, %1, %96) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %97 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_30 = "equeue.launch"(%90, %97, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %98 = "equeue.control_start"() : () -> !equeue.signal
    %99 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %100 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_31 = "equeue.launch"(%98, %99, %5, %21, %1, %100) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %101 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %102 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_32 = "equeue.launch"(%98, %101, %5, %26, %21, %1, %102) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %103 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %104 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_33 = "equeue.launch"(%98, %103, %5, %31, %26, %1, %104) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %105 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_34 = "equeue.launch"(%98, %105, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %106 = "equeue.control_start"() : () -> !equeue.signal
    %107 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %108 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_35 = "equeue.launch"(%106, %107, %5, %21, %1, %108) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %109 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %110 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_36 = "equeue.launch"(%106, %109, %5, %26, %21, %1, %110) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %111 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %112 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_37 = "equeue.launch"(%106, %111, %5, %31, %26, %1, %112) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %113 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_38 = "equeue.launch"(%106, %113, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %114 = "equeue.control_start"() : () -> !equeue.signal
    %115 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %116 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_39 = "equeue.launch"(%114, %115, %5, %21, %1, %116) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %117 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %118 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_40 = "equeue.launch"(%114, %117, %5, %26, %21, %1, %118) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %119 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %120 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_41 = "equeue.launch"(%114, %119, %5, %31, %26, %1, %120) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %121 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_42 = "equeue.launch"(%114, %121, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %122 = "equeue.control_start"() : () -> !equeue.signal
    %123 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %124 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_43 = "equeue.launch"(%122, %123, %5, %21, %1, %124) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %125 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %126 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_44 = "equeue.launch"(%122, %125, %5, %26, %21, %1, %126) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %127 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %128 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_45 = "equeue.launch"(%122, %127, %5, %31, %26, %1, %128) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %129 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_46 = "equeue.launch"(%122, %129, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %130 = "equeue.control_start"() : () -> !equeue.signal
    %131 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %132 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_47 = "equeue.launch"(%130, %131, %5, %21, %1, %132) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %133 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %134 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_48 = "equeue.launch"(%130, %133, %5, %26, %21, %1, %134) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %135 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %136 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_49 = "equeue.launch"(%130, %135, %5, %31, %26, %1, %136) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %137 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_50 = "equeue.launch"(%130, %137, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %138 = "equeue.control_start"() : () -> !equeue.signal
    %139 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %140 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_51 = "equeue.launch"(%138, %139, %5, %21, %1, %140) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %141 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %142 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_52 = "equeue.launch"(%138, %141, %5, %26, %21, %1, %142) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %143 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %144 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_53 = "equeue.launch"(%138, %143, %5, %31, %26, %1, %144) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %145 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_54 = "equeue.launch"(%138, %145, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %146 = "equeue.control_start"() : () -> !equeue.signal
    %147 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %148 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_55 = "equeue.launch"(%146, %147, %5, %21, %1, %148) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %149 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %150 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_56 = "equeue.launch"(%146, %149, %5, %26, %21, %1, %150) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %151 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %152 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_57 = "equeue.launch"(%146, %151, %5, %31, %26, %1, %152) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %153 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_58 = "equeue.launch"(%146, %153, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %154 = "equeue.control_start"() : () -> !equeue.signal
    %155 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %156 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_59 = "equeue.launch"(%154, %155, %5, %21, %1, %156) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %157 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %158 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_60 = "equeue.launch"(%154, %157, %5, %26, %21, %1, %158) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %159 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %160 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_61 = "equeue.launch"(%154, %159, %5, %31, %26, %1, %160) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %161 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_62 = "equeue.launch"(%154, %161, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %162 = "equeue.control_start"() : () -> !equeue.signal
    %163 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %164 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_63 = "equeue.launch"(%162, %163, %5, %21, %1, %164) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %165 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %166 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_64 = "equeue.launch"(%162, %165, %5, %26, %21, %1, %166) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %167 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %168 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_65 = "equeue.launch"(%162, %167, %5, %31, %26, %1, %168) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %169 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_66 = "equeue.launch"(%162, %169, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %170 = "equeue.control_start"() : () -> !equeue.signal
    %171 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %172 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_67 = "equeue.launch"(%170, %171, %5, %21, %1, %172) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %173 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %174 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_68 = "equeue.launch"(%170, %173, %5, %26, %21, %1, %174) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %175 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %176 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_69 = "equeue.launch"(%170, %175, %5, %31, %26, %1, %176) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %177 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_70 = "equeue.launch"(%170, %177, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %178 = "equeue.control_start"() : () -> !equeue.signal
    %179 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %180 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_71 = "equeue.launch"(%178, %179, %5, %21, %1, %180) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %181 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %182 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_72 = "equeue.launch"(%178, %181, %5, %26, %21, %1, %182) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %183 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %184 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_73 = "equeue.launch"(%178, %183, %5, %31, %26, %1, %184) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %185 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_74 = "equeue.launch"(%178, %185, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %186 = "equeue.control_start"() : () -> !equeue.signal
    %187 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %188 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_75 = "equeue.launch"(%186, %187, %5, %21, %1, %188) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %189 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %190 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_76 = "equeue.launch"(%186, %189, %5, %26, %21, %1, %190) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %191 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %192 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_77 = "equeue.launch"(%186, %191, %5, %31, %26, %1, %192) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %193 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_78 = "equeue.launch"(%186, %193, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %194 = "equeue.control_start"() : () -> !equeue.signal
    %195 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %196 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_79 = "equeue.launch"(%194, %195, %5, %21, %1, %196) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %197 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %198 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_80 = "equeue.launch"(%194, %197, %5, %26, %21, %1, %198) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %199 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %200 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_81 = "equeue.launch"(%194, %199, %5, %31, %26, %1, %200) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %201 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_82 = "equeue.launch"(%194, %201, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %202 = "equeue.control_start"() : () -> !equeue.signal
    %203 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %204 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_83 = "equeue.launch"(%202, %203, %5, %21, %1, %204) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %205 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %206 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_84 = "equeue.launch"(%202, %205, %5, %26, %21, %1, %206) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %207 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %208 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_85 = "equeue.launch"(%202, %207, %5, %31, %26, %1, %208) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %209 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_86 = "equeue.launch"(%202, %209, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %210 = "equeue.control_start"() : () -> !equeue.signal
    %211 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %212 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_87 = "equeue.launch"(%210, %211, %5, %21, %1, %212) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %213 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %214 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_88 = "equeue.launch"(%210, %213, %5, %26, %21, %1, %214) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %215 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %216 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_89 = "equeue.launch"(%210, %215, %5, %31, %26, %1, %216) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %217 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_90 = "equeue.launch"(%210, %217, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %218 = "equeue.control_start"() : () -> !equeue.signal
    %219 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %220 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_91 = "equeue.launch"(%218, %219, %5, %21, %1, %220) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %221 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %222 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_92 = "equeue.launch"(%218, %221, %5, %26, %21, %1, %222) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %223 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %224 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_93 = "equeue.launch"(%218, %223, %5, %31, %26, %1, %224) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %225 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_94 = "equeue.launch"(%218, %225, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %226 = "equeue.control_start"() : () -> !equeue.signal
    %227 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %228 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_95 = "equeue.launch"(%226, %227, %5, %21, %1, %228) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %229 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %230 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_96 = "equeue.launch"(%226, %229, %5, %26, %21, %1, %230) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %231 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %232 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_97 = "equeue.launch"(%226, %231, %5, %31, %26, %1, %232) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %233 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_98 = "equeue.launch"(%226, %233, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %234 = "equeue.control_start"() : () -> !equeue.signal
    %235 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %236 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_99 = "equeue.launch"(%234, %235, %5, %21, %1, %236) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %237 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %238 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_100 = "equeue.launch"(%234, %237, %5, %26, %21, %1, %238) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %239 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %240 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_101 = "equeue.launch"(%234, %239, %5, %31, %26, %1, %240) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %241 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_102 = "equeue.launch"(%234, %241, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %242 = "equeue.control_start"() : () -> !equeue.signal
    %243 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %244 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_103 = "equeue.launch"(%242, %243, %5, %21, %1, %244) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %245 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %246 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_104 = "equeue.launch"(%242, %245, %5, %26, %21, %1, %246) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %247 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %248 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_105 = "equeue.launch"(%242, %247, %5, %31, %26, %1, %248) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %249 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_106 = "equeue.launch"(%242, %249, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %250 = "equeue.control_start"() : () -> !equeue.signal
    %251 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %252 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_107 = "equeue.launch"(%250, %251, %5, %21, %1, %252) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %253 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %254 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_108 = "equeue.launch"(%250, %253, %5, %26, %21, %1, %254) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %255 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %256 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_109 = "equeue.launch"(%250, %255, %5, %31, %26, %1, %256) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %257 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_110 = "equeue.launch"(%250, %257, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %258 = "equeue.control_start"() : () -> !equeue.signal
    %259 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %260 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_111 = "equeue.launch"(%258, %259, %5, %21, %1, %260) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %261 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %262 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_112 = "equeue.launch"(%258, %261, %5, %26, %21, %1, %262) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %263 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %264 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_113 = "equeue.launch"(%258, %263, %5, %31, %26, %1, %264) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %265 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_114 = "equeue.launch"(%258, %265, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %266 = "equeue.control_start"() : () -> !equeue.signal
    %267 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %268 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_115 = "equeue.launch"(%266, %267, %5, %21, %1, %268) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %269 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %270 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_116 = "equeue.launch"(%266, %269, %5, %26, %21, %1, %270) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %271 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %272 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_117 = "equeue.launch"(%266, %271, %5, %31, %26, %1, %272) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %273 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_118 = "equeue.launch"(%266, %273, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %274 = "equeue.control_start"() : () -> !equeue.signal
    %275 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %276 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_119 = "equeue.launch"(%274, %275, %5, %21, %1, %276) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %277 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %278 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_120 = "equeue.launch"(%274, %277, %5, %26, %21, %1, %278) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %279 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %280 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_121 = "equeue.launch"(%274, %279, %5, %31, %26, %1, %280) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %281 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_122 = "equeue.launch"(%274, %281, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %282 = "equeue.control_start"() : () -> !equeue.signal
    %283 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %284 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_123 = "equeue.launch"(%282, %283, %5, %21, %1, %284) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %285 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %286 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_124 = "equeue.launch"(%282, %285, %5, %26, %21, %1, %286) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %287 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %288 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_125 = "equeue.launch"(%282, %287, %5, %31, %26, %1, %288) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %289 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_126 = "equeue.launch"(%282, %289, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    %290 = "equeue.control_start"() : () -> !equeue.signal
    %291 = "equeue.get_comp_field"(%21) {name = "proc"} : (i32) -> i32
    %292 = "equeue.get_comp_field"(%21) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_127 = "equeue.launch"(%290, %291, %5, %21, %1, %292) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: memref<512xf32>, %arg4: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream0"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %301 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %303 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %304 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %305 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%305, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %306 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%308, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %309 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%311, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %312 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %313 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%314, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %315 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %316 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%317, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %318 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %319 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %320 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%320, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %321 = "equeue.unkOp"(%302, %300, %301) {op_name = "mul4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %323 = "equeue.read"(%arg3, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%323, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %324 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.unkOp"(%302, %300, %301) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %326 = "equeue.read"(%302) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%326, %arg4, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %293 = "equeue.get_comp_field"(%26) {name = "proc"} : (i32) -> i32
    %294 = "equeue.get_comp_field"(%26) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_128 = "equeue.launch"(%290, %293, %5, %26, %21, %1, %294) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream1"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream4"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %295 = "equeue.get_comp_field"(%31) {name = "proc"} : (i32) -> i32
    %296 = "equeue.get_comp_field"(%31) {name = "ofmap"} : (i32) -> memref<4xi32>
    %done_129 = "equeue.launch"(%290, %295, %5, %31, %26, %1, %296) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<4xi32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream2"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream5"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<4xi32>) -> !equeue.signal
    %297 = "equeue.get_comp_field"(%36) {name = "proc"} : (i32) -> i32
    %done_130 = "equeue.launch"(%290, %297, %5, %36, %31, %1, %3) ( {
    ^bb0(%arg1: i32, %arg2: i32, %arg3: i32, %arg4: memref<512xf32>, %arg5: memref<481xf32>):  // no predecessors
      %298 = "equeue.get_comp_field"(%arg1) {name = "stream3"} : (i32) -> i32
      %299 = "equeue.get_comp_field"(%arg1) {name = "stream6"} : (i32) -> i32
      %300 = "equeue.get_comp_field"(%arg1) {name = "stream7"} : (i32) -> i32
      %301 = "equeue.get_comp_field"(%arg2) {name = "ifmap"} : (i32) -> memref<16xi32>
      %302 = "equeue.get_comp_field"(%arg2) {name = "filter"} : (i32) -> memref<8xi32>
      %303 = "equeue.get_comp_field"(%arg2) {name = "ofmap"} : (i32) -> memref<4xi32>
      %304 = "equeue.get_comp_field"(%arg3) {name = "ofmap"} : (i32) -> memref<4xi32>
      %305 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%305, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %306 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %307 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %308 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%308, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %309 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %310 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %311 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%311, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %312 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%312, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %313 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %314 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %315 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%315, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %316 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %317 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %318 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%318, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %319 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%319, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %320 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %321 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %322 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%322, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %323 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %324 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %325 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%325, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      %326 = "equeue.read"(%304, %299) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>, i32) -> tensor<4xi32>
      "equeue.write"(%326, %303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<4xi32>) -> ()
      %327 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %328 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %329 = "equeue.read"(%arg4, %298) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<512xf32>, i32) -> tensor<512xf32>
      "equeue.write"(%329, %301) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<512xf32>, memref<16xi32>) -> ()
      %330 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %331 = "equeue.unkOp"(%303, %301, %302) {op_name = "mac4"} : (memref<4xi32>, memref<16xi32>, memref<8xi32>) -> memref<4xi32>
      %332 = "equeue.read"(%303) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (memref<4xi32>) -> tensor<4xi32>
      "equeue.write"(%332, %arg5, %300) {bank = 0 : i64, size = dense<4> : tensor<1xi64>} : (tensor<4xi32>, memref<481xf32>, i32) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, i32, i32, memref<512xf32>, memref<481xf32>) -> !equeue.signal
    "equeue.await"(%done_130) : (!equeue.signal) -> ()
    return
  }
}
