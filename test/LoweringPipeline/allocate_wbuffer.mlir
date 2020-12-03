#map0 = affine_map<() -> (0)>
#map1 = affine_map<() -> (5)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>
#map6 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map7 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map8 = affine_map<(d0) -> (d0)>
#map9 = affine_map<(d0) -> (d0 + 1)>
#map10 = affine_map<(d0) -> (d0 + 5)>
#map11 = affine_map<() -> (1)>
#map12 = affine_map<() -> (3)>


module {
  func @graph(%arg0: memref<7x7xf32>, %arg1: memref<5x5xf32>, %arg2: memref<3x3xf32>) {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data = "f32", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp_field"(%0, %1) {names = "proc mem "} : (i32, i32) -> i32
    %3 = splat %2 : vector<5xi32>
    %4 = "equeue.create_mem"() {banks = 16 : i64, data = "f32", shape = dense<1024> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %5 = "equeue.create_dma"() : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%3, %6, %4, %5) {names = "pe_array proc mem dma "} : (vector<5xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%8, %6, %7, %arg0, %arg1, %arg2) ( {
    ^bb0(%arg3: i32, %arg4: memref<7x7xf32>, %arg5: memref<5x5xf32>, %arg6: memref<3x3xf32>):  // no predecessors
      %9 = "equeue.get_comp_field"(%arg3) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg7 = 0 to 5 {
        %23 = extract_element %9[%arg7] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
        %25 = "equeue.alloc"(%24) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
        "equeue.add_comp_field"(%23, %25) {names = "pe_wbuffer"} : (i32, memref<1xf32>) -> ()
      }
      %10 = "equeue.get_comp_field"(%arg3) {name = "mem"} : (i32) -> i32
      %11 = "equeue.alloc"(%10) {data = "f32", shape = dense<25> : tensor<1xi64>} : (i32) -> memref<25xf32>
      "equeue.add_comp_field"(%arg3, %11) {names = "wbuffer"} : (i32, memref<25xf32>) -> ()
      %12 = "equeue.get_comp_field"(%arg3) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg7 = 0 to 5 {
        %23 = extract_element %12[%arg7] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "mem"} : (i32) -> i32
        %25 = "equeue.alloc"(%24) {data = "f32", shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
        "equeue.add_comp_field"(%23, %25) {names = "pe_ibuffer"} : (i32, memref<1xf32>) -> ()
      }
      %13 = "equeue.get_comp_field"(%arg3) {name = "mem"} : (i32) -> i32
      %14 = "equeue.alloc"(%13) {data = "f32", shape = dense<49> : tensor<1xi64>} : (i32) -> memref<49xf32>
      "equeue.add_comp_field"(%arg3, %14) {names = "ibuffer"} : (i32, memref<49xf32>) -> ()
      %15 = linalg.reshape %arg4 [#map2, #map3] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %16 = linalg.reshape %arg5 [#map4, #map5] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %17 = linalg.reshape %arg6 [#map2, #map3] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %18 = subview %15[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map6>
      affine.for %arg7 = 0 to 1 {
        affine.for %arg8 = 0 to 1 {
          affine.for %arg9 = 0 to 3 {
            affine.for %arg10 = 0 to 3 {
              affine.for %arg11 = 0 to 5 step 5 {
                affine.for %arg12 = 0 to 5 {
                  affine.for %arg13 = 0 to 1 {
                    affine.for %arg14 = #map8(%arg7) to #map9(%arg7) {
                      affine.for %arg15 = #map8(%arg8) to #map9(%arg8) {
                        affine.for %arg16 = #map8(%arg9) to #map9(%arg9) {
                          affine.for %arg17 = #map8(%arg10) to #map9(%arg10) {
                            affine.for %arg18 = #map8(%arg11) to #map10(%arg11) {
                              affine.for %arg19 = #map8(%arg12) to #map9(%arg12) {
                                affine.for %arg20 = #map8(%arg13) to #map9(%arg13) {
                                  %23 = affine.load %18[%arg14, %arg16, %arg17, %arg20] : memref<1x3x3x1xf32, #map6>
                                  %24 = affine.load %16[%arg18, %arg19, %arg20, %arg15] : memref<5x5x1x1xf32>
                                  %25 = affine.load %17[%arg14, %arg16, %arg17, %arg15] : memref<1x3x3x1xf32>
                                  %26 = mulf %23, %24 : f32
                                  %27 = addf %25, %26 : f32
                                  affine.store %27, %17[%arg14, %arg16, %arg17, %arg15] : memref<1x3x3x1xf32>
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      %19 = "equeue.get_comp_field"(%arg3) {name = "ibuffer"} : (i32) -> memref<49xf32>
      "equeue.dealloc"(%19) : (memref<49xf32>) -> ()
      %20 = "equeue.get_comp_field"(%arg3) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg7 = 0 to 5 {
        %23 = extract_element %20[%arg7] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
        "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
      }
      %21 = "equeue.get_comp_field"(%arg3) {name = "wbuffer"} : (i32) -> memref<25xf32>
      "equeue.dealloc"(%21) : (memref<25xf32>) -> ()
      %22 = "equeue.get_comp_field"(%arg3) {name = "pe_array"} : (i32) -> vector<5xi32>
      affine.for %arg7 = 0 to 5 {
        %23 = extract_element %22[%arg7] : vector<5xi32>
        %24 = "equeue.get_comp_field"(%23) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
        "equeue.dealloc"(%24) : (memref<1xf32>) -> ()
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, memref<7x7xf32>, memref<5x5xf32>, memref<3x3xf32>) -> !equeue.signal
    return
  }
}
