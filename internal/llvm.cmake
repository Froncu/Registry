set(LLVM_VERSION 23.1.0)

cmake_host_system_information(RESULT HOST_SYSTEM_PROCESSOR QUERY OS_PLATFORM)
string(TOLOWER ${HOST_SYSTEM_PROCESSOR} HOST_SYSTEM_PROCESSOR)
if (CMAKE_HOST_WIN32)
   if (HOST_SYSTEM_PROCESSOR MATCHES "^(amd64|x86_64)$")
      set(LLVM_URL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/clang+llvm-${LLVM_VERSION}-x86_64-pc-windows-msvc.tar.xz")
   else ()
      message(FATAL_ERROR "Unsupported Windows architecture: ${HOST_SYSTEM_PROCESSOR}")
   endif ()
elseif (CMAKE_HOST_LINUX)
   if (HOST_SYSTEM_PROCESSOR MATCHES "^(amd64|x86_64)$")
      set(LLVM_URL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/LLVM-${LLVM_VERSION}-Linux-X64.tar.xz")
   elseif (HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
      set(LLVM_URL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/LLVM-${LLVM_VERSION}-Linux-ARM64.tar.xz")
   else ()
      message(FATAL_ERROR "Unsupported Linux architecture: ${HOST_SYSTEM_PROCESSOR}")
   endif ()
elseif (CMAKE_HOST_APPLE)
   if (HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
      set(LLVM_URL "https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/LLVM-${LLVM_VERSION}-macOS-ARM64.tar.xz")
   else ()
      message(FATAL_ERROR "Unsupported macOS architecture: ${HOST_SYSTEM_PROCESSOR}")
   endif ()
else ()
   message(FATAL_ERROR "Unsupported host OS: ${HOST_SYSTEM_PROCESSOR}")
endif ()

include(${CMAKE_CURRENT_LIST_DIR}/paths.cmake)

set(LLVM_LOCK_FILE ${REGISTRY_ARCHIVE}/llvm.lock)
set(LLVM_URL_FILE ${LLVM_ROOT}/llvm.url)

file(LOCK ${LLVM_LOCK_FILE} TIMEOUT 0 RESULT_VARIABLE LLVM_LOCK_RESULT)
if (NOT LLVM_LOCK_RESULT STREQUAL "0")
   message(STATUS "LLVM is being set up by another configuration; waiting...")
   file(LOCK ${LLVM_LOCK_FILE})
endif ()

if (EXISTS ${LLVM_URL_FILE})
   file(READ ${LLVM_URL_FILE} LLVM_INSTALLED_URL)
endif ()

if (NOT LLVM_INSTALLED_URL STREQUAL LLVM_URL)
   include(FetchContent)
   FetchContent_Populate(LLVM
      URL ${LLVM_URL}
      SOURCE_DIR ${LLVM_ROOT}
      BINARY_DIR ${REGISTRY_ARCHIVE}/fetch_content/build
      SUBBUILD_DIR ${REGISTRY_ARCHIVE}/fetch_content/subbuild
      DOWNLOAD_EXTRACT_TIMESTAMP TRUE)
   file(WRITE ${LLVM_URL_FILE} ${LLVM_URL})
   message(STATUS "LLVM ${LLVM_VERSION} installed at ${LLVM_ROOT}")
else ()
   message(STATUS "LLVM ${LLVM_VERSION} found at ${LLVM_ROOT}")
endif ()

file(LOCK ${LLVM_LOCK_FILE} RELEASE)
file(REMOVE ${LLVM_LOCK_FILE})

include(${CMAKE_CURRENT_LIST_DIR}/clang.cmake)