#ifndef EQUEUE_GENERATOR_H
#define EQUEUE_GENERATOR_H

#include <fstream>
#include <iostream>
#include <sstream>
#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueOps.h"
#include "EQueue/EQueueTraits.h"
#include "EDSC/Intrinsics.h"

#include "mlir/IR/AffineExpr.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/IntegerSet.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Verifier.h"
#include "mlir/IR/Types.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Transforms/LoopUtils.h"
#include "mlir/Transforms/Passes.h"

#include "mlir/Dialect/Affine/EDSC/Intrinsics.h"
#include "mlir/Dialect/Linalg/EDSC/Builders.h"
#include "mlir/Dialect/Linalg/EDSC/Intrinsics.h"
#include "mlir/Dialect/SCF/EDSC/Intrinsics.h"
#include "mlir/Dialect/StandardOps/EDSC/Intrinsics.h"
#include "mlir/Dialect/Vector/EDSC/Intrinsics.h"


#include "llvm/ADT/StringRef.h"
#include "llvm/Support/raw_ostream.h"
#include <math.h> 


struct layerConfig {
  int channel = 6;
  int ifmap_height = 10;//7
  int ifmap_width = 10;//7
  int num_filter = 10;//10
  int filter_height = 3;
  int filter_width = 3;
  int stride = 1;
  void print(){
    llvm::outs()<<"[network] \n"<<
    "ifmap_height: "<<ifmap_height<<"\n"<<
    "ifmap_width: "<<ifmap_width<<"\n"<<
    "filter_height: "<<filter_height<<"\n"<<
    "filter_width: "<<filter_width<<"\n"<<
    "channel: "<<channel<<"\n"<<
    "num_filter: "<<num_filter<<"\n"<<
    "stride: "<<stride<<"\n";
  }
};


enum DataFlow {WS, OS, IS, RS};

struct accelConfig {
  int array_height = 12;//12
  int array_width = 14;//14
  int ifmap_sram = 108;
  int filter_sram = 108;
  int ofmap_sram = 108;
  DataFlow dataflow = OS;
  std::string getStringDataflow()
  {
    switch (dataflow) {
      case WS: return "Weight Stationary";
      case OS: return "Output Stationary";
      case IS: return "Input Stationary";
      default: llvm_unreachable("invalid for dataflow");
    }
  }
  void print(){
    llvm::outs()<<"[Accelerator] \n";
    llvm::outs()<<"array_height: "<<array_height<<"\n"<<
    "array_width: "<<array_width<<" \n"<<
    "ifmap_sram: "<<ifmap_sram<<" \n"<<
    "filter_sram: "<<filter_sram<<" \n"<<
    "ofmap_sram: "<<ofmap_sram<<" \n"<<
    "dataflow: "<<" "<<getStringDataflow()<<" \n";
  }
};


class MLIRGenImpl {
public:
  MLIRGenImpl(mlir::MLIRContext &context) : builder(&context) {}
  void equeueGenerator(std::string &gen, std::string &config){
    // Load configuration
    if (config!=""){ 
      loadConfiguration(config);
    }
    
    // Generate mlir syntax
    if (gen ==  "systolicArray"){
        systolicArrayGenerator();
    } else if (gen == "linalg"){
        linalgGenerator();
    } else if (gen == "firSingle"){
        firSingleKernel();
    } else if (gen == "fir16"){
        fir16Kernel();
    } else if (gen == "fir16Limit"){
        fir16LimitedKernel();
    } else if (gen == "firMulti"){
        firMultiKernel();
    } else{
        llvm::errs()<<"No such implementation!\n";
    }
  }
    
  void loadConfiguration(std::string &config_fn){
    std::ifstream config_fp;
    config_fp.open(config_fn);
    if ( config_fp ) {
        std::stringstream instream;
        instream << config_fp.rdbuf();
        std::string instr;
        int number;
        while(instream>>instr){
          if(instr=="[Accelerator]") continue;
          else if(instr=="ArrayHeight:"){
            instream>>number;
            accel_config.array_height=number;
          }else if(instr=="ArrayWidth:"){
            instream>>number;
            accel_config.array_width=number;
          }else if(instr=="IfmapSramSz:"){
            instream>>number;
            accel_config.ifmap_sram=number;
          }else if(instr=="FilterSramSz:"){
            instream>>number;
            accel_config.filter_sram=number;
          }else if(instr=="OfmapSramSz:"){
            instream>>number;
            accel_config.ofmap_sram=number;
          }else if(instr=="Dataflow:"){
            instream>>instr;
            if(instr=="ws"){
              accel_config.dataflow=DataFlow::WS;
            } else if(instr=="os"){
              accel_config.dataflow=DataFlow::OS;
            } else if(instr=="is"){
              accel_config.dataflow=DataFlow::IS;
            } else {
              llvm_unreachable("invalid for dataflow");
            }
          }else if(instr=="[Network]"){
            instream>>instr;
            break;
          }else{
            llvm_unreachable("invalid input configuartion");
          }
        }
       
        instream>>number;
        layer_config.ifmap_height = number;//7
        instream>>number;
        layer_config.ifmap_width = number;//7
        instream>>number;
        layer_config.filter_height = number;
        instream>>number;
        layer_config.filter_width = number;
        instream>>number;
        layer_config.channel = number;
        instream>>number;
        layer_config.num_filter = number;//10
        instream>>number;
        layer_config.stride = number;
      
    } else {
      llvm::errs() << "Cannot find configration file "<<config_fn<<"!\n";
    }
    
    config_fp.close();
  }
  
  void linalgGenerator();
  void systolicArrayGenerator();
  void firSingleKernel();
  void fir16Kernel();
  void fir16LimitedKernel();
  void firMultiKernel();
  
  
  
private:
  layerConfig layer_config;
  accelConfig accel_config;
  
  mlir::ModuleOp theModule;
  mlir::OpBuilder builder;

  FuncOp makeFunction(StringRef name, ArrayRef<Type> results = {},
                             ArrayRef<Type> args = {}) {
    
    auto function = FuncOp::create(builder.getUnknownLoc(), name,
                                   builder.getFunctionType(args, results));
    auto &entryBlock = * function.addEntryBlock();

    // Set the insertion point in the builder to the beginning of the function
    // body, it will be used throughout the codegen to create operations in this
    // function.
    builder.setInsertionPointToStart(&entryBlock);

    return function;
  }
};





#endif
