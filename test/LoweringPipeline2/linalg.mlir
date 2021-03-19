#map0 = affine_map<(d0, d1, d2, d3) -> (d0, d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d1, d2, d3)>
#map4 = affine_map<(d0, d1, d2, d3) -> (d0 * 49 + d1 * 7 + d2 + d3)>
#map5 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d2, d3, d6)>
#map6 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d4, d5, d6, d1)>
#map7 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d2, d3, d1)>


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
      %9 = "equeue.get_comp_field"(%arg0) {name = "proc"} : (i32) -> i32
      %10 = "equeue.get_comp_field"(%arg0) {name = "dma"} : (i32) -> i32
      %11 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %12 = "equeue.alloc"(%11) {data_bit = 32 : i64, shape = dense<7> : tensor<2xi64>} : (i32) -> memref<7x7xf32>
      "equeue.add_comp_field"(%arg0, %12) {names = "ibuffer "} : (i32, memref<7x7xf32>) -> ()
      %13 = "equeue.alloc"(%11) {data_bit = 32 : i64, shape = dense<5> : tensor<2xi64>} : (i32) -> memref<5x5xf32>
      "equeue.add_comp_field"(%arg0, %13) {names = "wbuffer "} : (i32, memref<5x5xf32>) -> ()
      %14 = "equeue.alloc"(%11) {data_bit = 32 : i64, shape = dense<3> : tensor<2xi64>} : (i32) -> memref<3x3xf32>
      "equeue.add_comp_field"(%arg0, %14) {names = "obuffer "} : (i32, memref<3x3xf32>) -> ()
      %15 = linalg.reshape %12 [#map0, #map1] : memref<7x7xf32> into memref<1x7x7x1xf32>
      %16 = linalg.reshape %13 [#map2, #map3] : memref<5x5xf32> into memref<5x5x1x1xf32>
      %17 = linalg.reshape %14 [#map0, #map1] : memref<3x3xf32> into memref<1x3x3x1xf32>
      %18 = subview %15[0, 0, 0, 0] [1, 3, 3, 1] [1, 1, 1, 1]  : memref<1x7x7x1xf32> to memref<1x3x3x1xf32, #map4>
      linalg.generic {args_in = 2 : i64, args_out = 1 : i64, indexing_maps = [#map5, #map6, #map7], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} %18, %16, %17 {
      ^bb0(%arg1: f32, %arg2: f32, %arg3: f32):  // no predecessors
        %19 = mulf %arg1, %arg2 : f32
        %20 = addf %arg3, %19 : f32
        linalg.yield %20 : f32
      }: memref<1x3x3x1xf32, #map4>, memref<5x5x1x1xf32>, memref<1x3x3x1xf32>
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
