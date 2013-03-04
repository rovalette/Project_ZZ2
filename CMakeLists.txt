cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH test/bin/)

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

macro(create_compile_test _src_file _test_name)
	
	compile_test(${_src_file} result log)
	
	if(result)
		set(_success_or_fail failed)
		set(_log_infos "")
		set(_return_value 1)
	else()
		set(_success_or_fail succeeded)
		set(_log_infos "")
		set(_return_value 0)
	endif()
	
	set(__test_name ${_test_name})
	
	configure_file(
		test/template_test.cpp.in
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
	)
	
	add_executable(
		${_test_name}
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
	)
	
	add_test(
		try_compile_${_test_name}
		test/bin/${_test_name}
	)
	
endmacro(create_compile_test)

file(
	GLOB
	source_files
	src/*.cpp
)

enable_testing()

foreach(f ${source_files})
	string(REGEX REPLACE ".*/([^/]+).cpp" "\\1" testname ${f})
	message(STATUS "----> ${f}")
	create_compile_test(${f} ${testname})
endforeach()

