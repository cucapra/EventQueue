//===- EQueueDialect.h - EQueue dialect -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef XILINX_EQUEUEDIALECT_H
#define XILINX_EQUEUEDIALECT_H

#include "mlir/IR/Dialect.h"
#include "EQueueTraits.h"
using namespace mlir;
namespace xilinx {
namespace equeue {

// The Dialect
class EQueueDialect : public mlir::Dialect {
public:
  explicit EQueueDialect(mlir::MLIRContext *ctx);
  static StringRef getDialectNamespace() { return "equeue"; }


  /// Parse a type registered to this dialect. Overridding this method is
  /// required for dialects that have custom types.
  /// Technically this is only needed to be able to round-trip to textual IR.
  mlir::Type parseType(DialectAsmParser &parser) const override;

  /// Print a type registered to this dialect. Overridding this method is
  /// only required for dialects that have custom types.
  /// Technically this is only needed to be able to round-trip to textual IR.
  void printType(mlir::Type type, DialectAsmPrinter &os) const override;
};

////////////////////////////////////////////////////////////////////////////////
/////////////////////// Custom Types for the Dialect ///////////////////////////
////////////////////////////////////////////////////////////////////////////////

namespace detail {
struct EQueueContainerTypeStorage;
}

/// LLVM-style RTTI: one entry per subclass to allow dyn_cast/isa.
enum EQueueTypeKind {
  // The enum starts at the range reserved for this dialect.
  EQUEUE_SIGNAL = mlir::Type::FIRST_PRIVATE_EXPERIMENTAL_0_TYPE,
  EQUEUE_CONTAINER,
};

/// This class defines a simple parameterless type. All derived types must
/// inherit from the CRTP class 'Type::TypeBase'. It takes as template
/// parameters the concrete type (SimpleType), the base class to use (Type),
/// using the default storage class (TypeStorage) as the storage type.
/// 'Type::TypeBase' also provides several utility methods to simplify type
/// construction.
class EQueueSignalType : public Type::TypeBase<EQueueSignalType, Type, TypeStorage> {
public:
  /// Inherit some necessary constructors from 'TypeBase'.
  using Base::Base;

  /// This static method is used to support type inquiry through isa, cast,
  /// and dyn_cast.
  static bool kindof(unsigned kind) { return kind == EQueueTypeKind::EQUEUE_SIGNAL; }

  /// This method is used to get an instance of the 'SignalType'. Given that
  /// this is a parameterless type, it just needs to take the context for
  /// uniquing purposes.
  static EQueueSignalType get(MLIRContext *context) {
    // Call into a helper 'get' method in 'TypeBase' to get a uniqued instance
    // of this type.
    return Base::get(context, EQueueTypeKind::EQUEUE_SIGNAL);
  }
};

/// In MLIR Types are reference to immutable and uniqued objects owned by the
/// MLIRContext. As such `EQueueContainerType` only wraps a pointer to an uniqued
/// instance of `EQueueContainerTypeStorage` (defined in our implementation file) and
/// provides the public facade API to interact with the type.
class EQueueContainerType : public mlir::Type::TypeBase<EQueueContainerType, mlir::Type,
                                                 detail::EQueueContainerTypeStorage> {
public:
  using Base::Base;

  /// Return the type of individual elements in the array.
  mlir::Type getValueType();
	mlir::Type getContainerType();

  /// Get the unique instance of this Type from the context.
  static EQueueContainerType get(Type valueType, Type containerType);

  /// Support method to enable LLVM-style RTTI type casting.
  static bool kindof(unsigned kind) { return kind == EQueueTypeKind::EQUEUE_CONTAINER; }
};


namespace {
#define GET_OP_CLASSES
#include "EQueue/EQueueOpsDialect.h.inc"
}

} // namespace equeue
} // namespace xilinx

#endif // XILINX_EQUEUEDIALECT_H
