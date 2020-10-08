//===- EQueueStructs.h - EQueue structs -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef XILINX_EQUEUESTRUCTS_H
#define XILINX_EQUEUESTRUCTS_H

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
namespace xilinx {
namespace equeue {
// dma
#define BURST_MODE true
#define STEAL_CYECLE_MODE false
// unlimited storage/transmission bandwidth
#define ENOUGH -1
// unit conversion
#define Bit *1
#define Byte *1024 Bit
#define KB *1024 Byte
#define MB *1024 KB
#define GB *1024 MB

struct Device {
    //unique id
    uint64_t uid;

    std::vector< std::vector<std::pair<uint64_t, uint64_t>> > events;
    //int clock_frequency;
    int energy;
    //int area;
    int equeues;
    
    
    Device(uint64_t id, int eqs) : uid(id), energy(1), equeues(eqs) {
        for(int i = 0; i < eqs; i++){
            std::vector<std::pair<uint64_t, uint64_t>> event_queue;
            event_queue.push_back(std::make_pair(0,0));
            events.push_back(event_queue);
        }
    }
    virtual ~Device() = default;
    void deleteOutdatedEvents(int idx, uint64_t now_time){
        auto it = events[idx].begin();
        for(; it != events[idx].end(); it++){
            if(it->first >= now_time){
                break;
            }
        }
        events[idx].erase(events[idx].begin(), it);
    }
    //schedule the task on this device
    uint64_t scheduleEvent(int idx, uint64_t start_time, uint64_t exec_time, bool cleanEvents=false){
        auto iter = events[idx].begin();
        if (cleanEvents) deleteOutdatedEvents(idx, start_time);
        if(events[idx].size()==1){
            if(! (events[idx].begin()->first < start_time+exec_time) ){
                //the event cannot be scheduled at the begining
                start_time = (events[idx].begin()+1)->second + 1;
                iter = events[idx].begin()+1;
            }
        }else if (events[idx].size() > 1) {
            bool slotFound = false;
            for(; iter+1 != events[idx].end(); iter++){
                if( iter->second < start_time && (iter+1)->first - iter->second > 
                    exec_time) {
                    start_time = iter->second+1;
                    iter++;
                    slotFound = true;
                    break;
                }
            }
            if(!slotFound)
                //the event cannot be scheduled at any slot, put to the end
                start_time = (events[idx].end()-1)->second + 1;
                iter = events[idx].end();
        }
        events[idx].insert(iter, std::make_pair(start_time, start_time+exec_time));
        return start_time+exec_time;
    }
    //schedule the task on multiple devices
    template <class T>
    uint64_t  scheduleEvent(int idx, uint64_t start_time, uint64_t exec_time, std::vector<int> idx_list, std::initializer_list<T> dlist )
    {
        std::vector<uint64_t> start;
        start.push_back(start_time);
        start.push_back( (events[idx].end()-1)->second+1 );
        int i = 0;
        deleteOutdatedEvents(i, start_time);
        //schedule right after the latest end time of all events
        for( auto device : dlist )
        {
            device->deleteOutdatedEvents(i, start_time);
            auto e = device->events[idx_list[i++]];
            if(!e.empty())
                start.push_back((e.end()-1)->second+1);
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


struct DMA : public Device{
    bool mode;
    double transfer_rate;//volume per cycle
    int warmup_cycles;//bus grant, bus request
    //double transfer_rate_growth;//growth rate of rate
    //int saturated_volume;
    DMA(uint64_t id) : mode(BURST_MODE), transfer_rate(10 KB), warmup_cycles(2), Device(id, 1) {}
    int getTransferCycles(int volume){
        return warmup_cycles + ceil(volume/transfer_rate);
    }
};

constexpr unsigned int hash(const char *s, int off = 0) {                        
    return !s[off] ? 5381 : (hash(s, off+1)*33) ^ s[off];                           
}    

enum class MemOp { Read, Write };

struct Memory : public Device {
    int banks;
    int read_ports;
    int write_ports;
    int data_lines;//lines of data
    int data_size;
    int total_size;
    int total_volume;
    int default_volume;
    int cycles_per_data;//cycles to handle a set of read or write
    int min_cycles;
    int cycles;
    //int cache_size;
    //latency

    Memory(uint64_t id, int bks, int rp, int wp, int de_vol, int dlines, std::string dtype, 
        int cyc_per_data, int min_cyc) : Device(id, bks) {
        banks = bks;
        read_ports = rp;
        write_ports = wp;
        default_volume = de_vol;
        switch (hash(dtype.c_str())){
        case hash("f32"):
            data_size = 32;
            break;
        case hash("f16"):
            data_size = 32;
            break;
        case hash("f8"):
            data_size = 8;
            break;
        case hash("f4"):
            data_size = 4;
            break;
        default:
            data_size = 1;
            break;
        }
        data_lines = dlines;
        int address_size = dlines ? ceil(log2(dlines)) : 1;
        //valid + address bits + data bits
        default_volume = de_vol; 
        total_size = 1 + address_size + data_size; 
        total_volume = total_size * dlines;
        cycles_per_data = cyc_per_data;
        min_cycles= min_cyc;
        cycles = std::max( (int)round( cyc_per_data * (float)total_volume/(float)de_vol ) , min_cyc);
    }

    int getReadOrWriteCycles(int dlines, MemOp op){
        if(op == MemOp::Read)
            return (read_ports == ENOUGH)? cycles : ceil((float)dlines / (float)read_ports)*cycles;
        if(op == MemOp::Write)
            return (write_ports == ENOUGH)? cycles : ceil((float)dlines / (float)read_ports)*cycles;
        return -1;
    }
};
struct RegisterFile : public Memory {
   RegisterFile(uint64_t id, int bks, int dlines, std::string dtype) : Memory(id, bks, ENOUGH, ENOUGH, 64 Byte, dlines, dtype, 
        1, 1) {}
};
struct SRAM : public Memory {
   SRAM(uint64_t id, int bks, int dlines, std::string dtype) : Memory(id, bks, ENOUGH, ENOUGH, 10 KB, dlines, dtype, 
        10, 2) {}
};
struct DRAM : public Memory {
   DRAM(uint64_t id, int bks, int dlines, std::string dtype) : Memory(id, bks, ENOUGH, ENOUGH, 512 MB, dlines, dtype, 
        100, 5) {}
};

} // namespace equeue
} // namespace xilinx

#endif // XILINX_EQUEUESTRUCTS_H
