cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH bin/)

macro(compile_test _src_file _result _error_log)
	
	try_compile(
		result
		${CMAKE_CURRENT_BINARY_DIR}/bin
		${_src_file}
		OUTPUT_VARIABLE ${_error_log}
	)
	
	if(result)
		set(${_result} FALSE)
	else()
		set(${_result} TRUE)
	endif()
	
endmacro(compile_test)

macro(create_compile_test _src_file)
	
endmacro(create_compile_test)

file(
	GLOB
	source_files
	src/*.cpp
)

foreach(f ${source_files})
	message(STATUS "----> ${f}")
	compile_test(${f} result log)
	message(STATUS "--------> ${result}")
	if(result)
		#message(STATUS ${log})
	endif()
endforeach()

