cmake_minimum_required(VERSION 2.8.3)
project(uwsim)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  image_transport
  kdl_parser
  nav_msgs
  resource_retriever
  robot_state_publisher
  roscpp
  sensor_msgs
  tf
  urdf
  xacro
)

# build deps
foreach(DEP IN ITEMS uwsim_osgocean uwsim_osgworks)
    set(DEP_ROOT ${PROJECT_SOURCE_DIR}/../3rd_parties/${DEP}-release)
    set(DEP_BUILD ${DEP_ROOT}/build)
    if(NOT EXISTS ${DEP_BUILD})
        file(MAKE_DIRECTORY ${DEP_BUILD})
        execute_process(COMMAND cmake .. WORKING_DIRECTORY ${DEP_BUILD})
        execute_process(COMMAND make -j4 WORKING_DIRECTORY ${DEP_BUILD})
    endif()
    find_package(${DEP} REQUIRED HINTS "${DEP_BUILD}/lib")
endforeach()

find_package(Boost REQUIRED thread program_options system filesystem)
find_package(OpenSceneGraph COMPONENTS osgSim osgUtil osgDB osgFX osgGA osgTerrain osgViewer osgText osgWidget osg osgParticle osgManipulator)
find_package(PkgConfig)

pkg_check_modules(LIBXML++ REQUIRED libxml++-2.6)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES
    uwsim
  CATKIN_DEPENDS
    geometry_msgs
    image_transport
    kdl_parser
    nav_msgs
    resource_retriever
    robot_state_publisher
    roscpp
    sensor_msgs
    tf
    urdf
  DEPENDS
    Boost
    LIBXML++
    OPENSCENEGRAPH
)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/CMakeModules;{CMAKE_MODULE_PATH}")

SET(UWSIM_ROOT_PATH "${CMAKE_INSTALL_PREFIX}/${CATKIN_PACKAGE_SHARE_DESTINATION}")

CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/include/uwsim/SimulatorConfig.h.cmake
  ${PROJECT_SOURCE_DIR}/include/uwsim/SimulatorConfig.h
)

INCLUDE_DIRECTORIES(include
  ${OSGWORKS_INCLUDE_DIR}
  ${OSGOCEAN_INCLUDE_DIRS}
  ${LIBXML++_INCLUDE_DIRS} ${catkin_INCLUDE_DIRS} ${Boost_INCLUDE_DIRS})

link_directories(${orocos_kdl_LIBRARY_DIRS})

# this disables the warnings that come mostly from osg
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-ignored-qualifiers")
set(CMAKE_CXX_STANDARD 11)

add_library(uwsim 
src/osgOceanScene.cpp
src/SkyDome.cpp
src/SphereSegment.cpp
src/KinematicChain.cpp
src/URDFRobot.cpp
src/SimulatedIAUV.cpp
src/VirtualCamera.cpp
src/HUDCamera.cpp
src/ConfigXMLParser.cpp
src/UWSimUtils.cpp
src/ROSInterface.cpp
src/SceneBuilder.cpp
src/ViewBuilder.cpp
src/GPSSensor.cpp
src/VirtualSLSProjector.cpp
)

if(($ENV{ROS_DISTRO} STREQUAL "kinetic") OR ($ENV{ROS_DISTRO} STREQUAL "melodic"))
target_compile_definitions(uwsim PRIVATE "-DLEGACY_OSGOCEAN")
endif()

target_link_libraries(uwsim ${catkin_LIBRARIES} ${Boost_LIBRARIES} ${OSGOCEAN_LIBRARIES} ${OSGWORKS_LIBRARIES} ${OPENSCENEGRAPH_LIBRARIES} ${LIBXML++_LIBRARIES} -lGLU)

add_executable(uwsim_binary  src/main.cpp)
target_link_libraries(uwsim_binary uwsim ${catkin_LIBRARIES} ${Boost_LIBRARIES} ${OSGOCEAN_LIBRARIES} ${OSGWORKS_LIBRARIES} ${OPENSCENEGRAPH_LIBRARIES} ${LIBXML++_LIBRARIES} -lGLU )

install(
  TARGETS
    uwsim
    uwsim_binary
  ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)

install(DIRECTORY include/${PROJECT_NAME}
   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})
   
# install dep libraries
install(FILES ${OSGOCEAN_LIBRARIES} ${OSGWORKS_LIBRARIES} DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION})

##compìle xacros
file(GLOB xacro_files data/scenes/*.xml.xacro)

foreach(it ${xacro_files})
  # remove .xacro extension
  string(REGEX MATCH "(.*)[.]xacro$" unused ${it})
  set(output_filename ${CMAKE_MATCH_1})

  # create a rule to generate ${output_filename} from {it}
  xacro_add_xacro_file(${it} ${output_filename})

  list(APPEND world_files ${output_filename})
endforeach(it)

# add an abstract target to actually trigger the builds
add_custom_target(media_files ALL DEPENDS ${world_files})

install(DIRECTORY data/scenes data/shaders
   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/data
   PATTERN "*.xacro" EXCLUDE ##Exclude .xacro files
)

install(DIRECTORY src/
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
   FILES_MATCHING PATTERN "uwsim" 
   PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
               GROUP_READ GROUP_EXECUTE
               WORLD_READ WORLD_EXECUTE
)

install(FILES package.xml 
DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
