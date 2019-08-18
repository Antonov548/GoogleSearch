include(GenerateExportHeader)

file(GLOB_RECURSE includes "include/*.h")
file(GLOB_RECURSE sources "src/*.cpp")

add_library(google_api SHARED ${includes} ${sources})

generate_export_header(google_api EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/exports/google_api_export.h)

target_link_libraries(google_api Qt5::Core Qt5::Network Qt5::Concurrent)

target_include_directories(google_api PUBLIC ${CMAKE_BINARY_DIR}/exports "include")

set_target_properties(google_api PROPERTIES TARGET_LIBRARY_OUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib/google_api)
get_target_property(lib_path google_api TARGET_LIBRARY_OUT_DIRECTORY)
set_target_properties(google_api PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ${lib_path} LIBRARY_OUTPUT_DIRECTORY ${lib_path} RUNTIME_OUTPUT_DIRECTORY ${lib_path})
