cmake_minimum_required(VERSION 3.15)
project(beats VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Add executable
add_executable(beats beats.cpp)

# Enable Unicode support
target_compile_definitions(beats PRIVATE UNICODE _UNICODE)

# Install target
install(TARGETS beats
        RUNTIME DESTINATION bin)
