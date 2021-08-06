cmake_minimum_required(VERSION 3.15)
set(project_name calcifer)
project(${project_name})

set(CMAKE_CXX_STANDARD 17)

# AddressSanitizer, currently removed to pass basic tests
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")

# make target
file(GLOB_RECURSE source_files ${PROJECT_SOURCE_DIR}/src/*.cpp ${PROJECT_SOURCE_DIR}/src/front/*.cpp)
include_directories(${PROJECT_SOURCE_DIR}/include)
add_executable(${project_name} ${source_files})

