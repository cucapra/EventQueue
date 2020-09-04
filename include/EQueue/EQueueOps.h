//===- EQueueOps.h - EQueue dialect ops -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef XILINX_EQUEUEOPS_H
#define XILINX_EQUEUEOPS_H

#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"

#include "mlir/IR/Builders.h"
#include "mlir/IR/Function.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"

#include "EQueue/EQueueTraits.h"
using namespace mlir;
namespace xilinx {
namespace equeue {

#define GET_OP_CLASSES
#include "EQueue/EQueueOps.h.inc"

} // namespace equeue
} // namespace xilinx

#endif // XILINX_EQUEUEOPS_H
