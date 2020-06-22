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
def EQueue_ContainerType :
    Type<CPred<"$_self.isa<EQueueContainerType>()">, "equeue container type">;


//def EQueue_MemRegister : StrEnumAttrCase<"register">;
def EQueue_MemSRAM : StrEnumAttrCase<"SRAM">;
def EQueue_MemDRAM : StrEnumAttrCase<"DRAM">;

def EQueue_CreateMemOpAttr : StrEnumAttr<"CreateMemOpAttr",
    "built-in reduction memory type supported by create memory operation",
    [
//			EQueue_MemRegister,
			EQueue_MemSRAM,
			EQueue_MemDRAM
		]>{
			let cppNamespace = "xilinx::equeue";
		
		}
//structure creation operations
def EQueue_CreateMemOp : EQueue_Op<"create_mem", [NoSideEffect, StructureOpTrait]> {
    let summary = "Create memeory component.";
    let description = [{
        The `equeue.create_mem` operation takes in an input of memref type to generate a memory of that size and type attribute to determine the type of the memory. It uses an operation trait to declare that it has no side effects.

        This operation takes an shape and returns a reference to memory.

        Example:

        ```mlir
        %0 = "equeue.create_mem"(){type = "register"}:(memref<16xf32>)->i32
        ```
    }];

    let arguments = (ins I64ElementsAttr:$shape, StrAttr:$data, EQueue_CreateMemOpAttr:$type);
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

    let arguments = (ins EQueue_CreateProcOpAttr:$type);
    let results = (outs I32:$res);
		let parser = [{ return ::parse$cppClass(parser, result); }];
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
        %dma = "equeue.create_dma"():()->i32
        ```
    }];

    let results = (outs I32:$res);
}

def EQueue_CreateCompOp : EQueue_Op<"create_comp", [NoSideEffect, StructureOpTrait]> {
    let summary = "Create component with sub-coponents.";
    let description = [{
        The `equeue.create_comp` operation takes in multiple sub-components to generate a component.  
        This operation takes an i32 address and returns an i32 address.

        Example:

        ```mlir
        %0 = affine.alloc():memref<16xf32>
        // Apply the foo operation to %0
        %1 = "equeue.create_mem"(%0){type = "register"}:(memref<16xf32>)->i32
				%gpu = "equeue.create_comp"(%1):(i32)->i32
        ```
    }];

    let arguments = (ins Variadic<I32>:$size);
    let results = (outs I32:$res);
}
def AnyScalarOrTensor : TypeConstraint<Or<[AnySignlessInteger.predicate,
                                           AnyFloat.predicate,
                                           AnyTensor.predicate]>,
                                       "scalar-or-tensor">;
// memory operations
//TODO: parse I32
def EQueue_MemAllocOp: EQueue_Op<"alloc"> {
	let summary = "Alloc memory of given size on memory component.";
	let arguments = (ins I32:$mem, I64ElementsAttr :$shape, StrAttr:$data);
	let results = (outs EQueue_ContainerType: $buffer);
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
	let arguments = (ins Variadic<EQueue_ContainerType>: $buffer);
	let parser = [{ return ::parse$cppClass(parser, result); }];
}

def EQueue_MemWriteOp : EQueue_Op<"write"> {
    let summary = "Assign memeory component with value.";
    let description = [{
        The `equeue.assign_mem` operation takes in an memref data and a i32 adress pointing a memory component to generate a memory containing that piece of data
        
				This operation takes in a memref data and an i32 address and then returns container type to the memory.

        Example:

        ```mlir
        %size = affine.alloc():memref<16xf32>
				%value = affine.alloc():memref<16xf32>
        %start = "equeue.control_start"():()->index
        %1 = "equeue.create_mem"(%size){type = "register"}:(memref<16xf32>)->i32
        %2, %3 = "equeue.write"(%start, %value, %1):(index, memref<16xf32>, i32)->(index, container<memref<16xf32>, i32>>)
				```
    }];

    let arguments = (ins AnyScalarOrTensor: $value, EQueue_ContainerType: $buffer);
    let extraClassDeclaration = [{
      Value getBuffer(){
        return getOperand(1);
      };
	  }];

}

def EQueue_MemReadOp : EQueue_Op<"read", [NoSideEffect]> {
    let summary = "read data from container at certain index.";
    
    let arguments = (ins EQueue_ContainerType: $container, Variadic<Index>:$index);
    let results = (outs AnyScalarOrTensor: $res);
    let extraClassDeclaration = [{
      Value getBuffer(){
        return getOperand(0);
      };
      operand_range getIndex(){
        return {operand_begin() + 1, operand_end()};
      }
      bool hasOffset(){
        return !getIndex().empty();
      }
	  }];
}

def EQueue_MemCopyOp : EQueue_Op<"memcpy", [AsyncOpTrait]> {
    let summary = "Copy data on one memeory component to another memory component.";
    
    let arguments = (ins EQueue_SignalType: $start, EQueue_ContainerType: $src_buffer, EQueue_ContainerType: $dest_buffer, I32:$dma, Optional<Index>:$offset);
    let results = (outs EQueue_SignalType: $done);
		let extraClassDeclaration = [{
			Value getDMAHandler(){
				return getOperand(3);
			};
			Value getSrcBuffer(){
				return getOperand(1);
			};
			Value getDestBuffer(){
				return getOperand(2);
			};
		}];
}



// signal manupulation
def EQueue_ControlStartOp : EQueue_Op<"control_start", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
    let summary = "Create a start signal";
    
    let results = (outs EQueue_SignalType: $done);
}

def EQueue_ControlOrOp : EQueue_Op<"control_or", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
    let summary = "Logical or for input signals";
    
    let arguments = (ins Variadic<EQueue_SignalType>: $signals);
    let results = (outs EQueue_SignalType: $done);
}
def EQueue_ControlAndOp : EQueue_Op<"control_and", [NoSideEffect, ControlOpTrait, AsyncOpTrait]> {
    let summary = "Logical and for input signals";
    
    let arguments = (ins Variadic<EQueue_SignalType>: $signals);
    let results = (outs EQueue_SignalType: $done);
}
def EQueue_AwaitOp : EQueue_Op<"await", [NoSideEffect]> {
    let summary = "A barrier to communicate asynchronous call and synchronous call";    
    let arguments = (ins Variadic<EQueue_SignalType>: $signals);
}
def EQueue_ReturnOp: EQueue_Op<"return", 
		[NoSideEffect, Terminator]>{

  let arguments = (ins Variadic<AnyType>:$res);

}
def EQueue_LaunchOp : EQueue_Op<"launch", [SingleBlockImplicitTerminator<"ReturnOp">, IsolatedFromAbove, AsyncOpTrait]> {
  let summary = "launch a device";
  
	let arguments = (ins EQueue_SignalType:$start, I32:$device, Variadic<AnyType>:$operands);
  let results = (outs EQueue_SignalType:$done, Variadic<AnyType>:$res);
  let regions = (region AnyRegion:$region);
	let extraClassDeclaration = [{
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
  //let skipDefaultBuilders = 1;
  //let builders = [
  //  OpBuilder<"OpBuilder &builder, OperationState &result, "
  //            "Value cond, bool withElseRegion">,
  //  OpBuilder<"OpBuilder &builder, OperationState &result, "
  //            "TypeRange resultTypes, Value cond, bool withElseRegion">,
  //  OpBuilder<
  //      "OpBuilder &builder, OperationState &result, TypeRange resultTypes, "
  //      "Value cond, "
  //      "function_ref<void(OpBuilder &, Location)> thenBuilder "
  //      "    = buildTerminatedBody, "
  //      "function_ref<void(OpBuilder &, Location)> elseBuilder = nullptr">,
  //  OpBuilder<
  //      "OpBuilder &builder, OperationState &result, Value cond, "
  //      "function_ref<void(OpBuilder &, Location)> thenBuilder "
  //      "    = buildTerminatedBody, "
  //      "function_ref<void(OpBuilder &, Location)> elseBuilder = nullptr">
  //];

  //let extraClassDeclaration = [{
  //  OpBuilder getThenBodyBuilder() {
  //    Block* body = getBody();
  //    return results().empty() ? OpBuilder::atBlockTerminator(body)
  //                             : OpBuilder::atBlockEnd(body);
  //  }
  //}];
}

#endif // EQUEUE_OPS
