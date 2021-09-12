# C
### Pre-compiler
- Add `#include "CStaticLibrary.h"` in StaticLibraryExample-Bridging-Header.h file
### Compiler (Clang)
- Header Search Paths: `$(PROJECT_DIR)/library/product/CStaticLibrary`
### Linker (Clang)
- Library Search Paths: `$(PROJECT_DIR)/library/product/CStaticLibrary`
- Other linker flags: `-lCStaticLibrary`

# Objective C
### Pre-compiler
- Add `#include "ObjCStaticLibrary.h"` in StaticLibraryExample-Bridging-Header.h file
### Compiler (Clang)
- Header Search Paths: `$(PROJECT_DIR)/library/product/ObjCStaticLibrary`
### Linker (Clang)
- Library Search Paths: `$(PROJECT_DIR)/library/product/ObjCStaticLibrary`
- Other linker flags: `-lObjCStaticLibrary`

# Swift
### Compiler (Swift Compiler)
- Swift Compiler - Search Paths: `$(PROJECT_DIR)/library/product/SwiftStaticLibrary`
### Linker (Clang)
- Library Search Paths: `$(PROJECT_DIR)/library/product/ObjCStaticLibrary`
- Other linker flags: `-lSwiftStaticLibrary`
