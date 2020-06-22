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
		%accel_dma = "equeue.create_dma"():()->i32
		%accel = "equeue.create_comp"(%accel_core, %aie, %accel_dma, %sram):(i32, i32, i32, i32) -> i32
			
		
	
		//control
		%start_signal = "equeue.control_start"():()->!equeue.signal
		equeue.launch (%act, %weight, %aie_core_local, %dma, %m0, %m1= %act_in, %weight_in, %aie_core, %accel_dma, %sram, %aie_mem : tensor<16xf32>, tensor<5xf32>, i32, i32, i32, i32) 
		in (%start_signal, %accel_core) 
		{
			%s0 = "equeue.control_start"():()->!equeue.signal
			%weight_sram = equeue.alloc %m0, [5], f32 : !equeue.container<tensor<5xf32>, i32>
			%write_done0 = "equeue.write"(%s0, %weight, %weight_sram): (!equeue.signal,tensor<5xf32>, !equeue.container<tensor<5xf32>, i32>)->(!equeue.signal)
			%act_sram = equeue.alloc %m0, [16], f32: !equeue.container<tensor<16xf32>, i32>
			%write_done1 ="equeue.write"(%s0, %act, %act_sram): (!equeue.signal, tensor<16xf32>, !equeue.container<tensor<16xf32>, i32>)->(!equeue.signal)
		  	
			%output_sram = equeue.alloc %m0, [16], f32 : !equeue.container<tensor<12xf32>, i32>
			
			%weight_mem = equeue.alloc %m1, [5], f32:!equeue.container<tensor<5xf32>, i32>
			%act_mem = equeue.alloc %m1, [5], f32 :!equeue.container<tensor<5xf32>, i32>
			%ofmap_mem = equeue.alloc %m1, [1], f32 :!equeue.container<f32, i32>
			%write_done = "equeue.control_and"(%write_done0, %write_done1):(!equeue.signal, !equeue.signal)->!equeue.signal
			
			%dma_done0 = "equeue.memcpy"(%write_done, %weight_sram, %weight_mem, %dma): (!equeue.signal, !equeue.container<tensor<5xf32>,i32>, !equeue.container<tensor<5xf32>,i32>, i32) -> !equeue.signal
			%c0 = constant 0:index
			%c12 = constant 12:index//16-5+1=12
			%c1 = constant 1:index
			
				%dma_done1 = "equeue.memcpy"(%write_done, %act_sram, %act_mem, %dma): (!equeue.signal, !equeue.container<tensor<16xf32>,i32>, !equeue.container<tensor<5xf32>, i32>, i32) -> !equeue.signal
				
				%start_compute = "equeue.control_and"(%dma_done0, %dma_done1):(!equeue.signal, !equeue.signal)->!equeue.signal
				
				%compute_done = equeue.launch (%act_mem_local, %weight_mem_local, %ofmap_mem_local = %act_mem, %weight_mem, %ofmap_mem: !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>,!equeue.container<f32, i32>) in (%start_compute, %aie_core_local)  
				{
					%const0 = constant 0.0:f32
					%s1 = "equeue.control_start"() : ()->!equeue.signal
					%s2 = "equeue.write"(%s1, %const0, %ofmap_mem_local): (!equeue.signal, f32, !equeue.container<f32, i32>)->(!equeue.signal)
				
					%cst0 = constant 0:index
					%cst1 = constant 1:index
					%cst5 = constant 5:index
					"equeue.return"():()->()
				}					
			equeue.dealloc %compute_done, %act_sram, %weight_sram, %output_sram, %act_mem, %weight_mem, %ofmap_mem: !equeue.container<tensor<16xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<12xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32>
			"equeue.return"():()->()
		}
		return
	}
}
