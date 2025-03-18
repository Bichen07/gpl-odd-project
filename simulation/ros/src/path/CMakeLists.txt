cmake_minimum_required(VERSION 3.0.2)
project(path)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  std_msgs
  itri_msgs
  simulation_utils
  path_msgs
  route_mission_handler
)

find_package(Boost REQUIRED COMPONENTS system)

add_service_files(
  FILES
    DijkstraInterpolationPlanning.srv
    DijkstraPlanning.srv
    Republishing.srv
    WaypointQuerying.srv
    RouteWaypointQuerying.srv
    RequestEgoVehicleGlobalPath.srv
)

generate_messages(
  DEPENDENCIES
    geometry_msgs
    std_msgs
    path_msgs
)

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS path_msgs geometry_msgs roscpp std_msgs
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
  ${INC_DIRS}
  include
)

file(GLOB_RECURSE SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" src/*.cpp)
add_library(${PROJECT_NAME} STATIC
    ${SRC_FILES}
)

add_dependencies(${PROJECT_NAME} ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(${PROJECT_NAME}_planner_node src/path_planner_main.cpp)
add_executable(${PROJECT_NAME}_ego_vehicle_global_path_node src/path_ego_vehicle_global_path_main.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${catkin_INCLUDE_DIRS}
    ${JSONCPP_INCLUDE_DIRS}
)

target_link_libraries(${PROJECT_NAME}
  ${catkin_LIBRARIES}
)

target_link_libraries(${PROJECT_NAME}_planner_node
    ${PROJECT_NAME}
)

target_link_libraries(${PROJECT_NAME}_ego_vehicle_global_path_node
    ${PROJECT_NAME}
)

target_compile_definitions(${PROJECT_NAME}
  PRIVATE
  MAP_DATA_DIR="$ENV{MAP_DATA_PATH}/data/"
)

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_path.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
