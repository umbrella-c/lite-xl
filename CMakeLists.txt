cmake_minimum_required(VERSION 3.8)
project(lite-xl C)

set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules/")
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

include_directories(src/api src)

# locate required packages
find_package(Lua REQUIRED)
find_package(SDL2 REQUIRED)

# Configure primary executable target
add_executable(lite
    src/api/dirmonitor/dummy.c

    src/api/api.c
    src/api/dirmonitor.c
    src/api/process.c
    src/api/regex.c
    src/api/renderer.c
    src/api/system.c
    src/api/utf8.c
    
    src/main.c
    src/rencache.c
    src/renderer.c
    src/renwindow.c
)
target_include_directories(lite PRIVATE ${SDL2_INCLUDE_DIR} ${LUA_INCLUDE_DIR})
target_link_libraries(lite PRIVATE ${SDL2_LIBRARY} ${LUA_LIBRARY})

# Add a new install target
install(TARGETS lite DESTINATION bin)
install(DIRECTORY data DESTINATION share/lite)
