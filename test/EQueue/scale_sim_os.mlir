

module {
  func @graph(%arg0: memref<3x5x5xf32>, %arg1: memref<2x3x5x3xf32>) {
    %0 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 3 : i64, data = "f32", name = "mem", shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp"(%1, %0) {name = "pe_0,0"} : (i32, i32) -> i32
    %3 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %4 = "equeue.create_mem"() {banks = 3 : i64, data = "f32", name = "mem", shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %5 = "equeue.create_comp"(%4, %3, %2) {name = "pe_0,1"} : (i32, i32, i32) -> i32
    %6 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %7 = "equeue.create_mem"() {banks = 3 : i64, data = "f32", name = "mem", shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %8 = "equeue.create_comp"(%7, %6, %5) {name = "pe_1,0"} : (i32, i32, i32) -> i32
    %9 = "equeue.create_proc"() {name = "proc", type = "AIEngine"} : () -> i32
    %10 = "equeue.create_mem"() {banks = 3 : i64, data = "f32", name = "mem", shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %11 = "equeue.create_comp"(%10, %9, %8) {name = "pe_1,1"} : (i32, i32, i32) -> i32
    %12 = "equeue.create_mem"() {banks = 4 : i64, data = "f32", name = "mem", shape = dense<110592> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %13 = "equeue.create_dma"() {name = "dma"} : () -> i32
    %14 = "equeue.create_comp"(%13) {name = "dma_col"} : (i32) -> i32
    %15 = "equeue.create_dma"() {name = "dma"} : () -> i32
    %16 = "equeue.create_comp"(%15, %14) {name = "dma_col"} : (i32, i32) -> i32
    %17 = "equeue.create_dma"() {name = "dma"} : () -> i32
    %18 = "equeue.create_comp"(%17) {name = "dma_row"} : (i32) -> i32
    %19 = "equeue.create_dma"() {name = "dma"} : () -> i32
    %20 = "equeue.create_comp"(%19, %18) {name = "dma_row"} : (i32, i32) -> i32
    %21 = "equeue.create_proc"() {name = "proc", type = "MicroPlate"} : () -> i32
    %22 = "equeue.create_comp"(%11, %21, %12, %20, %16) {name = "accel"} : (i32, i32, i32, i32, i32) -> i32
    %23 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%23, %21, %22, %arg0, %arg1) ( {
    ^bb0(%arg2: i32, %arg3: memref<3x5x5xf32>, %arg4: memref<2x3x5x3xf32>):  // no predecessors
      %24 = "equeue.get_comp"(%arg2) {name = "proc"} : (i32) -> i32
      %25 = "equeue.get_comp"(%arg2) {name = "dma_row"} : (i32) -> i32
      %26 = "equeue.get_comp"(%arg2) {name = "dma_col"} : (i32) -> i32
      %27 = "equeue.get_comp"(%25) {name = "dma"} : (i32) -> i32
      %28 = "equeue.get_comp"(%25) {name = "dma_row"} : (i32) -> i32
      %29 = "equeue.get_comp"(%28) {name = "dma"} : (i32) -> i32
      %30 = "equeue.get_comp"(%26) {name = "dma"} : (i32) -> i32
      %31 = "equeue.get_comp"(%26) {name = "dma_col"} : (i32) -> i32
      %32 = "equeue.get_comp"(%31) {name = "dma"} : (i32) -> i32
      %33 = "equeue.get_comp"(%arg2) {name = "mem"} : (i32) -> i32
      %34 = "equeue.alloc"(%33) {data = "f32", shape = dense<[3, 5, 5]> : tensor<3xi64>} : (i32) -> memref<3x5x5xf32>
      %35 = "equeue.alloc"(%33) {data = "f32", shape = dense<[2, 3, 5, 3]> : tensor<4xi64>} : (i32) -> memref<2x3x5x3xf32>
      %36 = "equeue.alloc"(%33) {data = "f32", shape = dense<[2, 1, 1]> : tensor<3xi64>} : (i32) -> memref<2x1x1xf32>
      %37 = "equeue.get_comp"(%arg2) {name = "pe_1,1"} : (i32) -> i32
      %38 = "equeue.get_comp"(%37) {name = "mem"} : (i32) -> i32
      %39 = "equeue.get_comp"(%37) {name = "proc"} : (i32) -> i32
      %40 = "equeue.alloc"(%38) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %41 = "equeue.alloc"(%38) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %42 = "equeue.alloc"(%38) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %43 = "equeue.get_comp"(%37) {name = "pe_1,0"} : (i32) -> i32
      %44 = "equeue.get_comp"(%43) {name = "mem"} : (i32) -> i32
      %45 = "equeue.get_comp"(%43) {name = "proc"} : (i32) -> i32
      %46 = "equeue.alloc"(%44) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %47 = "equeue.alloc"(%44) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %48 = "equeue.alloc"(%44) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %49 = "equeue.get_comp"(%43) {name = "pe_0,1"} : (i32) -> i32
      %50 = "equeue.get_comp"(%49) {name = "mem"} : (i32) -> i32
      %51 = "equeue.get_comp"(%49) {name = "proc"} : (i32) -> i32
      %52 = "equeue.alloc"(%50) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %53 = "equeue.alloc"(%50) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %54 = "equeue.alloc"(%50) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %55 = "equeue.get_comp"(%49) {name = "pe_0,0"} : (i32) -> i32
      %56 = "equeue.get_comp"(%55) {name = "mem"} : (i32) -> i32
      %57 = "equeue.get_comp"(%55) {name = "proc"} : (i32) -> i32
      %58 = "equeue.alloc"(%56) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %59 = "equeue.alloc"(%56) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %60 = "equeue.alloc"(%56) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
      %c0 = constant 0 : index
      %61 = "equeue.control_start"() : () -> !equeue.signal
      %62 = "equeue.memcpy"(%61, %35, %40, %30, %c0) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_0 = "equeue.launch"(%62, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %63 = "equeue.memcpy"(%61, %35, %46, %32, %c0) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_1 = "equeue.launch"(%63, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_1) : (!equeue.signal) -> ()
      %64 = "equeue.control_start"() : () -> !equeue.signal
      %65 = "equeue.memcpy"(%64, %34, %42, %27, %c0) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_2 = "equeue.launch"(%65, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_3 = "equeue.launch"(%done_2, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %66 = "equeue.control_start"() : () -> !equeue.signal
      %67 = "equeue.memcpy"(%66, %34, %54, %29, %c0) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_4 = "equeue.launch"(%67, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %68 = "equeue.control_start"() : () -> !equeue.signal
      %done_5 = "equeue.launch"(%done_4, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %69 = "equeue.control_start"() : () -> !equeue.signal
      %done_6 = "equeue.launch"(%done_4, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_7 = "equeue.launch"(%done_6, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_8 = "equeue.launch"(%done_7, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_9 = "equeue.launch"(%done_8, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %70 = "equeue.control_and"(%done_6, %done_9) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %71 = "equeue.control_start"() : () -> !equeue.signal
      %done_10 = "equeue.launch"(%70, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %72 = "equeue.control_start"() : () -> !equeue.signal
      %done_11 = "equeue.launch"(%70, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %73 = "equeue.memcpy"(%done_11, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_12 = "equeue.launch"(%73, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_13 = "equeue.launch"(%done_12, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %74 = "equeue.memcpy"(%done_13, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %75 = "equeue.control_and"(%73, %74) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %76 = "equeue.control_start"() : () -> !equeue.signal
      %done_14 = "equeue.launch"(%75, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %77 = "equeue.control_start"() : () -> !equeue.signal
      %done_15 = "equeue.launch"(%75, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %78 = "equeue.memcpy"(%done_15, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_16 = "equeue.launch"(%78, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_17 = "equeue.launch"(%done_16, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %79 = "equeue.memcpy"(%done_17, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %80 = "equeue.control_and"(%78, %79) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %81 = "equeue.control_start"() : () -> !equeue.signal
      %done_18 = "equeue.launch"(%80, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %82 = "equeue.control_start"() : () -> !equeue.signal
      %done_19 = "equeue.launch"(%80, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_20 = "equeue.launch"(%done_19, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_21 = "equeue.launch"(%done_20, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %83 = "equeue.memcpy"(%done_21, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %84 = "equeue.control_and"(%done_19, %83) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_22 = constant 0 : index
      %85 = "equeue.control_start"() : () -> !equeue.signal
      %86 = "equeue.memcpy"(%85, %35, %40, %30, %c0_22) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_23 = "equeue.launch"(%86, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %87 = "equeue.memcpy"(%85, %35, %46, %32, %c0_22) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_24 = "equeue.launch"(%87, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_24) : (!equeue.signal) -> ()
      %88 = "equeue.control_start"() : () -> !equeue.signal
      %89 = "equeue.memcpy"(%88, %34, %42, %27, %c0_22) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_25 = "equeue.launch"(%89, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_26 = "equeue.launch"(%done_25, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %90 = "equeue.control_start"() : () -> !equeue.signal
      %91 = "equeue.memcpy"(%90, %34, %54, %29, %c0_22) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_27 = "equeue.launch"(%91, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %92 = "equeue.control_start"() : () -> !equeue.signal
      %done_28 = "equeue.launch"(%done_27, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %93 = "equeue.control_start"() : () -> !equeue.signal
      %done_29 = "equeue.launch"(%done_27, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_30 = "equeue.launch"(%done_29, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_31 = "equeue.launch"(%done_30, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_32 = "equeue.launch"(%done_31, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %94 = "equeue.control_and"(%done_29, %done_32) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %95 = "equeue.control_start"() : () -> !equeue.signal
      %done_33 = "equeue.launch"(%94, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %96 = "equeue.control_start"() : () -> !equeue.signal
      %done_34 = "equeue.launch"(%94, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %97 = "equeue.memcpy"(%done_34, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_35 = "equeue.launch"(%97, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_36 = "equeue.launch"(%done_35, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %98 = "equeue.memcpy"(%done_36, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %99 = "equeue.control_and"(%97, %98) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %100 = "equeue.control_start"() : () -> !equeue.signal
      %done_37 = "equeue.launch"(%99, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %101 = "equeue.control_start"() : () -> !equeue.signal
      %done_38 = "equeue.launch"(%99, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %102 = "equeue.memcpy"(%done_38, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_39 = "equeue.launch"(%102, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_40 = "equeue.launch"(%done_39, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %103 = "equeue.memcpy"(%done_40, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %104 = "equeue.control_and"(%102, %103) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %105 = "equeue.control_start"() : () -> !equeue.signal
      %done_41 = "equeue.launch"(%104, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %106 = "equeue.control_start"() : () -> !equeue.signal
      %done_42 = "equeue.launch"(%104, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_43 = "equeue.launch"(%done_42, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_44 = "equeue.launch"(%done_43, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %107 = "equeue.memcpy"(%done_44, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %108 = "equeue.control_and"(%done_42, %107) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_45 = constant 0 : index
      %109 = "equeue.control_start"() : () -> !equeue.signal
      %110 = "equeue.memcpy"(%109, %35, %40, %30, %c0_45) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_46 = "equeue.launch"(%110, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %111 = "equeue.memcpy"(%109, %35, %46, %32, %c0_45) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_47 = "equeue.launch"(%111, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_47) : (!equeue.signal) -> ()
      %112 = "equeue.control_start"() : () -> !equeue.signal
      %113 = "equeue.memcpy"(%112, %34, %42, %27, %c0_45) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_48 = "equeue.launch"(%113, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_49 = "equeue.launch"(%done_48, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %114 = "equeue.control_start"() : () -> !equeue.signal
      %115 = "equeue.memcpy"(%114, %34, %54, %29, %c0_45) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_50 = "equeue.launch"(%115, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %116 = "equeue.control_start"() : () -> !equeue.signal
      %done_51 = "equeue.launch"(%done_50, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %117 = "equeue.control_start"() : () -> !equeue.signal
      %done_52 = "equeue.launch"(%done_50, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_53 = "equeue.launch"(%done_52, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_54 = "equeue.launch"(%done_53, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_55 = "equeue.launch"(%done_54, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %118 = "equeue.control_and"(%done_52, %done_55) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %119 = "equeue.control_start"() : () -> !equeue.signal
      %done_56 = "equeue.launch"(%118, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %120 = "equeue.control_start"() : () -> !equeue.signal
      %done_57 = "equeue.launch"(%118, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %121 = "equeue.memcpy"(%done_57, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_58 = "equeue.launch"(%121, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_59 = "equeue.launch"(%done_58, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %122 = "equeue.memcpy"(%done_59, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %123 = "equeue.control_and"(%121, %122) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %124 = "equeue.control_start"() : () -> !equeue.signal
      %done_60 = "equeue.launch"(%123, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %125 = "equeue.control_start"() : () -> !equeue.signal
      %done_61 = "equeue.launch"(%123, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %126 = "equeue.memcpy"(%done_61, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_62 = "equeue.launch"(%126, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_63 = "equeue.launch"(%done_62, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %127 = "equeue.memcpy"(%done_63, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %128 = "equeue.control_and"(%126, %127) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %129 = "equeue.control_start"() : () -> !equeue.signal
      %done_64 = "equeue.launch"(%128, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %130 = "equeue.control_start"() : () -> !equeue.signal
      %done_65 = "equeue.launch"(%128, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_66 = "equeue.launch"(%done_65, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_67 = "equeue.launch"(%done_66, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %131 = "equeue.memcpy"(%done_67, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %132 = "equeue.control_and"(%done_65, %131) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_68 = constant 0 : index
      %133 = "equeue.control_start"() : () -> !equeue.signal
      %134 = "equeue.memcpy"(%133, %35, %40, %30, %c0_68) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_69 = "equeue.launch"(%134, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %135 = "equeue.memcpy"(%133, %35, %46, %32, %c0_68) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_70 = "equeue.launch"(%135, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_70) : (!equeue.signal) -> ()
      %136 = "equeue.control_start"() : () -> !equeue.signal
      %137 = "equeue.memcpy"(%136, %34, %42, %27, %c0_68) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_71 = "equeue.launch"(%137, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_72 = "equeue.launch"(%done_71, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %138 = "equeue.control_start"() : () -> !equeue.signal
      %139 = "equeue.memcpy"(%138, %34, %54, %29, %c0_68) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_73 = "equeue.launch"(%139, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %140 = "equeue.control_start"() : () -> !equeue.signal
      %done_74 = "equeue.launch"(%done_73, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %141 = "equeue.control_start"() : () -> !equeue.signal
      %done_75 = "equeue.launch"(%done_73, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_76 = "equeue.launch"(%done_75, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_77 = "equeue.launch"(%done_76, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_78 = "equeue.launch"(%done_77, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %142 = "equeue.control_and"(%done_75, %done_78) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %143 = "equeue.control_start"() : () -> !equeue.signal
      %done_79 = "equeue.launch"(%142, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %144 = "equeue.control_start"() : () -> !equeue.signal
      %done_80 = "equeue.launch"(%142, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %145 = "equeue.memcpy"(%done_80, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_81 = "equeue.launch"(%145, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_82 = "equeue.launch"(%done_81, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %146 = "equeue.memcpy"(%done_82, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %147 = "equeue.control_and"(%145, %146) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %148 = "equeue.control_start"() : () -> !equeue.signal
      %done_83 = "equeue.launch"(%147, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %149 = "equeue.control_start"() : () -> !equeue.signal
      %done_84 = "equeue.launch"(%147, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %150 = "equeue.memcpy"(%done_84, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_85 = "equeue.launch"(%150, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_86 = "equeue.launch"(%done_85, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %151 = "equeue.memcpy"(%done_86, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %152 = "equeue.control_and"(%150, %151) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %153 = "equeue.control_start"() : () -> !equeue.signal
      %done_87 = "equeue.launch"(%152, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %154 = "equeue.control_start"() : () -> !equeue.signal
      %done_88 = "equeue.launch"(%152, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_89 = "equeue.launch"(%done_88, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_90 = "equeue.launch"(%done_89, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %155 = "equeue.memcpy"(%done_90, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %156 = "equeue.control_and"(%done_88, %155) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_91 = constant 0 : index
      %157 = "equeue.control_start"() : () -> !equeue.signal
      %158 = "equeue.memcpy"(%157, %35, %40, %30, %c0_91) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_92 = "equeue.launch"(%158, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %159 = "equeue.memcpy"(%157, %35, %46, %32, %c0_91) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_93 = "equeue.launch"(%159, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_93) : (!equeue.signal) -> ()
      %160 = "equeue.control_start"() : () -> !equeue.signal
      %161 = "equeue.memcpy"(%160, %34, %42, %27, %c0_91) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_94 = "equeue.launch"(%161, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_95 = "equeue.launch"(%done_94, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %162 = "equeue.control_start"() : () -> !equeue.signal
      %163 = "equeue.memcpy"(%162, %34, %54, %29, %c0_91) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_96 = "equeue.launch"(%163, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %164 = "equeue.control_start"() : () -> !equeue.signal
      %done_97 = "equeue.launch"(%done_96, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %165 = "equeue.control_start"() : () -> !equeue.signal
      %done_98 = "equeue.launch"(%done_96, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_99 = "equeue.launch"(%done_98, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_100 = "equeue.launch"(%done_99, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_101 = "equeue.launch"(%done_100, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %166 = "equeue.control_and"(%done_98, %done_101) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %167 = "equeue.control_start"() : () -> !equeue.signal
      %done_102 = "equeue.launch"(%166, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %168 = "equeue.control_start"() : () -> !equeue.signal
      %done_103 = "equeue.launch"(%166, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %169 = "equeue.memcpy"(%done_103, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_104 = "equeue.launch"(%169, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_105 = "equeue.launch"(%done_104, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %170 = "equeue.memcpy"(%done_105, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %171 = "equeue.control_and"(%169, %170) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %172 = "equeue.control_start"() : () -> !equeue.signal
      %done_106 = "equeue.launch"(%171, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %173 = "equeue.control_start"() : () -> !equeue.signal
      %done_107 = "equeue.launch"(%171, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %174 = "equeue.memcpy"(%done_107, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_108 = "equeue.launch"(%174, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_109 = "equeue.launch"(%done_108, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %175 = "equeue.memcpy"(%done_109, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %176 = "equeue.control_and"(%174, %175) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %177 = "equeue.control_start"() : () -> !equeue.signal
      %done_110 = "equeue.launch"(%176, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %178 = "equeue.control_start"() : () -> !equeue.signal
      %done_111 = "equeue.launch"(%176, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_112 = "equeue.launch"(%done_111, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_113 = "equeue.launch"(%done_112, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %179 = "equeue.memcpy"(%done_113, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %180 = "equeue.control_and"(%done_111, %179) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_114 = constant 0 : index
      %181 = "equeue.control_start"() : () -> !equeue.signal
      %182 = "equeue.memcpy"(%181, %35, %40, %30, %c0_114) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_115 = "equeue.launch"(%182, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %183 = "equeue.memcpy"(%181, %35, %46, %32, %c0_114) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_116 = "equeue.launch"(%183, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_116) : (!equeue.signal) -> ()
      %184 = "equeue.control_start"() : () -> !equeue.signal
      %185 = "equeue.memcpy"(%184, %34, %42, %27, %c0_114) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_117 = "equeue.launch"(%185, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_118 = "equeue.launch"(%done_117, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %186 = "equeue.control_start"() : () -> !equeue.signal
      %187 = "equeue.memcpy"(%186, %34, %54, %29, %c0_114) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_119 = "equeue.launch"(%187, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %188 = "equeue.control_start"() : () -> !equeue.signal
      %done_120 = "equeue.launch"(%done_119, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %189 = "equeue.control_start"() : () -> !equeue.signal
      %done_121 = "equeue.launch"(%done_119, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_122 = "equeue.launch"(%done_121, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_123 = "equeue.launch"(%done_122, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_124 = "equeue.launch"(%done_123, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %190 = "equeue.control_and"(%done_121, %done_124) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %191 = "equeue.control_start"() : () -> !equeue.signal
      %done_125 = "equeue.launch"(%190, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %192 = "equeue.control_start"() : () -> !equeue.signal
      %done_126 = "equeue.launch"(%190, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %193 = "equeue.memcpy"(%done_126, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_127 = "equeue.launch"(%193, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_128 = "equeue.launch"(%done_127, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %194 = "equeue.memcpy"(%done_128, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %195 = "equeue.control_and"(%193, %194) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %196 = "equeue.control_start"() : () -> !equeue.signal
      %done_129 = "equeue.launch"(%195, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %197 = "equeue.control_start"() : () -> !equeue.signal
      %done_130 = "equeue.launch"(%195, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %198 = "equeue.memcpy"(%done_130, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_131 = "equeue.launch"(%198, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_132 = "equeue.launch"(%done_131, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %199 = "equeue.memcpy"(%done_132, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %200 = "equeue.control_and"(%198, %199) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %201 = "equeue.control_start"() : () -> !equeue.signal
      %done_133 = "equeue.launch"(%200, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %202 = "equeue.control_start"() : () -> !equeue.signal
      %done_134 = "equeue.launch"(%200, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_135 = "equeue.launch"(%done_134, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_136 = "equeue.launch"(%done_135, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %203 = "equeue.memcpy"(%done_136, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %204 = "equeue.control_and"(%done_134, %203) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_137 = constant 0 : index
      %205 = "equeue.control_start"() : () -> !equeue.signal
      %206 = "equeue.memcpy"(%205, %35, %40, %30, %c0_137) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_138 = "equeue.launch"(%206, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %207 = "equeue.memcpy"(%205, %35, %46, %32, %c0_137) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_139 = "equeue.launch"(%207, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_139) : (!equeue.signal) -> ()
      %208 = "equeue.control_start"() : () -> !equeue.signal
      %209 = "equeue.memcpy"(%208, %34, %42, %27, %c0_137) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_140 = "equeue.launch"(%209, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_141 = "equeue.launch"(%done_140, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %210 = "equeue.control_start"() : () -> !equeue.signal
      %211 = "equeue.memcpy"(%210, %34, %54, %29, %c0_137) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_142 = "equeue.launch"(%211, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %212 = "equeue.control_start"() : () -> !equeue.signal
      %done_143 = "equeue.launch"(%done_142, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %213 = "equeue.control_start"() : () -> !equeue.signal
      %done_144 = "equeue.launch"(%done_142, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_145 = "equeue.launch"(%done_144, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_146 = "equeue.launch"(%done_145, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_147 = "equeue.launch"(%done_146, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %214 = "equeue.control_and"(%done_144, %done_147) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %215 = "equeue.control_start"() : () -> !equeue.signal
      %done_148 = "equeue.launch"(%214, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %216 = "equeue.control_start"() : () -> !equeue.signal
      %done_149 = "equeue.launch"(%214, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %217 = "equeue.memcpy"(%done_149, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_150 = "equeue.launch"(%217, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_151 = "equeue.launch"(%done_150, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %218 = "equeue.memcpy"(%done_151, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %219 = "equeue.control_and"(%217, %218) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %220 = "equeue.control_start"() : () -> !equeue.signal
      %done_152 = "equeue.launch"(%219, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %221 = "equeue.control_start"() : () -> !equeue.signal
      %done_153 = "equeue.launch"(%219, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %222 = "equeue.memcpy"(%done_153, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_154 = "equeue.launch"(%222, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_155 = "equeue.launch"(%done_154, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %223 = "equeue.memcpy"(%done_155, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %224 = "equeue.control_and"(%222, %223) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %225 = "equeue.control_start"() : () -> !equeue.signal
      %done_156 = "equeue.launch"(%224, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %226 = "equeue.control_start"() : () -> !equeue.signal
      %done_157 = "equeue.launch"(%224, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_158 = "equeue.launch"(%done_157, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_159 = "equeue.launch"(%done_158, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %227 = "equeue.memcpy"(%done_159, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %228 = "equeue.control_and"(%done_157, %227) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_160 = constant 0 : index
      %229 = "equeue.control_start"() : () -> !equeue.signal
      %230 = "equeue.memcpy"(%229, %35, %40, %30, %c0_160) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_161 = "equeue.launch"(%230, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %231 = "equeue.memcpy"(%229, %35, %46, %32, %c0_160) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_162 = "equeue.launch"(%231, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_162) : (!equeue.signal) -> ()
      %232 = "equeue.control_start"() : () -> !equeue.signal
      %233 = "equeue.memcpy"(%232, %34, %42, %27, %c0_160) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_163 = "equeue.launch"(%233, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_164 = "equeue.launch"(%done_163, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %234 = "equeue.control_start"() : () -> !equeue.signal
      %235 = "equeue.memcpy"(%234, %34, %54, %29, %c0_160) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_165 = "equeue.launch"(%235, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %236 = "equeue.control_start"() : () -> !equeue.signal
      %done_166 = "equeue.launch"(%done_165, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %237 = "equeue.control_start"() : () -> !equeue.signal
      %done_167 = "equeue.launch"(%done_165, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_168 = "equeue.launch"(%done_167, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_169 = "equeue.launch"(%done_168, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_170 = "equeue.launch"(%done_169, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %238 = "equeue.control_and"(%done_167, %done_170) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %239 = "equeue.control_start"() : () -> !equeue.signal
      %done_171 = "equeue.launch"(%238, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %240 = "equeue.control_start"() : () -> !equeue.signal
      %done_172 = "equeue.launch"(%238, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %241 = "equeue.memcpy"(%done_172, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_173 = "equeue.launch"(%241, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_174 = "equeue.launch"(%done_173, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %242 = "equeue.memcpy"(%done_174, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %243 = "equeue.control_and"(%241, %242) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %244 = "equeue.control_start"() : () -> !equeue.signal
      %done_175 = "equeue.launch"(%243, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %245 = "equeue.control_start"() : () -> !equeue.signal
      %done_176 = "equeue.launch"(%243, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %246 = "equeue.memcpy"(%done_176, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_177 = "equeue.launch"(%246, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_178 = "equeue.launch"(%done_177, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %247 = "equeue.memcpy"(%done_178, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %248 = "equeue.control_and"(%246, %247) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %249 = "equeue.control_start"() : () -> !equeue.signal
      %done_179 = "equeue.launch"(%248, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %250 = "equeue.control_start"() : () -> !equeue.signal
      %done_180 = "equeue.launch"(%248, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_181 = "equeue.launch"(%done_180, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_182 = "equeue.launch"(%done_181, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %251 = "equeue.memcpy"(%done_182, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %252 = "equeue.control_and"(%done_180, %251) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_183 = constant 0 : index
      %253 = "equeue.control_start"() : () -> !equeue.signal
      %254 = "equeue.memcpy"(%253, %35, %40, %30, %c0_183) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_184 = "equeue.launch"(%254, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %255 = "equeue.memcpy"(%253, %35, %46, %32, %c0_183) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_185 = "equeue.launch"(%255, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_185) : (!equeue.signal) -> ()
      %256 = "equeue.control_start"() : () -> !equeue.signal
      %257 = "equeue.memcpy"(%256, %34, %42, %27, %c0_183) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_186 = "equeue.launch"(%257, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_187 = "equeue.launch"(%done_186, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %258 = "equeue.control_start"() : () -> !equeue.signal
      %259 = "equeue.memcpy"(%258, %34, %54, %29, %c0_183) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_188 = "equeue.launch"(%259, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %260 = "equeue.control_start"() : () -> !equeue.signal
      %done_189 = "equeue.launch"(%done_188, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %261 = "equeue.control_start"() : () -> !equeue.signal
      %done_190 = "equeue.launch"(%done_188, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_191 = "equeue.launch"(%done_190, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_192 = "equeue.launch"(%done_191, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_193 = "equeue.launch"(%done_192, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %262 = "equeue.control_and"(%done_190, %done_193) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %263 = "equeue.control_start"() : () -> !equeue.signal
      %done_194 = "equeue.launch"(%262, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %264 = "equeue.control_start"() : () -> !equeue.signal
      %done_195 = "equeue.launch"(%262, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %265 = "equeue.memcpy"(%done_195, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_196 = "equeue.launch"(%265, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_197 = "equeue.launch"(%done_196, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %266 = "equeue.memcpy"(%done_197, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %267 = "equeue.control_and"(%265, %266) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %268 = "equeue.control_start"() : () -> !equeue.signal
      %done_198 = "equeue.launch"(%267, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %269 = "equeue.control_start"() : () -> !equeue.signal
      %done_199 = "equeue.launch"(%267, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %270 = "equeue.memcpy"(%done_199, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_200 = "equeue.launch"(%270, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_201 = "equeue.launch"(%done_200, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %271 = "equeue.memcpy"(%done_201, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %272 = "equeue.control_and"(%270, %271) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %273 = "equeue.control_start"() : () -> !equeue.signal
      %done_202 = "equeue.launch"(%272, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %274 = "equeue.control_start"() : () -> !equeue.signal
      %done_203 = "equeue.launch"(%272, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_204 = "equeue.launch"(%done_203, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_205 = "equeue.launch"(%done_204, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %275 = "equeue.memcpy"(%done_205, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %276 = "equeue.control_and"(%done_203, %275) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_206 = constant 0 : index
      %277 = "equeue.control_start"() : () -> !equeue.signal
      %278 = "equeue.memcpy"(%277, %35, %40, %30, %c0_206) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_207 = "equeue.launch"(%278, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %279 = "equeue.memcpy"(%277, %35, %46, %32, %c0_206) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_208 = "equeue.launch"(%279, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_208) : (!equeue.signal) -> ()
      %280 = "equeue.control_start"() : () -> !equeue.signal
      %281 = "equeue.memcpy"(%280, %34, %42, %27, %c0_206) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_209 = "equeue.launch"(%281, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_210 = "equeue.launch"(%done_209, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %282 = "equeue.control_start"() : () -> !equeue.signal
      %283 = "equeue.memcpy"(%282, %34, %54, %29, %c0_206) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_211 = "equeue.launch"(%283, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %284 = "equeue.control_start"() : () -> !equeue.signal
      %done_212 = "equeue.launch"(%done_211, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %285 = "equeue.control_start"() : () -> !equeue.signal
      %done_213 = "equeue.launch"(%done_211, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_214 = "equeue.launch"(%done_213, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_215 = "equeue.launch"(%done_214, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_216 = "equeue.launch"(%done_215, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %286 = "equeue.control_and"(%done_213, %done_216) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %287 = "equeue.control_start"() : () -> !equeue.signal
      %done_217 = "equeue.launch"(%286, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %288 = "equeue.control_start"() : () -> !equeue.signal
      %done_218 = "equeue.launch"(%286, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %289 = "equeue.memcpy"(%done_218, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_219 = "equeue.launch"(%289, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_220 = "equeue.launch"(%done_219, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %290 = "equeue.memcpy"(%done_220, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %291 = "equeue.control_and"(%289, %290) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %292 = "equeue.control_start"() : () -> !equeue.signal
      %done_221 = "equeue.launch"(%291, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %293 = "equeue.control_start"() : () -> !equeue.signal
      %done_222 = "equeue.launch"(%291, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %294 = "equeue.memcpy"(%done_222, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_223 = "equeue.launch"(%294, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_224 = "equeue.launch"(%done_223, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %295 = "equeue.memcpy"(%done_224, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %296 = "equeue.control_and"(%294, %295) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %297 = "equeue.control_start"() : () -> !equeue.signal
      %done_225 = "equeue.launch"(%296, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %298 = "equeue.control_start"() : () -> !equeue.signal
      %done_226 = "equeue.launch"(%296, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_227 = "equeue.launch"(%done_226, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_228 = "equeue.launch"(%done_227, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %299 = "equeue.memcpy"(%done_228, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %300 = "equeue.control_and"(%done_226, %299) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_229 = constant 0 : index
      %301 = "equeue.control_start"() : () -> !equeue.signal
      %302 = "equeue.memcpy"(%301, %35, %40, %30, %c0_229) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_230 = "equeue.launch"(%302, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %303 = "equeue.memcpy"(%301, %35, %46, %32, %c0_229) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_231 = "equeue.launch"(%303, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_231) : (!equeue.signal) -> ()
      %304 = "equeue.control_start"() : () -> !equeue.signal
      %305 = "equeue.memcpy"(%304, %34, %42, %27, %c0_229) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_232 = "equeue.launch"(%305, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_233 = "equeue.launch"(%done_232, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %306 = "equeue.control_start"() : () -> !equeue.signal
      %307 = "equeue.memcpy"(%306, %34, %54, %29, %c0_229) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_234 = "equeue.launch"(%307, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %308 = "equeue.control_start"() : () -> !equeue.signal
      %done_235 = "equeue.launch"(%done_234, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %309 = "equeue.control_start"() : () -> !equeue.signal
      %done_236 = "equeue.launch"(%done_234, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_237 = "equeue.launch"(%done_236, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_238 = "equeue.launch"(%done_237, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_239 = "equeue.launch"(%done_238, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %310 = "equeue.control_and"(%done_236, %done_239) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %311 = "equeue.control_start"() : () -> !equeue.signal
      %done_240 = "equeue.launch"(%310, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %312 = "equeue.control_start"() : () -> !equeue.signal
      %done_241 = "equeue.launch"(%310, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %313 = "equeue.memcpy"(%done_241, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_242 = "equeue.launch"(%313, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_243 = "equeue.launch"(%done_242, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %314 = "equeue.memcpy"(%done_243, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %315 = "equeue.control_and"(%313, %314) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %316 = "equeue.control_start"() : () -> !equeue.signal
      %done_244 = "equeue.launch"(%315, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %317 = "equeue.control_start"() : () -> !equeue.signal
      %done_245 = "equeue.launch"(%315, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %318 = "equeue.memcpy"(%done_245, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_246 = "equeue.launch"(%318, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_247 = "equeue.launch"(%done_246, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %319 = "equeue.memcpy"(%done_247, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %320 = "equeue.control_and"(%318, %319) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %321 = "equeue.control_start"() : () -> !equeue.signal
      %done_248 = "equeue.launch"(%320, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %322 = "equeue.control_start"() : () -> !equeue.signal
      %done_249 = "equeue.launch"(%320, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_250 = "equeue.launch"(%done_249, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_251 = "equeue.launch"(%done_250, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %323 = "equeue.memcpy"(%done_251, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %324 = "equeue.control_and"(%done_249, %323) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_252 = constant 0 : index
      %325 = "equeue.control_start"() : () -> !equeue.signal
      %326 = "equeue.memcpy"(%325, %35, %40, %30, %c0_252) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_253 = "equeue.launch"(%326, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %327 = "equeue.memcpy"(%325, %35, %46, %32, %c0_252) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_254 = "equeue.launch"(%327, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_254) : (!equeue.signal) -> ()
      %328 = "equeue.control_start"() : () -> !equeue.signal
      %329 = "equeue.memcpy"(%328, %34, %42, %27, %c0_252) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_255 = "equeue.launch"(%329, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_256 = "equeue.launch"(%done_255, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %330 = "equeue.control_start"() : () -> !equeue.signal
      %331 = "equeue.memcpy"(%330, %34, %54, %29, %c0_252) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_257 = "equeue.launch"(%331, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %332 = "equeue.control_start"() : () -> !equeue.signal
      %done_258 = "equeue.launch"(%done_257, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %333 = "equeue.control_start"() : () -> !equeue.signal
      %done_259 = "equeue.launch"(%done_257, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_260 = "equeue.launch"(%done_259, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_261 = "equeue.launch"(%done_260, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_262 = "equeue.launch"(%done_261, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %334 = "equeue.control_and"(%done_259, %done_262) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %335 = "equeue.control_start"() : () -> !equeue.signal
      %done_263 = "equeue.launch"(%334, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %336 = "equeue.control_start"() : () -> !equeue.signal
      %done_264 = "equeue.launch"(%334, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %337 = "equeue.memcpy"(%done_264, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_265 = "equeue.launch"(%337, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_266 = "equeue.launch"(%done_265, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %338 = "equeue.memcpy"(%done_266, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %339 = "equeue.control_and"(%337, %338) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %340 = "equeue.control_start"() : () -> !equeue.signal
      %done_267 = "equeue.launch"(%339, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %341 = "equeue.control_start"() : () -> !equeue.signal
      %done_268 = "equeue.launch"(%339, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %342 = "equeue.memcpy"(%done_268, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_269 = "equeue.launch"(%342, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_270 = "equeue.launch"(%done_269, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %343 = "equeue.memcpy"(%done_270, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %344 = "equeue.control_and"(%342, %343) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %345 = "equeue.control_start"() : () -> !equeue.signal
      %done_271 = "equeue.launch"(%344, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %346 = "equeue.control_start"() : () -> !equeue.signal
      %done_272 = "equeue.launch"(%344, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_273 = "equeue.launch"(%done_272, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_274 = "equeue.launch"(%done_273, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %347 = "equeue.memcpy"(%done_274, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %348 = "equeue.control_and"(%done_272, %347) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_275 = constant 0 : index
      %349 = "equeue.control_start"() : () -> !equeue.signal
      %350 = "equeue.memcpy"(%349, %35, %40, %30, %c0_275) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_276 = "equeue.launch"(%350, %39, %52, %40) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %351 = "equeue.memcpy"(%349, %35, %46, %32, %c0_275) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<2x3x5x3xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_277 = "equeue.launch"(%351, %45, %58, %46) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      "equeue.await"(%done_277) : (!equeue.signal) -> ()
      %352 = "equeue.control_start"() : () -> !equeue.signal
      %353 = "equeue.memcpy"(%352, %34, %42, %27, %c0_275) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_278 = "equeue.launch"(%353, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_279 = "equeue.launch"(%done_278, %39, %41, %53) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %354 = "equeue.control_start"() : () -> !equeue.signal
      %355 = "equeue.memcpy"(%354, %34, %54, %29, %c0_275) {dest_bank = 0 : i64, src_bank = 1 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_280 = "equeue.launch"(%355, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %356 = "equeue.control_start"() : () -> !equeue.signal
      %done_281 = "equeue.launch"(%done_280, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %357 = "equeue.control_start"() : () -> !equeue.signal
      %done_282 = "equeue.launch"(%done_280, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_283 = "equeue.launch"(%done_282, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_284 = "equeue.launch"(%done_283, %45, %47, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg6) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_285 = "equeue.launch"(%done_284, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %358 = "equeue.control_and"(%done_282, %done_285) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %359 = "equeue.control_start"() : () -> !equeue.signal
      %done_286 = "equeue.launch"(%358, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %360 = "equeue.control_start"() : () -> !equeue.signal
      %done_287 = "equeue.launch"(%358, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %361 = "equeue.memcpy"(%done_287, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_288 = "equeue.launch"(%361, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_289 = "equeue.launch"(%done_288, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %362 = "equeue.memcpy"(%done_289, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %363 = "equeue.control_and"(%361, %362) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %364 = "equeue.control_start"() : () -> !equeue.signal
      %done_290 = "equeue.launch"(%363, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %365 = "equeue.control_start"() : () -> !equeue.signal
      %done_291 = "equeue.launch"(%363, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %366 = "equeue.memcpy"(%done_291, %53, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_292 = "equeue.launch"(%366, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_293 = "equeue.launch"(%done_292, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %367 = "equeue.memcpy"(%done_293, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %368 = "equeue.control_and"(%366, %367) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %369 = "equeue.control_start"() : () -> !equeue.signal
      %done_294 = "equeue.launch"(%368, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %370 = "equeue.control_start"() : () -> !equeue.signal
      %done_295 = "equeue.launch"(%368, %51, %54, %52, %53, %60) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_296 = "equeue.launch"(%done_295, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_297 = "equeue.launch"(%done_296, %57, %60, %58, %59) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %371 = "equeue.memcpy"(%done_297, %59, %36, %29) {dest_bank = 1 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %372 = "equeue.control_and"(%done_295, %371) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %c0_298 = constant 0 : index
      %373 = "equeue.control_start"() : () -> !equeue.signal
      %374 = "equeue.memcpy"(%373, %34, %42, %27, %c0_298) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<3x5x5xf32>, memref<1xf32>, i32, index) -> !equeue.signal
      %done_299 = "equeue.launch"(%374, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %375 = "equeue.control_start"() : () -> !equeue.signal
      %done_300 = "equeue.launch"(%done_299, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %376 = "equeue.memcpy"(%done_300, %41, %36, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_301 = "equeue.launch"(%376, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %377 = "equeue.memcpy"(%done_301, %47, %36, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %378 = "equeue.control_and"(%376, %377) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %379 = "equeue.control_start"() : () -> !equeue.signal
      %done_302 = "equeue.launch"(%378, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %380 = "equeue.memcpy"(%done_302, %41, %36, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %done_303 = "equeue.launch"(%380, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %381 = "equeue.memcpy"(%done_303, %47, %36, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %382 = "equeue.control_and"(%380, %381) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      %383 = "equeue.control_start"() : () -> !equeue.signal
      %done_304 = "equeue.launch"(%382, %39, %42, %40, %41, %48) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        "equeue.write"(%386, %arg8) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %done_305 = "equeue.launch"(%done_304, %45, %48, %46, %47) ( {
      ^bb0(%arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>):  // no predecessors
        %386 = "equeue.read"(%arg5) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %387 = "equeue.read"(%arg6) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %388 = mulf %386, %387 : f32
        %389 = "equeue.read"(%arg7) {bank = 0 : i64} : (memref<1xf32>) -> f32
        %390 = addf %388, %389 : f32
        "equeue.write"(%390, %arg7) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        "equeue.return"() : () -> ()
      }) : (!equeue.signal, i32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> !equeue.signal
      %384 = "equeue.memcpy"(%done_305, %47, %36, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<2x1x1xf32>, i32) -> !equeue.signal
      %385 = "equeue.control_and"(%done_304, %384) : (!equeue.signal, !equeue.signal) -> !equeue.signal
      "equeue.await"(%385) : (!equeue.signal) -> ()
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, memref<3x5x5xf32>, memref<2x3x5x3xf32>) -> !equeue.signal
    return
  }
}
