vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/froncu/tephra.git
    REF 8cf757e8441e745de80e2ed36a525de622dddc7e)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME tephra)
vcpkg_copy_tools(TOOL_NAMES tephra AUTO_CLEAN)