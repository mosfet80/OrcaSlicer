bambustudio_add_cmake_project(
    TBB
    URL "https://github.com/wjakob/tbb/archive/e07dd0fd6b215325d3b9fd272c6cdb6d2c55e093.zip"
    URL_HASH SHA256=52b3d056fba461eb0c5a2b7442e2f30bb4b6a498ad4480654791e3bb2e6da194
    PATCH_COMMAND ${PATCH_CMD} ${CMAKE_CURRENT_LIST_DIR}/0001-TBB-GCC13.patch
    CMAKE_ARGS
        -DTBB_BUILD_SHARED=OFF
        -DTBB_BUILD_TESTS=OFF
        -DTBB_BUILD_TESTS=OFF
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DCMAKE_DEBUG_POSTFIX=_debug
)

if (MSVC)
    add_debug_dep(dep_TBB)
endif ()


