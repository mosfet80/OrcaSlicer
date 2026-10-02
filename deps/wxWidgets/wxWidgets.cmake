if (NOT EMSCRIPTEN)
    set(_wx_toolkit "")
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        set(_wx_toolkit "-DwxBUILD_TOOLKIT=gtk3")
    endif()

    set(_unicode_utf8 OFF)
    if (UNIX AND NOT APPLE) # wxWidgets will not use char as the underlying type for wxString unless its forced to.
        set (_unicode_utf8 ON)
    endif()

    if (MSVC)
        set(_wx_webview "-DwxUSE_WEBVIEW_EDGE=ON")

    else ()
        set(_wx_webview "-DwxUSE_WEBVIEW=ON")
    endif ()

    if (UNIX AND NOT APPLE)
        set(_wx_secretstore "-DwxUSE_SECRETSTORE=OFF")
    else ()
        set(_wx_secretstore "-DwxUSE_SECRETSTORE=ON")
    endif ()

orcaslicer_add_cmake_project(
    wxWidgets
    GIT_REPOSITORY "https://github.com/SoftFever/Orca-deps-wxWidgets"
    GIT_TAG v3.3.2
    GIT_SHALLOW ON
    GIT_SUBMODULES 3rdparty/catch 3rdparty/pcre 3rdparty/libwebp
    PATCH_COMMAND ${_wx_patch_command}
    DEPENDS ${PNG_PKG} ${ZLIB_PKG} ${EXPAT_PKG} ${JPEG_PKG}
    CMAKE_ARGS
        -DwxBUILD_PRECOMP=ON
        ${_wx_toolkit}
        "-DCMAKE_DEBUG_POSTFIX:STRING=${_wx_debug_postfix}"
        -DwxBUILD_DEBUG_LEVEL=0
        -DwxBUILD_SAMPLES=OFF
        ${_wx_shared}
        -DwxUSE_MEDIACTRL=ON
        -DwxUSE_DETECT_SM=OFF
        -DwxUSE_PRIVATE_FONTS=ON
        -DwxUSE_OPENGL=ON
        -DwxUSE_GLCANVAS_EGL=ON
        -DwxUSE_WEBREQUEST=ON
        -DwxUSE_WEBVIEW=ON
        ${_wx_edge}
        -DwxUSE_WEBVIEW_IE=OFF
        -DwxUSE_REGEX=builtin
        -DwxUSE_LIBSDL=OFF
        -DwxUSE_XTEST=OFF
        -DwxUSE_STC=OFF
        -DwxUSE_AUI=ON
        -DwxUSE_LIBPNG=sys
        -DwxUSE_ZLIB=sys
        -DwxUSE_LIBJPEG=sys
        -DwxUSE_LIBTIFF=OFF
        -DwxUSE_LIBWEBP=builtin
        -DwxUSE_EXPAT=sys
        -DwxUSE_NANOSVG=OFF
)
    set(DEP_wxWidgets_DEPENDS ZLIB PNG EXPAT JPEG NanoSVG)


    if (MSVC)
        # After the build, copy the WebView2Loader.dll into the installation directory.
        # This should probably be done better.
        add_custom_command(TARGET dep_wxWidgets POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy
                "${CMAKE_CURRENT_BINARY_DIR}/builds/wxWidgets/lib/vc_x64_lib/WebView2Loader.dll"
                "${${PROJECT_NAME}_DEP_INSTALL_PREFIX}/bin/WebView2Loader.dll")
    endif()

endif ()
if (MSVC)
    add_debug_dep(dep_wxWidgets)
endif ()
