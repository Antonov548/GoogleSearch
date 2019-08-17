cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

project(GoogleSearch LANGUAGES CXX)

find_package(Qt5 COMPONENTS Core Widgets Quick)

set(CMAKE_AUTOMOC ON)

add_subdirectory(tray_icon)
add_subdirectory(google_search)
