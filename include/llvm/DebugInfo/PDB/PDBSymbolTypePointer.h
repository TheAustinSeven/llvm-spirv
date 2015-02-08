//===- PDBSymbolTypePointer.h - pointer type info ---------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H
#define LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H

#include "PDBSymbol.h"
#include "PDBTypes.h"

namespace llvm {

class raw_ostream;

class PDBSymbolTypePointer : public PDBSymbol {
public:
  PDBSymbolTypePointer(std::unique_ptr<IPDBRawSymbol> PointerTypeSymbol);

  void dump(llvm::raw_ostream &OS) const override;

  FORWARD_SYMBOL_METHOD(isConstType)
  FORWARD_SYMBOL_METHOD(getLength)
  FORWARD_SYMBOL_METHOD(getLexicalParentId)
  FORWARD_SYMBOL_METHOD(isReference)
  FORWARD_SYMBOL_METHOD(getSymIndexId)
  FORWARD_SYMBOL_METHOD(getTypeId)
  FORWARD_SYMBOL_METHOD(isUnalignedType)
  FORWARD_SYMBOL_METHOD(isVolatileType)

  static bool classof(const PDBSymbol *S) {
    return S->getSymTag() == PDB_SymType::PointerType;
  }
};

} // namespace llvm

#endif // LLVM_DEBUGINFO_PDB_PDBSYMBOLTYPEPOINTER_H
