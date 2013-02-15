macro(check var val)
  if(NOT "${${var}}" STREQUAL "${val}")
    message(SEND_ERROR "${var} is \"${${var}}\", not \"${val}\"")
  endif()
endmacro()

message(STATUS "config=[${config}]")
check(test_0 "")
check(test_0_with_comma "")
check(test_1 "content")
check(test_1_with_comma "-Wl,--no-undefined")
check(test_and_0 "0")
check(test_and_0_0 "0")
check(test_and_0_1 "0")
check(test_and_1 "1")
check(test_and_1_0 "0")
check(test_and_1_1 "1")
check(test_config_0 "0")
check(test_config_1 "1")
foreach(c debug release relwithdebinfo minsizerel)
  if(NOT "${test_config_${c}}" MATCHES "^(0+|1+)$")
    message(SEND_ERROR "test_config_${c} is \"${test_config_${c}}\", not all 0 or all 1")
  endif()
endforeach()
check(test_not_0 "1")
check(test_not_1 "0")
check(test_or_0 "0")
check(test_or_0_0 "0")
check(test_or_0_1 "1")
check(test_or_1 "1")
check(test_or_1_0 "1")
check(test_or_1_1 "1")
check(test_bool_notfound "0")
check(test_bool_foo_notfound "0")
check(test_bool_true "1")
check(test_bool_false "0")
check(test_bool_on "1")
check(test_bool_off "0")
check(test_bool_no "0")
check(test_bool_n "0")
check(test_bool_empty "0")
check(test_strequal_yes_yes "1")
check(test_strequal_yes_yes_cs "0")
check(test_strequal_yes_no "0")
check(test_strequal_no_yes "0")
check(test_strequal_angle_r "1")
check(test_strequal_comma "1")
check(test_strequal_angle_r_comma "0")
check(test_strequal_both_empty "1")
check(test_strequal_one_empty "0")
check(test_angle_r ">")
check(test_comma ",")
check(test_colons_1 ":")
check(test_colons_2 "::")
check(test_colons_3 "Qt5::Core")
check(test_colons_4 "C:\\\\CMake")
check(test_colons_5 "C:/CMake")
check(test_incomplete_1 "$<")
check(test_incomplete_2 "$<something")
check(test_incomplete_3 "$<something:")
check(test_incomplete_4 "$<something:,")
check(test_incomplete_5 "$something:,>")
check(test_incomplete_6 "<something:,>")
check(test_incomplete_7 "$<something::")
check(test_incomplete_8 "$<something:,")
check(test_incomplete_9 "$<something:,,")
check(test_incomplete_10 "$<something:,:")
check(test_incomplete_11 "$<something,,")
check(test_incomplete_12 "$<,,")
check(test_incomplete_13 "$<somespecialthing")
check(test_incomplete_14 "$<>")
check(test_incomplete_15 "$<some$<thing")
check(test_incomplete_16 "$<BOOL:something")
check(test_incomplete_17 "some$thing")
check(test_incomplete_18 "$<1:some,thing")
check(test_incomplete_19 "$<1:some,thing>")
check(test_incomplete_20 "$<CONFIGURATION>")
check(test_incomplete_21 "$<BOOL:something>")
