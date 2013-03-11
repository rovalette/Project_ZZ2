
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
	
	set(${_result} ${result})
	
	if(NOT result)
		set(${_error_log} ${error_log})
	endif()
	
endmacro(compile_test)

# macro : create_compile_test
# _src_file : absolute path to source file
#

macro(add_compile_test _src_file _test_name _expected_result _expected_error)
	
	############### ARG CONTROL #####################
	
	# check if the expected error is defined
	if (NOT ${_expected_error})
		message(FATAL_ERROR "${_expected_error} is not defined")
	endif()
	set(__expected_error ${_expected_error})
	set(_expected_error ${_expected_error})
	set(expected_error ${${_expected_error}})
	set(_expected_result ${_expected_result})
	
	# arguments control
	if(_expected_result MATCHES "^EXPECT$")
		
		if(_expected_error MATCHES NO_ERROR)
			set(__expected_result true)
			set(_allow_unexpected false)
		else()
			set(__expected_result false)
			set(_allow_unexpected true)
		endif()
		
	elseif(_expected_result MATCHES "^EXPECT_ONLY$")
		
		if(_expected_error MATCHES ANY_ERROR)
			message(FATAL_ERROR "EXPECT_ONLY argument cannot be used with ANY_ERROR argument")
		elseif(_expected_error MATCHES NO_ERROR)
			set(__expected_result true)
			set(_allow_unexpected false)
		else()
			set(__expected_result false)
			set(_allow_unexpected false)
		endif()
		
	else()
		message(FATAL_ERROR "invalid argument ${_expected_result} in add_compile_test")
	endif()
	
	####################### END ARG CONTROL ##########################
	
	# launch the try_compile task
	compile_test(${_src_file} result log)
	string(TOLOWER ${result} result)
	
	if(${result} MATCHES true)
		if(${__expected_result} MATCHES true)
			set(_no_error_text "TEST SUCCEEDED")
		else()
			set(_no_error_text "TEST FAILED (${_expected_error} error was expected)")
		endif()
	endif()
	
	# put the log into a file
	set(_error_file ${CMAKE_CURRENT_BINARY_DIR}/test/data/${_test_name}_errors.txt)
	configure_file(
		modules/template_errors.txt.in
		${_error_file}
	)
	
	# configure a cpp file with the result of try_compile
	configure_file(
		modules/template_test.cpp.in
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
	)
	
	# create an executable for the test
	add_executable(
		${_test_name}
		${CMAKE_CURRENT_BINARY_DIR}/test/src/${_test_name}.cpp
	)
	
	# add the executable to the ctest suite
	add_test(
		${_test_name}
		test/bin/${_test_name}
	)
endmacro(add_compile_test)

