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
#include "EQueue/CommandProcessor.h"
#include "Generator/EQueueGenerator.h"

static llvm::cl::opt<bool> generateInputFile(
    "generate",
    llvm::cl::desc("generate the input file"),
    llvm::cl::init(false));

static llvm::cl::opt<std::string> inputFilename(llvm::cl::Positional,
                                                llvm::cl::desc("<input file>"),
                                                llvm::cl::init("-"));
static llvm::cl::opt<std::string>
    configFilename("config", llvm::cl::desc("Config filename"),
                   llvm::cl::value_desc("input configuration filename"), llvm::cl::init(""));
static llvm::cl::opt<std::string>
    jsonFilename("json", llvm::cl::desc("Json filename"),
                   llvm::cl::value_desc("json filename for file to log tracing (trace event format)"), llvm::cl::init("../test/out/out.json"));
static llvm::cl::opt<std::string>
    outputFilename("o", llvm::cl::desc("Output filename"),
                   llvm::cl::value_desc("filename"), llvm::cl::init("-"));

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

  // Register equeue passes here.
  mlir::registerDialect<xilinx::equeue::EQueueDialect>();

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
  
  if(generateInputFile){
    MLIRGenImpl generator(context);	  
    
    std::string config_fn;
	  if (configFilename!=""){ config_fn = configFilename.c_str();
	    std::ifstream config_fp(config_fn);
	    if ( config_fp ) {
          std::stringstream configBuffer;
          configBuffer << config_fp.rdbuf();
          generator.loadConfiguration(configBuffer);
          config_fp.close();
      } else {
        llvm::errs() << "cannot find configration file"<<configFilename.c_str()<<"!\n";
      }
    }
    
    generator.linalgGenerator2();
  }
  else{
    // Set up the input file.
    auto file = mlir::openInputFile(inputFilename, &errorMessage);
    if (!file) {
      llvm::errs() << errorMessage << "\n";
      return 1;
    }

    if (failed(MlirOptMain(output->os(), std::move(file), passPipeline,
                           splitInputFile, verifyDiagnostics, verifyPasses,
                           allowUnregisteredDialects))) {
      return 1;
    }
	  /*
    auto module = loadFileAndProcessModule(context);
	  PassManager pm(module->getContext());

	  
	  std::string json_fn;
	  if (jsonFilename.c_str()) json_fn = jsonFilename.c_str();
	  std::ofstream json_fp(json_fn);
	  std::stringstream traceStream;
	  acdc::CommandProcessor proc(traceStream);
	  proc.run(module.get());
    json_fp << traceStream.str();*/
  }
  


  // Keep the output file if the invocation of MlirOptMain was successful.
  output->keep();
  return 0;
}
