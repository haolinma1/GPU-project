@echo off
REM
REM Copyright (c) 2005-2021 Intel Corporation
REM
REM Licensed under the Apache License, Version 2.0 (the "License");
REM you may not use this file except in compliance with the License.
REM You may obtain a copy of the License at
REM
REM     http://www.apache.org/licenses/LICENSE-2.0
REM
REM Unless required by applicable law or agreed to in writing, software
REM distributed under the License is distributed on an "AS IS" BASIS,
REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM See the License for the specific language governing permissions and
REM limitations under the License.
REM

@echo off

set "TBBROOT=D:\Seneca\GPU\work\Final_Data_Analysis_Stock\vcpkg_installed\vcpkg\blds\tbb\src\v2022.0.0-3c0387beea.clean"
set "TBB_DLL_PATH=D:\Seneca\GPU\work\Final_Data_Analysis_Stock\vcpkg_installed\vcpkg\blds\tbb\x64-windows-dbg\msvc_19.42_cxx_64_md_debug"

set "INCLUDE=%TBBROOT%\include;%INCLUDE%"
set "CPATH=%TBBROOT%\include;%CPATH%"
set "LIB=D:\Seneca\GPU\work\Final_Data_Analysis_Stock\vcpkg_installed\vcpkg\blds\tbb\x64-windows-dbg\msvc_19.42_cxx_64_md_debug;%LIB%"
set "PATH=D:\Seneca\GPU\work\Final_Data_Analysis_Stock\vcpkg_installed\vcpkg\blds\tbb\x64-windows-dbg\msvc_19.42_cxx_64_md_debug;%PATH%"
set "PKG_CONFIG_PATH=D:\Seneca\GPU\work\Final_Data_Analysis_Stock\vcpkg_installed\vcpkg\blds\tbb\x64-windows-dbg\msvc_19.42_cxx_64_md_debug\pkgconfig;%PKG_CONFIG_PATH%"


