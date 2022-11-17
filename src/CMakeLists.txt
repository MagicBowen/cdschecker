file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
    "*.c" "*.C" "*.cc" "*.CC" "*.cpp" "*.CPP" "*.c++"
)

list(REMOVE_ITEM SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/malloc.c")

if (CMAKE_HOST_APPLE)
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-undefined,dynamic_lookup -dynamiclib")
endif()

add_library(malloc OBJECT malloc.c)
target_compile_options(malloc PRIVATE -fPIC)
target_compile_definitions(malloc PRIVATE MSPACES ONLY_MSPACES HAVE_MMAP=0)

add_library(${TARGET_LIB} SHARED ${SOURCES})

target_link_libraries(${TARGET_LIB} malloc dl)
# target_compile_definitions(${TARGET_LIB} PRIVATE -rdynamic)

target_include_directories(${TARGET_LIB}
    PUBLIC ${PROJECT_SOURCE_DIR}/include
    PRIVATE ${PROJECT_SOURCE_DIR}/include/cdschecker
)
