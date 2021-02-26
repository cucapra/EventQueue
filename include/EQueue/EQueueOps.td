//===- EQueueOps.td ----------------------------------------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef EQUEUE_OPS
#define EQUEUE_OPS
include "EQueueDialect.td"

include "mlir/IR/OpBase.td"
include "mlir/Interfaces/ControlFlowInterfaces.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
include "mlir/IR/OpAsmInterface.td"


// Provide a definition for the EQueueSignalType for use in ODS. This allows for
// using EQueueSignalType in a similar way to Tensor or MemRef.
def EQueue_SignalType :
    Type<CPred<"$_self.isa<EQueueSignalType>()">, "equeue signal type">;
// Provide a definition for the EQueueContainerType for use in ODS. This allows for
// using EQueueContainerType in a similar way to Tensor or MemRef.
//def EQueue_ContainerType :
//    Type<CPred<"$_self.isa<EQueueContainerType>()">, "equeue container type">;


def EQueue_MemRegister : StrEnumAttrCase<"RegisterFile">;
def EQueue_MemSRAM : StrEnumAttrCase<"SRAM">;
def EQueue_MemDRAM : StrEnumAttrCase<"DRAM">;
def EQueue_MemSINK : StrEnumAttrCase<"SINK">;//for simulation purpose

def EQueue_CreateMemOpAttr : StrEnumAttr<"CreateMemOpAttr",
    "built-in reduction memory type supported by create memory operation",
    [
			EQueue_MemRegister,
			EQueue_MemSRAM,
			EQueue_MemDRAM,
			EQueue_MemSINK
		]>{
			let cppNamespace = "xilinx::equeue";
		
		}
//structure creation operations
def EQueue_CreateMemOp : EQueue_Op<"create_mem", [NoSideEffect, StructureOpTrait]> {
  let summary = "Create memeory component.";
  let description = [{
    Creates a memory component of the given memory type, data size and data type, 
    and returns a handler to the memory component.

    Example:

    ```mlir
    %1 = equeue.create_mem [1024], f32, SRAM
    ```
  }];

  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ArrayRef<int64_t> shape, int64_t data_bit, StringRef type, int64_t banks=1"
    >
  ];
  let arguments = (ins I64ElementsAttr:$shape, I64Attr:$data_bit, EQueue_CreateMemOpAttr:$type, OptionalAttr<I64Attr>:$banks);
  let results = (outs I32:$res);
  let parser = [{ return ::parse$cppClass(parser, result); }];
  //let skipDefaultBuilders = 1;
  let extraClassDeclaration = [{
    SmallVector<int, 8> getShape(){
      auto attr = getAttr("shape").cast<DenseIntElementsAttr>();
      SmallVector<int, 8> shape(attr.getValues<int64_t>());
      return shape;
    };
    StringRef getDataType(){
      return getAttr("data").cast<StringAttr>().getValue();
    };
    StringRef getMemType(){
      return getAttr("type").cast<StringAttr>().getValue();
    };
    int64_t getBank(){
      if(getAttr("banks")){
        return getAttr("banks").cast<IntegerAttr>().getInt();
      }else{
        return 1;
      }
    };
  }];
}

def EQueue_ProcARMx86 : StrEnumAttrCase<"ARMx86">;
def EQueue_ProcARMr5 : StrEnumAttrCase<"ARMr5">;
def EQueue_ProcMicroPlate : StrEnumAttrCase<"MicroPlate">;
def EQueue_ProcAIEngine : StrEnumAttrCase<"AIEngine">;

def EQueue_CreateProcOpAttr : StrEnumAttr<"CreateProcOpAttr",
    "built-in reduction memory type supported by create memory operation",
    [
			EQueue_ProcARMx86,
			EQueue_ProcARMr5,
			EQueue_ProcMicroPlate,
			EQueue_ProcAIEngine
		]>{
			let cppNamespace = "xilinx::equeue";
		}

def EQueue_CreateProcOp : EQueue_Op<"create_proc", [NoSideEffect, StructureOpTrait]> {
  let summary = "Create processor component.";
  let description = [{
    Creates a processor component of the given processor type, 
    and returns a handler to the processor component.

    Example:

    ```mlir
    %1 = equeue.create_proc Kernel, ARMr5
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, StringRef type">];
  let arguments = (ins EQueue_CreateProcOpAttr:$type);
  let results = (outs I32:$res);
  let parser = [{ return ::parse$cppClass(parser, result); }];
  //let skipDefaultBuilders = 1;
}


def EQueue_Streaming : StrEnumAttrCase<"Streaming">;
def EQueue_Window : StrEnumAttrCase<"Window">;

def EQueue_ConnectionOpAttr : StrEnumAttr<"ConnectionOpAttr",
    "built-in connection type",
    [
			EQueue_Streaming,
			EQueue_Window
		]>{
			let cppNamespace = "xilinx::equeue";
		}


def EQueue_ConnectionOp : EQueue_Op<"connection", [NoSideEffect, StructureOpTrait]> {
  let summary = "Connect components.";
  let description = [{
    Connects components and set bandwidth.
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, StringRef type, int64_t bandwidth = -1">];
  let arguments = (ins EQueue_ConnectionOpAttr:$type, OptionalAttr<I64Attr>:$bandwidth);
  let results = (outs I32:$res);
  //let skipDefaultBuilders = 1;
}


def EQueue_CreateDMAOp : EQueue_Op<"create_dma", [NoSideEffect, StructureOpTrait]> {
  let summary = "Create DMA component.";
  let description = [{
    The `equeue.create_dma` operation creates a dma on demands.

    This operation takes no input and returns an i32 address.

    Example:

    ```mlir
    // Apply the foo operation to %0
    %dma = "equeue.create_dma"(){}:()->i32
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result">];
  //let arguments = (ins StrAttr:$name);
  let results = (outs I32:$res);
}


def EQueue_CreateCompOp : EQueue_Op<"create_comp_field", [NoSideEffect, StructureOpTrait]> {
  let summary = "Create component with sub-coponents.";
  let description = [{
    The operation takes variable number of operands representing component handlers.
    It creates a component made of input component handlers, and returns a handler 
    to the component.

    Example:

    ```mlir
    %accel_mem = equeue.create_mem Mem, [64], f32, SRAM
    %accel_core = equeue.create_proc Kernel, ARMr5
    %accel_dma = "equeue.create_dma"(){}:()->i32
    %accel = "equeue.create_comp_field"(%accel_core, %accel_dma, %accel_mem){name = "core dma mem"}:(i32, i32, i32) -> i32
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ArrayRef<std::string> names, ValueRange comps">];
  //AnyType with a name is fine
  let arguments = (ins StrAttr:$names, Variadic<AnyType>:$comps);
  let results = (outs I32:$res);  
  let extraClassDeclaration = [{
		StringRef getNames(){
			return getAttr("names").cast<StringAttr>().getValue();
		};
		
    Value getNamedComp(std::string structName){
      std::string comp_names = getNames().str();
      std::istringstream iss(comp_names);
      std::vector<std::string> tokens;
      copy(std::istream_iterator<std::string>(iss),
           std::istream_iterator<std::string>(),
           std::back_inserter(tokens));
      int i = 0;
      Value match_comp;
      for(auto token: tokens){
        if(token==structName){
          match_comp = getOperand(i);
          i++;
        }
      }
      return match_comp;
    };
    
	}];
}

def EQueue_AddCompOp : EQueue_Op<"add_comp_field", [NoSideEffect, StructureOpTrait]> {
  let summary = "Add sub-coponents to existing component.";
  let description = [{
    The operation takes a component reference and a variable number of operands representing component handlers.
    It adds field to existing component or modify existing a component field and returns nothing.

    Example:

    ```mlir
    %accel_mem = equeue.create_mem Mem, [64], f32, SRAM
    %accel_core = equeue.create_proc Kernel, ARMr5
    %accel = "equeue.create_comp_field"(%accel_core, %accel_dma, %accel_mem){name = "core dma"}:(i32, i32, i32) -> i32
    %accel_dma = "equeue.create_dma"(){name = "DMA"}:()->i32
    "equeue.add_comp_field"(%accel, %accel_mem){name = "mem"}:(i32, i32) -> ()
    
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value comp, ArrayRef<std::string> names, ValueRange comps">];

  let arguments = (ins I32: $comp, StrAttr:$names, Variadic<AnyType>:$comps);
  //let results = (outs I32:$res);
  let extraClassDeclaration = [{
		StringRef getNames(){
			return getAttr("names").cast<StringAttr>().getValue();
		};
	}];
		
}

def EQueue_GetCompOp : EQueue_Op<"get_comp_field", [NoSideEffect, StructureOpTrait]> {
  let summary = "Get component from a composed component.";
  let description = [{
    The operation takes variable number of operands representing component handlers.
    It creates a component made of input component handlers, and returns a handler 
    to the component.

    Example:

    ```mlir
    %accel_mem = equeue.create_mem [64], f32, SRAM
    %accel_core = equeue.create_proc ARMr5
    %accel_dma = "equeue.create_dma"():()->i32
    %accel = "equeue.create_comp"(%accel_core, %accel_dma, %accel_mem){name = "core DMA mem"}:(i32, i32, i32) -> i32
    %get_dma = "equeue.get_comp_field"(%accel_dma) {name = "DMA"}:(i32) -> i32
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value comp, StringRef name">, 
    OpBuilder<
    "Builder builder, OperationState &result, Value comp, StringRef name, Type resType">];
  let arguments = (ins I32:$comp, StrAttr:$name);
  let results = (outs AnyType:$res);
  let extraClassDeclaration = [{
		StringRef getName(){
			return getAttr("name").cast<StringAttr>().getValue();
		};
    Value getCompHandler(){
      return getOperand();
    };
  }];
}

def AnyScalarOrTensor : TypeConstraint<Or<[AnySignlessInteger.predicate,
                                           AnyFloat.predicate,
                                           AnyTensor.predicate]>,
                                       "scalar-or-tensor">;
// memory operations
def EQueue_MemAllocOp: EQueue_Op<"alloc"> {
	let summary = "Alloc memory of given size on memory component.";
  let description = [{
    Returns a buffer representing a reference to a particular memory space. 
    This operation takes in a memory handler as operand. Together with attributes 
    of memory buffer, the operation models a buffer allocation process and 
    returns a buffer.

    Example:

    ```mlir
    %1 = equeue.create_mem [1024], f32, SRAM
    %2 = equeue.alloc %1, [5], f32 : memref<5xf32>
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value mem, ArrayRef<int64_t> shape," 
    "int64_t data_bit, Type tensorDataType"
	>];
	let arguments = (ins I32:$mem, I64ElementsAttr :$shape, I64Attr:$dat_bita);
	let results = (outs AnyMemRef: $buffer);
	let parser = [{ return ::parse$cppClass(parser, result); }];
  let extraClassDeclaration = [{
		SmallVector<int, 8> getShape(){
		  auto attr = getAttr("shape").cast<DenseIntElementsAttr>();
      SmallVector<int, 8> shape(attr.getValues<int64_t>());
      return shape;
		};
		StringRef getDataType(){
			return getAttr("data").cast<StringAttr>().getValue();
		};
    Value getMemHandler(){
      return getOperand();
    }
	}];
}



def EQueue_MemDeallocOp: EQueue_Op<"dealloc"> {
	let summary = "Dealloc memory of given size on memory component.";
  let description = [{
    Deallocate a buffer (or more) and the space reserved for the buffer on 
    the memory it refers to.

    Example:

    ```mlir
    %1 = equeue.create_mem [1024], f32, SRAM
    %2 = equeue.alloc %1, [5], f32 : memref<5xf32>
    equeue.dealloc %2: memref<5xf32>
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ValueRange buffer"
	>];
	let arguments = (ins Variadic<AnyMemRef>: $buffer);
	let parser = [{ return ::parse$cppClass(parser, result); }];
}

def EQueue_MemReadOp : EQueue_Op<"read", [NoSideEffect]> {
  let summary = "read data from buffer at certain index.";
  let description = [{
    This operation takes in a memory buffer and an offset of variable number.
    Returns the value read from the buffer given certain offset 

    Example:
    ```mlir
    %value = "equeue.read" (%buffer, %j):(memref<5xf32>, index)->f32 
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value buffer, Value connection = Value(), ArrayRef<int64_t> size = {}, int64_t bank = 0"
	>];
	//Ignore Variadic<Index>:$offset at this moment
  let arguments = (ins AnyMemRef: $buffer, Optional<I32>: $connection, OptionalAttr<I64ElementsAttr>: $size, OptionalAttr<I64Attr>: $bank);
  let results = (outs AnyScalarOrTensor: $res);
  let extraClassDeclaration = [{
    Value getBuffer(){
      return getOperand(0);
    };
    int64_t getBank(){
      if(getAttr("bank")){
        return getAttr("bank").cast<IntegerAttr>().getInt();
      }else{
        return 0;
      }
    };
    
    operand_range getIndex(){
    //TODO:UPDATE OFFSET
      return {operand_begin(), operand_end()};
    };
    bool hasOffset(){
    //TODO:properly define offset operations
      return false;
    };
  }];
}


def EQueue_MemWriteOp : EQueue_Op<"write"> {
  let summary = "Assign memeory component with value.";
  let description = [{
    This operation takes in a value of any tensor or scalar type, together a memory buffer. 
    It writes a value to a memory buffer. 

    Example:
    ```mlir
    %1 = equeue.create_mem [1024], f32, SRAM
    %2 = equeue.alloc %1, [1], f32 : memref<f32, i32>
    %3 = std.constant 10: f32
    "equeue.write"(%3, %2): (f32, memref<f32, i32>)->()
    ```
  }];

  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value value, Value buffer, Value connection = Value(), int64_t bank = 0"
	>];
  let arguments = (ins AnyScalarOrTensor: $value, AnyMemRef: $buffer, Optional<I32>: $connection, OptionalAttr<I64Attr>: $bank);
  let extraClassDeclaration = [{
    Value getBuffer(){
      return getOperand(1);
    };
    int64_t getBank(){
      if(getAttr("bank")){
        return getAttr("bank").cast<IntegerAttr>().getInt();
      }else{
        return 0;
      }
    };
  }];

}


//unknown op
def EQueue_UnkownSpecificationOp : EQueue_Op<"unkSpecOp", [NoSideEffect, StructureOpTrait]> {
  let summary = "Unknown operation specification.";
  let description = [{
    Unkown operation specification on input/output bits, cycle to compute.
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, uint64_t input_bit, uint64_t output_bit, uint64_t cycle">];
  let arguments = (ins I64Attr: $input_bit, I64Attr: $output_bit, I64Attr:$cycle);
  let results = (outs I32:$res);
  //let skipDefaultBuilders = 1;
}


//unknown op
def EQueue_UnkownOp : EQueue_Op<"unkOp", [NoSideEffect]> {
  let summary = "Unknown operation.";
  let description = [{
    Unkown operation with specification.
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, StringRef op_name, ValueRange inputs, Type resType">];
  let arguments = (ins StrAttr:$op_name, Variadic<AnyType>:$inputs);
  let results = (outs AnyType:$res);
  //let skipDefaultBuilders = 1;
  let extraClassDeclaration = [{
		StringRef getOpName(){
			return getAttr("op_name").cast<StringAttr>().getValue();
		};
	}];
}










// IsolatedFromAbove,
def EQueue_LaunchOp : EQueue_Op<"launch", [SingleBlockImplicitTerminator<"ReturnOp">, AsyncOpTrait]> {
  let summary = "launch a device";
  let description = [{
    Returns a signal representing a event is finished, whose type is `::equeue::SignalType`, 
    as well as variable number of results from `equeue.return` operation.
    
    The first two operands `equeue.launch`operation takes in is a signal to start the event 
    and the device the event is launched on. The other operands are all resources are passed 
    to the device, representing the device has gained control over the resources.

    The operation also takes in a region as input operand, or equivalently, launch body. 
    Inside the launch body, operations are executed sequentially with a program counter to 
    denote the execution state. Event queue of corresponding dialect prevents the asynchronous 
    event operations block the sequential execution.

    Example:
    ```mlir
    %done = equeue.launch (%1, %2, %3, %4 = %act_mem, %weight_mem, %ofmap_mem, %k: 
    memref<5xf32>, memref<5xf32>, 
    memref<5xf32>, index) 
    in (%start, %core_device)  
    {
      %c0 = constant 0.0:f32
      "equeue.write"(%c0, %3): (f32, memref<5xf32>)->()
      %cst0 = constant 0:index
      %cst1 = constant 1:index
      %cst5 = constant 2:index
      scf.for %i = %cst0 to %cst5 step %cst1 {
        %j = affine.apply affine_map<(d0,d1)->(d0+d1)>(%offset,%i)
        %ifmap = "equeue.read" (%1,%j):(memref<5xf32>, index)->f32 
        %filter = "equeue.read" (%2,%i):(memref<5xf32>, index)->f32 
        %ofmap = "equeue.read" (%3):(memref<5xf32>) -> f32
        %psum = mulf %filter, %ifmap: f32
        %ofmap_flight = addf %ofmap, %psum: f32

        "equeue.write"( %ofmap_flight, %3):(f32, memref<5xf32>)->()
        "scf.yield"():()->()
      }	
      "equeue.return"():()->()
    }
    ```
  }];
  let builders = [OpBuilder<
    "OpBuilder builder, OperationState &result, Value start, Value device, ValueRange operands, " 
    "function_ref<void(OpBuilder &, Location, ValueRange)> bodyBuilder"
	>];
	let arguments = (ins EQueue_SignalType:$start, I32:$device, Variadic<AnyType>:$operands);
  let results = (outs EQueue_SignalType:$done, Variadic<AnyType>:$res);
  let regions = (region AnyRegion:$region);
	let extraClassDeclaration = [{
    using BodyBuilderFn =
        function_ref<void(OpBuilder &, Location, ValueRange)>;
        
		Value getStartSignal(){
			return getOperand(0);
		};
		Value getDeviceHandler(){
			return getOperand(1);
		};
    operand_range getLaunchOperands(){
      return {operand_begin() + 2, operand_end()};
    }
  }];
	let parser = [{ return parse$cppClass(parser, result); }];
}

def EQueue_ReturnOp: EQueue_Op<"return", 
		[NoSideEffect, Terminator]>{
  let summary = "explicit terminator of  `equeue.launch` launch body";
  let description = [{
    Takes in variable number of operands and passes to `equeue.launch` operation as results.
    Returns nothing. 

    Example:
    ```mlir
    %done, %dram_buffer = equeue.launch (%1 = %sram_buffer: !equeue.container<tensor<5xf32>, i32>) 
    in (%start, %core_device) : tensor<5xf32>
    {
      %3 = "equeue.read"(%1):(!equeue.container<tensor<5xf32>, i32>)-> tensor<5xf32>
      "equeue.return"(%3):(tensor<5xf32>)->()
    }
    ```
  }];
  let skipDefaultBuilders=1;
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ValueRange res", [{
      result.addOperands(res);
  }]>
  ];
  let arguments = (ins Variadic<AnyType>:$res);

}

def EQueue_MemCopyOp : EQueue_Op<"memcpy", [AsyncOpTrait]> {
  let summary = "Copies value from one buffer to the other.";
  let description = [{
    Returns a signal representing a event is finished, whose type is `::equeue::SignalType`. 
    The first operand it takes in is a start signal, then the source buffer, destination buffer 
    and the device that launching the event, usually a DMA. It can also take in variable number 
    of offset.

    Example:
    ```mlir
    %done = "equeue.memcpy"(%start, %src_buffer, %dest_buffer, %dma): (!equeue.signal, 
    memref<5xf32>, memref<5xf32>) -> 
    !equeue.signal		
    ```

    This is completely equivalent to the following code rewritten with `equeue.launch`, but 
    `equeue.memcpy` is more concise, i.e. `equeue.memcpy` is the syntactic sugar for 
    `equeue.launch` on a particular device with only read and write operations in the launch body.
    
    Example:
    ```mlir
    %done = equeue.launch (%1, %2 = %sram_buffer, %dram_buffer: 
    memref<5xf32>, memref<5xf32>, i32>) 
    in (%start, %dma)  
    {
      %3 = "equeue.read"(%1):(memref<5xf32>)-> tensor<5xf32>
      "equeue.write"( %3, %1):(tensor<5xf32>, memref<5xf32>)->()
      "equeue.return"():()->()
    }	
    ```
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, Value start, Value src_buffer, Value dest_buffer, Value dma, Value connection = Value(),"
    " ArrayRef<int64_t> size = {}, int64_t src_bank = 0, int64_t dest_bank = 0"
	>];
  let arguments = (ins EQueue_SignalType: $start, AnyMemRef: $src_buffer, AnyMemRef: $dest_buffer, I32:$dma, I32: $connection, OptionalAttr<I64ElementsAttr>: $size,
  OptionalAttr<I64Attr>: $src_bank, OptionalAttr<I64Attr>: $dest_bank);
  let results = (outs EQueue_SignalType: $done);
  let extraClassDeclaration = [{
    Value getDMAHandler(){
      return getOperand(3);
    };
    //temporary
    operand_range getIndex(){
      return {operand_begin() + 4, operand_end()};
    };
    /*
    bool hasOffset(){
      return !getIndex().empty();
    };*/
    Value getSrcBuffer(){
      return getOperand(1);
    };
    Value getDestBuffer(){
      return getOperand(2);
    };
    int64_t getSrcBank(){
      if(getAttr("src_bank")){
        return getAttr("src_bank").cast<IntegerAttr>().getInt();
      }else{
        return 0;
      }
    };
    int64_t getDestBank(){
      if(getAttr("dest_bank")){
        return getAttr("dest_bank").cast<IntegerAttr>().getInt();
      }else{
        return 0;
      }
    };
  }];
}



// signal manupulation
def EQueue_ControlStartOp : EQueue_Op<"control_start", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
  let summary = "Create a start signal";
  let description = [{
    Returns a immediate done signal. The event takes no time.
    
    Example:
    ```mlir
    %start = "equeue.control_start"():()->!equeue.signal
    //then a launch operation relying on nothing can start execution
    %done, %dram_buffer = equeue.launch (%1 = %sram_buffer: !equeue.container<tensor<5xf32>, i32> ) 
    in (%start, %core_device) : tensor<5xf32>
    {
      %3 = "equeue.read"(%1):(!equeue.container<tensor<5xf32>, i32>)-> tensor<5xf32>
      "equeue.return"(%3):(tensor<5xf32>)->()
    }
    ``` 
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result"
	>];
  let results = (outs EQueue_SignalType: $done);
}

def EQueue_ControlAndOp : EQueue_Op<"control_and", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
  let summary = "Logical AND for input signals";
  let description = [{
    Takes in variable number of signal operands and returns a done signal when all 
    events represented by input signals are done.
    
    Example:
    ```mlir
    %3 = "equeue.control_and"(%1, %2):(!equeue.signal, !equeue.signal)->!equeue.signal
    ``` 
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ValueRange signals"
	>];
  let arguments = (ins Variadic<EQueue_SignalType>: $signals);
  let results = (outs EQueue_SignalType: $done);
}
def EQueue_ControlOrOp : EQueue_Op<"control_or", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
  let summary = "Logical OR for input signals";
  let description = [{
    Takes in variable number of signal operands and returns a done signal when any event 
    represented by the input signal is done.

    Example:
    ```mlir
    %3 = "equeue.control_or"(%1, %2):(!equeue.signal, !equeue.signal)->!equeue.signal
    ``` 
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ValueRange signals"
	>];
  let arguments = (ins Variadic<EQueue_SignalType>: $signals);
  let results = (outs EQueue_SignalType: $done);
}
//await 
def EQueue_AwaitOp : EQueue_Op<"await", [NoSideEffect]> {
  let summary = "A barrier to communicate asynchronous call and synchronous call";    
  let description = [{
    Takes in variable number of signal operands. 
    The `equeue.await` operation is executed sequentially as normal sequential operation, 
    i.e. it is not pushed to any event queue. However, it blocks on signal operands before 
    the signal is actually generated, namely, the event the signal represents finishes. 
    In this way, the out of order execution of concurrent devices can communicate with sequential 
    execution of current device.
    
    Example:
    ```mlir
    "equeue.await"(%1, %2):(!equeue.signal, !equeue.signal) -> ()
    // e.g. sometime return may want to wait for certain launching block finishs
    "equeue.return"(%3):(tensor<5xf32>)->()
    ``` 
  }];
  let builders = [OpBuilder<
    "Builder builder, OperationState &result, ValueRange signals"
	>];
  let arguments = (ins Variadic<EQueue_SignalType>: $signals);
}

#endif // EQUEUE_OPS
