cmake_minimum_required(VERSION 2.8.3)
project(rss)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  roslib
  tf
  geometry_msgs
  std_msgs
  itri_msgs
  rss_msgs
  scenario_msgs
  ad_rss_lib
  scenario
  simulation_utils
)

find_package(
  PkgConfig REQUIRED
)

pkg_check_modules(JSONCPP jsoncpp)
find_package(Eigen3 REQUIRED)
find_package(PCL 1.2 REQUIRED)

catkin_package(
  INCLUDE_DIRS
  CATKIN_DEPENDS
  roscpp
  roslib
  tf
  geometry_msgs
  scenario
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  include
)

file (GLOB_RECURSE SRC_FILES CONFIGURE_DEPENDS RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" src/*.cpp)
list(REMOVE_ITEM SRC_FILES "src/rss_verification_main.cpp")
add_library(${PROJECT_NAME} STATIC
  ${SRC_FILES}
)

add_dependencies(${PROJECT_NAME} ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(${PROJECT_NAME}_verification_node src/rss_verification_main.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${catkin_INCLUDE_DIRS}
    ${JSONCPP_INCLUDE_DIRS}
)

target_link_libraries(${PROJECT_NAME}
  ${catkin_LIBRARIES}
  ${JSONCPP_LIBRARIES}
  ${PCL_LIBRARIES})

target_link_libraries(${PROJECT_NAME}_verification_node
  ${PROJECT_NAME}
)

target_compile_definitions(${PROJECT_NAME}
  PRIVATE
  MAP_DATA_DIR="$ENV{MAP_DATA_PATH}/data/"
)
