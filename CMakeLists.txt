cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH test/bin/)

include(modules/CompileTest.cmake)

file(
	GLOB
	source_files
	src/*.cpp
)

#foreach(f ${source_files})
#	get_filename_component(testname ${f} NAME)
#	get_filename_component(testnameWE ${f} NAME_WE)
#	message(STATUS "----> ${testname}")
#	create_compile_test(${f} ${testnameWE})
#endforeach()

create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main1.cpp "test_main1_compile_pas" FALSE "")
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main2.cpp "test_main2_compile_pas" FALSE FILE_NOT_FOUND)
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main3.cpp "test_main3_compile" TRUE "")
create_compile_test(${CMAKE_CURRENT_SOURCE_DIR}/src/main4.cpp "test_main4_compile_pas" FALSE UNDECLARED_IDENTIFIER)
