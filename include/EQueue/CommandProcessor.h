//===- CommandProcessor.h ---------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "llvm/ADT/Any.h"

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "llvm/ADT/APInt.h"
#include "llvm/ADT/APFloat.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorOr.h"
#include "llvm/Support/MemoryBuffer.h"

#include "mlir/IR/Function.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"

#include <ostream>

namespace acdc {

class CommandProcessor {

public:
    CommandProcessor(std::ostream &trace_stream) :
      traceStream(trace_stream), verbose(true)
    {
    }

    ~CommandProcessor() {}

  void run(mlir::ModuleOp module);

private:
  std::ostream &traceStream;
  bool verbose;

};
struct OpEntry{
  mlir::Operation *op;

  uint64_t tid;
  std::vector<uint64_t> mem_tids;

  uint64_t start_time;
  uint64_t end_time;
  uint64_t queue_ready_time;
  bool is_started() { return start_time != 0 && end_time != 0; }
  bool is_done(uint64_t t) { return t >= end_time; }

  OpEntry(mlir::Operation *o) : op(o), tid(0), start_time(0), end_time(0), queue_ready_time(0) {}
  OpEntry(mlir::Operation *o, uint64_t id) : op(o), tid(id), start_time(0), end_time(0), queue_ready_time(0) {}
  OpEntry() : op(nullptr), tid(0), start_time(0), end_time(0), queue_ready_time(0) {}

};
#define EVENT_QUEUE_SIZE 2
struct LauncherTable {
  bool host = false;
  OpEntry op_entry;
  
  mlir::Block *block;
  mlir::Block::iterator next_iter;

  llvm::SmallVector<mlir::Operation *, EVENT_QUEUE_SIZE> event_queue;
  bool is_idle(){
    return !op_entry.op;
  }
  void set_block(mlir::Block *b){
    block = b;
    next_iter = b->begin();
  }
  bool add_event_queue(mlir::Operation *o){
    if(!host && event_queue.size()==EVENT_QUEUE_SIZE) return false;
    else event_queue.push_back(o);
    return true;
  }
  LauncherTable()
    : op_entry(), block(nullptr) { }
};

template <class K>
class ScopedMap{
  public:
    ScopedMap(){}
    ~ScopedMap(){}
    uint64_t size(){
      return scopedMap.size();
    }
    void print(){
      for (auto it = scopedMap.begin(); it!=scopedMap.end()-1; it++){
        llvm::outs()<<"scope["<<it - scopedMap.begin()<<"]\n";
        for(auto it2 = it->begin(); it2 !=it->end(); it2++ ){
          llvm::outs()<<it2->first<<": "<<it2->second<<"\n";
        }
      }
    }
    void add(K key){
      scopedMap[scopedMap.size()-1][key]++;
    }
    uint64_t count(K key){
      for (auto it = scopedMap.begin(); it!=scopedMap.end(); it++)
        if(it->count(key)) 
          return it - scopedMap.begin() + 1;
      return 0;
    }
    uint64_t operator [](K key){
      for (auto it = scopedMap.end(); it!=scopedMap.begin(); it--)
        if( (it-1)->count(key) ) 
          return scopedMap[scopedMap.size()-1][key];
      return 0;
    }
    void addScope(){
      llvm::DenseMap<K, uint64_t> new_scope;
      scopedMap.push_back(new_scope);
    }
    void endScope(){
      scopedMap.pop_back();
    }
  private:
    std::vector<llvm::DenseMap<K, uint64_t>> scopedMap;

};

template <class T> class Executor;

struct VisitorInterface
{
  virtual ~VisitorInterface() = default;
	virtual void Visit(Executor<mlir::ConstantIndexOp>&) = 0;
	
//    virtual void Visit(Component<float>&) = 0;
};

class ExecutorInterface{
public:
    virtual void runFunc(VisitorInterface&) = 0;
};

template <class T> class Executor : public ExecutorInterface {
public:
	Executor(T op, std::vector<llvm::Any> &in, std::vector<llvm::Any> &out) : op(op), in(in), out(out)
  {
  }

  void runFunc(VisitorInterface &visitor) { visitor.Visit(*this); }
	T op;
  std::vector<llvm::Any> &in;
  std::vector<llvm::Any> &out;
};


}
