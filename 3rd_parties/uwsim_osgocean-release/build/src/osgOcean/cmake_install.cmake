# Install script for directory: /home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/src/osgOcean

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
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

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so"
         RPATH "")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libosgOcean.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/build/lib/libosgOcean.so")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/usr/local/lib/libosgOcean.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/uwsim_osgocean/osgOcean/Cylinder;/usr/local/include/uwsim_osgocean/osgOcean/DistortionSurface;/usr/local/include/uwsim_osgocean/osgOcean/FFTOceanTechnique;/usr/local/include/uwsim_osgocean/osgOcean/FFTOceanSurface;/usr/local/include/uwsim_osgocean/osgOcean/FFTOceanSurfaceVBO;/usr/local/include/uwsim_osgocean/osgOcean/FFTSimulation;/usr/local/include/uwsim_osgocean/osgOcean/GodRays;/usr/local/include/uwsim_osgocean/osgOcean/GodRayBlendSurface;/usr/local/include/uwsim_osgocean/osgOcean/MipmapGeometry;/usr/local/include/uwsim_osgocean/osgOcean/MipmapGeometryVBO;/usr/local/include/uwsim_osgocean/osgOcean/OceanScene;/usr/local/include/uwsim_osgocean/osgOcean/OceanTechnique;/usr/local/include/uwsim_osgocean/osgOcean/OceanTile;/usr/local/include/uwsim_osgocean/osgOcean/RandUtils;/usr/local/include/uwsim_osgocean/osgOcean/ScreenAlignedQuad;/usr/local/include/uwsim_osgocean/osgOcean/ShaderManager;/usr/local/include/uwsim_osgocean/osgOcean/SiltEffect;/usr/local/include/uwsim_osgocean/osgOcean/WaterTrochoids;/usr/local/include/uwsim_osgocean/osgOcean/Export;/usr/local/include/uwsim_osgocean/osgOcean/Version")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/uwsim_osgocean/osgOcean" TYPE FILE FILES
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/Cylinder"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/DistortionSurface"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/FFTOceanTechnique"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/FFTOceanSurface"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/FFTOceanSurfaceVBO"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/FFTSimulation"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/GodRays"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/GodRayBlendSurface"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/MipmapGeometry"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/MipmapGeometryVBO"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/OceanScene"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/OceanTechnique"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/OceanTile"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/RandUtils"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/ScreenAlignedQuad"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/ShaderManager"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/SiltEffect"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/WaterTrochoids"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/Export"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgocean-release/include/osgOcean/Version"
    )
endif()

