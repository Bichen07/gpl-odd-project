cmake_minimum_required(VERSION 3.0.2)
project(metric)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
add_compile_options(-std=c++11)
set(UTILS_PATH "${CMAKE_SOURCE_DIR}/simulation_utils")

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  std_msgs
  simulation_utils
)

find_package(Boost REQUIRED COMPONENTS system)

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   geometry_msgs#   std_msgs
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if your package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES metric
#  CATKIN_DEPENDS geometry_msgs roscpp std_msgs
#  DEPENDS system_lib
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

file (GLOB_RECURSE SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" src/*.cpp)
list(REMOVE_ITEM SRC_FILES "src/metric_min_bounding_envelope_main.cpp")
add_library(${PROJECT_NAME}
    ${SRC_FILES}
)

add_dependencies(${PROJECT_NAME} ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(${PROJECT_NAME}_min_bounding_envelope_node src/metric_min_bounding_envelope_main.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${catkin_INCLUDE_DIRS}
    ${JSONCPP_INCLUDE_DIRS}
)
target_link_libraries(${PROJECT_NAME}
  ${catkin_LIBRARIES}
  ${JSONCPP_LIBRARIES}
)
target_link_libraries(${PROJECT_NAME}_min_bounding_envelope_node
    ${PROJECT_NAME}
)

target_compile_definitions(${PROJECT_NAME}
  PRIVATE
    MAP_DATA_DIR="$ENV{MAP_DATA_PATH}/data/"
)

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_metric.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
