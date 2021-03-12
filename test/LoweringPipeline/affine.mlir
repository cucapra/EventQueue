#map0 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map6 = affine_map<() -> (0)>
#map7 = affine_map<() -> (1)>
#map8 = affine_map<() -> (5)>
#map9 = affine_map<() -> (3)>


module {
  func @graph(%arg0: memref<7x7xf32>, %arg1: memref<5x5xf32>, %arg2: memref<3x3xf32>) {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp_field"(%0, %1) {names = "proc mem "} : (i32, i32) -> i32
    %3 = splat %2 : vector<5xi32>
    %4 = "equeue.create_mem"() {banks = 16 : i64, data_bit = 32 : i64, shape = dense<1024> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %5 = "equeue.create_dma"() : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%3, %6, %4, %5) {names = "pe_array proc mem dma "} : (vector<5xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%8, %6, %7, %arg0, %arg1, %arg2) ( {
    ^bb0(%arg3: i32, %arg4: memref<7x7xf32>, %arg5: memref<5x5xf32>, %arg6: memref<3x3xf32>):  // no predecessors
      %9 = linalg.reshape %arg4 [#map0, #map1] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %10 = linalg.reshape %arg5 [#map2, #map3] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %11 = linalg.reshape %arg6 [#map0, #map1] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %12 = subview %9[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map4>
      affine.for %arg7 = 0 to 1 {
        affine.for %arg8 = 0 to 1 {
          affine.for %arg9 = 0 to 3 {
            affine.for %arg10 = 0 to 3 {
              affine.for %arg11 = 0 to 5 {
                affine.for %arg12 = 0 to 5 {
                  affine.for %arg13 = 0 to 1 {
                    %13 = affine.load %12[%arg7, %arg9, %arg10, %arg13] : memref<1x3x3x1xf32, #map4>
                    %14 = affine.load %10[%arg11, %arg12, %arg13, %arg8] : memref<5x5x1x1xf32>
                    %15 = affine.load %11[%arg7, %arg9, %arg10, %arg8] : memref<1x3x3x1xf32>
                    %16 = mulf %13, %14 : f32
                    %17 = addf %15, %16 : f32
                    affine.store %17, %11[%arg7, %arg9, %arg10, %arg8] : memref<1x3x3x1xf32>
                  }
                }
              }
            }
          }
        }
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32, memref<7x7xf32>, memref<5x5xf32>, memref<3x3xf32>) -> !equeue.signal
    return
  }
}
