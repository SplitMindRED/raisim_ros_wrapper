cmake_minimum_required(VERSION 3.11)
project(raisim_ros_wrapper)
set(RAISIM_VERSION 1.1.7)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

find_package(catkin REQUIRED)

# Include CMake helper modules
include(GNUInstallDirs)

set(RAISIM_OS linux)  
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/raisim/${RAISIM_OS})

set(RAISIM_BIN_DIR ${RAISIM_OS})
set(RAISIM_LOCAL_DIR ${CMAKE_CURRENT_LIST_DIR}/raisimLib)

catkin_package(
  INCLUDE_DIRS ${RAISIM_LOCAL_DIR}/raisim/${RAISIM_BIN_DIR}/include
  CATKIN_DEPENDS
  LIBRARIES raisim
)

include_directories(
  ${RAISIM_LOCAL_DIR}/raisim/${RAISIM_BIN_DIR}/include
  ${catkin_INCLUDE_DIRS}
)

set (_IMPORT_PREFIX ${RAISIM_LOCAL_DIR}/raisim/${RAISIM_BIN_DIR})

# Create imported target raisim::raisimZ
add_library(raisim::raisimZ SHARED IMPORTED)
set_target_properties(raisim::raisimZ PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

# Create imported target raisim::raisimPng
add_library(raisim::raisimPng SHARED IMPORTED)
set_target_properties(raisim::raisimPng PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
  INTERFACE_LINK_LIBRARIES "raisim::raisimZ"
)

# Create imported target raisim::raisimMine
add_library(raisim::raisimMine SHARED IMPORTED)
set_target_properties(raisim::raisimMine PROPERTIES
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

# Create imported target raisim::raisimODE
add_library(raisim::raisimODE SHARED IMPORTED)
set_target_properties(raisim::raisimODE PROPERTIES
  INTERFACE_COMPILE_DEFINITIONS "dIDEDOUBLE;dIDEDOUBLE"
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

# Create imported target raisim::raisim
add_library(raisim::raisim SHARED IMPORTED)
set_target_properties(raisim::raisim PROPERTIES
  INTERFACE_COMPILE_FEATURES "cxx_std_11"
  INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
  INTERFACE_LINK_LIBRARIES "raisim::raisimPng;raisim::raisimODE;raisim::raisimMine;${catkin_LIBRARIES}"
)

# Install raisim lib
file(
  COPY
  ${RAISIM_LOCAL_DIR}/raisim/${RAISIM_BIN_DIR}/lib/
  DESTINATION
  ${CATKIN_DEVEL_PREFIX}
)

install(DIRECTORY
  ${RAISIM_LOCAL_DIR}/raisim/${RAISIM_BIN_DIR}/lib/
  DESTINATION
  ${CATKIN_DEVEL_PREFIX}
)