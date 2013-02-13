cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH bin/)

file(
	GLOB_RECURSE
	source_files
	src/*
)

add_executable(
	proj_test
	${source_files}
)

enable_testing()

try_compile(
	RESULT
	${CMAKE_CURRENT_BINARY_DIR}/bin/ 
	${CMAKE_CURRENT_SOURCE_DIR}/src/main.cpp
	OUTPUT_VARIABLE LOG1
)

message(STATUS ${RESULT})
