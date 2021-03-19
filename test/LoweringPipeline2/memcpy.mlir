%done = "equeue.launch"(%8, %6, %7) ( {
^bb0(%arg0: i32):  // no predecessors
  %9 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %9[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
    %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
    "equeue.add_comp_field"(%23, %25) {names = "pe_obuffer"} : (i32, memref<1xf32>) -> ()
  }
  %10 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %10[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
    %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
    "equeue.add_comp_field"(%23, %25) {names = "pe_wbuffer"} : (i32, memref<1xf32>) -> ()
  }
  %11 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %11[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
    %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
    "equeue.add_comp_field"(%23, %25) {names = "pe_ibuffer"} : (i32, memref<1xf32>) -> ()
  }
  %12 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
  %13 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
  "equeue.add_comp_field"(%arg0, %13) {names = "ibuffer "} : (i32, memref<7x7xf32>) -> ()
  %14 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
  "equeue.add_comp_field"(%arg0, %14) {names = "wbuffer "} : (i32, memref<5x5xf32>) -> ()
  %15 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
  "equeue.add_comp_field"(%arg0, %15) {names = "obuffer "} : (i32, memref<3x3xf32>) -> ()
  %16 = linalg.reshape %13 [affine_map<(d0, d1, d2, d3) -> (d0, d1)>, affine_map<(d0, d1, d2, d3) -> (d2, d3)>] : memref<7x7xf32> into memref<1x7x7x1xf32>
  %17 = linalg.reshape %14 [affine_map<(d0, d1, d2, d3) -> (d0)>, affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>] : memref<5x5xf32> into memref<5x5x1x1xf32>
  %18 = linalg.reshape %15 [affine_map<(d0, d1, d2, d3) -> (d0, d1)>, affine_map<(d0, d1, d2, d3) -> (d2, d3)>] : memref<3x3xf32> into memref<1x3x3x1xf32>
  %19 = subview %16[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>>
  %c0 = constant 0 : index
  %c0_0 = constant 0 : index
  affine.for %arg1 = 0 to 3 {
    affine.for %arg2 = 0 to 3 {
      %c0_1 = constant 0 : index
      %c5 = constant 5 : index
      affine.parallel (%arg3) = (%c0_1) to (%c5) {
        %37 = "equeue.get_comp_field"(%arg0) {name = "wbuffer"} : (i32) -> memref<5x5xf32>
        %38 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
        %39 = extract_element %38[%arg3] : vector<5xi32>
        %40 = "equeue.get_comp_field"(%39) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
        %41 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
        %42 = "equeue.control_start"() : () -> !equeue.signal
        %43 = "equeue.memcpy"(%42, %37, %40, %41) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<5x5xf32>, memref<1xf32>, i32) -> !equeue.signal
      }
      %23 = "equeue.get_comp_field"(%arg0) {name = "ibuffer"} : (i32) -> memref<7x7xf32>
      %24 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      %c0_2 = constant 0 : index
      %25 = extract_element %24[%c0_2] : vector<5xi32>
      %26 = "equeue.get_comp_field"(%25) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
      %27 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
      %28 = "equeue.control_start"() : () -> !equeue.signal
      %29 = "equeue.memcpy"(%28, %23, %26, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<7x7xf32>, memref<1xf32>, i32) -> !equeue.signal
      affine.parallel (%arg3) = (0) to (5) {
        affine.for %arg4 = 0 to 5 {
          %c0_3 = constant 0 : index
          %37 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %c0_4 = constant 0 : index
          %38 = extract_element %37[%c0_4] : vector<5xi32>
          %39 = "equeue.get_comp_field"(%38) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
          %40 = "equeue.read"(%39) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
          %41 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %42 = extract_element %41[%arg4] : vector<5xi32>
          %43 = "equeue.get_comp_field"(%42) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
          %44 = "equeue.read"(%43) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
          %45 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %c4_5 = constant 4 : index
          %46 = extract_element %45[%c4_5] : vector<5xi32>
          %47 = "equeue.get_comp_field"(%46) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
          %48 = "equeue.read"(%47) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
          %49 = mulf %40, %44 : f32
          %50 = addf %48, %49 : f32
          %51 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %c4_6 = constant 4 : index
          %52 = extract_element %51[%c4_6] : vector<5xi32>
          %53 = "equeue.get_comp_field"(%52) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
          "equeue.write"(%50, %53) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
        }
      }
      %30 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      %c4 = constant 4 : index
      %31 = extract_element %30[%c4] : vector<5xi32>
      %32 = "equeue.get_comp_field"(%31) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
      %33 = "equeue.get_comp_field"(%arg0) {name = "obuffer"} : (i32) -> memref<3x3xf32>
      %34 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
      %35 = "equeue.control_start"() : () -> !equeue.signal
      %36 = "equeue.memcpy"(%35, %32, %33, %34) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<3x3xf32>, i32) -> !equeue.signal
    }
  }
  %20 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %20[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
    "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
  }
  %21 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %21[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
    "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
  }
  %22 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
  affine.for %arg1 = 0 to 5 {
    %23 = extract_element %22[%arg1] : vector<5xi32>
    %24 = "equeue.get_comp_field"(%23) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
    "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
  }
  "equeue.return"() : () -> ()
}) : (!equeue.signal, i32, i32) -> !equeue.signal
#map0 = affine_map<() -> (0)>
#map1 = affine_map<() -> (5)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>
#map6 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map7 = affine_map<(d0) -> (d0)>
#map8 = affine_map<() -> (3)>


module {
  func @graph() {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp_field"(%0, %1) {names = "proc mem "} : (i32, i32) -> i32
    %3 = splat %2 : vector<5xi32>
    %4 = "equeue.create_mem"() {banks = 16 : i64, data_bit = 32 : i64, shape = dense<1024> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %5 = "equeue.create_dma"() : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%3, %6, %4, %5) {names = "pe_array proc mem dma "} : (vector<5xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%8, %6, %7) ( {
    ^bb0(%arg0: i32):  // no predecessors
      %9 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %9[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
        %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
        "equeue.add_comp_field"(%23, %25) {names = "pe_obuffer"} : (i32, memref<1xf32>) -> ()
      }
      %10 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %10[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
        %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
        "equeue.add_comp_field"(%23, %25) {names = "pe_wbuffer"} : (i32, memref<1xf32>) -> ()
      }
      %11 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %11[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
        %25 = "equeue.alloc"(%24) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
        "equeue.add_comp_field"(%23, %25) {names = "pe_ibuffer"} : (i32, memref<1xf32>) -> ()
      }
      %12 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %13 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
      "equeue.add_comp_field"(%arg0, %13) {names = "ibuffer "} : (i32, memref<7x7xf32>) -> ()
      %14 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
      "equeue.add_comp_field"(%arg0, %14) {names = "wbuffer "} : (i32, memref<5x5xf32>) -> ()
      %15 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
      "equeue.add_comp_field"(%arg0, %15) {names = "obuffer "} : (i32, memref<3x3xf32>) -> ()
      %16 = linalg.reshape %13 [#map2, #map3] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %17 = linalg.reshape %14 [#map4, #map5] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %18 = linalg.reshape %15 [#map2, #map3] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %19 = subview %16[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map6>
      %c0 = constant 0 : index
      %c0_0 = constant 0 : index
      affine.for %arg1 = 0 to 3 {
        affine.for %arg2 = 0 to 3 {
          %c0_1 = constant 0 : index
          %c5 = constant 5 : index
          affine.parallel (%arg3) = (%c0_1) to (%c5) {
            %37 = "equeue.get_comp_field"(%arg0) {name = "wbuffer"} : (i32) -> memref<5x5xf32>
            %38 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
            %39 = extract_element %38[%arg3] : vector<5xi32>
            %40 = "equeue.get_comp_field"(%39) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
            %41 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
            %42 = "equeue.control_start"() : () -> !equeue.signal
            %43 = "equeue.memcpy"(%42, %37, %40, %41) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<5x5xf32>, memref<1xf32>, i32) -> !equeue.signal
          }
          %23 = "equeue.get_comp_field"(%arg0) {name = "ibuffer"} : (i32) -> memref<7x7xf32>
          %24 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %c0_2 = constant 0 : index
          %25 = extract_element %24[%c0_2] : vector<5xi32>
          %26 = "equeue.get_comp_field"(%25) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
          %27 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
          %28 = "equeue.control_start"() : () -> !equeue.signal
          %29 = "equeue.memcpy"(%28, %23, %26, %27) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<7x7xf32>, memref<1xf32>, i32) -> !equeue.signal
          affine.parallel (%arg3) = (0) to (5) {
            affine.for %arg4 = 0 to 5 {
              %c0_3 = constant 0 : index
              %37 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
              %c0_4 = constant 0 : index
              %38 = extract_element %37[%c0_4] : vector<5xi32>
              %39 = "equeue.get_comp_field"(%38) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
              %40 = "equeue.read"(%39) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
              %41 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
              %42 = extract_element %41[%arg4] : vector<5xi32>
              %43 = "equeue.get_comp_field"(%42) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
              %44 = "equeue.read"(%43) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
              %45 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
              %c4_5 = constant 4 : index
              %46 = extract_element %45[%c4_5] : vector<5xi32>
              %47 = "equeue.get_comp_field"(%46) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
              %48 = "equeue.read"(%47) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
              %49 = mulf %40, %44 : f32
              %50 = addf %48, %49 : f32
              %51 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
              %c4_6 = constant 4 : index
              %52 = extract_element %51[%c4_6] : vector<5xi32>
              %53 = "equeue.get_comp_field"(%52) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
              "equeue.write"(%50, %53) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
            }
          }
          %30 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
          %c4 = constant 4 : index
          %31 = extract_element %30[%c4] : vector<5xi32>
          %32 = "equeue.get_comp_field"(%31) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
          %33 = "equeue.get_comp_field"(%arg0) {name = "obuffer"} : (i32) -> memref<3x3xf32>
          %34 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
          %35 = "equeue.control_start"() : () -> !equeue.signal
          %36 = "equeue.memcpy"(%35, %32, %33, %34) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<3x3xf32>, i32) -> !equeue.signal
        }
      }
      %20 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %20[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
        "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
      }
      %21 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %21[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
        "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
      }
      %22 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg1 = 0 to 5 {
        %23 = extract_element %22[%arg1] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
        "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
