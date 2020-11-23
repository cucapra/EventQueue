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

using create_dma = ValueBuilder<xilinx::equeue::CreateDMAOp>;
using create_mem = ValueBuilder<xilinx::equeue::CreateMemOp>;
using create_proc = ValueBuilder<xilinx::equeue::CreateProcOp>;
using create_comp = ValueBuilder<xilinx::equeue::CreateCompOp>;
using add_comp = OperationBuilder<xilinx::equeue::AddCompOp>;
using get_comp = ValueBuilder<xilinx::equeue::GetCompOp>;

using alloc_op = ValueBuilder<xilinx::equeue::MemAllocOp>;
using dealloc_op = OperationBuilder<xilinx::equeue::MemDeallocOp>;
using read_op = ValueBuilder<xilinx::equeue::MemReadOp>;
using write_op = OperationBuilder<xilinx::equeue::MemWriteOp>;
using memcpy_op = ValueBuilder<xilinx::equeue::MemCopyOp>;

using return_op = OperationBuilder<xilinx::equeue::ReturnOp>;

using start_op = ValueBuilder<xilinx::equeue::ControlStartOp>;
using control_and = ValueBuilder<xilinx::equeue::ControlAndOp>;
using control_or = ValueBuilder<xilinx::equeue::ControlOrOp>;
using await_op = OperationBuilder<xilinx::equeue::AwaitOp>;



ValueRange LaunchOpBuilder(Value start, Value device,
  ValueRange operands, function_ref<void(ValueRange)> bodyBuilder); 
  
//}// namespace intrinsics
//}// namespace edsc
//}// namespace mlir

#endif
