### Why EQueue Dialect

There can be several long term goals for equeue dialect

- For ML system designer, fast test/simulation result given network & accelerator
- Automatic design space exploration for lowering from upper dialect / control only program
- Different levels of abstraction inside EQueue dialect (e.g. 4x4 adder hiding implementation detail => bit by bit adder with detail implementation) The simulation time should go slower and slower while EQueue dialect get lowering down

It is not necessary to implement all the goals, but when thinking about next steps, we can try to accomplish them at our best.