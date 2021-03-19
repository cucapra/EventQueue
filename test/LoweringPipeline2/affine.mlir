#map0 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map5 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map6 = affine_map<() -> (0)>
#map7 = affine_map<() -> (5)>
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
      %9 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %10 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
      "equeue.add_comp_field"(%arg0, %10) {names = "ibuffer "} : (i32, memref<7x7xf32>) -> ()
      %11 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
      "equeue.add_comp_field"(%arg0, %11) {names = "wbuffer "} : (i32, memref<5x5xf32>) -> ()
      %12 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
      "equeue.add_comp_field"(%arg0, %12) {names = "obuffer "} : (i32, memref<3x3xf32>) -> ()
      %13 = linalg.reshape %10 [#map0, #map1] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %14 = linalg.reshape %11 [#map2, #map3] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %15 = linalg.reshape %12 [#map0, #map1] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %16 = subview %13[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map4>
      %c0 = constant 0 : index
      %c0_0 = constant 0 : index
      affine.for %arg1 = 0 to 3 {
        affine.for %arg2 = 0 to 3 {
          affine.for %arg3 = 0 to 5 {
            affine.for %arg4 = 0 to 5 {
              %c0_1 = constant 0 : index
              %17 = affine.load %16[%c0, %arg1, %arg2, %c0_1] : memref<1x3x3x1xf32, #map4>
              %18 = affine.load %14[%arg3, %arg4, %c0_1, %c0_0] : memref<5x5x1x1xf32>
              %19 = affine.load %15[%c0, %arg1, %arg2, %c0_0] : memref<1x3x3x1xf32>
              %20 = mulf %17, %18 : f32
              %21 = addf %19, %20 : f32
              affine.store %21, %15[%c0, %arg1, %arg2, %c0_0] : memref<1x3x3x1xf32>
            }
          }
        }
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
