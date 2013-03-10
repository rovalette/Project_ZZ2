
enable_testing()

include(${CMAKE_CURRENT_SOURCE_DIR}/modules/errors_dico.cmake)

# macro : compile_test
#
#

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

# macro : create_compile_test
# _src_file : absolute path to source file
#

macro(create_compile_test _src_file _test_name _expected_result _expected_error)
	compile_test(${_src_file} result log)
	
	string(TOLOWER ${result} result)
	string(TOLOWER ${_expected_result} _expected_result)
	
	set(expected_error ${${_expected_error}})
	
	set(_error_file ${CMAKE_CURRENT_BINARY_DIR}/test/data/${_test_name}_errors.txt)
	configure_file(
		test/template_errors.txt.in
		${_error_file}
		@ONLY
	)
	#set(_expected_error ${CMAKE_CURRENT_SOURCE_DIR}/test/expected_error.txt.in)
	
	configure_file(
		test/template_test.cpp.in
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
		@ONLY
	)
	
	add_executable(
		${_test_name}
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
	)
	
	add_test(
		${_test_name}
		test/bin/${_test_name}
	)
endmacro(create_compile_test)

#macro(create_compile_test _src_file _test_name _expected_result)
	
#	create_compile_test(${_src_file} ${_test_name} ${_expected_result} "")
	
#endmacro(create_compile_test)