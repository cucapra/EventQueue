#ifndef EQUEUE_EDSC_INTRINSICS_H
#define EQUEUE_EDSC_INTRINSICS_H

#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "mlir/EDSC/Builders.h"
#include "llvm/Support/raw_ostream.h"



//namespace mlir{
//namespace edsc {
//namespace intrinsics {

using namespace mlir;
using namespace mlir::edsc;

using create_dma = ValueBuilder<equeue::CreateDMAOp>;
using create_mem = ValueBuilder<equeue::CreateMemOp>;
using create_proc = ValueBuilder<equeue::CreateProcOp>;
using connection = ValueBuilder<equeue::ConnectionOp>;
using create_comp = ValueBuilder<equeue::CreateCompOp>;
using add_comp = OperationBuilder<equeue::AddCompOp>;
using get_comp = ValueBuilder<equeue::GetCompOp>;

using alloc_op = ValueBuilder<equeue::MemAllocOp>;
using dealloc_op = OperationBuilder<equeue::MemDeallocOp>;
using read_op = ValueBuilder<equeue::MemReadOp>;
using write_op = OperationBuilder<equeue::MemWriteOp>;
using memcpy_op = ValueBuilder<equeue::MemCopyOp>;


using unk_spec = ValueBuilder<equeue::UnkownSpecificationOp>;
using unk_op = ValueBuilder<equeue::UnkownOp>;

using return_op = OperationBuilder<equeue::ReturnOp>;

using start_op = ValueBuilder<equeue::ControlStartOp>;
using control_and = ValueBuilder<equeue::ControlAndOp>;
using control_or = ValueBuilder<equeue::ControlOrOp>;
using await_op = OperationBuilder<equeue::AwaitOp>;



ValueRange LaunchOpBuilder(Value start, Value device,
  ValueRange operands, function_ref<void(ValueRange)> bodyBuilder); 
  
//}// namespace intrinsics
//}// namespace edsc
//}// namespace mlir

#endif
