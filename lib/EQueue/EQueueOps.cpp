//===- EQueueOps.cpp - EQueue dialect ops ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#include <iostream>
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueTraits.h"
#include "mlir/Dialect/Shape/IR/Shape.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Dialect/Traits.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/AffineMap.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/Function.h"
#include "mlir/IR/FunctionImplementation.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/EDSC/Builders.h"

#include "llvm/ADT/SmallString.h"
#include "llvm/Support/raw_ostream.h"

using namespace mlir;
using namespace equeue;

//===----------------------------------------------------------------------===//
// CreateDMAOp 
//===-------------------------------------------------
//===----------------------------------------------------------------------===//
void CreateDMAOp::build(Builder builder, OperationState &result) {
	//result.addAttribute("name", builder.getStringAttr(name));
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}

//===----------------------------------------------------------------------===//
// CreateMemOp 
//===----------------------------------------------------------------------===//
void CreateMemOp::build(Builder builder, OperationState &result, 
	ArrayRef<int64_t> shape, int64_t data_bit, StringRef type, int64_t banks) {
	//result.addAttribute("name", builder.getStringAttr(name));
	//TODO: depend on input type
	result.addAttribute("shape", builder.getI64TensorAttr(shape));
	result.addAttribute("data_bit", builder.getI64IntegerAttr(data_bit));
	result.addAttribute("type", builder.getStringAttr(type));
	result.addAttribute("banks", builder.getI64IntegerAttr(banks));
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}

static ParseResult parseCreateMemOp(OpAsmParser &parser,
                                     OperationState &result) {
	Builder &builder = parser.getBuilder();
	auto i32Type = IntegerType::get(32, builder.getContext());
	Attribute extentsRaw, ports;
  StringRef name, data, type;
  //int64_t rports, wports;
	NamedAttrList dummy;
	if ( //parser.parseKeyword(&name) || parser.parseComma() || 
	    parser.parseAttribute(extentsRaw, "shape", dummy) || 
			parser.parseComma() || parser.parseKeyword(&data) || 
			parser.parseComma() || parser.parseKeyword(&type) ||
			//parser.parseComma() || parser.parseAttribute(ports, "banks", result.attributes) ||
			parser.parseComma() || parser.parseAttribute(ports, "banks", result.attributes) ) 
			
		return failure();
	auto extentsArray = extentsRaw.dyn_cast<ArrayAttr>();
	if (!extentsArray)
		return failure();
	SmallVector<int64_t, 6> ints;
	for (Attribute extent : extentsArray) {
		IntegerAttr attr = extent.dyn_cast<IntegerAttr>();
		if (!attr)
		return failure();
		ints.push_back(attr.getInt());
	}
	//result.addAttribute("name",  builder.getStringAttr(name));
	result.addAttribute("shape", builder.getI64TensorAttr(ints));
	result.addAttribute("data", builder.getStringAttr(data));
	result.addAttribute("type", builder.getStringAttr(type));
	//auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
	return success();
}


//===----------------------------------------------------------------------===//
// CreateProcOp 
//===----------------------------------------------------------------------===//
void CreateProcOp::build(Builder builder, OperationState &result, 
  StringRef type) {
	//result.addAttribute("name", builder.getStringAttr(name));
	result.addAttribute("type", builder.getStringAttr(type));
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}
static ParseResult parseCreateProcOp(OpAsmParser &parser,
                                     OperationState &result) {
	StringRef type;
	if ( //parser.parseKeyword(&name) || parser.parseComma() || 
	  parser.parseKeyword(&type) )
		return failure();

	Builder &builder = parser.getBuilder();
  //result.addAttribute("name", parser.getBuilder().getStringAttr(name));
  result.addAttribute("type", parser.getBuilder().getStringAttr(type));
  auto i32Type = IntegerType::get(32, builder.getContext());
  result.types.push_back(i32Type);
	return success();
}

//===----------------------------------------------------------------------===//
// ConnectionOp 
//===----------------------------------------------------------------------===//
void ConnectionOp::build(Builder builder, OperationState &result, StringRef type, int64_t bandwidth) {
	result.addAttribute("type", builder.getStringAttr(type));
	result.addAttribute("bandwidth", builder.getI64IntegerAttr(bandwidth));
	
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}

//===----------------------------------------------------------------------===//
// CreateCompOp 
//===----------------------------------------------------------------------===//
void CreateCompOp::build(Builder builder, OperationState &result, ArrayRef<std::string> names, ValueRange comps) {
  std::string name_attr;
  for (auto n: names){
    name_attr+=n;
    name_attr+=" ";
  }
  result.addOperands(comps);
	result.addAttribute("names", builder.getStringAttr(name_attr));
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}

//===----------------------------------------------------------------------===//
// AddCompOp 
//===----------------------------------------------------------------------===//
void AddCompOp::build(Builder builder, OperationState &result, Value comp, ArrayRef<std::string> names, ValueRange comps) {
  std::string name_attr;
  for (auto n: names){
    name_attr+=n;
    name_attr+=" ";
  }
  result.addOperands(comp);
  result.addOperands(comps);
	result.addAttribute("names", builder.getStringAttr(name_attr));
	//auto i32Type = IntegerType::get(32, builder.getContext());
	//result.types.push_back(i32Type);
}

//===----------------------------------------------------------------------===//
// GetCompOp 
//===----------------------------------------------------------------------===//
void GetCompOp::build(Builder builder, OperationState &result, Value comp, StringRef name) {
  result.addOperands(comp);
	result.addAttribute("name", builder.getStringAttr(name));
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}

void GetCompOp::build(Builder builder, OperationState &result, Value comp, StringRef name, Type resType) {
  result.addOperands(comp);
	result.addAttribute("name", builder.getStringAttr(name));
	result.types.push_back(resType);
}

//===----------------------------------------------------------------------===//
// MemAllocOp 
//===----------------------------------------------------------------------===//
void MemAllocOp::build(Builder builder, OperationState &result, Value mem, 
	ArrayRef<int64_t> shape, int64_t data_bit, Type tensorDataType) {
  result.addOperands(mem);
	result.addAttribute("shape", builder.getI64TensorAttr(shape));
	result.addAttribute("data_bit", builder.getI64IntegerAttr(data_bit));
  auto tensorType =  RankedTensorType::get(
        shape, tensorDataType);
	auto f32Type = FloatType::getF32(builder.getContext());
	auto memrefType = MemRefType::get(shape, f32Type, {}, 0);
	result.types.push_back(memrefType);
}

static ParseResult parseMemAllocOp(OpAsmParser &parser,
                                     OperationState &result) {
	Builder &builder = parser.getBuilder();
  OpAsmParser::OperandType mem;
  Attribute extentsRaw;
  StringRef data;
	NamedAttrList dummy;
	auto i32Type = IntegerType::get(32, builder.getContext());
  Type resType;
	if ( parser.parseOperand(mem) || parser.parseComma() ||
		parser.resolveOperand(mem, i32Type, result.operands) || 
		parser.parseAttribute(extentsRaw, "shape", dummy) ||
		parser.parseComma() ||
		parser.parseKeyword(&data) ||
		parser.parseColon() ||
		parser.parseType(resType) ) 
    return failure();
	result.addAttribute("data", parser.getBuilder().getStringAttr(data));
	result.types.push_back(resType);
	auto extentsArray = extentsRaw.dyn_cast<ArrayAttr>();
	if (!extentsArray)
		return failure();
	SmallVector<int64_t, 6> ints;
	for (Attribute extent : extentsArray) {
		IntegerAttr attr = extent.dyn_cast<IntegerAttr>();
		if (!attr)
		return failure();
		ints.push_back(attr.getInt());
	}
	result.addAttribute("shape", builder.getI64TensorAttr(ints));
	return success();
}
/*
//===----------------------------------------------------------------------===//
// ReferAllocMemOp 
//===----------------------------------------------------------------------===//
void ReferAllocMemOp::build(Builder builder, OperationState &result, Value buffer) {
  result.addOperands(buffer);
	auto I32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(I32Type);
}

//===----------------------------------------------------------------------===//
// DereferAllocMemOp 
//===----------------------------------------------------------------------===//
void DereferAllocMemOp::build(Builder builder, OperationState &result, Value reference, Type bufferType) {
  result.addOperands(reference);
	result.types.push_back(bufferType);
}
*/

//===----------------------------------------------------------------------===//
// MemDeallocOp 
//===----------------------------------------------------------------------===//
void MemDeallocOp::build(Builder builder, OperationState &result, ValueRange buffer) {
  result.addOperands(buffer);
}

static ParseResult parseMemDeallocOp(OpAsmParser &parser,
                                     OperationState &result) {
  Builder &builder = parser.getBuilder();
	//OpAsmParser::OperandType signal;
	//auto signalType = EQueueSignalType::get(builder.getContext());
 	SmallVector<OpAsmParser::OperandType, 16> buffers;
	SmallVector<Type, 16> types;
  if (  //parser.parseOperand(signal) || parser.parseComma() || 
		//parser.resolveOperand(signal, signalType, result.operands) ||
		parser.parseOperandList(buffers) ||  
		parser.parseColonTypeList(types) ||
		parser.resolveOperands(buffers, types, parser.getCurrentLocation(), 
		result.operands) )
    return failure();
	//result.types.push_back(signalType);
	return success();
}

//===----------------------------------------------------------------------===//
// MemWriteOp 
//===----------------------------------------------------------------------===//
void MemWriteOp::build(Builder builder, OperationState &result, Value value, Value buffer, Value connection, ArrayRef<int64_t> size, int64_t bank) {
  result.addOperands(value);
  result.addOperands(buffer);
  if(connection!=Value()){
    result.addOperands(connection);
  }
  if(size!=ArrayRef<int64_t>{}){
	  result.addAttribute("size", builder.getI64TensorAttr(size));
	}
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));
}


void MemWriteOp::build(Builder builder, OperationState &result, Value value, Value buffer, ArrayRef<int64_t> size, int64_t bank) {
  result.addOperands(value);
  result.addOperands(buffer);
  if(size!=ArrayRef<int64_t>{}){
	  result.addAttribute("size", builder.getI64TensorAttr(size));
	}
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));
}


void MemWriteOp::build(Builder builder, OperationState &result, Value value, Value buffer, int64_t bank) {
  result.addOperands(value);
  result.addOperands(buffer);
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));
}
//===----------------------------------------------------------------------===//
// MemReadOp 
//===----------------------------------------------------------------------===//
void MemReadOp::build(Builder builder, OperationState &result, Value buffer, Value connection, ArrayRef<int64_t> size, int64_t bank) {
  result.addOperands(buffer);
  if(connection!=Value()){
    result.addOperands(connection);
  }
  if(size!=ArrayRef<int64_t>{}){
	  result.addAttribute("size", builder.getI64TensorAttr(size));
	}
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));

  auto memrefType = buffer.getType().cast<MemRefType>();
  if(size==ArrayRef<int64_t>{1}){
    result.types.push_back(memrefType.getElementType());
  }else if(size!=ArrayRef<int64_t>{}){
	  result.types.push_back(RankedTensorType::get(memrefType.getShape(), memrefType.getElementType()));
	}else{
	  result.types.push_back(RankedTensorType::get(size, memrefType.getElementType()));
	}
	
}

void MemReadOp::build(Builder builder, OperationState &result, Value buffer, ArrayRef<int64_t> size, int64_t bank) {
  result.addOperands(buffer);
  if(size!=ArrayRef<int64_t>{}){
	  result.addAttribute("size", builder.getI64TensorAttr(size));
	}
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));

  auto memrefType = buffer.getType().cast<MemRefType>();
  if(size==ArrayRef<int64_t>{1}){
    result.types.push_back(memrefType.getElementType());
  }else if(size!=ArrayRef<int64_t>{}){
	  result.types.push_back(RankedTensorType::get(memrefType.getShape(), memrefType.getElementType()));
	}else{
	  result.types.push_back(RankedTensorType::get(size, memrefType.getElementType()));
	}
}

void MemReadOp::build(Builder builder, OperationState &result, Value buffer, int64_t bank) {
  result.addOperands(buffer);
	result.addAttribute("bank", builder.getI64IntegerAttr(bank));

  auto memrefType = buffer.getType().cast<MemRefType>();
	auto tensorType = RankedTensorType::get(memrefType.getShape(), memrefType.getElementType());
	result.types.push_back(tensorType);//tensor
	
}
//===----------------------------------------------------------------------===//
// UnkownSpecificationOp 
//===----------------------------------------------------------------------===//
void UnkownSpecificationOp::build(Builder builder, OperationState &result, uint64_t input_bit, uint64_t output_bit, uint64_t cycle) {
	result.addAttribute("input_bit", builder.getI64IntegerAttr(input_bit));
	result.addAttribute("output_bit", builder.getI64IntegerAttr(output_bit));
	result.addAttribute("cycle", builder.getI64IntegerAttr(cycle));
	
	auto i32Type = IntegerType::get(32, builder.getContext());
	result.types.push_back(i32Type);
}


//===----------------------------------------------------------------------===//
// UnkownOp 
//===----------------------------------------------------------------------===//
void UnkownOp::build(Builder builder, OperationState &result, StringRef op_name, ValueRange inputs, Type resType) {
	result.addAttribute("op_name", builder.getStringAttr(op_name));
	result.addOperands(inputs);
	result.types.push_back(resType);
}



//===----------------------------------------------------------------------===//
// LaunchOp 
//===----------------------------------------------------------------------===//
//XXX(Zhijing): not sure about bodyBuilder yet
// also, why opbuilder, not builder, what's the difference?
void LaunchOp::build(OpBuilder builder, OperationState &result, Value start, Value device,
  ValueRange operands, function_ref<void(OpBuilder &, Location, ValueRange)> bodyBuilder) {
  result.addOperands(start);
  result.addOperands(device);
  result.addOperands(operands);
  Region *bodyRegion = result.addRegion();
  Block *bodyBlock = new Block;
  for(auto operand: operands){
    bodyBlock->addArgument(operand.getType());
  }
  bodyRegion->push_back(bodyBlock);

  
  OpBuilder::InsertionGuard guard(builder);
  builder.setInsertionPointToStart(bodyBlock);
  bodyBuilder(builder, result.location, bodyBlock->getArguments());
  //TODO:verify it is a return op
  Operation *returnOp = bodyBlock->getTerminator();
  
	auto signalType = EQueueSignalType::get(builder.getContext());
	result.types.push_back(signalType); 
	result.types.append(returnOp->getOperands().getTypes().begin(),
	  returnOp->getOperands().getTypes().end());
  
}
static ParseResult parseLaunchOp(OpAsmParser &parser,
                                     OperationState &result) {
	Builder &builder = parser.getBuilder();
	SmallVector<OpAsmParser::OperandType, 8> regionArgs;
	SmallVector<OpAsmParser::OperandType, 10> operands;
	OpAsmParser::OperandType regionArg, device, signal;
	SmallVector<Type, 8> types;
	SmallVector<Type, 8> resTypes;
 	if ( parser.parseLParen() ) return failure();
	
	while (succeeded( parser.parseOptionalRegionArgument(regionArg)) &&
		!regionArg.name.empty()) {
		regionArgs.push_back(regionArg);
		if (failed(parser.parseOptionalComma())) {
			if (parser.parseEqual() || 
				parser.parseOperandList(operands) ||
				parser.parseColonTypeList(types)) 
				return failure();
			break;
		}
	}
	
	if (parser.parseRParen() ||
		parser.parseKeyword("in") ||
		parser.parseLParen() ||
		parser.parseOperand(signal) || 
		parser.parseComma() || 
		parser.parseOperand(device) || 
		parser.parseRParen() ||
		parser.parseOptionalColonTypeList(resTypes))
		return failure();

	Region *body = result.addRegion();
	if (operands.size() != regionArgs.size() || parser.parseRegion(*body, regionArgs, 
			types) )
		return failure();

	operands.insert(operands.begin(), device);
	operands.insert(operands.begin(), signal);

	auto i32Type = IntegerType::get(32, builder.getContext());
	auto signalType = EQueueSignalType::get(builder.getContext());
	types.insert(types.begin(), i32Type);
	types.insert(types.begin(), signalType);
	if ( parser.resolveOperands(operands, types, parser.getCurrentLocation(), 
		result.operands)) 
		return failure();
	result.types.push_back(signalType); 
	result.types.append(resTypes.begin(), resTypes.end()); 
	return success();
}


//===----------------------------------------------------------------------===//
// ReturnOp 
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// MemCopyOp 
//===----------------------------------------------------------------------===//
void MemCopyOp::build(Builder builder, OperationState &result, Value start, Value src_buffer, Value dest_buffer, 
  Value dma, Value connection, ArrayRef<int64_t> size, int64_t src_bank, int64_t dest_bank) {
  result.addOperands(start);
  result.addOperands(src_buffer);
  result.addOperands(dest_buffer);
  result.addOperands(dma);
  if(connection!=Value()){
    result.addOperands(connection);
  }
  //ValueRange offset,  
  //result.addOperands(offset);
  if(size!=ArrayRef<int64_t>{}){
    result.addAttribute("size", builder.getI64TensorAttr(size));
  }
	result.addAttribute("src_bank", builder.getI64IntegerAttr(src_bank));
	result.addAttribute("dest_bank", builder.getI64IntegerAttr(dest_bank));
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}
void MemCopyOp::build(Builder builder, OperationState &result, Value start, Value src_buffer, Value dest_buffer, 
  Value dma, ArrayRef<int64_t> size, int64_t src_bank, int64_t dest_bank) {
  result.addOperands(start);
  result.addOperands(src_buffer);
  result.addOperands(dest_buffer);
  result.addOperands(dma);
  if(size!=ArrayRef<int64_t>{}){
    result.addAttribute("size", builder.getI64TensorAttr(size));
  }
	result.addAttribute("src_bank", builder.getI64IntegerAttr(src_bank));
	result.addAttribute("dest_bank", builder.getI64IntegerAttr(dest_bank));
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}

void MemCopyOp::build(Builder builder, OperationState &result, Value start, Value src_buffer, Value dest_buffer, 
  Value dma, int64_t src_bank, int64_t dest_bank) {
  result.addOperands(start);
  result.addOperands(src_buffer);
  result.addOperands(dest_buffer);
  result.addOperands(dma);
	result.addAttribute("src_bank", builder.getI64IntegerAttr(src_bank));
	result.addAttribute("dest_bank", builder.getI64IntegerAttr(dest_bank));
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}




//===----------------------------------------------------------------------===//
// ControlStartOp 
//===----------------------------------------------------------------------===//
void ControlStartOp::build(Builder builder, OperationState &result) {
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}


//===----------------------------------------------------------------------===//
// ControlAndOp 
//===----------------------------------------------------------------------===//
void ControlAndOp::build(Builder builder, OperationState &result, ValueRange signals) {
  result.addOperands(signals);
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}


//===----------------------------------------------------------------------===//
// ControlOrOp 
//===----------------------------------------------------------------------===//
void ControlOrOp::build(Builder builder, OperationState &result, ValueRange signals) {
  result.addOperands(signals);
	auto signalType = EQueueSignalType::get(builder.getContext());
  result.types.push_back(signalType);
}


//===----------------------------------------------------------------------===//
// AwaitOp 
//===----------------------------------------------------------------------===//
void AwaitOp::build(Builder builder, OperationState &result, ValueRange signals) {
  result.addOperands(signals);
}
namespace equeue {
#define GET_OP_CLASSES
#include "EQueue/EQueueOps.cpp.inc"
} // namespace equeue
