cmake_minimum_required(VERSION 2.6)

project(proj_test)

set(EXECUTABLE_OUTPUT_PATH test/bin/)

macro(compile_test _src_file _result _error_log)
	
	try_compile(
		result
		${CMAKE_CURRENT_BINARY_DIR}/bin
		${_src_file}
		OUTPUT_VARIABLE error_log
	)
	
	if(result)
		set(${_result} FALSE)
	else()
		set(${_result} TRUE)
		set(${_error_log} ${error_log})
	endif()
	
endmacro(compile_test)

macro(create_compile_test _src_file _test_name)
	
	compile_test(${_src_file} result log)
	
	set(__test_name ${_test_name})
	
	if(result)
		set(_error_file ${CMAKE_CURRENT_BINARY_DIR}/test/data/${_test_name}_errors.txt)
		configure_file(
			test/template_errors.txt.in
			${_error_file}
		)
		set(_expected_error ${CMAKE_CURRENT_SOURCE_DIR}/test/expected_error.txt.in)
		set(_is_errors true)
		set(_log_infos "")
		set(_return_value 1)
	else()
		set(_is_errors false)
		set(_log_infos "")
		set(_return_value 0)
	endif()
	
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
	get_filename_component(testname ${f} NAME)
	get_filename_component(testnameWE ${f} NAME_WE)
	message(STATUS "----> ${testname}")
	create_compile_test(${f} ${testnameWE})
endforeach()

