//===- equeue-opt.cpp -------------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include <fstream>
#include <iostream>

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/Verifier.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "mlir/ExecutionEngine/ExecutionEngine.h"
#include "mlir/ExecutionEngine/OptUtils.h"
#include "mlir/Parser.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/Transforms/Passes.h"

#include "llvm/ADT/StringRef.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/ErrorOr.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/ToolOutputFile.h"

#include "EQueue/EQueueDialect.h"
#include "EQueue/EQueueTraits.h"
#include "EQueue/EQueuePasses.h"
#include "EQueue/CommandProcessor.h"
#include "Generator/EQueueGenerator.h"

static llvm::cl::opt<std::string> generate(
    "generate",
    llvm::cl::desc("generate the input file"),
    llvm::cl::init(""));

static llvm::cl::opt<bool> simulateInputFile(
    "simulate",
    llvm::cl::desc("simulate the input file"),
    llvm::cl::init(false));
    
static llvm::cl::opt<std::string> inputFilename(llvm::cl::Positional,
                                                llvm::cl::desc("<input file>"),
                                                llvm::cl::init("-"));

static llvm::cl::opt<std::string>
    configFilename("config", llvm::cl::desc("Config filename"),
                   llvm::cl::value_desc("input configuration filename"), llvm::cl::init(""));
                   
static llvm::cl::opt<std::string>
    jsonFilename("json", llvm::cl::desc("Json filename"),
                   llvm::cl::value_desc("json filename for file to log "
                   "tracing (trace event format)"), 
                   llvm::cl::init("../test/out/out.json"));

static llvm::cl::opt<std::string>
    outputFilename("o", llvm::cl::desc("Output filename"),
                   llvm::cl::value_desc("filename"), llvm::cl::init("-"));
                   
static llvm::cl::opt<bool> colName(
    "show-col-name",
    llvm::cl::desc("Show column name of output summary"),
    llvm::cl::init(false));
    
static llvm::cl::opt<bool> splitInputFile(
    "split-input-file",
    llvm::cl::desc("Split the input file into pieces and process each "
                   "chunk independently"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> verifyDiagnostics(
    "verify-diagnostics",
    llvm::cl::desc("Check that emitted diagnostics match "
                   "expected-* lines on the corresponding line"),
    llvm::cl::init(false));

static llvm::cl::opt<bool> verifyPasses(
    "verify-each",
    llvm::cl::desc("Run the verifier after each transformation pass"),
    llvm::cl::init(true));

static llvm::cl::opt<bool> allowUnregisteredDialects(
    "allow-unregistered-dialect",
    llvm::cl::desc("Allow operation with no registered dialects"),
    llvm::cl::init(false));

static llvm::cl::opt<bool>
    showDialects("show-dialects",
                 llvm::cl::desc("Print the list of registered dialects"),
                 llvm::cl::init(false));
                 
mlir::OwningModuleRef loadFileAndProcessModule(mlir::MLIRContext &context) {
  mlir::OwningModuleRef module;

	llvm::ErrorOr<std::unique_ptr<llvm::MemoryBuffer>> fileOrErr =
		llvm::MemoryBuffer::getFileOrSTDIN(inputFilename);
	if (std::error_code EC = fileOrErr.getError()) {
	  llvm::errs() << "Could not open input file: " << EC.message() << "\n";
	  return nullptr;
	}
	llvm::SourceMgr sourceMgr;
	sourceMgr.AddNewSourceBuffer(std::move(*fileOrErr), llvm::SMLoc());
	module = mlir::parseSourceFile(sourceMgr, &context);
	if (!module) {
	  llvm::errs() << "Error can't load file " << inputFilename << "\n";
	  return nullptr;
	}
	if (failed(mlir::verify(*module))) {
	  llvm::errs() << "Error verifying MLIR module\n";
	  return nullptr;
	}
	if (!module)
		return nullptr;
	return module;
}
int main(int argc, char **argv) {
  mlir::registerAllDialects();
  mlir::registerAllPasses();
  equeue::registerStructureMatchingPass();
  equeue::registerSplitLaunchPass();
  equeue::registerTilingPass();
  equeue::registerParallelizePass();
  equeue::registerAllocatePass();
  equeue::registerReassignBufferPass();
  equeue::registerMemCopyPass();
  equeue::registerMemCopyToLaunchPass();
  equeue::registerMergeMemCopyLaunchPass();
  equeue::registerLoopRemovingPass();
  equeue::registerSimplifyAffineLoopPass();
  equeue::registerLoopReorderPass();
  equeue::registerAddLoopPass();
  equeue::registerMergeLoopPass();
  equeue::registerModifyLoopPass();
  equeue::registerEqueueReadWritePass();
  equeue::registerSystolicArrayPass();
  equeue::registerParallelToEQueuePass();
  equeue::registerLowerExtractionPass();

  // Register equeue passes here.
  mlir::registerDialect<equeue::EQueueDialect>();

  llvm::InitLLVM y(argc, argv);

  // Register any pass manager command line options.
  mlir::registerPassManagerCLOptions();
  mlir::PassPipelineCLParser passPipeline("", "Compiler passes to run");

  // Parse pass names in main to ensure static initialization completed.
  llvm::cl::ParseCommandLineOptions(argc, argv,
                                    "MLIR modular optimizer driver\n");

  mlir::MLIRContext context;
  if (showDialects) {
    llvm::outs() << "Registered Dialects:\n";
    for (mlir::Dialect *dialect : context.getRegisteredDialects()) {
      llvm::outs() << dialect->getNamespace() << "\n";
    }
    return 0;
  }
  
  std::string errorMessage;
  auto output = mlir::openOutputFile(outputFilename, &errorMessage);
  if (!output) {
    llvm::errs() << errorMessage << "\n";
    exit(1);
  }
  
  if(generate!=""){
    MLIRGenImpl generator(context);	  
    generator.equeueGenerator(generate, configFilename);
    
  }
  else{
    // Set up the input file.
    auto file = mlir::openInputFile(inputFilename, &errorMessage);
    if (!file) {
      llvm::errs() << errorMessage << "\n";
      return 1;
    }
	  
    
    if(simulateInputFile){    
      if (failed(MlirOptMain(llvm::nulls(), std::move(file), passPipeline,
         splitInputFile, verifyDiagnostics, verifyPasses,
         allowUnregisteredDialects))) {
        return 1;
      }
      auto module = loadFileAndProcessModule(context);
	    std::string json_fn;
	    if (jsonFilename.c_str()) json_fn = jsonFilename.c_str();
	    std::ofstream json_fp(json_fn);
	    std::stringstream traceStream;
	    CommandProcessor proc(traceStream);
      if(colName){
        llvm::outs()<<"exec_time,cycles,sram_read_total,sram_write_total,"
          <<"reg_read_total,reg_write_total,sram_read,sram_write,reg_read,reg_write,"
          <<"sram_max_read,sram_max_write,reg_max_read,reg_max_write,sram_n_max_read,"
          <<"sram_n_max_write,reg_n_max_read,reg_n_max_write\n"; 
	    }
	    proc.run(module.get());
      json_fp << traceStream.str();
    }else{
      if (failed(MlirOptMain(llvm::outs(), std::move(file), passPipeline,
         splitInputFile, verifyDiagnostics, verifyPasses,
         allowUnregisteredDialects))) {
        return 1;
      }
    
    }
  }
  


  // Keep the output file if the invocation of MlirOptMain was successful.
  //output->keep();
  return 0;
}
