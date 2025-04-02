cmake_minimum_required(VERSION 3.5.0)
project(RayTracing)

# Set architecture to x64
if(MSVC)
    set(CMAKE_GENERATOR_PLATFORM x64)
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64")
endif()

# Set configurations
set(CMAKE_CONFIGURATION_TYPES Debug Release Dist)

# Define output directory pattern
set(OUTPUT_DIR "${CMAKE_BUILD_TYPE}-${CMAKE_SYSTEM_NAME}-x64")

# Set global output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${OUTPUT_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${OUTPUT_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${OUTPUT_DIR})

# Set default startup project (for Visual Studio)
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT WalnutApp)

find_package(Vulkan REQUIRED)
include_directories(${Vulkan_INCLUDE_DIRS})
find_package(OpenGL REQUIRED)

# Generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Include subprojects
add_subdirectory(Walnut-cmake)
add_subdirectory(RayTracing)
