//===- EQueueStructs.h - EQueue structs -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef EQUEUESTRUCTS_H
#define EQUEUESTRUCTS_H

#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "mlir/IR/Builders.h"
#include "mlir/IR/Function.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include <string>
#include <cmath>
#include <algorithm>    
#include <vector>
#include <initializer_list>
#include <iostream>
using namespace mlir;
namespace equeue {
// dma
#define BURST_MODE true
#define STEAL_CYCLE_MODE false
// unlimited storage/transmission bandwidth
#define ENOUGH -1
// unit conversion
#define Bit *1
#define Byte *1024 Bit
#define KB *1024 Byte
#define MB *1024 KB
#define GB *1024 MB

enum class MemOp { Read, Write };

struct Device {
    //unique id
    uint64_t uid;
    
    std::string type;
    std::vector< std::vector<std::pair<uint64_t, uint64_t>> > events;
    //int clock_frequency;
    int energy;
    //int area;
    int equeues;
    
    
    Device(uint64_t id, int eqs, std::string typ) : uid(id), energy(1), equeues(eqs), type(typ)  {
        for(int i = 0; i < eqs; i++){
            std::vector<std::pair<uint64_t, uint64_t>> event_queue;
            event_queue.push_back(std::make_pair(0,0));
            events.push_back(event_queue);
        }
    }
    virtual ~Device() = default;
    void deleteOutdatedEvents(int idx, uint64_t now_time){
        if(events.empty()) return;
        auto it = events[idx].begin();
        for(; it != events[idx].end(); it++){
            if(it->second > now_time){
                if(it!=events[idx].begin()){
                  it--;
                  events[idx].erase(events[idx].begin(), it);
                }
                break;
            }
        }
    }
    //schedule the task on this device
    uint64_t scheduleEvent(int idx, uint64_t start_time, uint64_t exec_time, bool cleanEvents=false){
        if(exec_time==0) return start_time;
        
        auto iter = events[idx].begin();
        if (cleanEvents) deleteOutdatedEvents(idx, start_time);
        if(events[idx].size()==1){
            if(! (events[idx].begin()->first < start_time+exec_time) ){
                //the event cannot be scheduled at the begining
                start_time = (events[idx].begin()+1)->second;
                iter = events[idx].begin()+1;
            }
        }else if (events[idx].size() > 1) {
            bool slotFound = false;
            for(; iter+1 != events[idx].end(); iter++){
                if( iter->second <= start_time && (iter+1)->first < 
                    start_time + exec_time) {
                    iter++;
                    slotFound = true;
                    break;
                }
            }
            if(!slotFound){
                //the event cannot be scheduled at any slot, put to the end
                start_time = (events[idx].end()-1)->second;
                iter = events[idx].end();
            }
        }
        events[idx].insert(iter, std::make_pair(start_time, start_time+exec_time));
        return start_time+exec_time;
    }
    //schedule the task on multiple devices
    //template <class T>
    uint64_t  scheduleEvent(int idx, uint64_t start_time, uint64_t exec_time, std::vector<int> idx_list, std::initializer_list<Device *> dlist )
    {
        if(exec_time==0) return start_time;
        
        std::vector<uint64_t> start;
        start.push_back(start_time);
        start.push_back( (events[idx].end()-1)->second );
        int i = 0;
        //schedule right after the latest end time of all events
        for( auto device : dlist )
        {   
            //device->deleteOutdatedEvents(idx_list[i], start_time);
            auto e = device->events[idx_list[i++]];
            if(!e.empty()){
                start.push_back( (e.end()-1)->second );
            }
        }
        
        uint64_t start_t = *std::max_element(start.begin(), start.end());
        
        events[idx].push_back(std::make_pair(start_t, exec_time+start_t));
        i = 0;
        for( auto device : dlist )
        {
            device->events[idx_list[i++]].push_back(std::make_pair(start_t, exec_time+start_t));
        }
        return start_t + exec_time;
    }

    
};

struct Connection : public Device{
    int bandwidth;
    std::map<uint64_t, int> write_schedule;
    int data_total;
    Connection(uint64_t id, int bandwid) : Device(id, 1, "Connection") {
        bandwidth = bandwid;
        data_total = 0;
    }
    uint64_t getReadOrWriteCycles(int bits){

        return floor( (float)bits/bandwidth);
    }
    bool scheduleTransmission(uint64_t cycle, int bits, MemOp op){

      if(op == MemOp::Write){
        data_total+=bits;
        if(!write_schedule.empty()){
          auto start_time = write_schedule.rbegin()->first;
          cycle = std::max({cycle, start_time+getReadOrWriteCycles(bits)});
        }
        write_schedule.insert({cycle, bits});
        return true;
      }else{

        if(write_schedule.empty()) return false;
        auto iter = write_schedule.begin();
        int vol = 0;
        for(; iter!=write_schedule.end(); iter++){
          vol+=iter->second;
          if(vol >= bits) break;
        }
        if(iter==write_schedule.end()) return false;
        
        
        auto prev_vol = vol-iter->second;
        //prev_time + getCycle(bits - prev_vol)
        auto required_cycle = iter->first + getReadOrWriteCycles(bits - prev_vol);
        if(required_cycle > cycle) return false;
        write_schedule.erase(write_schedule.begin(), ++iter);//[ , )
        if(vol!=bits) write_schedule.insert({required_cycle, vol-bits});

        return true;
      }
    }

    float getBandwidth(uint64_t cycles){
      if(cycles == 0) return 0;
      return data_total/cycles;
    }
};

struct DMA : public Device{
    bool mode;
    double transfer_rate;//volume per cycle
    int warmup_cycles;//bus grant, bus request
    //double transfer_rate_growth;//growth rate of rate
    //int saturated_volume;
    DMA(uint64_t id) : mode(BURST_MODE), transfer_rate(10 KB), warmup_cycles(0), Device(id, 1, "DMA") {}
    int getTransferCycles(int volume){
        return warmup_cycles + ceil(volume/transfer_rate);
    }
};

constexpr unsigned int hash(const char *s, int off = 0) {                        
    return !s[off] ? 5381 : (hash(s, off+1)*33) ^ s[off];                           
}    


struct Memory : public Device {
    int read_ports;
    int write_ports;
    int data_lines;//lines of data
    int data_size;
    int full_data_size;
    int total_volume;
    int default_volume;
    int cycles_per_data;//cycles to handle a set of read or write
    int coefficient;
    int min_cycles;
    //to cal bandwidth
    uint64_t total_read;
    uint64_t total_write;

    Memory(uint64_t id, int bks, std::string type, int rp, int wp, int de_vol, int dlines, int dtype_bit, 
        int cyc_per_data, int min_cyc) : Device(id, bks, type) {
        read_ports = rp;
        write_ports = wp;
        data_lines = dlines; 
        data_size = dtype_bit;
        int address_size = dlines ? ceil(log2(dlines)) : 0;
        //valid + address bits + data bits
        full_data_size = 1 + address_size + data_size; 
        total_volume = full_data_size * dlines;
        default_volume = de_vol;
        cycles_per_data = ceil(cyc_per_data * (de_vol/default_volume));
        min_cycles= ceil(min_cyc * (de_vol/default_volume));
        total_read = 0;
        total_write = 0;
    }

    uint64_t getReadOrWriteCycles(int dlines, MemOp op){
        //llvm::outs()<<min_cycles<<" "<<int(ceil((float)dlines / (float)read_ports)*cycles_per_data)<<"\n";
        if(op == MemOp::Read){
            total_read += dlines*data_size;
            return (read_ports == ENOUGH)? min_cycles : int(ceil((float)dlines / (float)read_ports)*cycles_per_data);
        }else{
            total_write += dlines*data_size;
            return (write_ports == ENOUGH)? min_cycles : int(ceil((float)dlines / (float)write_ports)*cycles_per_data);
        }
    }
    float getBandwidth(uint64_t cycles, MemOp op){
      if(cycles == 0) return 0;
      if(op == MemOp::Read)
        return (float)total_read/(float)cycles;
      else
        return (float)total_write/(float)cycles;
    }
};

//1:10:100 is the usual estimate
struct RegisterFile : public Memory {
   RegisterFile(uint64_t id, int bks, int dlines, int dtype_bit) : Memory(id, bks, "RegisterFile", ENOUGH, ENOUGH, 64 Byte, dlines, dtype_bit, 
        0, 0) {}
};
struct SRAM : public Memory {
   SRAM(uint64_t id, int bks, int dlines, int dtype_bit) : Memory(id, bks, "SRAM", bks, ENOUGH, 10 KB, dlines, dtype_bit, 
        0, 0) {}
};

/*struct SRAM : public Memory {
   SRAM(uint64_t id, int bks, int dlines, int dtype_bit) : Memory(id, bks, "SRAM", bks, ENOUGH, 10 KB, dlines, dtype_bit, 
        5, 5) {}
};*/
struct DRAM : public Memory {
   DRAM(uint64_t id, int bks, int dlines, int dtype_bit) : Memory(id, bks, "DRAM", bks, ENOUGH, 512 MB, dlines, dtype_bit, 
        100, 50) {}
};
struct SINK : public Memory {
   SINK(uint64_t id, int bks, int dlines, int dtype_bit) : Memory(id, bks, "SINK", ENOUGH, ENOUGH, ENOUGH, ENOUGH, ENOUGH, 
        0, 0) {}
};

} // namespace equeue

#endif // EQUEUESTRUCTS_H
