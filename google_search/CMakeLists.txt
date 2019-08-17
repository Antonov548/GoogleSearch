add_executable(google_search "src/main.cpp")

target_link_libraries(google_search Qt5::Widgets Qt5::Core Qt5::Quick)

target_link_libraries(google_search tray_icon)
target_include_directories(google_search PUBLIC "${CMAKE_SOURCE_DIR}/tray_icon/include")

set_target_properties(google_search PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/GoogleSearch)
