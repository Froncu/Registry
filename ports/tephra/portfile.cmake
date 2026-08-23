vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/froncu/tephra.git
    REF 926e4f1446d68740dc01f3a008263502a3c2492d)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_copy_tools(TOOL_NAMES tephra AUTO_CLEAN)