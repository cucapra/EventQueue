#map0 = affine_map<() -> (0)>
#map1 = affine_map<() -> (14)>
#map2 = affine_map<() -> (12)>
#map3 = affine_map<(d0) -> (d0 + 1)>
#map4 = affine_map<() -> (10)>
#map5 = affine_map<() -> (27)>
#map6 = affine_map<() -> (25)>


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
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "mem"} : (i32) -> i32
          %16 = "equeue.alloc"(%15) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%14, %16) {names = "pe_obuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "mem"} : (i32) -> i32
          %16 = "equeue.alloc"(%15) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%14, %16) {names = "pe_wbuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "mem"} : (i32) -> i32
          %16 = "equeue.alloc"(%15) {data_bit = 32 : i64, shape = dense<1> : tensor<1xi64>} : (i32) -> memref<1xf32>
          "equeue.add_comp_field"(%14, %16) {names = "pe_ibuffer"} : (i32, memref<1xf32>) -> ()
        }
      }
      %10 = "equeue.get_comp_field"(%arg0) {name = "mem"} : (i32) -> i32
      %11 = "equeue.alloc"(%10) {data_bit = 32 : i64, shape = dense<[1, 7, 7, 3]> : tensor<4xi64>} : (i32) -> memref<1x7x7x3xf32>
      "equeue.add_comp_field"(%arg0, %11) {names = "ibuffer "} : (i32, memref<1x7x7x3xf32>) -> ()
      %12 = "equeue.alloc"(%10) {data_bit = 32 : i64, shape = dense<[5, 5, 3, 10]> : tensor<4xi64>} : (i32) -> memref<5x5x3x10xf32>
      "equeue.add_comp_field"(%arg0, %12) {names = "wbuffer "} : (i32, memref<5x5x3x10xf32>) -> ()
      %13 = "equeue.alloc"(%10) {data_bit = 32 : i64, shape = dense<[3, 3, 3, 10]> : tensor<4xi64>} : (i32) -> memref<3x3x3x10xf32>
      "equeue.add_comp_field"(%arg0, %13) {names = "obuffer "} : (i32, memref<3x3x3x10xf32>) -> ()
      affine.for %arg1 = 0 to 25 step 14 {
        affine.for %arg2 = 0 to 27 step 12 {
          affine.for %arg3 = 0 to 14 {
            affine.for %arg4 = 0 to 12 {
              %14 = extract_element %9[%arg4, %arg3] : vector<12x14xi32>
              %15 = "equeue.get_comp_field"(%14) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
              %16 = affine.apply #map3(%arg4)
              %17 = extract_element %9[%16, %arg3] : vector<12x14xi32>
              %18 = "equeue.get_comp_field"(%17) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
              %19 = "equeue.get_comp_field"(%14) {name = "dma"} : (i32) -> i32
              %20 = "equeue.control_start"() : () -> !equeue.signal
              %21 = "equeue.memcpy"(%20, %15, %18, %19) {dest_bank = 0 : i64, src_bank = 0 : i64} : (!equeue.signal, memref<1xf32>, memref<1xf32>, i32) -> !equeue.signal
            }
          }
          affine.for %arg3 = 0 to 10 {
            affine.for %arg4 = 0 to 14 {
              affine.for %arg5 = 0 to 12 {
                %14 = extract_element %9[%arg5, %arg4] : vector<12x14xi32>
                %15 = "equeue.get_comp_field"(%14) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
                %16 = affine.apply #map3(%arg4)
                %17 = extract_element %9[%arg5, %16] : vector<12x14xi32>
                %18 = "equeue.control_start"() : () -> !equeue.signal
                %19 = "equeue.get_comp_field"(%14) {name = "proc"} : (i32) -> i32
                %20 = "equeue.control_start"() : () -> !equeue.signal
                %21 = "equeue.control_start"() : () -> !equeue.signal
                %done_0, %res:3 = "equeue.launch"(%21, %19) ( {
                  %22 = "equeue.get_comp_field"(%14) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
                  %23 = "equeue.read"(%22) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
                  %24 = "equeue.read"(%15) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
                  %25 = "equeue.get_comp_field"(%14) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
                  "equeue.return"(%23, %24, %25) : (f32, f32, memref<1xf32>) -> ()
                }) : (!equeue.signal, i32) -> (!equeue.signal, f32, f32, memref<1xf32>)
                %done_1 = "equeue.launch"(%20, %19) ( {
                  %22 = "equeue.read"(%res#2) {bank = 0 : i64, size = dense<1> : tensor<1xi64>} : (memref<1xf32>) -> f32
                  %23 = "equeue.unkOp"(%22, %res#0, %res#1) {op_name = "mac"} : (f32, f32, f32) -> f32
                  %24 = "equeue.get_comp_field"(%14) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
                  "equeue.write"(%23, %24) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
                  "equeue.write"(%res#1, %15) {bank = 0 : i64} : (f32, memref<1xf32>) -> ()
                  "equeue.return"() : () -> ()
                }) : (!equeue.signal, i32) -> !equeue.signal
              }
            }
          }
        }
      }
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "pe_ibuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%15) : (memref<1xf32>) -> ()
        }
      }
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "pe_wbuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%15) : (memref<1xf32>) -> ()
        }
      }
      affine.for %arg1 = 0 to 12 {
        affine.for %arg2 = 0 to 14 {
          %14 = extract_element %9[%arg1, %arg2] : vector<12x14xi32>
          %15 = "equeue.get_comp_field"(%14) {name = "pe_obuffer"} : (i32) -> memref<1xf32>
          "equeue.dealloc"(%15) : (memref<1xf32>) -> ()
        }
      }
      "equeue.return"() : () -> ()
    }) : (!equeue.signal, i32, i32) -> !equeue.signal
    return
  }
}
