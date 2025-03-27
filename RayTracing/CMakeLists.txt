cmake_minimum_required(VERSION 3.31.0)
project(RayTracing CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(MINGW OR WIN32)
    message(STATUS "RayTracing Windows build")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mwindows")
endif(MINGW OR WIN32)

find_package(Vulkan REQUIRED)
find_package(OpenGL REQUIRED)

file(GLOB_RECURSE ${PROJECT_NAME}_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/**.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/src/**.h
)

add_executable(${PROJECT_NAME} ${${PROJECT_NAME}_SRC})

# Add the correct include directory for Walnut headers
target_include_directories(${PROJECT_NAME} PRIVATE 
    ${CMAKE_SOURCE_DIR}/Walnut-cmake/Walnut/src
    ${CMAKE_SOURCE_DIR}/Walnut-cmake/vendor/glfw/include
    ${CMAKE_SOURCE_DIR}/Walnut-cmake/vendor/imgui
    ${CMAKE_SOURCE_DIR}/Walnut-cmake/vendor/glm
)

target_link_libraries(${PROJECT_NAME} PRIVATE 
    Walnut 
    ${Vulkan_LIBRARIES} 
    glfw 
    ${OPENGL_gl_LIBRARY}
)
