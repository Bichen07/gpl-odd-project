cmake_minimum_required(VERSION 2.8.3)
project(scenario)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")
add_compile_options(-std=c++11)
set(OVERLAID_WORKSPACE "/repository/ros")
set(SIMULATION_PATH ${CMAKE_SOURCE_DIR})
set(UTILS_PATH "${CMAKE_SOURCE_DIR}/simulation_utils")
set(ESMINILIB "${CMAKE_SOURCE_DIR}/esmini/bin/libesminiLib.so")

find_package(catkin REQUIRED COMPONENTS
  roscpp
  roslib
  tf
  std_msgs
  carla_msgs
  geometry_msgs
  itri_msgs
  scenario_msgs
  simulation_srvs
  message_generation
  route_mission_handler
  simulation_adv
  simulation_utils
  path
  path_msgs
  genmsg
  actionlib_msgs
  actionlib
)

find_package(
  PkgConfig REQUIRED
  GeographicLib REQUIRED
)

pkg_check_modules(JSONCPP jsoncpp)
find_package(PCL 1.2 REQUIRED)
find_package(Backward REQUIRED)

add_message_files(
  DIRECTORY msg
  FILES
    AgentAttribute.msg
    AgentPose.msg
    AgentState.msg
    AgentStates.msg
    IsoAccPerformance.msg
    IsoAccTargetDiscriminationPerformance.msg
    IsoAccTimeGapPerformance.msg
    IsoFvcwsLateralDiscriminationPerformance.msg
    IsoFvcwsLongitudinalDiscriminationPerformance.msg
    IsoVehicleAttribute.msg
    IsoVehicleState.msg
    IsoLkasLaneKeepingPerformance.msg
)

add_service_files(
  FILES
    AgentAttributeAccess.srv
    AgentDataArrayEvaluation.srv
    CarlaActorUpdate.srv
    DetectedObjectEvaluation.srv
    IsoAccCurveCapabilityEvaluation.srv
    IsoAccPerformanceEvaluation.srv
    IsoAccTargetDiscriminationEvaluation.srv
    IsoFvcwsLateralDiscriminationEvaluation.srv
    IsoFvcwsLongitudinalDiscriminationEvaluation.srv
    ScenarioUpdate.srv
)

add_action_files(
  DIRECTORY action
  FILES ScenarioReconfigure.action
)

generate_messages(
  DEPENDENCIES
  geometry_msgs
  route_mission_handler
  path_msgs
  itri_msgs
  scenario_msgs
  actionlib_msgs
)

catkin_package(
  INCLUDE_DIRS
    include/actor
    include/motion
  LIBRARIES
    ${PROJECT_NAME}
)

file(GLOB INC_DIRS LIST_DIRECTORIES true RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" include/*)
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  ${simulation_INCLUDE_DIRS}
  ${rss_INCLUDE_DIRS}
  ${INC_DIRS}
  ${UTILS_PATH}/include/carla
  ${UTILS_PATH}/include/geometry
  ${UTILS_PATH}/include/logger
  ${UTILS_PATH}/include/math
  ${UTILS_PATH}/include/utils
)

file(GLOB_RECURSE SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" src/*/*.cpp)
add_library(${PROJECT_NAME} STATIC
  ${SRC_FILES}
)

add_dependencies(${PROJECT_NAME} ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(${PROJECT_NAME}_mr_vil_testing_node src/mr_vil_testing.cpp)
add_executable(${PROJECT_NAME}_sil_testing_node src/sil_testing.cpp)
add_executable(${PROJECT_NAME}_updater_node src/updater.cpp)
add_executable(navigation_path_runner_node src/navigation_path_runner.cpp)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    ${catkin_INCLUDE_DIRS}
    ${JSONCPP_INCLUDE_DIRS}
    ${UTILS_PATH}/include
    ${UTILS_PATH}/thirdparty
    /project/mmsl_simulation/src/esmini/includes
)

target_link_libraries(${PROJECT_NAME}
    ${catkin_LIBRARIES}
    ${JSONCPP_LIBRARIES}
    ${catkin_LIBRARIES}
    ${ESMINILIB}
)

target_link_libraries(${PROJECT_NAME}_mr_vil_testing_node
  Backward::Backward
  ${PROJECT_NAME}
  ${GeographicLib_LIBRARIES}
  ${PCL_LIBRARIES}
  X11
  Xi
  Xcursor
  ${ESMINILIB}
)

target_link_libraries(${PROJECT_NAME}_sil_testing_node
  ${PROJECT_NAME}
  ${GeographicLib_LIBRARIES}
  ${PCL_LIBRARIES}
  X11
  Xi
  Xcursor
  ${ESMINILIB}
)

target_link_libraries(${PROJECT_NAME}_updater_node
  Backward::Backward
  ${PROJECT_NAME}
  ${GeographicLib_LIBRARIES}
  ${PCL_LIBRARIES}
  X11
  Xi
  Xcursor
  ${ESMINILIB}
)

target_link_libraries(navigation_path_runner_node
  Backward::Backward
  ${PROJECT_NAME}
  ${ESMINILIB}
)

target_compile_definitions(${PROJECT_NAME}
  PRIVATE
  MAP_DATA_DIR="$ENV{MAP_DATA_PATH}/data/"
)

