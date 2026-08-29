include(${CMAKE_CURRENT_LIST_DIR}/paths.cmake)
set(LLVM_BIN ${LLVM_ROOT}/bin)

if (CMAKE_HOST_WIN32)
   set(CMAKE_C_COMPILER ${LLVM_BIN}/clang-cl.exe)
   set(CMAKE_CXX_COMPILER ${LLVM_BIN}/clang-cl.exe)

   if (NOT DEFINED VCPKG_TARGET_ARCHITECTURE OR NOT DEFINED VCPKG_CRT_LINKAGE)
      set(CMAKE_RC_COMPILER ${LLVM_BIN}/llvm-rc.exe)
   endif ()
else ()
   set(CMAKE_C_COMPILER ${LLVM_BIN}/clang)
   set(CMAKE_CXX_COMPILER ${LLVM_BIN}/clang++)
endif ()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../scripts)