function(set_target_defaults TARGET_NAME)
   set_target_properties(${TARGET_NAME} PROPERTIES
      CXX_STANDARD 23
      CXX_STANDARD_REQUIRED TRUE)

   target_compile_options(${PROJECT_NAME}
      PRIVATE $<$<CXX_COMPILER_FRONTEND_VARIANT:GNU>:-Wall;-Wextra;-Wpedantic;-Werror;-Wno-braced-scalar-init>
      PRIVATE $<$<CXX_COMPILER_FRONTEND_VARIANT:MSVC>:/W4;/WX>)
endfunction()