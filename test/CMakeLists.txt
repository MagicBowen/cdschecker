# ---- Name of test target ----

set(TEST_TARGET ${TARGET_LIB}_test)

# ---- Source files of test ----

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
    "*.c" "*.C" "*.cc" "*.CC" "*.cpp" "*.CPP" "*.c++")

# ---- Define test target ----

add_library(${TEST_TARGET} OBJECT ${SOURCES})

target_include_directories(${TEST_TARGET}
    PRIVATE ${PROJECT_SOURCE_DIR}/include/cdschecker
            ${PROJECT_SOURCE_DIR}/src)

target_link_libraries(${TEST_TARGET} PRIVATE ${TARGET_LIB})