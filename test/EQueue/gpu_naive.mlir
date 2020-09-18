#map0 = affine_map<(d0, d1) -> (d0 + d1)>


module {
  func @graph(%arg0: tensor<16xf32>, %arg1: tensor<5xf32>) -> tensor<12xf32> {
    %0 = "equeue.create_mem"() {data = "f32", name = "AIE_MEM", shape = dense<11> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %1 = "equeue.create_proc"() {name = "AIE_CORE", type = "AIEngine"} : () -> i32
    %2 = "equeue.create_comp"(%0, %1) {name = "AIE"} : (i32, i32) -> i32
    %3 = "equeue.create_mem"() {data = "f32", name = "SRAM", shape = dense<64> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %4 = "equeue.create_proc"() {name = "ACCEL_CORE", type = "ARMr5"} : () -> i32
    %5 = "equeue.create_dma"() {name = "ACCEL_DMA"} : () -> i32
    %6 = "equeue.create_comp"(%4, %2, %5, %3) {name = "ACCEL"} : (i32, i32, i32, i32) -> i32
    %7 = "equeue.control_start"() : () -> !equeue.signal
    %done, %res = "equeue.launch"(%7, %4, %arg0, %arg1, %1, %5, %3, %0) ( {
    ^bb0(%arg2: tensor<16xf32>, %arg3: tensor<5xf32>, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32):  // no predecessors
      %8 = "equeue.alloc"(%arg6) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> !equeue.container<tensor<5xf32>, i32>
      "equeue.write"(%arg3, %8) : (tensor<5xf32>, !equeue.container<tensor<5xf32>, i32>) -> ()
      %9 = "equeue.alloc"(%arg6) {data = "f32", shape = dense<16> : tensor<1xi64>} : (i32) -> !equeue.container<tensor<16xf32>, i32>
      "equeue.write"(%arg2, %9) : (tensor<16xf32>, !equeue.container<tensor<16xf32>, i32>) -> ()
      %10 = "equeue.alloc"(%arg6) {data = "f32", shape = dense<16> : tensor<1xi64>} : (i32) -> !equeue.container<tensor<12xf32>, i32>
      %11 = "equeue.alloc"(%arg7) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> !equeue.container<tensor<5xf32>, i32>
      %12 = "equeue.alloc"(%arg7) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> !equeue.container<tensor<5xf32>, i32>
      %13 = "equeue.alloc"(%arg7) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> !equeue.container<f32, i32>
      %14 = "equeue.control_start"() : () -> !equeue.signal
      %15 = "equeue.memcpy"(%14, %8, %11, %arg5) : (!equeue.signal, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, i32) -> !equeue.signal
      %c0 = constant 0 : index
      %c2 = constant 2 : index
      %c1 = constant 1 : index
      %16 = scf.for %arg8 = %c0 to %c2 step %c1 iter_args(%arg9 = %14) -> (!equeue.signal) {
        %18 = "equeue.memcpy"(%arg9, %9, %12, %arg5, %arg8) : (!equeue.signal, !equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, i32, index) -> !equeue.signal
        %19 = "equeue.control_and"(%15, %18) : (!equeue.signal, !equeue.signal) -> !equeue.signal
        %done_0 = "equeue.launch"(%19, %arg4, %12, %11, %13, %arg8) ( {
        ^bb0(%arg10: !equeue.container<tensor<5xf32>, i32>, %arg11: !equeue.container<tensor<5xf32>, i32>, %arg12: !equeue.container<f32, i32>, %arg13: index):  // no predecessors
          %cst = constant 0.000000e+00 : f32
          "equeue.write"(%cst, %arg12) : (f32, !equeue.container<f32, i32>) -> ()
          %c0_1 = constant 0 : index
          %c1_2 = constant 1 : index
          %c2_3 = constant 2 : index
          scf.for %arg14 = %c0_1 to %c2_3 step %c1_2 {
            %21 = affine.apply #map0(%arg13, %arg14)
            %22 = "equeue.read"(%arg10, %21) : (!equeue.container<tensor<5xf32>, i32>, index) -> f32
            %23 = "equeue.read"(%arg11, %arg14) : (!equeue.container<tensor<5xf32>, i32>, index) -> f32
            %24 = "equeue.read"(%arg12) : (!equeue.container<f32, i32>) -> f32
            %25 = mulf %23, %22 : f32
            %26 = addf %24, %25 : f32
            "equeue.write"(%26, %arg12) : (f32, !equeue.container<f32, i32>) -> ()
          }
          "equeue.return"() : () -> ()
        }) : (!equeue.signal, i32, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32>, index) -> !equeue.signal
        %20 = "equeue.memcpy"(%done_0, %13, %10, %arg5, %arg8) : (!equeue.signal, !equeue.container<f32, i32>, !equeue.container<tensor<12xf32>, i32>, i32, index) -> !equeue.signal
        scf.yield %20 : !equeue.signal
      }
      "equeue.await"(%16) : (!equeue.signal) -> ()
      %17 = "equeue.read"(%10) : (!equeue.container<tensor<12xf32>, i32>) -> tensor<5xf32>
      "equeue.dealloc"(%9, %8, %10, %12, %11, %13) : (!equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<12xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32>) -> ()
      "equeue.return"(%17) : (tensor<5xf32>) -> ()
    }) : (!equeue.signal, i32, tensor<16xf32>, tensor<5xf32>, i32, i32, i32, i32) -> (!equeue.signal, tensor<12xf32>)
    "equeue.await"(%done) : (!equeue.signal) -> ()
    return %res : tensor<12xf32>
  }
}
