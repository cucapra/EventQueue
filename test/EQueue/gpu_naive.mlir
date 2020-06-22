// RUN: equeue-opt %s | equeue-opt | FileCheck %s

module {
    // CHECK-LABEL: func @graph()
    func @graph(%act_in : tensor<16xf32>, %weight_in : tensor<5xf32>) {

				//structure
				%aie_mem = equeue.create_mem [11], f32, SRAM
				%aie_core = equeue.create_proc AIEngine
				%aie = "equeue.create_comp"(%aie_mem, %aie_core):(i32, i32)->i32
       	
				%sram = equeue.create_mem [64], f32, SRAM
				%accel_core = equeue.create_proc ARMr5
				%dma = "equeue.create_dma"():()->i32
				%accel = "equeue.create_comp"(%accel_core, %aie, %dma, %sram):(i32, i32, i32, i32) -> i32
					
				
			
				//control
				%start_signal = "equeue.control_start"():()->!equeue.signal
				%assign_done, %act_sram, %weight_sram, %output_sram, %act_aie, %weight_aie, %ofmap_aie = equeue.launch (%act, %weight, %m0, %m1 = %act_in, %weight_in, %sram, %aie_mem : tensor<16xf32>, tensor<5xf32>, i32, i32) 
				in (%start_signal, %accel_core) : !equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<12xf32>, i32>, !equeue.container<tensor<5xf32>, i32> ,  !equeue.container<tensor<5xf32>, i32> , !equeue.container<f32, i32>
				{
					%s0 = "equeue.control_start"():()->!equeue.signal
					%weight_s = equeue.alloc %m0, [5], f32 : !equeue.container<tensor<5xf32>, i32>
					"equeue.write"(%s0, %weight, %weight_s): (!equeue.signal,tensor<5xf32>, !equeue.container<tensor<5xf32>, i32>)->(!equeue.signal)
					%act_s = equeue.alloc %m0, [16], f32: !equeue.container<tensor<16xf32>, i32>
					"equeue.write"(%s0, %act, %act_s): (!equeue.signal, tensor<16xf32>, !equeue.container<tensor<16xf32>, i32>)->(!equeue.signal)
				  	
					%output_s = equeue.alloc %m0, [16], f32 : !equeue.container<tensor<12xf32>, i32>
					
					%weight_a = equeue.alloc %m1, [5], f32:!equeue.container<tensor<5xf32>, i32>
					%act_a = equeue.alloc %m1, [5], f32 :!equeue.container<tensor<5xf32>, i32>
					%ofmap_a = equeue.alloc %m1, [1], f32 :!equeue.container<f32, i32>
					"equeue.return"(%act_s, %weight_s, %output_s, %act_a, %weight_a, %ofmap_a): (!equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<12xf32>, i32>, !equeue.container<tensor<5xf32>, i32>,  !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32> )->()
				}

				%dma_done0 = "equeue.memcpy"(%assign_done, %weight_sram, %weight_aie, %dma): (!equeue.signal, !equeue.container<tensor<5xf32>,i32>, !equeue.container<tensor<5xf32>,i32>, i32)-> (!equeue.signal) 
					%c0 = constant 0:index
					%c12 = constant 12:index//16-5+1=12
					%c1 = constant 1:index
					%compute_done = scf.for %k = %c0 to %c12 step %c1 
					iter_args(%dma_start = %assign_done) -> (!equeue.signal) {
					
					%dma_done1 = "equeue.memcpy"(%dma_start, %act_sram, %act_aie, %dma, %k): (!equeue.signal, !equeue.container<tensor<16xf32>,i32>, !equeue.container<tensor<5xf32>, i32>, i32, index)-> (!equeue.signal)
					
					%start_compute = "equeue.control_and"(%dma_done0, %dma_done1):(!equeue.signal, !equeue.signal)->!equeue.signal
					
					%compute_done = equeue.launch (%act_aie_local, %weight_aie_local, %ofmap_aie_local, %offset = %act_aie, %weight_aie, %ofmap_aie, %k: !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>,!equeue.container<f32, i32>, index) in (%start_compute, %aie_core)  
					{
						%const0 = constant 0.0:f32
						%s1 = "equeue.control_start"() : ()->!equeue.signal
						%s2 = "equeue.write"(%s1, %const0, %ofmap_aie_local): (!equeue.signal, f32, !equeue.container<f32, i32>)->(!equeue.signal)
					
						%cst0 = constant 0:index
						%cst1 = constant 1:index
						%cst5 = constant 5:index
						scf.for %i = %cst0 to %cst5 step %cst1 {
							%j = affine.apply affine_map<(d0,d1)->(d0+d1)>(%offset,%i)
							%ifmap = "equeue.read" (%s1, %act_aie_local,%j):(!equeue.signal, !equeue.container<tensor<5xf32>, i32>, index)->f32 
							%filter = "equeue.read" (%s1, %weight_aie_local,%i):(!equeue.signal, !equeue.container<tensor<5xf32>, i32>, index)->f32 
							%ofmap = "equeue.read" (%s2, %ofmap_aie_local):(!equeue.signal,!equeue.container<f32, i32>) -> f32

							%psum = mulf %filter, %ifmap: f32
							%ofmap_flight = addf %ofmap, %psum: f32

							"equeue.write"(%s1, %ofmap_flight, %ofmap_aie_local):(!equeue.signal, f32, !equeue.container<f32, i32>)->(!equeue.signal)
						}	
						"equeue.return"():()->()
					}					
					%ofmap_done = "equeue.memcpy"(%compute_done, %ofmap_aie, %output_sram, %dma, %k):(!equeue.signal, !equeue.container<f32, i32>, !equeue.container<tensor<12xf32>, i32>, i32, index)->(!equeue.signal)
					scf.yield %ofmap_done:!equeue.signal
				}
				//"equeue.launch"(%compute_done, %aie_core)({
				//	equeue.dealloc %act_sram: !equeue.container<tensor<16xf32>, i32>
				//	equeue.dealloc %weight_sram: !equeue.container<tensor<5xf32>, i32>
				//	equeue.dealloc %output_sram: !equeue.container<tensor<12xf32>, i32>
				//	equeue.dealloc %act_aie: !equeue.container<tensor<5xf32>, i32>
				//	equeue.dealloc %weight_aie: !equeue.container<tensor<5xf32>, i32>
				//	equeue.dealloc %ofmap_aie: !equeue.container<f32, i32>
				//	"equeue.return"():()->()
				//}):(!equeue.signal, i32)->(!equeue.signal)
				return
    }
}
