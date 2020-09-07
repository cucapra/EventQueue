### Why EQueue Dialect

There can be several long term goals for equeue dialect

- For ML system designer, fast test/simulation result given network & accelerator
- Automatic design space exploration for lowering from upper dialect / control only program
- Different levels of abstraction inside EQueue dialect (e.g. 4x4 adder hiding implementation detail => bit by bit adder with detail implementation). The simulation time should go slower and slower while EQueue dialect get lowering down.
  - Create performance model (not event-queue model) for each kind of resources. e.g. resource contention for bus, memory, etc. But no need to get details of it which hugely slows down the simulation.

- *Dynamic* graph to ensure generality. 
  - e.g. sparsity; tensor with varied size in NLP
  - collaborate the model with [legion](https://legion.stanford.edu/) 

It is not necessary to implement all the goals, but when thinking about next steps, we can try to accomplish them at our best.