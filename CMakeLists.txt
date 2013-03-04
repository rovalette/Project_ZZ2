cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH bin/)

macro(compile_test src_file)
	
	try_compile(
		result
		${CMAKE_CURRENT_BINARY_DIR}/bin
		${src_file}
		OUTPUT_VARIABLE compile_error_log
	)
	
	message(STATUS "------> ${result}")
	message(STATUS ${compile_error_log})
	
endmacro(compile_test)

file(
	GLOB_RECURSE
	source_files
	src/*.cpp
)

foreach(f ${source_files})
	message(STATUS "----> compile_test(${f})")
	compile_test(${f})
endforeach()
