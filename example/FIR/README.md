# FIR on Xilinx Versal ACAP AI Engine


This example implements Finite Impulse Response (FIR) on Xilinx’s AI Engine in Versal ACAP using our EQueue simulation.

Typical simulation tools can make it challenging for software designers to identify hardware bottlenecks. This example shows how to use EQueue simulation flow to do it in an opposite way: one can start with a simple design and gradually add real-world constraints to carefully test how the constraints affect the users. 

**This example is adapted from [Xilinx FIR tutorial](https://github.com/Xilinx/Vitis-Tutorials/tree/2021.2/AI_Engine_Development/Design_Tutorials/02-super_sampling_rate_fir). 

### Xilinx Versal ACAP and AI Engine

Xilinx’s Versal adaptive compute acceleration platform (ACAP) is a reconfigurable platform that includes programmable logic, ARM cores, and AI Engines, which are specialized vector units. The AI Engine is a fixed array of interconnected VLIW SIMD processors optimized for signal processing and machine learning. Please check details on their [user manual](https://www.xilinx.com/support/documentation/architecture-manuals/am009-versal-ai-engine.pdf). 

The AI Engines come as an array of interconnected processors using AXI-Stream interconnect blocks and it serves as a perfect use case of EQueue simulation, as the backend is fixed but leaves flexibility on mapping strategies.

![](../../mydoc/fig/fir/AIEngineArray.jpg)

### FIR

A finite impulse response (FIR) filter is a common signal processing primitive that responds to inputs of finite duration.
An FIR operation filters and accumulates on a sliding-window. Given a series of discrete input samples x and N coefficients
c, the output samples y are calculated as:

<img src="../../mydoc/fig/fir/FIR_Equation.jpg" width="150" />

We compare our simulator’s reports to those from Xilinx’s own, hand-written, closed-source simulator to ground the results. The Xilinx FIR tutorial uses a filter with 32 complex, asymmetric coefficients and a digital series of length 512. Each value occupies 32 bits.

