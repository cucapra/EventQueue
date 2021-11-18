//===- EQueueDialect.cpp - EQueue dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "mlir/IR/DialectImplementation.h"

using namespace mlir;

//===----------------------------------------------------------------------===//
// EQueue dialect.
//===----------------------------------------------------------------------===//


namespace equeue {


namespace detail {

/// This class holds the implementation of the EQueueContainerType.
/// It is intended to be uniqued based on its content and owned by the context.
class EQueueContainerTypeStorage : public mlir::TypeStorage {

public:
	EQueueContainerTypeStorage(Type valueType, Type containerType) : valueType(valueType), containerType(containerType) {}
  /// The hash key used for uniquing.
  using KeyTy = std::pair<Type, Type>;
  bool operator==(const KeyTy &key) const { return key == KeyTy(getValueType(), getContainerType()); }

  /// This is a factory method to create our type storage. It is only
  /// invoked after looking up the type in the context using the key and not
  /// finding it.
  static EQueueContainerTypeStorage *construct(mlir::TypeStorageAllocator &allocator,
                                        const KeyTy &key) {

    // Allocate the instance for the EQueueContainerTypeStorage itself
    auto *storage = allocator.allocate<EQueueContainerTypeStorage>();
    // Initialize the instance using placement new.
    return new (storage) EQueueContainerTypeStorage(key.first, key.second);
  }

  Type getValueType() const { return valueType; }
	Type getContainerType() const {return containerType;}

private:
  Type valueType;
	Type containerType;

};
} // namespace detail

EQueueContainerType EQueueContainerType::get(mlir::Type valueType, mlir::Type containerType) {
  // Call into a helper 'get' method in 'TypeBase' to get a uniqued instance
  // of this type. The first two parameters are the context to unique in and
  // the kind of the type. The parameters after the type kind are forwarded to
  // the storage instance.
  // XXX(Zhijing): not sure if it's enough to get a unique instance with 
	// valueType
	return Base::get(valueType.getContext(), EQueueTypeKind::EQUEUE_CONTAINER, valueType, containerType);
}

mlir::Type EQueueContainerType::getValueType() {
  return getImpl()->getValueType();
}

mlir::Type EQueueContainerType::getContainerType() {
  return getImpl()->getContainerType();
}

mlir::Type equeue::EQueueDialect::parseType(DialectAsmParser &parser) const {
  Location loc = parser.getEncodedSourceLoc(parser.getNameLoc());

  // All types start with an identifier that we switch on.
  StringRef typeNameSpelling;
  if (failed(parser.parseKeyword(&typeNameSpelling)))
    return nullptr;

	if (typeNameSpelling == "signal"){
		return EQueueSignalType::get(getContext());
	}
  if (typeNameSpelling == "container") {
    if(failed(parser.parseLess()))
      return nullptr;
    Type value;
    if(failed(parser.parseType(value)))
      return nullptr;
    if(failed(parser.parseComma()))
      return nullptr;   
		Type container;   
		if(failed(parser.parseType(container)))
      return nullptr;

		if(failed(parser.parseGreater()))
      return nullptr;
    return EQueueContainerType::get(value, container);
  }

  parser.emitError(parser.getCurrentLocation(), "Invalid EQueue type '" + typeNameSpelling + "'");
  return nullptr;
}

/// Print a EQueueContainerType
void equeue::EQueueDialect::printType(mlir::Type type, DialectAsmPrinter &os) const {
  if (auto ty = type.dyn_cast<EQueueContainerType>()){
  	os << "container<";
 		os.getStream() << ty.getValueType()<< ", " <<ty.getContainerType();
  	os << ">";
	} else if (auto ty = type.dyn_cast<EQueueSignalType>()){
		os <<"signal";
	} else {
    os << "unknown aten type";
    return;
  }
}



equeue::EQueueDialect::EQueueDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context) {
	addTypes<EQueueSignalType, EQueueContainerType>();
  addOperations<
#define GET_OP_LIST
#include "EQueue/EQueueOps.cpp.inc"
  >();
}

}// namespace equeue
