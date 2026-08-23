vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/froncu/tephra.git
    REF b152c8c188e3acb36cec0016cb498a411d015ae9)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME tephra)
vcpkg_copy_tools(TOOL_NAMES tephra AUTO_CLEAN)