### Next Steps

This is to log my random thoughts on future steps...

#### Validation
- Implement architecture like systolic array and ML accelerator like Eyeriss at different scales. 

- Having two designs with relative accuracy can somewhat help validate the simulator.
  - take 2 result from literature (l1, l2)
  - write the designs in equeue dialect, and then run equeue simulator generate two results (e1,e2)
  - if the relative result in energy and latency (l1/l2, e1/e2) are the same or close, the simulator make sense

- Some obstacles in the above validation flow
  - It is hard to write equeue dialect example! Especially for larger hardware like Eyeriss. I've spent a week to make python version simulator work...
    - Need a high level generator...Not sure if it's the right way though
  - Parallelism, large scale operation is not handled in equeue dialect yet.
    - Build parallel semantics, or in high level generator create the component multiple times.
  - Network/BUS is not modeled yet.

#### BUS/Network

- equeue.create_bus bandwidth
  - bus should be there for all data transfer, so it's essentially a network connecting two level memories.
  - BUS is Network in Magnolia
    https://github.com/cucapra/Magnolia/tree/master/example

- implict BUS vs. explict BUS
  - implict: create connection at component creation time, not specify in control
  - explict: read (%data) through (%BUS)

- At simulation, BUS check bandwidth and timing to determine the transfer time.

#### Let's increase scalability!

- comp creation operations:
  - %1 = create_mem "my_name_is_mem", %0
  - %2 = create_comp (%1, ...)
  - get_comp(%2, "my_name_is_mem") 

- Duplications and get the duplications

  1. new type:  equeue.shape
     equeue.shape< 3x2x container<tensor<5xf32>, i32> >
     equeue.shape< 3x2x i32 >
     Prob is: how to realize?

  2. %outer = equeue.parallel () = () to () step (){
         equeue.yield %inner
     }
     %outer should be equeue.shape type

  3. %comp = equeue.dup %component, [N, N]

     %comp should be equeue.shape type

  4. Scalability in data

     - Split and concatenate tensor => putting a partitioned tensor to a container
       But I don't see any support
       std only has element level extraction and concatenation[10xi32]

     - So maybe splitting container<tensor<2x5xf32>,i32> instead:
       equeue.split_container
       equeue.concate_container

#### Pipelining  

- In order execution, out of order write back
  - It's more rely on simulation model
  - Or, we can do it explictly
    equeue.pipeline{
    	opA 
    	opB
    	opC
    }






