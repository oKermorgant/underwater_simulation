# Install script for directory: /home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/src/osgwTools

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
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib/libosgwTools.so.3.00.00")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so.3.00.00")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibosgworksx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/build/lib/libosgwTools.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libosgwTools.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xlibosgworks-devx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/uwsim_osgworks/osgwTools" TYPE FILE FILES
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Export.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/AbsoluteModelTransform.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/CallbackSupport.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/CameraConfigObject.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Capabilities.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/CollapseLOD.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/CountsVisitor.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/DataLoader.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/DecimationTestModel.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/FBOUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/FindNamedNode.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/ForceFlattenTransforms.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/GeometryModifier.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/GeometryOperation.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/InsertRemove.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/LODCreationNodeVisitor.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/MultiCameraProjectionMatrix.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/NodePathUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/NodeUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Orientation.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/ParallelVisitor.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/PrimitiveSetConversion.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Quat.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/ReadFile.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/ReducerOp.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/RefID.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/RemoveData.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/RemoveLOD.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/RemoveProgram.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/ScreenCapture.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/SerializerSupport.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Shapes.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/SimplifierOp.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/StateSetUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/StateTrackingNodeVisitor.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Transform.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/TransformUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/TransparencyUtils.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Trianglizer.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Uniqifier.h"
    "/home/olivier/code/libs/ros/src/underwater_simulation/3rd_parties/uwsim_osgworks-release/include/osgwTools/Version.h"
    )
endif()

