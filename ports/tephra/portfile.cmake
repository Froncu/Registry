vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/froncu/tephra.git
    REF 85257af9a74ce33f4630d3afe0ca393c81742693)

set(VCPKG_BUILD_TYPE release)
vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_cmake_config_fixup()
vcpkg_copy_tools(TOOL_NAMES tephra AUTO_CLEAN)