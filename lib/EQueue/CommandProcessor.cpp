//===- CommandProcessor.cpp -------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "EQueue/CommandProcessor.h"

#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EQueue/EQueueStructs.h"

#include <list>
#include <deque>
#include <vector>
#include <map>
#include <sstream>
#include <string>
#include <float.h>

#define INDEX_WIDTH 32
#define DEBUG_TYPE "command_processor"
static bool verbose = true;
using namespace mlir;
namespace acdc {

//using ExecFunc = void (*)(T, std::vector<llvm::Any> &, std::vector<llvm::Any> &);//op, in, out
struct Visitor : VisitorInterface{
	void Visit(Executor<mlir::ConstantIndexOp>& exec) override {

		auto attr = exec.op.getAttrOfType<mlir::IntegerAttr>("value");
		exec.out[0] = attr.getValue().sextOrTrunc(INDEX_WIDTH);
	}
};

class Runner {

  const int TRACE_PID_QUEUE=0;
  const int TRACE_PID_ALLOC=1;
  const int TRACE_PID_EQUEUE=2;


#if 0
void executeOp(mlir::Op op,
               std::vector<llvm::Any> &in,
               std::vector<llvm::Any> &out) {
}
#endif

public:

  Runner(std::ostream &trace_stream) : traceStream(trace_stream), time(1), deviceId(0)
  {
  }



std::string printAnyValueWithType(mlir::Type type, llvm::Any &value) {
  std::stringstream out;
  if(type.isa<mlir::IntegerType>() ||
     type.isa<mlir::IndexType>()) {
    out << llvm::any_cast<llvm::APInt>(value).getSExtValue();
    return out.str();
  } else if(type.isa<mlir::FloatType>()) {
    out << llvm::any_cast<llvm::APFloat>(value).convertToDouble();
    return out.str();
  } else if(type.isa<mlir::NoneType>()) {
    return "none";
  } else {
    llvm_unreachable("Unknown result type!");
  }
}


void emitTraceStart(std::ostream &s)
{
  s << "[\n";
}

void emitTraceEnd(std::ostream &s)
{
  s << "{}]\n";
}

void emitTraceEvent(std::ostream &s,
                    std::string name,
                    std::string cat,
                    std::string ph,
                    int64_t start_time,
                    int64_t tid,
                    int64_t pid) {
  s << "{\n";
  s << "  \"name\": \"" << name << "\"," << "\n";
  s << "  \"cat\": \""<< cat << "\"," << "\n";
  s << "  \"ph\": \""<< ph << "\"," << "\n";
  s << "  \"ts\": " << start_time << "," << "\n";
  s << "  \"pid\": " << pid << "," << "\n";
  s << "  \"tid\": " << tid << "," << "\n";
  s << "  \"args\": " << "{}" << "" << "\n";
  s << "},\n";
}

Value getAllocDevice(Value memRef){
  auto op = valueIds[memRef].getDefiningOp();
  if( mlir::dyn_cast<mlir::linalg::ReshapeOp>(op) ||
      mlir::dyn_cast<mlir::SubViewOp>(op)){
    return getAllocDevice(op->getOperand(0));
  }
  return valueIds[mlir::cast<xilinx::equeue::MemAllocOp>(op).getMemHandler()];
  
}


//shapedValue: memref, vector, rankedTensor
int getMemVolume(mlir::Value shapedValue){
  int dlines = 1;
  for (auto s : shapedValue.getType().cast<ShapedType>().getShape()){
    dlines *= s;
  }
  return dlines;
}

uint64_t modelOp(const uint64_t &time, mlir::Operation *op, std::vector<uint64_t> &mem_tids)//, OpEntry &c)
{
  LLVM_DEBUG(llvm::dbgs()<<"[modelOp] start model op: "<<to_string(op)<<"\n");
  uint64_t execution_time = 1;
  if (auto Op = mlir::dyn_cast<xilinx::equeue::CreateMemOp>(op)) {
    auto shape = Op.getShape();
    int dlines = 1;
    for (auto s : shape){
      dlines *= s;
    }
    auto dtype = Op.getDataBit();
    auto banks = Op.getBank();
    auto key = valueIds[op->getResults()[0]];
    if (Op.getMemType() == "DRAM")
      deviceMap[key] = std::make_unique<xilinx::equeue::DRAM>(deviceId, banks, dlines, dtype);
    else if (Op.getMemType() == "SRAM")
      deviceMap[key] = std::make_unique<xilinx::equeue::SRAM>(deviceId, banks, dlines, dtype);
    else if (Op.getMemType() == "RegisterFile")
      deviceMap[key] = std::make_unique<xilinx::equeue::RegisterFile>(deviceId, banks, dlines, dtype);
    else if (Op.getMemType() == "SINK")
      deviceMap[key] = std::make_unique<xilinx::equeue::SINK>(deviceId, banks, dlines, dtype);
    else
      llvm_unreachable("No such memory type.\n");
    deviceId++;
  }
  else if (auto Op = mlir::dyn_cast<xilinx::equeue::CreateDMAOp>(op)) {
    auto key = valueIds[op->getResults()[0]];
    deviceMap[key] = std::make_unique<xilinx::equeue::DMA>(deviceId++);
  }
  else if (auto Op = mlir::dyn_cast<xilinx::equeue::ConnectionOp>(op)) {
    auto key = valueIds[op->getResults()[0]];
    deviceMap[key] = std::make_unique<xilinx::equeue::Connection>(deviceId++, Op.getBandwidth());
  }
  else if (auto Op = mlir::dyn_cast<xilinx::equeue::MemReadOp>(op)) {

    Value buffer = valueIds[Op.getBuffer()];
    auto allocOp = buffer.getDefiningOp<xilinx::equeue::MemAllocOp>();
    int dlines = Op.getDlines(allocOp);
    int vol = Op.getVol(allocOp);
    auto key = getAllocDevice(buffer);
    
    auto mem = static_cast<xilinx::equeue::Memory *>(deviceMap[key].get());
    mem_tids.push_back(mem->uid);
    execution_time = mem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Read);
    int idx = Op.getBank();
    

    if(Op.getConnection()!=Value()){
      Value connection = valueIds[Op.getConnection()];
      auto con = static_cast<xilinx::equeue::Connection *>(deviceMap[connection].get());
      execution_time = std::max({execution_time, con->getReadOrWriteCycles(vol)});
      con->scheduleEvent(0, time, execution_time, {idx}, {mem});
    }else{
      mem->scheduleEvent(idx, time, execution_time, true);
    }
    return time;
  }
  else if (auto Op = mlir::dyn_cast<xilinx::equeue::MemWriteOp>(op)) {
    Value buffer = valueIds[Op.getBuffer()];
    auto allocOp = buffer.getDefiningOp<xilinx::equeue::MemAllocOp>();
    int dlines = Op.getDlines(allocOp);
    int vol = Op.getVol(allocOp);
    
    auto key = getAllocDevice(buffer);
    auto mem = static_cast<xilinx::equeue::Memory *>(deviceMap[key].get());
    mem_tids.push_back(mem->uid);
    execution_time = mem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Write);
    int idx = Op.getBank();
    
    
    if(Op.getConnection()!=Value()){
      Value connection = valueIds[Op.getConnection()];
      auto con = static_cast<xilinx::equeue::Connection *>(deviceMap[connection].get());
      execution_time = std::max({execution_time, con->getReadOrWriteCycles(vol)});
      con->scheduleEvent(0, time, execution_time, {idx}, {mem});
    }else{
      mem->scheduleEvent(idx, time, execution_time, true);
    }
    return time;
  }
  else if (auto Op = mlir::dyn_cast<xilinx::equeue::MemCopyOp>(op)) {
    
    Value srcBuffer = valueIds[Op.getSrcBuffer()];
    Value destBuffer = valueIds[Op.getDestBuffer()];
    auto srcAllocOp = srcBuffer.getDefiningOp<xilinx::equeue::MemAllocOp>();
    auto destAllocOp = srcBuffer.getDefiningOp<xilinx::equeue::MemAllocOp>();
    int dlines = Op.getDlines(srcAllocOp, destAllocOp);
    int vol = Op.getVol(srcAllocOp, destAllocOp);  
    
    auto destKey = getAllocDevice(destBuffer);
    auto srcKey = getAllocDevice(srcBuffer);
    
    auto srcMem = static_cast<xilinx::equeue::Memory *>(deviceMap[srcKey].get());
    mem_tids.push_back(srcMem->uid);
    uint64_t readTime = srcMem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Read);
    
    auto destMem = static_cast<xilinx::equeue::Memory *>(deviceMap[destKey].get());
    mem_tids.push_back(destMem->uid);
    uint64_t writeTime = destMem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Write);


    //int total_size = srcMem->total_size;
    //int volume = dlines * total_size;
    int volume = dlines;
    auto key = valueIds[Op.getDMAHandler()];
    auto dma = static_cast<xilinx::equeue::DMA *>(deviceMap[key].get());
    uint64_t dmaTime = dma->getTransferCycles(volume);
    execution_time = std::max({readTime, writeTime, dmaTime});        
    //clean outdated events
    int src_idx = Op.getSrcBank();
    int dest_idx = Op.getDestBank();
    Value connection = valueIds[Op.getConnection()];

    if(connection!=Value()){
      auto con = static_cast<xilinx::equeue::Connection *>(deviceMap[connection].get());
      execution_time = std::max({execution_time, con->getReadOrWriteCycles(vol)});
      return dma->scheduleEvent(0, time, execution_time, {0, src_idx, dest_idx}, {con, srcMem, destMem});
    }else{
      return dma->scheduleEvent(0, time, execution_time, {src_idx, dest_idx}, {srcMem, destMem});
    }
  }
  else if (auto Op = mlir::dyn_cast<mlir::linalg::GenericOp>(op)) {
    //TODO: connection not modeled here
    auto cur_time = time;
    //TODO: there should be some analysis on common channel, but ignore for now
    auto total_loop = 1;
    for(int i = 0; i < Op.getNumInputs(); i++){
      auto key = getAllocDevice(Op.getInput(i));
      auto mem = static_cast<xilinx::equeue::Memory *>(deviceMap[key].get());
      mem_tids.push_back(mem->uid);
      auto dlines = getMemVolume(Op.getInput(i));
		  auto vol = Op.getInput(i).getDefiningOp<xilinx::equeue::MemAllocOp>().getDataBit()*dlines;
      total_loop*=dlines;
      uint64_t readTime = mem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Read);
      //assuming memory bank is always 0
      mem->scheduleEvent(0, cur_time, readTime, true);
      cur_time += readTime;
    }
    for(int i = 0; i < Op.getNumOutputs(); i++){
      auto key = getAllocDevice(Op.getOutputBuffer(i));
      auto mem = static_cast<xilinx::equeue::Memory *>(deviceMap[key].get());
      mem_tids.push_back(mem->uid);
      auto dlines = getMemVolume(Op.getInput(i));
		  auto vol = Op.getInput(i).getDefiningOp<xilinx::equeue::MemAllocOp>().getDataBit()*dlines;
      total_loop*=dlines;
      uint64_t writeTime = mem->getReadOrWriteCycles(vol, dlines, xilinx::equeue::MemOp::Write);
      //assuming memory bank is always 0
      mem->scheduleEvent(0, cur_time, writeTime, true);
      cur_time += writeTime;
    }
    for(auto iter = Op.getBody()->begin(); iter!=Op.getBody()->end(); iter++){
      auto cur_op = &(*iter);
      auto new_time = modelOp(cur_time, cur_op, mem_tids);
      cur_time += (new_time-cur_time)*total_loop;
    }
    return cur_time;
  }
  if (  op->hasTrait<mlir::OpTrait::StructureOpTrait>() ||
        mlir::dyn_cast<mlir::ConstantOp>(op) ||
        mlir::dyn_cast<xilinx::equeue::MemAllocOp>(op) ||
        mlir::dyn_cast<xilinx::equeue::MemDeallocOp>(op) ||
        mlir::dyn_cast<xilinx::equeue::AwaitOp>(op) ||
        mlir::dyn_cast<xilinx::equeue::LaunchOp>(op) ||
        mlir::dyn_cast<xilinx::equeue::ReturnOp>(op) ||
        mlir::dyn_cast<mlir::linalg::ReshapeOp>(op) ||
        mlir::dyn_cast<mlir::scf::ForOp>(op) ||
        mlir::dyn_cast<mlir::scf::YieldOp>(op) ||
        mlir::dyn_cast<mlir::SubViewOp>(op) ||
        mlir::dyn_cast<mlir::ReturnOp>(op) ){
    execution_time = 0;
  }
  return execution_time+time;
}

std::string to_string(Operation *op) {
  return op ? op->getName().getStringRef().str() : "nop";
}

std::string to_string(OpEntry &c) {
  return to_string(c.op);
}


//update value if the value has signalType
void updateExecution(mlir::ValueRange args){
  for (Value arg: args)
    if( arg.getType().isa<xilinx::equeue::EQueueSignalType>() ){
      LLVM_DEBUG(llvm::dbgs()<<"[updateExecution]"<<arg<<"\n" );
      valueMap[valueIds[arg]]++;
    }
}
//update signal to its definer
void updateSignalIds(mlir::ValueRange args0, mlir::ValueRange args1){
  auto arg1_it = args1.begin();
  for (Value arg0: args0 ){
    if( arg0.getType().isa<xilinx::equeue::EQueueSignalType>() ){
      signalIds[valueIds[arg0]] = getSignalId(valueIds[*arg1_it]);
    }
    arg1_it += 1;
  }
}

void updateIterState(mlir::ValueRange args, bool yield){
  for (Value arg: args ){
    if( arg.getType().isa<xilinx::equeue::EQueueSignalType>() ){
      iterState[valueIds[arg]] = yield;
    }
  }
}
void finishOp(LauncherTable &l, uint64_t time, uint64_t pid)
{
  if (l.is_idle()) return;
  LLVM_DEBUG(llvm::dbgs()<<to_string(l.op_entry.op)<<": not idle\n");

  auto &c = l.op_entry;
  if (c.is_started()) {
    if (c.is_done(time)) {
      if (verbose) {
        llvm::outs() << "finish: '";
        //c.op->print(llvm::outs());
        llvm::outs()<<to_string(c.op);
        llvm::outs() << "' @ " << time << "\n";
      }

      LLVM_DEBUG(llvm::dbgs() << "OP:  " << c.op->getName() << "\n");
      if (auto Op = mlir::dyn_cast<xilinx::equeue::MemCopyOp>(c.op)){
        updateExecution( c.op->getResults() );
      }
      if (auto Op = mlir::dyn_cast<xilinx::equeue::LaunchOp>(c.op)){
        updateSignalIds( Op.getBody()->getArguments(), Op.getLaunchOperands() );
      }else if (auto Op = mlir::dyn_cast<xilinx::equeue::ReturnOp>(c.op)) {
        // increment launchOp && its results
        updateExecution( c.op->getParentOp()->getResult(0) );
        updateSignalIds( c.op->getParentOp()->getResults().drop_front(), c.op->getOperands() );
      }
      else if (auto Op = mlir::dyn_cast<mlir::scf::ForOp>(c.op)){
        updateSignalIds( Op.getRegionIterArgs(), Op.getIterOperands() );
        updateIterState( Op.getRegionIterArgs(), false );
      }
      else if (auto Op = mlir::dyn_cast<mlir::scf::YieldOp>(c.op)){
        
        //LLVM_DEBUG(llvm::dbgs() << "[finish op] yield!!!!!!!!! "<< c.op <<" "<< exTimes[c.op] << "\n");
        if( exTimes[c.op] % getExTimes( c.op->getParentOp() ) == 0 ){
          updateSignalIds( c.op->getParentOp()->getResults(), c.op->getOperands() );
        }else{
          auto pop = mlir::dyn_cast<mlir::scf::ForOp>(c.op->getParentOp());
          updateSignalIds( pop.getRegionIterArgs(), c.op->getOperands() );
          updateIterState( pop.getRegionIterArgs(), true );
        }
      } else{
        if ( mlir::dyn_cast<xilinx::equeue::CreateProcOp>(c.op) ||
          mlir::dyn_cast<xilinx::equeue::CreateDMAOp>(c.op)){
          auto key = c.op->getResult(0);
          LauncherTable l;
          if( auto dma_op = mlir::dyn_cast<xilinx::equeue::CreateDMAOp>(c.op) ){
            l.name = "";//dma_op.getName().str();
          } else if ( auto proc_op = mlir::dyn_cast<xilinx::equeue::CreateProcOp>(c.op)){
            l.name = "";//proc_op.getName().str();
          }
          launchTables.insert({key, l});
        }
      }

      auto op_str = to_string(c)+std::to_string(c.tid);
      size_t position = op_str.find(op_str);
      auto opStr = op_str.substr(position);
      // emit trace event end
      if ( c.end_time != c.start_time ){
        emitTraceEvent(traceStream, opStr, l.name, "E", time, pid, 0);
      }
      for(auto iter = c.mem_tids.begin(); iter != c.mem_tids.end(); iter++){
        emitTraceEvent(traceStream, opStr, l.name, "E", time, *iter, 1);
      }
      // set op_entry to empty
      OpEntry entry;
      l.op_entry = entry;
    }else {
      // running...
      if (verbose) {
        llvm::outs() << "running: '";
        //c.op->print(llvm::outs());
	      llvm::outs()<<to_string(c.op);
        llvm::outs() << "' @ " << time << " - " << c.end_time << "\n";
      }
      // in-order, return.
    }
  }

}

void scheduleOp(LauncherTable &l, uint64_t time, uint64_t pid)
{
  if( l.is_idle() ) return;

  auto& c_next = l.op_entry;
  LLVM_DEBUG(llvm::dbgs()<<"[schedule] got c_next\n");
  if (!c_next.queue_ready_time)
    c_next.queue_ready_time = time;
  // emit trace event begin

  if( auto Op = llvm::dyn_cast<xilinx::equeue::AwaitOp>(c_next.op) ){
    LLVM_DEBUG(llvm::dbgs()<<"[schedule] await op\n");
    llvm::outs()<<"[schedule] await op\n";
    if(waitForSignal(c_next.op))
      return;
  }
  LLVM_DEBUG(llvm::dbgs()<<"[schedule] not waiting for any signal\n");

  if ( !c_next.is_started() ){
    //not scheduled before, let's schedule it
    if( llvm::dyn_cast<xilinx::equeue::LaunchOp>(c_next.op) ||
        llvm::dyn_cast<xilinx::equeue::MemCopyOp>(c_next.op) ||
         llvm::dyn_cast<xilinx::equeue::AwaitOp>(c_next.op) ){
      opMap[c_next.op]++;
    }
    LLVM_DEBUG(llvm::dbgs()<<"[schedule] updated execution\n");
    
    c_next.start_time = time;
    c_next.end_time = modelOp(time, c_next.op, c_next.mem_tids);

    if (verbose) {
      llvm::outs()<<"scheduled: '";
      //c_next.op->print(llvm::outs());
      llvm::outs()<<to_string(c_next.op);
      llvm::outs() << "' @ " << c_next.start_time << " - " << c_next.end_time << "\n";
    }
    auto op_str = to_string(c_next)+std::to_string(c_next.tid);
    size_t position = op_str.find(op_str);
    auto opStr = op_str.substr(position);
    if ( c_next.end_time != c_next.start_time ){
      emitTraceEvent(traceStream, opStr, l.name, "B", time, pid, 0);
    }
    for(auto iter = c_next.mem_tids.begin(); iter != c_next.mem_tids.end(); iter++){
      emitTraceEvent(traceStream, opStr, l.name, "B", time, *iter, 1);
    }
    if (time > c_next.queue_ready_time) {
      emitTraceEvent(traceStream, "stall", l.name, "B", c_next.queue_ready_time, pid, 0);
      emitTraceEvent(traceStream, "stall", l.name, "E", time, pid, 0);
    }

  }
  return;
}


int64_t getConstant(mlir::Value v){
  if (auto constantOp = v.getDefiningOp<ConstantOp>())
    return constantOp.getValue().cast<IntegerAttr>().getInt();
  else
    llvm_unreachable("invalid for loop control argument");
}
/// get execution time of for loop, assuming all bounds are constant
int64_t getExTimes(mlir::Operation *op){
  int64_t lb = getConstant(op->getOperand(0));
  int64_t ub = getConstant(op->getOperand(1));
  int64_t step =  getConstant(op->getOperand(2));
  return int((ub - lb)/step);
}

mlir::Value getSignalId(mlir::Value in){
   return signalIds.count(in)? signalIds[in] : in;
}

bool waitForSignal(mlir::Operation* op){
  // check if the signals are all ready
  // if so, the operation is ready to be execute
  //auto op_block_cycle = blockExs[op->getBlock()];
  for( auto in : op->getOperands() ){
    if(in.getType().isa<xilinx::equeue::EQueueSignalType>()){
      if( waitForSignal(op, in) ) return true;
    }
  }
  return false;
}

bool waitForSignal(mlir::Operation* op, mlir::Value in){
  auto signal = getSignalId(valueIds[in]);
  auto op_block_cycle = blockExs[op->getBlock()];
  auto in_block_cycle = 1;
  if(to_string(op)!="equeue.await"){
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] "<<to_string(op)<<"\n");
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] sending to waitforsignal(op,in) "<<in<<"\n");
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] aliasing "<<signal<<"\n");
  }
  if(signal.getDefiningOp())
    in_block_cycle = blockExs[signal.getDefiningOp()->getBlock()];
  if( !valueMap.count( signal ) ){
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] signal not generated "<<"\n");
    return ! (iterInitValue.count( valueIds[in] ) // the signal is iterator
        && iterInitValue[valueIds[in]] != signal // the signal is not initial_value
        && valueMap.count(iterInitValue[valueIds[in]] ) ); // the initial_signal is generated
  }
  if(valueIds.count(in)){
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] valueIds[in] "<< valueIds[in] <<"\n");
  }
  if( iterInitValue.count( in ) ){
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] init value - "<< iterInitValue[ in ]<<"\n");
  }
  if( iterInitValue.count( valueIds[in] ) // the signal is iterator
      && iterInitValue[valueIds[in]] != signal ){ // the signal is not initial_value
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] signal generated, not initial value"<<"\n");
    auto init_signal = iterInitValue[valueIds[in]];
    auto init_value_cycle = 1;
    if(init_signal.getDefiningOp())
      init_value_cycle = blockExs[init_signal.getDefiningOp()->getBlock()];
    if( opMap[op] * init_value_cycle >= op_block_cycle * valueMap[init_signal] ){
      LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] op not enough for init value"<<"\n");
      return true;
    }
    //however, init signal is not necessary in the same block as signal 
    //normalized it
    if( (float)opMap[op]/ (float)op_block_cycle >=  (float)valueMap[signal] / (float)in_block_cycle
       + 1.0 / (float)init_value_cycle  ){
      LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] op not enough for updated value"<<"\n");
      LLVM_DEBUG(llvm::dbgs()<<opMap[op]<< " "<<valueMap[signal] << " " <<
        op_block_cycle << " " << in_block_cycle<<"\n");
      return true;
    }
  }else{
    LLVM_DEBUG(llvm::dbgs()<<"[waitforsignal] signal generated, inital value"<<"\n");
    if(opMap[op] * in_block_cycle >= op_block_cycle * valueMap[signal] ){
      return true;
    }
  }

  return false;
}
bool checkControlQueue(){
  bool generateSignal = false;
  auto iter = controlQueue.begin();
  while(iter != controlQueue.end()){
    auto op = *iter;
    if(op->hasTrait<mlir::OpTrait::ControlOpTrait>()){
      if( waitForSignal(op) ){
        iter++;  
        continue;
      }
      //finish control op
      //immediately udpate signal
      LLVM_DEBUG(llvm::dbgs()<<"[checkControlQueue] finish "<<to_string(op)<<"\n");
      opMap[op]++;
      updateExecution(op->getResults());
      // first event of event_queue will be handled by launcher
      // continue to check next one
      controlQueue.erase(iter);
      iter = controlQueue.begin();
      generateSignal = true;
      continue;
    }else{
      llvm_unreachable("check control queue should not sure anything other than control operation.\n");
    }
  }
  return generateSignal;
}

void checkEventQueue(LauncherTable& l){
  if( !l.event_queue.empty() ){
    //launch op
    auto op = l.event_queue.front();
    if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(op) ){
      if( waitForSignal(op, Op.getStartSignal()) ) return;
    } else {//memcopy
      if( waitForSignal(op) ) return;
    }
    LLVM_DEBUG(llvm::dbgs()<<"[checkEventQueue] "<<to_string(op)<<" finish waiting\n");
    if( l.is_idle() ){
      // the first event of event_queue is ready at launcher
      // and launcher is idle to process it

      // the only way to get launchOp is through checkEventQueue
      // so we need to update next_iter and op_entry here
      OpEntry entry(op);
      l.op_entry = entry;
      LLVM_DEBUG(llvm::dbgs()<<"[launchee] added op_entry\n");
      if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(op) )
        l.set_block(Op.getBody());
      l.event_queue.erase(l.event_queue.begin());
      LLVM_DEBUG(llvm::dbgs()<<"[launchee] erased : "<<l.event_queue.size()<<"\n");
    }
  }
  return ;
}

void setOpEntry(LauncherTable& l, uint64_t& tid){
    auto &opEntry = l.op_entry;
    auto size = launchTables.size();
    if(!opEntry.op){
      while(true){
        if( !l.block || l.next_iter == l.block->end() ) break;
        LLVM_DEBUG(llvm::dbgs()<<"[set_op_entry] next op\n");
        auto op = &*l.next_iter;
        LLVM_DEBUG(llvm::dbgs()<<to_string(op)<<"\n");
        LauncherTable lt;
        if(op->hasTrait<mlir::OpTrait::AsyncOpTrait>()){
          // launch, memcpy, control...
          if(op->hasTrait<mlir::OpTrait::ControlOpTrait>()){
            controlQueue.push_back(op);
            l.next_iter++;
          }else{
            Value launcher;
            if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(op) ){
              launcher = valueIds[Op.getDeviceHandler()];
            } else if ( auto Op = llvm::dyn_cast<xilinx::equeue::MemCopyOp>(op) ){
              launcher = valueIds[Op.getDMAHandler()];
            }
            auto& lt = launchTables[launcher];
            if(lt.add_event_queue(op)){
              l.next_iter++;
            }else
              break;
          }
        } else {
          OpEntry entry(op, tid++);
          l.op_entry=entry;
          if (auto Op = mlir::dyn_cast<mlir::scf::ForOp>(op)){
            l.set_block(Op.getBody());
          } else if ( auto Op = llvm::dyn_cast<mlir::scf::YieldOp>(op) ){
            exTimes[op]++;
            LLVM_DEBUG(llvm::dbgs()<<"[set_op_entry] forOp ex times: "<<exTimes[op]<<"\n");
            auto pop = op->getParentOp(); // forOp
            if (exTimes[op] % getExTimes(pop) == 0) {
              // exit for loop
              l.block = pop->getBlock();
              l.next_iter = ++mlir::Block::iterator(pop);
            }else{
              // redo for loop
              l.next_iter =  llvm::dyn_cast<mlir::scf::ForOp>(pop).getBody()->begin();
            }
          } else {
            l.next_iter++;
          }
          break;
        }
      }
    }
    assert(size == launchTables.size());
}

void nextEndTimes( LauncherTable &l, std::vector<uint64_t> &next_times){
  if ( !l.is_idle() && l.op_entry.is_started() ){
  	next_times.push_back(l.op_entry.end_time);
  }
}

void simulateFunction(mlir::FuncOp &toplevel)
{
  LLVM_DEBUG(llvm::dbgs()<<"========== start simulation ===========\n");
  auto hostIter = toplevel.getCallableRegion()->front().begin();
  hostTable.host = true;//host can launch, create component, assign mem
  hostTable.name = "host";
  hostTable.next_iter = hostIter;
  hostTable.block = &toplevel.getCallableRegion()->front();

  time = 1;
  bool running = true;
  uint64_t tid = 0;
  while (running) {
    LLVM_DEBUG(llvm::dbgs()<<"1. setOpEntry\n");
    setOpEntry(hostTable, tid);
    //llvm::outs()<<"1. setOpEntry "<<launchTables.size()<<"\n";
    int i = 0;
    for ( auto iter = launchTables.begin(); iter != launchTables.end(); iter++){
      LLVM_DEBUG(llvm::dbgs()<<iter->first<<":\n");
      setOpEntry(iter->second, tid);
    }
    LLVM_DEBUG(llvm::dbgs()<<"2. checkEventQueue\n");
    //llvm::outs()<<"2. checkEventQueue\n";
    checkEventQueue(hostTable);
    checkControlQueue();
    for ( auto iter = launchTables.begin(); iter != launchTables.end(); iter++){
      checkEventQueue(iter->second);
      if( checkControlQueue() ){
      //new signal generated, check from the front
        iter=launchTables.begin();
      }
    }
    // end condition, nothing can be put on to op_entry
    running = !hostTable.is_idle();
		for (auto iter = launchTables.begin(); iter!=launchTables.end(); iter++){
			running = running || !iter->second.is_idle();
		}
    if( !running ) break;

    LLVM_DEBUG(llvm::dbgs()<<"3. scheduleOp\n");
    //llvm::outs()<<"3. scheduleOp\n";
    uint64_t pid = 0;
    scheduleOp(hostTable, time, pid++);
    for (auto iter = launchTables.begin(); iter!= launchTables.end(); iter++){
			scheduleOp(iter->second, time, pid++);
		}

    // find the closest time stamp currently running op is done.
    std::vector<uint64_t> next_times;
    nextEndTimes(hostTable, next_times);
		for (auto iter = launchTables.begin(); iter!=launchTables.end(); iter++){
      nextEndTimes(iter->second, next_times);
		}
    if(!next_times.size()){
      LLVM_DEBUG(llvm::dbgs()<<"!!!!!!!!WRONG!!!!!!!!!!\n\n");
      time = time;
    } else {
      time =  *std::min_element(next_times.begin(), next_times.end());
    }
    LLVM_DEBUG(llvm::dbgs()<<"Next end time: "<<time<<"\n");
    LLVM_DEBUG(llvm::dbgs()<<"4. finishOp\n");
    //llvm::outs()<<"4. finishOp\n";
    pid = 0;
    finishOp(hostTable, time, pid++);
    for (auto iter = launchTables.begin(); iter!= launchTables.end(); iter++){
			finishOp(iter->second, time, pid++);
		}
    LLVM_DEBUG(llvm::dbgs()<<"=================\n\n");
  }

}
  void printValueRef(const Value& value) {
    if (value.getDefiningOp())
      llvm::outs() << value.getDefiningOp()->getName();
    else {
      auto blockArg = value.cast<BlockArgument>();
      llvm::outs()  << "arg" << blockArg.getArgNumber() << "@b ";
      if (blockArg.getOwner()->getParentOp())
        llvm::outs()<< blockArg.getOwner()->getParentOp()->getName();
    }
    llvm::outs() << " ";
  };

template <typename FuncT1, typename FuncT2>
inline void walkRegions(MutableArrayRef<Region> regions, const FuncT1 &func1, const FuncT2 &func2) {
  for (Region &region : regions)
    for (Block &block : region) {
      func1(block);
      // Traverse all nested regions.
      for (Operation &operation : block){
        walkRegions(operation.getRegions(), func1, func2);
        func2(operation);
      }
    }
}
/// link operands of launch with region arguments of launch region
/// so that a region argument is mapped to its defining Op
void buildIdMap(mlir::FuncOp &toplevel){
  walkRegions(*toplevel.getCallableRegion(), [&](Block &block) {
      // build iter init_value map
      auto pop = block.getParentOp();
      if( auto Op = llvm::dyn_cast<mlir::scf::ForOp>(pop) ) {
        auto arg_it = Op.getRegionIterArgs().begin();
        for ( Value operand : Op.getIterOperands() ){
          iterInitValue.insert({*arg_it, valueIds[operand]});
          valueIds.insert({*arg_it, *arg_it});
          arg_it += 1;
        }
      } else if( auto Op = llvm::dyn_cast<xilinx::equeue::LaunchOp>(pop) ) {
        auto arg_it = block.args_begin();
        for ( Value operand : Op.getLaunchOperands() ){
          valueIds.insert({*arg_it, valueIds[operand]});
          arg_it += 1;
        }
      } else {
        for (BlockArgument argument : block.getArguments())
          valueIds.insert({argument, argument});
      }
    }, [&](Operation &operation){
      //get_comp operation
      if(auto Op = llvm::dyn_cast<xilinx::equeue::GetCompOp>(operation)){
        auto create_comp = valueIds[Op.getCompHandler()];
        auto name = Op.getName();
        auto comp = compMap[create_comp][name.str()];
        valueIds.insert({operation.getResult(0), comp});
        
      }else{
        if(auto Op = llvm::dyn_cast<xilinx::equeue::CreateCompOp>(operation)){
          std::vector<std::string> names(Op.getCompStrList());
          int i = 0; 
          std::map<std::string, mlir::Value> nameCompMap;
          for(auto name: names){
            nameCompMap.insert({name, valueIds[Op.getOperand(i)]});
            i++;
          }
          compMap.insert({operation.getResult(0), nameCompMap});
        }
        else if(auto Op = llvm::dyn_cast<xilinx::equeue::AddCompOp>(operation)){
          Value create_comp =  valueIds[Op.getCompHandler()];
          std::vector<std::string> names(Op.getCompStrList());
          int i = 1; 
          for(auto name: names){
            compMap[create_comp].insert({name, valueIds[Op.getOperand(i)]});
            i++;
          }
        }
        for (Value result : operation.getResults()){
          valueIds.insert({result, result});
        }
      }
  });
}
void buildExMap(mlir::FuncOp &toplevel){
  walkRegions(*toplevel.getCallableRegion(), [&](Block &block) {
    auto pop = block.getParentOp();
    uint64_t ex_times = 1;
    if( auto Op = llvm::dyn_cast<mlir::scf::ForOp>(pop) ) {
      ex_times = getExTimes(pop);
    }
    if( blockExs.count(pop->getBlock()) )
      blockExs.insert({&block, blockExs[pop->getBlock()]*ex_times});
    else
      blockExs.insert({&block, ex_times});
  }, [&](Operation &operation){});
}
// todo private:
public:

  // The valueMap associates each SSA statement in the program
  // with the number of time the value is produced.
  llvm::DenseMap<mlir::Value, uint64_t> valueMap;
  // There is a lap between a value is consumed and a result is generated
  // e.g. %1 = memcpy(%0) immediately consumes %0, while %1 is still on-flight
  // we therefore need opMap to track if we have enough value to proceed
  llvm::DenseMap<mlir::Operation *, uint64_t> opMap;

  uint64_t deviceId;
  llvm::DenseMap<mlir::Value, std::unique_ptr<xilinx::equeue::Device> > deviceMap;

private:
  std::ostream &traceStream;

  uint64_t time;

  LauncherTable hostTable;
	llvm::DenseMap<mlir::Value, LauncherTable > launchTables;
  // store control events, clock-ish
  std::vector<mlir::Operation *> controlQueue;
  // map operation to (left) execution times
  llvm::DenseMap< mlir::Operation *, uint64_t > exTimes;
  llvm::DenseMap<mlir::Value, mlir::Value> signalIds;
  llvm::DenseMap<mlir::Value, bool> iterState;
  llvm::DenseMap<mlir::Value, mlir::Value> iterInitValue;

  llvm::DenseMap<mlir::Value, mlir::Value> valueIds;
  llvm::DenseMap<mlir::Value, std::map<std::string, mlir::Value> > compMap;
  llvm::DenseMap<mlir::Block *, uint64_t> blockExs;
}; // Runner
}

namespace acdc {

void CommandProcessor::run(mlir::ModuleOp module) {

  std::string topLevelFunction("graph");
  mlir::Operation *mainP = module.lookupSymbol(topLevelFunction);
  // The toplevel function can accept any number of operands, and returns
  // any number of results.
  if (!mainP) {
    llvm::errs() << "Toplevel function " << topLevelFunction << " not found!\n";
  }

  // We need three things in a function-type independent way.
  // The type signature of the function.
  mlir::FunctionType ftype;
  // The arguments of the entry block.
  mlir::Block::BlockArgListType blockArgs;


  Runner runner(traceStream);

  // The number of inputs to the function in the IR.
  unsigned numInputs = 0;
  unsigned numOutputs = 0;

  if (mlir::FuncOp toplevel =
      module.lookupSymbol<mlir::FuncOp>(topLevelFunction)) {
    runner.buildIdMap(toplevel);
    runner.buildExMap(toplevel);
    ftype = toplevel.getType();
    mlir::Block &entryBlock = toplevel.getBody().front();
    blockArgs = entryBlock.getArguments();

    // Get the primary inputs of toplevel off the command line.
    numInputs = ftype.getNumInputs();
    numOutputs = ftype.getNumResults();
  } else {
    llvm_unreachable("Function not supported.\n");
  }

  runner.emitTraceStart(traceStream);

  for(unsigned i = 0; i < numInputs; i++) {
    mlir::Type type = ftype.getInput(i);
    //if (auto tensorTy = type.dyn_cast<mlir::TensorType>()) {
      // We require this memref type to be fully specified.
      // runner.valueMap[blockArgs[i]]++;
    //} else {
    //  llvm_unreachable("Only memref arguments are supported.\n");
    //}
  }

  std::vector<llvm::Any> results(numOutputs);
  std::vector<uint64_t> resultTimes(numOutputs);
  if(mlir::FuncOp toplevel =
     module.lookupSymbol<mlir::FuncOp>(topLevelFunction)) {
    runner.simulateFunction(toplevel);
  }

  #if 0
  // Go back through the arguments and output any memrefs.
  for(unsigned i = 0; i < numInputs; i++) {
    mlir::Type type = ftype.getInput(i);
    if (type.isa<mlir::MemRefType>()) {
      // We require this memref type to be fully specified.
      auto memreftype = type.dyn_cast<mlir::MemRefType>();
      unsigned buffer = llvm::any_cast<unsigned>(valueDefMap[blockArgs[i]]);
      auto elementType = memreftype.getElementType();
      for(int j = 0; j < memreftype.getNumElements(); j++) {
        if(j != 0) llvm::outs() << ",";
        llvm::outs() << printAnyValueWithType(elementType,
                                        store[buffer][j]);
      }
      llvm::outs() << " ";
    }
  }
  #endif

  runner.emitTraceEnd(traceStream);

}// CommandProcessor::run

} // namespace acdc
