//===- EQueueTraits.h -------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef EQUEUE_TRAITS_H
#define EQUEUE_TRAITS_H
#include "mlir/IR/OpDefinition.h"
namespace mlir{
namespace OpTrait{
template <typename ConcreteType> class StructureOpTrait : public OpTrait::TraitBase<ConcreteType, StructureOpTrait> {
};

template <typename ConcreteType> class ControlOpTrait : public OpTrait::TraitBase<ConcreteType, ControlOpTrait> {};

template <typename ConcreteType> class AsyncOpTrait : public OpTrait::TraitBase<ConcreteType, AsyncOpTrait> {};
}//OpTrait
}//mlir
#endif
