# Install script for directory: D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/pkgs/jsoncpp_x64-windows")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "OFF")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/json" TYPE FILE FILES
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/allocator.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/assertions.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/config.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/forwards.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/json.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/json_features.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/reader.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/value.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/version.h"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/jsoncpp/src/1.9.6-29ceffc35f.clean/include/json/writer.h"
    )
endif()

