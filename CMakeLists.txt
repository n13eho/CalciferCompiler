cmake_minimum_required(VERSION 3.15)
set(project_name calcifer)
project(${project_name})

set(CMAKE_CXX_STANDARD 17)

# AddressSanitizer, currently removed to pass basic tests
#set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address")

# make target
file(GLOB_RECURSE source_files ${PROJECT_SOURCE_DIR}/src/*.cpp ${PROJECT_SOURCE_DIR}/src/front/*.cpp)
include_directories(${PROJECT_SOURCE_DIR}/include)
add_executable(${project_name} ${source_files})

# option for test
option(CUSTOM_TEST "Run custom test cases" ON)
option(FUNC_TEST "Run functional test cases" ON)
option(PERF_TEST "Run performance test cases" ON)

message("Custom test: ${CUSTOM_TEST}")
message("Functional test: ${FUNC_TEST}")
message("Performance test: ${PERF_TEST}")

# add test, usage: `make test` or `ctest`
enable_testing()

file(GLOB preliminary_func_test_cases "sysyruntimelibrary/section1/functional_test/*.sy")
file(GLOB preliminary_perf_test_cases "sysyruntimelibrary/section1/performance_test/*.sy")
file(GLOB final_perf_test_cases "sysyruntimelibrary/section2/performance_test/*.sy")
file(GLOB custom_test_cases "test_set/*.sy")

# test which cases
set(all_test_cases "")
if (FUNC_TEST)
    set(all_test_cases ${all_test_cases} ${preliminary_func_test_cases})
endif()
if (PERF_TEST)
    set(all_test_cases ${all_test_cases} ${preliminary_perf_test_cases} ${final_perf_test_cases})
endif()
if (CUSTOM_TEST)
    set(all_test_cases ${all_test_cases} ${custom_test_cases})
endif()
# test start, officially
foreach(file ${all_test_cases})
    get_filename_component(file_name "${file}" NAME_WE)
    add_test(NAME ${file_name}
            COMMAND ./${project_name} ${file})
endforeach()