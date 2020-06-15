# Install script for directory: /home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/src/osgwMx

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibosgworksx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib/libosgwMx.so.3.00.00")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00"
         OLD_RPATH "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so.3.00.00")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibosgworksx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib/libosgwMx.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so"
         OLD_RPATH "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwMx.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibosgworks-devx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/uwsim_osgworks/osgwMx" TYPE FILE FILES
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/Export.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/CameraUpdateCallback.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/MxCore.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/MxEventHandler.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/MxGamePad.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/MxSpaceBall.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwMx/MxUtils.h"
    )
endif()

