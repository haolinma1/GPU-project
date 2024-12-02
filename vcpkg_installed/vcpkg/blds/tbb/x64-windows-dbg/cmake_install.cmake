# Install script for directory: D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/src/v2022.0.0-3c0387beea.clean

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/pkgs/tbb_x64-windows/debug")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
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

if(CMAKE_INSTALL_COMPONENT STREQUAL "devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/src/v2022.0.0-3c0387beea.clean/include/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "devel" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB/TBBTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB/TBBTargets.cmake"
         "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/CMakeFiles/Export/50bf70e196cec95d4d513cf01ed33e20/TBBTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB/TBBTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB/TBBTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB" TYPE FILE FILES "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/CMakeFiles/Export/50bf70e196cec95d4d513cf01ed33e20/TBBTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB" TYPE FILE FILES "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/CMakeFiles/Export/50bf70e196cec95d4d513cf01ed33e20/TBBTargets-debug.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/TBB" TYPE FILE FILES
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/TBBConfig.cmake"
    "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/TBBConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "devel" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/doc/TBB" TYPE FILE FILES "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/src/v2022.0.0-3c0387beea.clean/README.md")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/src/tbb/cmake_install.cmake")
  include("D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/src/tbbmalloc/cmake_install.cmake")
  include("D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/src/tbbmalloc_proxy/cmake_install.cmake")
  include("D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/src/tbbbind/cmake_install.cmake")
  include("D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/cmake/post_install/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "D:/Seneca/GPU/work/Final_Data_Analysis_Stock/vcpkg_installed/vcpkg/blds/tbb/x64-windows-dbg/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
