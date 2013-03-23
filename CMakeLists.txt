cmake_minimum_required(VERSION 2.6)

project(myProj)

set(EXECUTABLE_OUTPUT_PATH test/bin/)

include(modules/CompileTest.cmake)

add_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main1.cpp "test_main1_compile_pas" EXPECT_ONLY EXPECTED_SEMICOLON)
add_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main2.cpp "test_main2_compile_pas" EXPECT FILE_NOT_FOUND)
add_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main3.cpp "test_main3_compile" EXPECT NO_ERROR)
add_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main4.cpp "test_main4_compile_pas" EXPECT_ONLY UNDECLARED_IDENTIFIER)
