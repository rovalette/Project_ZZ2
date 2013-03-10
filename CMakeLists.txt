cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH test/bin/)

include(modules/CompileTest.cmake)

create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main1.cpp "test_main1_compile_pas" FALSE EXPECTED_SEMICOLON)
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main2.cpp "test_main2_compile_pas" FALSE FILE_NOT_FOUND)
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main3.cpp "test_main3_compile" TRUE NO_ERROR)
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main4.cpp "test_main4_compile_pas" FALSE ANY_ERROR)
