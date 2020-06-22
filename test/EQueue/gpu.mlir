// RUN: equeue-opt %s | equeue-opt | FileCheck %s

module {
	func @graph(%act_in : tensor<16xf32>, %weight_in : tensor<5xf32>) -> tensor<12xf32> {

		//structure
		%aie_mem = equeue.create_mem [11], f32, SRAM
		%aie_core = equeue.create_proc AIEngine
		%aie = "equeue.create_comp"(%aie_mem, %aie_core):(i32, i32)->i32
   	
		%sram = equeue.create_mem [64], f32, SRAM
		%accel_core = equeue.create_proc ARMr5
		%accel_dma = "equeue.create_dma"():()->i32
		%accel = "equeue.create_comp"(%accel_core, %aie, %accel_dma, %sram):(i32, i32, i32, i32) -> i32
	
		//control
		%start_signal = "equeue.control_start"():()->!equeue.signal
		%done_signal, %result = equeue.launch (%act, %weight, %aie_core_local, %dma, %m0, %m1 = %act_in, %weight_in, 
		%aie_core, %accel_dma, %sram, %aie_mem : tensor<16xf32>, tensor<5xf32>, i32, i32, i32, i32) 
		in (%start_signal, %accel_core) : tensor<12xf32> {
			%weight_sram = equeue.alloc %m0, [5], f32 : !equeue.container<tensor<5xf32>, i32>
			//memory busy
			//execution interval
			//event queue operation
			"equeue.write"(%weight, %weight_sram): (tensor<5xf32>, !equeue.container<tensor<5xf32>, i32>)->()
			%act_sram = equeue.alloc %m0, [16], f32: !equeue.container<tensor<16xf32>, i32>
			"equeue.write"(%act, %act_sram): (tensor<16xf32>, !equeue.container<tensor<16xf32>, i32>)->()
		  	
			%output_sram = equeue.alloc %m0, [16], f32 : !equeue.container<tensor<12xf32>, i32>
			
			%weight_mem = equeue.alloc %m1, [5], f32:!equeue.container<tensor<5xf32>, i32>
			%act_mem = equeue.alloc %m1, [5], f32 :!equeue.container<tensor<5xf32>, i32>
			%ofmap_mem = equeue.alloc %m1, [1], f32 :!equeue.container<f32, i32>
			
			%start_memcpy = "equeue.control_start"():()->!equeue.signal
			%dma_done0 = "equeue.memcpy"(%start_memcpy, %weight_sram, %weight_mem, %dma): (!equeue.signal, !equeue.container<tensor<5xf32>,i32>, !equeue.container<tensor<5xf32>,i32>, i32) -> !equeue.signal
			
			%c0 = constant 0:index
			%c12 = constant 2:index // 16-5+1=12
			%c1 = constant 1:index
			%compute_done = scf.for %k = %c0 to %c12 step %c1 
				iter_args(%dma_start = %start_memcpy) -> (!equeue.signal) {
				%dma_done1 = "equeue.memcpy"(%dma_start, %act_sram, %act_mem, %dma, %k): (!equeue.signal, !equeue.container<tensor<16xf32>,i32>, !equeue.container<tensor<5xf32>, i32>, i32, index) -> !equeue.signal
				%start_compute = "equeue.control_and"(%dma_done0, %dma_done1):(!equeue.signal, !equeue.signal)->!equeue.signal
				%compute_once = equeue.launch (%act_mem_local, %weight_mem_local, %ofmap_mem_local, %offset = 
				%act_mem, %weight_mem, %ofmap_mem, %k: !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, 
				!equeue.container<f32, i32>, index) 
				in (%start_compute, %aie_core_local)  
				{
					%const0 = constant 0.0:f32
					"equeue.write"(%const0, %ofmap_mem_local): (f32, !equeue.container<f32, i32>)->()
					%cst0 = constant 0:index
					%cst1 = constant 1:index
					%cst5 = constant 2:index
					scf.for %i = %cst0 to %cst5 step %cst1 {
						%j = affine.apply affine_map<(d0,d1)->(d0+d1)>(%offset,%i)
						%ifmap = "equeue.read" (%act_mem_local,%j):(!equeue.container<tensor<5xf32>, i32>, index)->f32 
						%filter = "equeue.read" (%weight_mem_local,%i):(!equeue.container<tensor<5xf32>, i32>, index)->f32 
						%ofmap = "equeue.read" (%ofmap_mem_local):(!equeue.container<f32, i32>) -> f32

						%psum = mulf %filter, %ifmap: f32
						%ofmap_flight = addf %ofmap, %psum: f32

						"equeue.write"( %ofmap_flight, %ofmap_mem_local):(f32, !equeue.container<f32, i32>)->()
						"scf.yield"():()->()
					}	
					"equeue.return"():()->()
				}
				%ofmap_done = "equeue.memcpy"(%compute_once, %ofmap_mem, %output_sram, %dma, %k):(!equeue.signal, !equeue.container<f32, i32>, !equeue.container<tensor<12xf32>, i32>, i32, index)->(!equeue.signal)
				"scf.yield"(%ofmap_done):(!equeue.signal)->()
			}
			"equeue.await"(%compute_done):(!equeue.signal)->()
			%act_out = "equeue.read" (%output_sram):(!equeue.container<tensor<12xf32>, i32> ) -> tensor<5xf32>
			equeue.dealloc %act_sram, %weight_sram, %output_sram, %act_mem, %weight_mem, %ofmap_mem: !equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<12xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32>
			"equeue.return"(%act_out):(tensor<5xf32>)->()
		}
		"equeue.await"(%done_signal):(!equeue.signal)->()
		return %result: tensor<12xf32>
	}
}
