vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/froncu/tephra.git
    REF 69bd7a56e7b97790c30b08598fa18cca3479cd66)

vcpkg_from_git(
   OUT_SOURCE_PATH REGISTRY_SOURCE_PATH
   URL https://github.com/froncu/registry.git
   REF a51306fb8ee7aaa320570600904a16a950baacdd)

file(MAKE_DIRECTORY ${SOURCE_PATH}/registry/scripts)
file(COPY ${REGISTRY_SOURCE_PATH}/scripts/target_defaults.cmake DESTINATION ${SOURCE_PATH}/registry/scripts)

vcpkg_cmake_configure(SOURCE_PATH ${SOURCE_PATH})
vcpkg_cmake_install()
vcpkg_copy_tools(TOOL_NAMES tephra AUTO_CLEAN)