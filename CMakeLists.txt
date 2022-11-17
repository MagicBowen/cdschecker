cmake_minimum_required(VERSION 3.10)

# ---- Project ----

project(cdschecker VERSION 1.0.0)

# ---- Include guards ----

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    message(
        FATAL_ERROR
            "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there."
    )
endif()

# ---- Options for project ----

option(ENABLE_TEST   "Build tests" ON)
option(ENABLE_BENCH  "Build bench tests" ON)

# ---- Lib config ----
set(TARGET_LIB model)
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -g -O3")

if (CMAKE_HOST_APPLE)
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_XOPEN_SOURCE -DMAC")
    # add_definitions(-Wno-invalid-offsetof -Wno-format)
endif()

# ---- Add source for project ----

add_subdirectory(src)

# ---- Add test for project ----
if(ENABLE_TEST)
    add_subdirectory(test)
endif()

# ---- Add test for project ----
if(ENABLE_BENCH)
    add_subdirectory(benchmarks)
endif()
