cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

project(GoogleSearch LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core Widgets Quick Gui QuickControls2 Network Concurrent)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_subdirectory(tray_icon)
add_subdirectory(google_api_model)
add_subdirectory(google_search)
