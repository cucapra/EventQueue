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
  func @graph(%arg0: tensor<7x7xf32>, %arg1: tensor<5x5xf32>) -> tensor<3x3xf32> {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data = "f32", shape = dense<11> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp_field"(%0, %1) {names = "proc mem "} : (i32, i32) -> i32
    %3 = splat %2 : vector<5xi32>
    %4 = "equeue.create_mem"() {banks = 16 : i64, data = "f32", shape = dense<1024> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %5 = "equeue.create_dma"() : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%3, %6, %4, %5) {names = "pe_array proc mem dma "} : (vector<5xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done, %res = "equeue.launch"(%8, %6, %7, %arg0, %arg1) ( {
    ^bb0(%arg2: i32, %arg3: tensor<7x7xf32>, %arg4: tensor<5x5xf32>):  // no predecessors
      %9 = "equeue.get_comp_field"(%arg2) {name = "mem"} : (i32) -> i32
      %10 = "equeue.alloc"(%9) {data = "f32", shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
      %11 = "equeue.alloc"(%9) {data = "f32", shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
      %12 = "equeue.alloc"(%9) {data = "f32", shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
      "equeue.write"(%arg3, %10) {bank = 0 : i64} : (tensor<7x7xf32>, memref<7x7xf32>) -> ()
      "equeue.write"(%arg4, %11) {bank = 0 : i64} : (tensor<5x5xf32>, memref<5x5xf32>) -> ()
      %13 = linalg.reshape %10 [#map0, #map1] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %14 = linalg.reshape %11 [#map2, #map3] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %15 = linalg.reshape %12 [#map0, #map1] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %16 = subview %13[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map4>
      affine.for %arg5 = 0 to 1 {
        affine.for %arg6 = 0 to 1 {
          affine.for %arg7 = 0 to 3 {
            affine.for %arg8 = 0 to 3 {
              affine.for %arg9 = 0 to 5 {
                affine.for %arg10 = 0 to 5 {
                  affine.for %arg11 = 0 to 1 {
                    %18 = affine.load %16[%arg5, %arg7, %arg8, %arg11] : memref<1x3x3x1xf32, #map4>
                    %19 = affine.load %14[%arg9, %arg10, %arg11, %arg6] : memref<5x5x1x1xf32>
                    %20 = affine.load %15[%arg5, %arg7, %arg8, %arg6] : memref<1x3x3x1xf32>
                    %21 = mulf %18, %19 : f32
                    %22 = addf %20, %21 : f32
                    affine.store %22, %15[%arg5, %arg7, %arg8, %arg6] : memref<1x3x3x1xf32>
                  }
                }
              }
            }
          }
        }
      }
      %17 = "equeue.read"(%12) {bank = 0 : i64} : (memref<3x3xf32>) -> tensor<3x3xf32>
      "equeue.dealloc"(%11, %12, %10) : (memref<5x5xf32>, memref<3x3xf32>, memref<7x7xf32>) -> ()
      "equeue.return"(%17) : (tensor<3x3xf32>) -> ()
    }) : (!equeue.signal, i32, i32, tensor<7x7xf32>, tensor<5x5xf32>) -> (!equeue.signal, tensor<3x3xf32>)
    return %res : tensor<3x3xf32>
  }
}
