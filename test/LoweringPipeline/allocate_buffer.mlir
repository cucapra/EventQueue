#map0 = affine_map<() -> (0)>
#map1 = affine_map<() -> (14)>
#map2 = affine_map<() -> (12)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0 * 600 + d1 * 60 + d2 * 6 + d3)>
#map4 = affine_map<() -> (10)>
#map5 = affine_map<() -> (54)>
#map6 = affine_map<() -> (64)>


module {
  func @graph() {
    %0 = "equeue.create_proc"() {type = "AIEngine"} : () -> i32
    %1 = "equeue.create_mem"() {banks = 1 : i64, data_bit = 32 : i64, shape = dense<3> : tensor<1xi64>, type = "RegisterFile"} : () -> i32
    %2 = "equeue.create_dma"() : () -> i32
    %3 = "equeue.create_comp_field"(%0, %1, %2) {names = "proc mem dma "} : (i32, i32, i32) -> i32
    %4 = splat %3 : vector<12x14xi32>
    %5 = "equeue.create_mem"() {banks = 16 : i64, data_bit = 32 : i64, shape = dense<4096> : tensor<1xi64>, type = "SRAM"} : () -> i32
    %6 = "equeue.create_proc"() {type = "MicroPlate"} : () -> i32
    %7 = "equeue.create_comp_field"(%4, %6, %5, %2) {names = "pe_array proc mem "} : (vector<12x14xi32>, i32, i32, i32) -> i32
    %8 = "equeue.control_start"() : () -> !equeue.signal
    %done = "equeue.launch"(%8, %6, %7) ( {
    ^bb0(%arg0: i32):  // no predecessors
      %9 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "mem"} : (i32) -> i32
          %22 = "equeue.alloc"(%21) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%20, %22) {names = "pe_obuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      %10 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %10[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "mem"} : (i32) -> i32
          %22 = "equeue.alloc"(%21) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%20, %22) {names = "pe_wbuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      %11 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %11[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "mem"} : (i32) -> i32
          %22 = "equeue.alloc"(%21) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%20, %22) {names = "pe_ibuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      %12 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %13 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<[1, 10, 10, 6]> : tensor<4xi64>} : (i32) -> memref<1x10x10x6xf32>
      "equeue.add_comp_field"(%arg0, %13) {names = "ibuffer "} : (i32, memref<1x10x10x6xf32>) -> ()
      %14 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<[3, 3, 6, 10]> : tensor<4xi64>} : (i32) -> memref<3x3x6x10xf32>
      "equeue.add_comp_field"(%arg0, %14) {names = "wbuffer "} : (i32, memref<3x3x6x10xf32>) -> ()
      %15 = "equeue.alloc"(%12) {data_bit = 32 : i64, shape = dense<[1, 8, 8, 10]> : tensor<4xi64>} : (i32) -> memref<1x8x8x10xf32>
      "equeue.add_comp_field"(%arg0, %15) {names = "obuffer "} : (i32, memref<1x8x8x10xf32>) -> ()
      %16 = subview %13[0, 0, 0, 0] [1, 8, 8, 6] [1, 1, 1, 1]  : memref<1x10x10x6xf32> to memref<1x8x8x6xf32, #map3>
      affine.for %arg1 = 0 to 64 step 14 {
        affine.for %arg2 = 0 to 54 step 12 {
          affine.for %arg3 = 0 to 10 {
            %c0 = constant 0 : index
            affine.for %arg4 = 0 to 14 {
              %c0_0 = constant 0 : index
              affine.for %arg5 = 0 to 12 {
                %c0_1 = constant 0 : index
                %20 = "equeue.read"(%16) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1x8x8x6xf32, #map3>) -> f32
                %21 = "equeue.read"(%14) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<3x3x6x10xf32>) -> f32
                %22 = "equeue.read"(%15) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1x8x8x10xf32>) -> f32
                %23 = "equeue.unkOp"(%22, %20, %21) {op_name = "mac"} : (f32, f32, f32) -> f32
                "equeue.write"(%23, %15) {bank = 0 : i64} : (f32, memref<1x8x8x10xf32>) -> ()
              }
            }
          }
        }
      }
      %17 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %17[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%21) : (memref<1xf32>) -> ()
        }
      }
      %18 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %18[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%21) : (memref<1xf32>) -> ()
        }
      }
      %19 = "equeue.get_comp_field"(%arg0) {name = "pe_array"} : (i32) -> vector<12x14xi32>
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %20 = extract_element %19[%arg1, %arg2] : vector<12x14xi32>
          %21 = "equeue.get_comp_field"(%20) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%21) : (memref<1xf32>) -> ()
        }
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
