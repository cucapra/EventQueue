#map0 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (10)>
#map3 = affine_map<() -> (9)>
#map4 = affine_map<() -> (5)>


module {
  func @graph() {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_comp_field"(%0, %1) {names = "proc mem "} : (i32, i32) -> i32
    %3 = splat %2 : vector<12x14xi32>
    %4 = "equeue.create_mem"() {banks = 16 : i64, data_bit = 32 : i64, shape = dense<4096> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %5 = "equeue.create_dma"() : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%3, %6, %4, %5) {names = "pe_array proc mem dma "} : (vector<12x14xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%8, %6, %7) ( {
    ^bb0(%arg0: i32):  // no predecessors
      %9 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %10 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<[1, 7, 7, 1]> : tensor<4xi64>} : (i32) -> memref<1x7x7x1xf32>
      "equeue.add_comp_field"(%arg0, %10) {names = "ibuffer "} : (i32, memref<1x7x7x1xf32>) -> ()
      %11 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<[5, 5, 1, 10]> : tensor<4xi64>} : (i32) -> memref<5x5x1x10xf32>
      "equeue.add_comp_field"(%arg0, %11) {names = "wbuffer "} : (i32, memref<5x5x1x10xf32>) -> ()
      %12 = "equeue.alloc"(%9) {data_bit = 32 : i64, shape = dense<[1, 3, 3, 10]> : tensor<4xi64>} : (i32) -> memref<1x3x3x10xf32>
      "equeue.add_comp_field"(%arg0, %12) {names = "obuffer "} : (i32, memref<1x3x3x10xf32>) -> ()
      %13 = subview %10[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map0>
      %c0 = constant 0 : index
      affine.for %arg1 = 0 to 5 {
        affine.for %arg2 = 0 to 5 {
          %c0_0 = constant 0 : index
          affine.for %arg3 = 0 to 9 {
            affine.for %arg4 = 0 to 10 {
              %c0_1 = constant 0 : index
              %14 = "equeue.read"(%13) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1x3x3x1xf32, #map0>) -> f32
              %15 = "equeue.read"(%11) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<5x5x1x10xf32>) -> f32
              %16 = "equeue.read"(%12) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1x3x3x10xf32>) -> f32
              %17 = "equeue.unkOp"(%16, %14, %15) {op_name = "mac"} : (f32, f32, f32) -> f32
              "equeue.write"(%17, %12) {bank = 0 : i64} : (f32, memref<1x3x3x10xf32>) -> ()
            }
          }
        }
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
