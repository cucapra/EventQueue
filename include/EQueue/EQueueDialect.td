//===- EQueueDialect.td ------------------------------------*- tablegen -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef EQUEUE_DIALECT
#define EQUEUE_DIALECT

include "mlir/IR/OpBase.td"

//===----------------------------------------------------------------------===//
// EQueue dialect definition.
//===----------------------------------------------------------------------===//

def EQueue_Dialect : Dialect {
    let name = "equeue";
    let summary = "A equeue out-of-tree MLIR dialect.";
    let description = [{
        This dialect is an example of an out-of-tree MLIR dialect designed to
        illustrate the basic setup required to develop MLIR-based tools without
        working inside of the LLVM source tree.
    }];
    let cppNamespace = "equeue";
}

//===----------------------------------------------------------------------===//
// Base equeue operation definition.
//===----------------------------------------------------------------------===//

def StructureOpTrait : NativeOpTrait<"StructureOpTrait">;
def ControlOpTrait : NativeOpTrait<"ControlOpTrait">;
def AsyncOpTrait : NativeOpTrait<"AsyncOpTrait">;
class EQueue_Op<string mnemonic, list<OpTrait> traits = []> :
        Op<EQueue_Dialect, mnemonic, traits>;

#endif // EQUEUE_DIALECT
