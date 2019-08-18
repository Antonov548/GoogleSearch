qt5_add_resources(QT_RESOURCES res.qrc)

file(GLOB_RECURSE includes "include/*.h")
file(GLOB_RECURSE sources "src/*.cpp")

add_executable(google_search ${sources} ${QT_RESOURCES})

target_link_libraries(google_search Qt5::Gui Qt5::Core Qt5::Quick Qt5::QuickControls2 tray_icon google_api)

target_include_directories(google_search PUBLIC "${CMAKE_SOURCE_DIR}/tray_icon/include")

set_target_properties(google_search PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/GoogleSearch)
