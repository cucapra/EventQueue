# 'equeue' Dialect
The dialect provides middle-level abstractions for launching concurrent kernel devices. It provides abstractions for device invocations on memories and kernels, allowing flexible device hierarchy and clear data flow.

Its goal is to bridge the gap between low-level hardware model and high-level abstraction where no hardware information is given, thus facilitating custom lowering among different design choices. It may be targeted, for example, by DSLs using MLIR. 

The dialect uses `equeue` as its canonical prefix.



### Component Creation Operations (StructureOpTrait)

To support arbitrary hardware hierarchy and allow each hardware to have its own properties, equeue dialect have a lot operations to model the hardware structure. This facilitates explicit data movement on different memories and modeling concurrent devices.

#### `equeue.create_mem`(equeue::CreateMemOp)

Creates a memory component of the given memory type, data size and data type, and returns a handler to the memory component.

```MLIR
%1 = equeue.create_mem [1024], f32, SRAM
```

##### Attributes:

| **Attribute** | **MLIR Type**             | **Description**             |
| ------------- | ------------------------- | --------------------------- |
| `shape`       | ::mlir::I64ElementsAttr   | shape of memory             |
| `data`        | ::mlir::StrAttr           | data type                   |
| `type`        | ::equeue::CreateMemOpAttr | type of memory (SRAM, DRAM) |

##### Results:

| **Result** | **Description** |
| ---------- | --------------- |
| `res`      | ::mlir::I32     |

#### `equeue.create_proc`(equeue::CreateProcOp)

Creates a processor component of the given processor type, and returns a handler to the processor component.

```MLIR
%1 = equeue.create_proc ARMr5
```

##### Attributes:

| **Attribute** | **MLIR Type**              | **Description**                                              |
| ------------- | -------------------------- | ------------------------------------------------------------ |
| `type`        | ::equeue::CreateProcOpAttr | memory type of the processor (AIE, MicroPlate, ARMr5, ARMx86) |

##### Results:

| **Result** | **Description** |
| ---------- | --------------- |
| `res`      | ::mlir::I32     |

#### `equeue.create_dma`(equeue::CreateDMAOp)

Creates a DMA component, and returns a handler to the DMA component.

```MLIR
%1 = "equeue.create_dma"():()->i32
```

##### Results:

| **Result** | **Description** |
| ---------- | --------------- |
| `res`      | ::mlir::I32     |



#### `equeue.create_comp`(equeue::CreateCompOp)

The operation takes variable number of operands representing component handlers.

It creates a component made of input component handlers, and returns a handler to the component.

```MLIR
%accel_mem = equeue.create_mem [64], f32, SRAM
%accel_core = equeue.create_proc ARMr5
%accel_dma = "equeue.create_dma"():()->i32
%accel = "equeue.create_comp"(%accel_core, %accel_dma, %accel_mem):(i32, i32, i32) -> i32
```

##### Operands:

| **Operand** | **Description** |
| ----------- | --------------- |
| `size`      | Variadic\<I32\> |

##### Results:

| **Result** | **Description** |
| ---------- | --------------- |
| `res`      | ::mlir::I32     |



### Memory Operations

Since equeue dialect can model memory, it can model data movement by representing specific buffer referencing a particular memory space.

All memory operation are operating or generating memory buffer of `::equeue::ContainerType` which represents a reference to a memory space `equeue.create_mem` created of particular size. 

#### `equeue.alloc`(equeue::MemAllocOp)

Returns a buffer representing a reference to a particular memory space. The type of memory buffer is `::equeue::ContainerType`

This operation takes in a memory handler as operand. Together with attributes of memory buffer, the operation models a buffer allocation process and returns a buffer.

```MLIR
%1 = equeue.create_mem [1024], f32, SRAM
%2 = equeue.alloc %1, [5], f32 : !equeue.container<tensor<5xf32>, i32>
```

##### Attributes:

| **Attribute** | **MLIR Type**           | **Description**         |
| ------------- | ----------------------- | ----------------------- |
| `shape`       | ::mlir::I64ElementsAttr | shape of buffer         |
| `data`        | ::mlir::StrAttr         | data type of the buffer |

##### Operands:

| Operand | **Description** |
| ------- | --------------- |
| `mem`   | ::mlir::I32     |

##### Results:

| **Result** | **Description**         |
| ---------- | ----------------------- |
| `buffer`   | ::equeue::ContainerType |

#### `equeue.dealloc`(equeue::MemDeallocOp)

Deallocate a buffer (or more) and the space reserved for the buffer on the memory it refers to.

```MLIR
%1 = equeue.create_mem [1024], f32, SRAM
%2 = equeue.alloc %1, [5], f32 : !equeue.container<tensor<5xf32>, i32>
equeue.dealloc %2: !equeue.container<tensor<5xf32>, i32>
```

##### Operands:

| Operand  | **Description**         |
| -------- | ----------------------- |
| `buffer` | ::equeue::ContainerType |



#### `equeue.write`(equeue::MemWriteOp)

Writes a value to a memory buffer. 

This operation takes in a value of any tensor or scalar type, together a memory buffer. 

```MLIR
%1 = equeue.create_mem [1024], f32, SRAM
%2 = equeue.alloc %1, [1], f32 : !equeue.container<f32, i32>
%3 = std.constant 10: f32
"equeue.write"(%3, %2): (f32, !equeue.container<f32, i32>)->()
```

##### Operands:

| Operand  | **Description**                        |
| -------- | -------------------------------------- |
| `value`  | ::mlir::AnyTensor or ::mlir::AnyScalar |
| `buffer` | ::equeue::ContainerType                |

#### `equeue.Read`(equeue::MemReadOp)

Reads a value from a memory buffer. 

This operation takes in a memory buffer and an offset of variable number.

Returns the value read from the buffer given certain offset 

```MLIR
%value = "equeue.read" (%buffer, %j):(!equeue.container<tensor<5xf32>, i32>, index)->f32 
```

##### Operands:

| Operand  | **Description**           |
| -------- | ------------------------- |
| `buffer` | ::equeue::ContainerType   |
| `offset` | Variadic\<::mlir::Index\> |

##### Results:

| **Result** | **Description**                        |
| ---------- | -------------------------------------- |
| `value`    | ::mlir::AnyTensor or ::mlir::AnyScalar |



### Event Operations (AsyncOpTrait)

Event operations actually composed of two kinds: launching operations and control operations.

The rationale behind equeue dialect of creating individual devices is not limited to modeling memory, but more important, to model concurrent devices.

#### Modeling Concurrent Devices

In equeue dialect, all components being created are running concurrently with each other. One way is model them is to assume all components are running synchronously, as [gpu dialect](https://mlir.llvm.org/docs/Dialects/GPU/) does. However, that limits the flexibility and expressiveness to model arbitrary hardware structure.

The event operations are asynchronous operations, i.e. it only starts execution when receiving a start signal of `equeue.signal` type and generating a done signal when `equeue.signal` is the execution of the event ends. That is, each signal is generated from a event, which can be launching or control operations. 

To store the events that a device should run in order, at simulation time, each device is modeled with a event queue to store the events. When the event queue is full, no more event is allowed to be pushed on the the queue. Each device also has a program counter, when the event queue is full and the program counter is pointing to a event operation, then the execution stalls till there is empty slots in the corresponding event queue.



### Launching Operations (AsyncOpTrait)

The launching operation is a special kind of event operation, it not only starts execution with a start signal and ends by generating a done signal, but also it specifies which device the operation is running on.

By and large, equeue dialect creates `equeue.launch` and `equeue.memcpy` operations that describing a kernel being launched asynchronously *on certain devices*. 

#### `equeue.launch`(equeue::LaunchOp)

Returns a signal representing a event is finished, whose type is `::equeue::SignalType`, as well as variable number of results from `equeue.return` operation.

The first two operands `equeue.launch`operation takes in is a signal to start the event and the device the event is launched on. The other operands are all resources are passed to the device, representing the device has gained control over the resources.

The operation also takes in a region as input operand, or equivalently, launch body. Inside the launch body, operations are executed sequentially with a program counter to denote the execution state. Event queue of corresponding dialect prevents the asynchronous event operations block the sequential execution.

```MLIR
%done = equeue.launch (%1, %2, %3, %4 = %act_mem, %weight_mem, %ofmap_mem, %k: 
!equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>, !equeue.container<f32, i32>, index) 
in (%start, %core_device)  
{
	%c0 = constant 0.0:f32
	"equeue.write"(%c0, %3): (f32, !equeue.container<f32, i32>)->()
	%cst0 = constant 0:index
	%cst1 = constant 1:index
	%cst5 = constant 2:index
	scf.for %i = %cst0 to %cst5 step %cst1 {
		%j = affine.apply affine_map<(d0,d1)->(d0+d1)>(%offset,%i)
		%ifmap = "equeue.read" (%1,%j):(!equeue.container<tensor<5xf32>, i32>, index)->f32 
		%filter = "equeue.read" (%2,%i):(!equeue.container<tensor<5xf32>, i32>, index)->f32 
		%ofmap = "equeue.read" (%3):(!equeue.container<f32, i32>) -> f32
		%psum = mulf %filter, %ifmap: f32
		%ofmap_flight = addf %ofmap, %psum: f32

		"equeue.write"( %ofmap_flight, %3):(f32, !equeue.container<f32, i32>)->()
		"scf.yield"():()->()
	}	
	"equeue.return"():()->()
}
```



##### Operands:

| Operand    | **Description**      |
| ---------- | -------------------- |
| `start`    | ::equeue::SignalType |
| `device`   | ::MLIR::I32          |
| `operands` | Variadic\<AnyType\>  |

##### Results:

| **Result** | **Description**      |
| ---------- | -------------------- |
| `done`     | ::equeue::SignalType |
| `res`      | Variadic\<AnyType\>  |

#### `equeue.return`(equeue::ReturnOp)

Takes in variable number of operands and passes to `equeue.launch` operation as results.

Returns nothing. 

This operation is the explicit terminator of  `equeue.launch` launch body.

```MLIR
%done, %dram_buffer = equeue.launch (%1 = %sram_buffer: !equeue.container<tensor<5xf32>, i32> ) 
in (%start, %core_device) : tensor<5xf32>
{
	%3 = "equeue.read"(%1):(!equeue.container<tensor<5xf32>, i32>)-> tensor<5xf32>
	"equeue.return"(%3):(tensor<5xf32>)->()
}
```

##### Operands:

| Operand    | **Description**     |
| ---------- | ------------------- |
| `operands` | Variadic\<AnyType\> |

#### `equeue.memcpy`(equeue::MemCopyOp)

Represents copies value from one buffer to the other.

Returns a signal representing a event is finished, whose type is `::equeue::SignalType`. 

The first operand it takes in is a start signal, then the source buffer, destination buffer and the device that launching the event, usually a DMA. It can also take in variable number of offset.

```MLIR
%done = "equeue.memcpy"(%start, %src_buffer, %dest_buffer, %dma): (!equeue.signal, !equeue.container<tensor<5xf32>,i32>, !equeue.container<tensor<5xf32>,i32>, i32) -> !equeue.signal		
```

This is completely equivalent to the following code rewritten with `equeue.launch`, but `equeue.memcpy` is more concise, i.e. `equeue.memcpy` is the syntactic sugar for `equeue.launch` on a particular device with only read and write operations in the launch body.

```MLIR
%done = equeue.launch (%1, %2 = %sram_buffer, %dram_buffer: 
!equeue.container<tensor<5xf32>, i32>, !equeue.container<tensor<5xf32>, i32>) 
in (%start, %dma)  
{
	%3 = "equeue.read"(%1):(!equeue.container<tensor<5xf32>, i32>)-> tensor<5xf32>
	"equeue.write"( %3, %1):(tensor<5xf32>, !equeue.container<f32, i32>)->()
	"equeue.return"():()->()
}
```

##### Operands:

| Operand       | **Description**             |
| ------------- | --------------------------- |
| `start`       | ::equeue::SignalType        |
| `src_buffer`  | ::equeue::ContainerType     |
| `dest_buffer` | ::equeue::ContainerType     |
| `dma`         | ::MLIR::I32                 |
| `offset`      | Variadic\<::equeue::Index\> |

##### Results:

| **Result** | **Description**      |
| ---------- | -------------------- |
| `done`     | ::equeue::SignalType |



### Control Operations (AsyncOpTrait, ControlOpTrait)

Equeue dialect also has control operations as one kind of event operations to generate control signal information. The control operation lives inside a `equeue.launch` body and is pushed to event queue of the launching device of `equeue.launch`.

#### `equeue.control_start`(equeue::ControlStartOp)

Returns a immediate done signal. The event takes no time.

```MLIR
%start = "equeue.control_start"():()->!equeue.signal
//then a launch operation relying on nothing can start execution
%done, %dram_buffer = equeue.launch (%1 = %sram_buffer: !equeue.container<tensor<5xf32>, i32> ) 
in (%start, %core_device) : tensor<5xf32>
{
	%3 = "equeue.read"(%1):(!equeue.container<tensor<5xf32>, i32>)-> tensor<5xf32>
	"equeue.return"(%3):(tensor<5xf32>)->()
}
```

##### Results:

| **Result** | **Description**      |
| ---------- | -------------------- |
| `done`     | ::equeue::SignalType |

#### `equeue.control_and`(equeue::ControlAndOp)

Takes in variable number of signal operands and returns a done signal when all events represented by input signals are done.

```MLIR
%3 = "equeue.control_and"(%1, %2):(!equeue.signal, !equeue.signal)->!equeue.signal
```

##### Operands:

| Operand   | **Description**                  |
| --------- | -------------------------------- |
| `signals` | Variadic\<::equeue::SignalType\> |

##### Results:

| **Result** | **Description**      |
| ---------- | -------------------- |
| `done`     | ::equeue::SignalType |

#### `equeue.control_or`(equeue::ControlOrOp)

Takes in variable number of signal operands and returns a done signal when any event represented by the input signal is done.

```MLIR
%3 = "equeue.control_or"(%1, %2):(!equeue.signal, !equeue.signal)->!equeue.signal
```

##### Operands:

| Operand   | **Description**                  |
| --------- | -------------------------------- |
| `signals` | Variadic\<::equeue::SignalType\> |

##### Results:

| **Result** | **Description**      |
| ---------- | -------------------- |
| `done`     | ::equeue::SignalType |



### The Bridge 

The execution inside the launch body is sequential. The event operations are executed asynchronously. Then if the sequential execution operation would like to be executed after certain event is done, how to synchronize them?

#### `equeue.await`(equeue::AwaitOpOp)

Takes in variable number of signal operands. 

The `equeue.await` operation is executed sequentially as normal sequential operation, i.e. it is not pushed to any event queue. However, it blocks on signal operands before the signal is actually generated, namely, the event the signal represents finishes. In this way, the out of order execution of concurrent devices can communicate with sequential execution of current device.

```MLIR
"equeue.await"(%1, %2):(!equeue.signal, !equeue.signal) -> ()
// e.g. sometime return may want to wait for certain launching block finishs
"equeue.return"(%3):(tensor<5xf32>)->()
```

##### Operands:

| Operand   | **Description**                  |
| --------- | -------------------------------- |
| `signals` | Variadic\<::equeue::SignalType\> |

















