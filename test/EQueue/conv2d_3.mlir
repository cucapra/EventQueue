

module {
  func @graph(%arg0: tensor<7x7xf32>, %arg1: tensor<5x5xf32>) -> tensor<3x3xf32> {
    %0 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp"(%1, %0) {name = "pe_0"} : (i32, i32) -> i32
    %3 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %4 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %5 = "equeue.create_comp"(%4, %3, %2) {name = "pe_1"} : (i32, i32, i32) -> i32
    %6 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %7 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %8 = "equeue.create_comp"(%7, %6, %5) {name = "pe_2"} : (i32, i32, i32) -> i32
    %9 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %10 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %11 = "equeue.create_comp"(%10, %9, %8) {name = "pe_3"} : (i32, i32, i32) -> i32
    %12 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %13 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %14 = "equeue.create_comp"(%13, %12, %11) {name = "pe_4"} : (i32, i32, i32) -> i32
    %15 = "equeue.create_mem"() {data = "f32", name = "mem", shape = dense<1024> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %16 = "equeue.create_dma"() {name = "dma"} : () -> i32
    %17 = "equeue.create_proc"() {name = "proc", type = "MicroPlate"} : () -> i32
    %18 = "equeue.create_comp"(%14, %17, %15, %16) {name = "accel"} : (i32, i32, i32, i32) -> i32
    %19 = "equeue.control_start"() : () -> !equeue.signal
    %done, %res = "equeue.launch"(%19, %17, %18, %arg0, %arg1) ( {
    ^bb0(%arg2: i32, %arg3: tensor<7x7xf32>, %arg4: tensor<5x5xf32>):  // no predecessors
      %20 = "equeue.get_comp"(%arg2) {name = "proc"} : (i32) -> i32
      %21 = "equeue.get_comp"(%arg2) {name = "dma"} : (i32) -> i32
      %22 = "equeue.get_comp"(%arg2) {name = "mem"} : (i32) -> i32
      %23 = "equeue.alloc"(%22) {data = "f32", shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
      %24 = "equeue.alloc"(%22) {data = "f32", shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
      %25 = "equeue.alloc"(%22) {data = "f32", shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
      "equeue.write"(%arg2, %23) : (i32, memref<7x7xf32>) -> ()
      %26 = "equeue.control_start"() : () -> !equeue.signal
      %27 = "equeue.get_comp"(%arg2) {name = "pe_4"} : (i32) -> i32
      %28 = "equeue.get_comp"(%27) {name = "mem"} : (i32) -> i32
      %29 = "equeue.get_comp"(%27) {name = "proc"} : (i32) -> i32
      %30 = "equeue.alloc"(%28) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %31 = "equeue.alloc"(%28) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %32 = "equeue.alloc"(%28) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %33 = "equeue.memcpy"(%26, %24, %30, %21) : (!equeue.signal, memref<5x5xf32>, memref<5xf32>, i32) -> !equeue.signal
      %34 = "equeue.get_comp"(%27) {name = "pe_3"} : (i32) -> i32
      %35 = "equeue.get_comp"(%34) {name = "mem"} : (i32) -> i32
      %36 = "equeue.get_comp"(%34) {name = "proc"} : (i32) -> i32
      %37 = "equeue.alloc"(%35) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %38 = "equeue.alloc"(%35) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %39 = "equeue.alloc"(%35) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %40 = "equeue.memcpy"(%26, %24, %37, %21) : (!equeue.signal, memref<5x5xf32>, memref<5xf32>, i32) -> !equeue.signal
      %41 = "equeue.get_comp"(%34) {name = "pe_2"} : (i32) -> i32
      %42 = "equeue.get_comp"(%41) {name = "mem"} : (i32) -> i32
      %43 = "equeue.get_comp"(%41) {name = "proc"} : (i32) -> i32
      %44 = "equeue.alloc"(%42) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %45 = "equeue.alloc"(%42) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %46 = "equeue.alloc"(%42) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %47 = "equeue.memcpy"(%26, %24, %44, %21) : (!equeue.signal, memref<5x5xf32>, memref<5xf32>, i32) -> !equeue.signal
      %48 = "equeue.get_comp"(%41) {name = "pe_1"} : (i32) -> i32
      %49 = "equeue.get_comp"(%48) {name = "mem"} : (i32) -> i32
      %50 = "equeue.get_comp"(%48) {name = "proc"} : (i32) -> i32
      %51 = "equeue.alloc"(%49) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %52 = "equeue.alloc"(%49) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %53 = "equeue.alloc"(%49) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %54 = "equeue.memcpy"(%26, %24, %51, %21) : (!equeue.signal, memref<5x5xf32>, memref<5xf32>, i32) -> !equeue.signal
      %55 = "equeue.get_comp"(%48) {name = "pe_0"} : (i32) -> i32
      %56 = "equeue.get_comp"(%55) {name = "mem"} : (i32) -> i32
      %57 = "equeue.get_comp"(%55) {name = "proc"} : (i32) -> i32
      %58 = "equeue.alloc"(%56) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %59 = "equeue.alloc"(%56) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %60 = "equeue.alloc"(%56) {data = "f32", shape = dense<5> : tensor<1xi64>} : (i32) -> memref<5xf32>
      %61 = "equeue.memcpy"(%26, %24, %58, %21) : (!equeue.signal, memref<5x5xf32>, memref<5xf32>, i32) -> !equeue.signal
      %c0 = constant 0 : index
      %c3 = constant 3 : index
      %c1 = constant 1 : index
      %62 = scf.for %arg5 = %c0 to %c3 step %c1 iter_args(%arg6 = %61) -> (!equeue.signal) {
        %64 = "equeue.memcpy"(%arg6, %23, %32, %21) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32) -> !equeue.signal
        %cst = constant 0.000000e+00 : f32
        "equeue.write"(%cst, %31) : (f32, memref<1xf32>) -> ()
        %65 = "equeue.memcpy"(%arg6, %23, %39, %21) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32) -> !equeue.signal
        %cst_0 = constant 0.000000e+00 : f32
        "equeue.write"(%cst_0, %38) : (f32, memref<1xf32>) -> ()
        %66 = "equeue.memcpy"(%arg6, %23, %46, %21) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32) -> !equeue.signal
        %cst_1 = constant 0.000000e+00 : f32
        "equeue.write"(%cst_1, %45) : (f32, memref<1xf32>) -> ()
        %67 = "equeue.memcpy"(%arg6, %23, %53, %21) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32) -> !equeue.signal
        %cst_2 = constant 0.000000e+00 : f32
        "equeue.write"(%cst_2, %52) : (f32, memref<1xf32>) -> ()
        %68 = "equeue.memcpy"(%arg6, %23, %60, %21) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32) -> !equeue.signal
        %cst_3 = constant 0.000000e+00 : f32
        "equeue.write"(%cst_3, %59) : (f32, memref<1xf32>) -> ()
        %69 = "equeue.control_and"(%64, %65, %66, %67, %68) : (!equeue.signal, !equeue.signal, !equeue.signal, !equeue.signal, !equeue.signal) -> !equeue.signal
        %c0_4 = constant 0 : index
        %c3_5 = constant 3 : index
        %c1_6 = constant 1 : index
        %70 = scf.for %arg7 = %c0_4 to %c3_5 step %c1_6 iter_args(%arg8 = %69) -> (!equeue.signal) {
          %71 = "equeue.memcpy"(%arg8, %23, %32, %21, %arg7) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32, index) -> !equeue.signal
          %done_7 = "equeue.launch"(%71, %29, %32, %30, %31) ( {
          ^bb0(%arg9: memref<5xf32>, %arg10: memref<5xf32>, %arg11: memref<1xf32>):  // no predecessors
            %c0_16 = constant 0 : index
            %c5 = constant 5 : index
            %c1_17 = constant 1 : index
            scf.for %arg12 = %c0_16 to %c5 step %c1_17 {
              %81 = "equeue.read"(%arg9, %arg12) : (memref<5xf32>, index) -> f32
              %82 = "equeue.read"(%arg10, %arg12) : (memref<5xf32>, index) -> f32
              %83 = mulf %81, %82 : f32
              %84 = "equeue.read"(%arg11) : (memref<1xf32>) -> f32
              %85 = addf %84, %83 : f32
              "equeue.write"(%85, %arg11) : (f32, memref<1xf32>) -> ()
            }
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<5xf32>, memref<5xf32>, memref<1xf32>) -> !equeue.signal
          %72 = "equeue.memcpy"(%arg8, %23, %39, %21, %arg7) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32, index) -> !equeue.signal
          %done_8 = "equeue.launch"(%72, %36, %39, %37, %38) ( {
          ^bb0(%arg9: memref<5xf32>, %arg10: memref<5xf32>, %arg11: memref<1xf32>):  // no predecessors
            %c0_16 = constant 0 : index
            %c5 = constant 5 : index
            %c1_17 = constant 1 : index
            scf.for %arg12 = %c0_16 to %c5 step %c1_17 {
              %81 = "equeue.read"(%arg9, %arg12) : (memref<5xf32>, index) -> f32
              %82 = "equeue.read"(%arg10, %arg12) : (memref<5xf32>, index) -> f32
              %83 = mulf %81, %82 : f32
              %84 = "equeue.read"(%arg11) : (memref<1xf32>) -> f32
              %85 = addf %84, %83 : f32
              "equeue.write"(%85, %arg11) : (f32, memref<1xf32>) -> ()
            }
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<5xf32>, memref<5xf32>, memref<1xf32>) -> !equeue.signal
          %73 = "equeue.control_and"(%done_8, %done_7) : (!equeue.signal, !equeue.signal) -> !equeue.signal
          %done_9 = "equeue.launch"(%73, %36, %31, %38) ( {
          ^bb0(%arg9: memref<1xf32>, %arg10: memref<1xf32>):  // no predecessors
            %81 = "equeue.read"(%arg9) : (memref<1xf32>) -> f32
            %82 = "equeue.read"(%arg10) : (memref<1xf32>) -> f32
            %83 = addf %81, %82 : f32
            "equeue.write"(%83, %arg10) : (f32, memref<1xf32>) -> ()
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
          %74 = "equeue.memcpy"(%arg8, %23, %46, %21, %arg7) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32, index) -> !equeue.signal
          %done_10 = "equeue.launch"(%74, %43, %46, %44, %45) ( {
          ^bb0(%arg9: memref<5xf32>, %arg10: memref<5xf32>, %arg11: memref<1xf32>):  // no predecessors
            %c0_16 = constant 0 : index
            %c5 = constant 5 : index
            %c1_17 = constant 1 : index
            scf.for %arg12 = %c0_16 to %c5 step %c1_17 {
              %81 = "equeue.read"(%arg9, %arg12) : (memref<5xf32>, index) -> f32
              %82 = "equeue.read"(%arg10, %arg12) : (memref<5xf32>, index) -> f32
              %83 = mulf %81, %82 : f32
              %84 = "equeue.read"(%arg11) : (memref<1xf32>) -> f32
              %85 = addf %84, %83 : f32
              "equeue.write"(%85, %arg11) : (f32, memref<1xf32>) -> ()
            }
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<5xf32>, memref<5xf32>, memref<1xf32>) -> !equeue.signal
          %75 = "equeue.control_and"(%done_10, %done_8) : (!equeue.signal, !equeue.signal) -> !equeue.signal
          %done_11 = "equeue.launch"(%75, %43, %38, %45) ( {
          ^bb0(%arg9: memref<1xf32>, %arg10: memref<1xf32>):  // no predecessors
            %81 = "equeue.read"(%arg9) : (memref<1xf32>) -> f32
            %82 = "equeue.read"(%arg10) : (memref<1xf32>) -> f32
            %83 = addf %81, %82 : f32
            "equeue.write"(%83, %arg10) : (f32, memref<1xf32>) -> ()
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
          %76 = "equeue.memcpy"(%arg8, %23, %53, %21, %arg7) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32, index) -> !equeue.signal
          %done_12 = "equeue.launch"(%76, %50, %53, %51, %52) ( {
          ^bb0(%arg9: memref<5xf32>, %arg10: memref<5xf32>, %arg11: memref<1xf32>):  // no predecessors
            %c0_16 = constant 0 : index
            %c5 = constant 5 : index
            %c1_17 = constant 1 : index
            scf.for %arg12 = %c0_16 to %c5 step %c1_17 {
              %81 = "equeue.read"(%arg9, %arg12) : (memref<5xf32>, index) -> f32
              %82 = "equeue.read"(%arg10, %arg12) : (memref<5xf32>, index) -> f32
              %83 = mulf %81, %82 : f32
              %84 = "equeue.read"(%arg11) : (memref<1xf32>) -> f32
              %85 = addf %84, %83 : f32
              "equeue.write"(%85, %arg11) : (f32, memref<1xf32>) -> ()
            }
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<5xf32>, memref<5xf32>, memref<1xf32>) -> !equeue.signal
          %77 = "equeue.control_and"(%done_12, %done_10) : (!equeue.signal, !equeue.signal) -> !equeue.signal
          %done_13 = "equeue.launch"(%77, %50, %45, %52) ( {
          ^bb0(%arg9: memref<1xf32>, %arg10: memref<1xf32>):  // no predecessors
            %81 = "equeue.read"(%arg9) : (memref<1xf32>) -> f32
            %82 = "equeue.read"(%arg10) : (memref<1xf32>) -> f32
            %83 = addf %81, %82 : f32
            "equeue.write"(%83, %arg10) : (f32, memref<1xf32>) -> ()
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
          %78 = "equeue.memcpy"(%arg8, %23, %60, %21, %arg7) : (!equeue.signal, memref<7x7xf32>, memref<5xf32>, i32, index) -> !equeue.signal
          %done_14 = "equeue.launch"(%78, %57, %60, %58, %59) ( {
          ^bb0(%arg9: memref<5xf32>, %arg10: memref<5xf32>, %arg11: memref<1xf32>):  // no predecessors
            %c0_16 = constant 0 : index
            %c5 = constant 5 : index
            %c1_17 = constant 1 : index
            scf.for %arg12 = %c0_16 to %c5 step %c1_17 {
              %81 = "equeue.read"(%arg9, %arg12) : (memref<5xf32>, index) -> f32
              %82 = "equeue.read"(%arg10, %arg12) : (memref<5xf32>, index) -> f32
              %83 = mulf %81, %82 : f32
              %84 = "equeue.read"(%arg11) : (memref<1xf32>) -> f32
              %85 = addf %84, %83 : f32
              "equeue.write"(%85, %arg11) : (f32, memref<1xf32>) -> ()
            }
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<5xf32>, memref<5xf32>, memref<1xf32>) -> !equeue.signal
          %79 = "equeue.control_and"(%done_14, %done_12) : (!equeue.signal, !equeue.signal) -> !equeue.signal
          %done_15 = "equeue.launch"(%79, %57, %52, %59) ( {
          ^bb0(%arg9: memref<1xf32>, %arg10: memref<1xf32>):  // no predecessors
            %81 = "equeue.read"(%arg9) : (memref<1xf32>) -> f32
            %82 = "equeue.read"(%arg10) : (memref<1xf32>) -> f32
            %83 = addf %81, %82 : f32
            "equeue.write"(%83, %arg10) : (f32, memref<1xf32>) -> ()
            "equeue.return"() : () -> ()
          }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
          %80 = "equeue.memcpy"(%done_15, %59, %25, %21) : (!equeue.signal, memref<1xf32>, memref<3x3xf32>, i32) -> !equeue.signal
          scf.yield %80 : !equeue.signal
        }
        scf.yield %70 : !equeue.signal
      }
      "equeue.await"(%62) : (!equeue.signal) -> ()
      %63 = "equeue.read"(%25) : (memref<3x3xf32>) -> tensor<3x3xf32>
      "equeue.dealloc"(%24, %25, %23) : (memref<5x5xf32>, memref<3x3xf32>, memref<7x7xf32>) -> ()
      "equeue.return"(%63) : (tensor<3x3xf32>) -> ()
    }) : (!equeue.signal, i32, i32, tensor<7x7xf32>, tensor<5x5xf32>) -> (!equeue.signal, tensor<3x3xf32>)
    "equeue.await"(%done) : (!equeue.signal) -> ()
    return %res : tensor<3x3xf32>
  }
}
