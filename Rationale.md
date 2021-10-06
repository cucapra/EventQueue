There are four concerns mainly mentioned by reviewers:

A. **Novelty (review D).** Our paper proposes a *general* framework for *high-level* hardware simulation. It is an alternative to single-purpose accelerator models written "by hand" in mainstream languages like C++. The framework is tied to a specific accelerator domain (e.g., tensor computations); our case studies demonstrate different architecture styles with different degrees of programmability. Its novelty and key advantages come from the compiler-driven approach, which (a) makes it easier to write and modify hardware, and (b) enables the construction of *passes* that generate and transform accelerator models.

- (a) The EQueue dialect separates the accelerator design from its simulator implementation, which makes it easier to change the hardware and explore design alternatives.
- (b) By building on a compiler infrastructure, the EQueue dialect offers extensibility through *passes* that generate designs that are tedious and error-prone for humans to construct by hand. We demonstrate this capability in the systolic array case study, which shows how *lowering passes* can translate from algorithmic representations into a wide variety of hardware structures.

B. **Benefits vs. Costs (reviews B, C and D).** Many asked for the reason to choose our simulator over a highly-optimized simulator like SCALE-Sim.

- For hardware designers, it would be lucky if their design is perfectly the same as existing simulators (e.g. SCALE-Sim) model. But if it doesn’t, it would be painful to rewrite the simulator (410 in 569 LOC to change WS to IS on the *same* architecture for SCALE-Sim).

- For general simulators or low level simulators like AIE simulator. It takes much more time to both change the design and simulate.

- We modify the second paragraph of Section 1 and 6-B, 7-F to illustrate this.

C. **Evaluation (reviews B, C and E)**. Some reviewers asked about direct comparisons to existing simulators. 

- We agree — we selected our case studies so that we would have existing simulators available to compare to. 

- Because our novelty lies in compilation, the goal in each case was not to "beat" the existing, traditional simulator but to show that the EQueue-based simulators could match their accuracy while being far easier to build and improving their flexibility. 

- The two case study shows that EQueue-based simulators are as accurate as the traditional simulators. Section 6-B and 6-D discuss the ease of construction and flexibility —changing dataflows, for example, requires only 11 lines of code or applying some compiler passes. Section 7 shows that even a high-level simulation can guide user to improve their design.

- To explain this, we modify the last paragraph of Section 1 and add **Benefits** paragraphs at the end of each evaluation subsection. 
- On the other hand, we do realize that as a simulator, it is important to show its performance; now Section 6-E shows a scalability evaluation where we tested 4050 designs and discussed the general rule revealed by the simulation.

D. **Modeling (reviews A, B and E)**. Several reviewers asked how to model components and operations. 

- There is an operation library and a component library. During simulation, the *create_\** semantics creates C++ structures. If a component is executed it calculates the time for execution or returns a stall signal when the condition is not met. 
- Many components have complex or customized behavior. We leave it to users to define their own component. To extend a new component like cache or DRAM, one can add it to the component library where the interface is still cycle and stall signals.To extend the operation set, one can use *equeue.op(“new-op”, in-args, out-args)* and extend the operation library based on the behavior of *“new-op”*.
- We add subsection 4-D to illustrate this.



**Review A:**

- Do you model SRAM bank conflict?

  - See (D). 

  - Yes. SRAM creates a scheduling queue for each bank, if there is a conflict, the memory returns a stall signal to the processor and lets it wait. 

- What if an accelerator uses a cache?

  - See (D). 

  - We don't model it, but one can extend the component library with the cycle and stall interface. For example, give cycle count when the cache hits and give a stall signal when it misses.

- How do you model DRAM traffic?

  - See (D). 

  - Similar to cache, but one can extend the component library with a different timing model. Because DRAM behavior can be complicated, one can plug in a DRAM simulator and interact with the component library.

  

**Review B:**

- How difficult is it to change simulator logic to express the functionality?

  - See (D). 

  - We don’t change simulator logic, but extending the operation library. 

- How difficult is it to understand and extend EQueue compared to say understanding and extending gem5?

  - The main reason to use gem5 would be one wants to tweak a processor already supported by gem5, e.g. by changing the coherence protocol. 

  - But our framework aims at making a custom machine from scratch, e.g. modeling a deep neural network for a systolic array, or modeling operations on the reconfiguration Xilinx AI Engine. In this sense, we may be more likely to use gem5 to extend our simulator’s component library.

Minor points:

- How do you represent simulator input?
  - The input is an EQueue program. See Section 4. 

- What is the performance overhead of the generated simulator compared to for instance SCALE-Sim?

  - See (B) and (C). 

  - The comparison with SCALE-Sim is in Section 6-C. We match the accuracy and SCALE-Sim is faster at a scale of O(100).

  - Notice SCALE-Sim is a baseline. We don’t want to it, but to accomplish the same accuracy with more flexibility and lower cost using the compiler approach.

- How long does it take to compile the simulator? How does compiler passes and accelerator complexity impact compilation time?

  - One may apply compiler passes to explore design space, but it is not used for simulation. 

  - The compilation flow takes microseconds and is negligible to the simulation time. We add it to Section 6-D and Figure 11.

  

**Reviewer C:**

- Can you put a comparison in terms of accuracy, performance, and programming cost on multiple applications using the architecture demonstrated?

  - See (C).

  - It is hard to compare expressiveness with performance. But we tried to demonstrate the accuracy and programming cost compared to SCALE-Sim in Section 6-C. We update Section 6-E with a scalability evaluation to demonstrate the performance.

- Does the compilation framework go straight from a high-level language such as C, or does the programmer need to implement the program at the low level?

  - One can use C++ to generate an MLIR program. It can be both at a low level like EQueue, or lowered from a high level like Linalg in Section 6-D. We provide lots of reusable passes and we welcome the community to extend it.

  - We modify Section 4-A to illustrate this.

- How to know that the expressive capability is worth the potential costs?

  - See (B).



**Reviewer D:**

- What is your novelty? What is the novelty over SCALE-Sim, MAESTRO,  TVM, Dahlia or Calyx?

  - See (A) for the novelty of this work. We propose a simulation framework across multiple abstraction levels, targeting multiple backends from AIE, GPU to RTL.

  - See (B) for comparison with SCALE-Sim. 

  - MAESTRO is a systolic dataflow modeling framework. Just like SCALE-Sim, it is very specific to application and hard to make changes. 

  - TVM, Dahlia, or Calyx are compiler frameworks, not simulation framework.  
  - TVM and Dahlia do not tell the hardware configuration. Imagine that if one extends any of these frameworks for simulation, the simulator would have to treat the processor as a **black box** or have to "imagine" the architecture configuration. Our work finds *a general way to express different kinds of architectures.*
  - Calyx is very low-level but it requires a huge amount of work for modeling asynchronous tasks we propose in the paper.
  - None of the work listed can model the asynchronous tasks.

- We have Verilator and HLS tools, and can estimate the performance of accelerators already. Why is the proposed work needed? 

  - See (A).
  - Verilator and HLS tools target a specific backend, FPGA; modification requires substantial rewriting; designers have little control over HLS optimization.
  - Our work is general to all kinds of architecture, exposes the intermediate representation and the compilation framework makes it easy to explore design spaces. 

- How do I know whether my abstraction is correct? 
  - Our simulator helps designers to understand their design before getting to implementation. Like other simulators, one has to check the correctness themselves. 
  - Our detailed, visualized tracing may help (Section 7). 

- After I design the simulator here, can I output to a hardware design language?

  - We simulator does not generate hardware. 
  - People may just want fast and dirty simulation to make some early design decisions. The two case studies are to illustrate high-level performance modeling is meaningful.

- What are the steps in the entire design flow?

  - One will write a EQueue program and give it as input to the EQueue simulator, which outputs a summary and detailed tracing. See Section 4. 

    

**Reviewer E:**

- Is the case study limited to only consider ML-related accelerators?
  - The AI Engine example, though given the name of AI, is not limited to ML applications. 
  - There are a huge variety of accelerators. Our case study covers two cases and tries to demonstrate the flexibility. 
  - We intentionally choose two kinds of architectures, not limited to FPGA, or RTL, but AI Engine.
- The baseline used in the experiments is the results generated by another simulator, rather than real hardware performance. Why is it designed so? 
  - AIE simulator and SCALE-Sim are validated, real-word simulators. 
- Can you demonstrate the EQueue simulator can bear a larger workload or a broader range of applications?
  - See (C). We updated Section 6-E to provide more data points.
- The elapsed simulation time is also a key metric to help developers improve productivity. Can you compare the elapsed simulation time to existing simulators?
  - See Section 6-E. It can take up to tons of seconds for simulation, slower than application specific simulators, faster than general purpose simulators.
- Can you discuss how you model memory hierarchy?
  - See (D).