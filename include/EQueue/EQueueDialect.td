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
    let summary = "Equeue queue MLIR dialect.";
    let description = [{
        This dialect is designed to provide middle-level abstractions for launching 
        concurrent kernel devices. It provides abstractions for device invocations 
        on memories and kernels, allowing flexible device hierarchy and clear data 
        flow.
        Its goal is to bridge the gap between low-level hardware model and high-level 
        abstraction where no hardware information is given, thus facilitating custom 
        lowering among different design choices. It may be targeted, for example, 
        by DSLs using MLIR. 
        The dialect uses `equeue` as its canonical prefix.
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
