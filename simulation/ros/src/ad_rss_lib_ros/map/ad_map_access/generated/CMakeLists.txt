##
# ----------------- BEGIN LICENSE BLOCK ---------------------------------
#
# Copyright (C) 2018-2020 Intel Corporation
#
# SPDX-License-Identifier: MIT
#
# ----------------- END LICENSE BLOCK -----------------------------------
##
##
# Generated file
#
# Generator Version : 11.0.0-1997
##

cmake_minimum_required(VERSION 3.5)
project(ad_map_access VERSION 2.3.0)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 14)

option(BUILD_SHARED_LIBS "Build shared libraries instead of static ones" ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(INCLUDE_DIRS)
set(LIBRARIES)

include(ad_map_access)

if ((NOT ad_map_access_SOURCES) OR (NOT ad_map_access_INCLUDE_DIRS))
  message(FATAL_ERROR "${PROJECT_NAME}: Variable ad_map_access_SOURCES or ad_map_access_INCLUDE_DIRS pointing to the generator managed library not set!")
endif()

find_package(Boost REQUIRED COMPONENTS program_options filesystem)
get_target_property(BOOST_PROGRAM_OPTIONS_INTERFACE_INCLUDE_DIRS Boost::program_options INTERFACE_INCLUDE_DIRECTORIES)
list(APPEND INCLUDE_DIRS ${BOOST_PROGRAM_OPTIONS_INTERFACE_INCLUDE_DIRS})
list(APPEND LIBRARIES Boost::program_options)
get_target_property(BOOST_FILESYSTEM_INTERFACE_INCLUDE_DIRS Boost::filesystem INTERFACE_INCLUDE_DIRECTORIES)
list(APPEND INCLUDE_DIRS ${BOOST_FILESYSTEM_INTERFACE_INCLUDE_DIRS})
list(APPEND LIBRARIES Boost::filesystem)

get_target_property(AD_MAP_OPENDRIVE_READER_INTERFACE_INCLUDE_DIRS ad_map_opendrive_reader INCLUDE_DIRECTORIES)
list(APPEND INCLUDE_DIRS ${AD_MAP_OPENDRIVE_READER_INTERFACE_INCLUDE_DIRS})
list(APPEND LIBRARIES ad_map_opendrive_reader)

add_library(${PROJECT_NAME}
  ${ad_map_access_SOURCES}
  src/ad/map/access/PartitionId.cpp
  src/ad/map/access/TrafficType.cpp
  src/ad/map/intersection/IntersectionType.cpp
  src/ad/map/intersection/TurnDirection.cpp
  src/ad/map/landmark/LandmarkId.cpp
  src/ad/map/landmark/LandmarkType.cpp
  src/ad/map/landmark/TrafficLightType.cpp
  src/ad/map/landmark/TrafficSignType.cpp
  src/ad/map/lane/ContactLocation.cpp
  src/ad/map/lane/ContactType.cpp
  src/ad/map/lane/LaneDirection.cpp
  src/ad/map/lane/LaneId.cpp
  src/ad/map/lane/LaneType.cpp
  src/ad/map/match/MapMatchedPositionType.cpp
  src/ad/map/match/ObjectReferencePoints.cpp
  src/ad/map/point/Altitude.cpp
  src/ad/map/point/ECEFCoordinate.cpp
  src/ad/map/point/ENUCoordinate.cpp
  src/ad/map/point/ENUHeading.cpp
  src/ad/map/point/Latitude.cpp
  src/ad/map/point/Longitude.cpp
  src/ad/map/restriction/RoadUserType.cpp
  src/ad/map/route/ConnectingRouteType.cpp
  src/ad/map/route/LaneChangeDirection.cpp
  src/ad/map/route/RouteCreationMode.cpp
)

if (DEFINED ad_map_access_TARGET_COMPILE_DEFINITIONS)
string(APPEND TARGET_COMPILE_DEFINITIONS ${ad_map_access_TARGET_COMPILE_DEFINITIONS})
endif()

target_compile_definitions(${PROJECT_NAME} PUBLIC ${TARGET_COMPILE_DEFINITIONS})
target_compile_options(${PROJECT_NAME} PRIVATE ${TARGET_COMPILE_OPTIONS})
set_property(TARGET ${PROJECT_NAME} APPEND_STRING PROPERTY LINK_FLAGS ${TARGET_LINK_FLAGS})

target_include_directories(${PROJECT_NAME} PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_INSTALL_INCLUDEDIR}
  ${ad_map_access_TARGET_INCLUDE_DIRECTORIES}
  ${ad_map_access_INCLUDE_DIRS}
  ${INCLUDE_DIRS}
)

target_link_libraries(${PROJECT_NAME} PUBLIC
  ad_physics
  spdlog::spdlog
  ${ad_map_access_TARGET_LINK_LIBRARIES}
  PRIVATE
  ${LIBRARIES}
)

#####################################################################
# Tools
#####################################################################
if (ad_map_access_TOOLS_DIR)
  add_subdirectory(${ad_map_access_TOOLS_DIR} ad_map_access_tools)
endif()

