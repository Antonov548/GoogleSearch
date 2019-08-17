include(GenerateExportHeader)

file(GLOB_RECURSE lib_includes "include/*.h")
file(GLOB_RECURSE lib_sources "src/*.cpp")

add_library(tray_icon SHARED ${lib_includes} ${lib_sources})

generate_export_header(tray_icon EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/exports/tray_icon_export.h)

target_link_libraries(tray_icon Qt5::Widgets Qt5::Core)

target_include_directories(tray_icon PUBLIC ${CMAKE_BINARY_DIR}/exports "include")

set_target_properties(tray_icon PROPERTIES TARGET_LIBRARY_OUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
get_target_property(lib_path tray_icon TARGET_LIBRARY_OUT_DIRECTORY)
set_target_properties(tray_icon PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ${lib_path} LIBRARY_OUTPUT_DIRECTORY ${lib_path} RUNTIME_OUTPUT_DIRECTORY ${lib_path})
