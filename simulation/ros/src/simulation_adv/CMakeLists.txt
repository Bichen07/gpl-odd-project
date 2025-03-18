cmake_minimum_required(VERSION 3.0.2)
project(simulation_adv)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

add_compile_options(-std=c++11)
set(OVERLAID_WORKSPACE "/repository/ros")
set(UTILS_PATH "${CMAKE_SOURCE_DIR}/simulation_utils")
set(ESMINILIB "${CMAKE_SOURCE_DIR}/esmini/bin/libesminiLib.so")

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  itri_msgs
  message_generation
  message_runtime
  roscpp
  simulation_msgs
  simulation_srvs
  scenario_msgs
  simulation_utils
  std_msgs
  tf
)

find_package(PkgConfig REQUIRED)
find_package(PCL 1.2 REQUIRED)
find_package(Backward REQUIRED)

add_service_files(
  DIRECTORY
  srv
  FILES
  Trigger.srv
)

generate_messages(
  DEPENDENCIES
  std_msgs
)

catkin_package(
    CATKIN_DEPENDS
        itri_msgs
        roscpp
        tf
        simulation_utils
        simulation_msgs
        simulation_srvs
        scenario_msgs
)

include_directories(
    ${PCL_INCLUDE_DIRS}
    ${UTILS_PATH}/include/common
    ${UTILS_PATH}/thirdparty
    ${UTILS_PATH}/thirdparty/Box2D
    ${UTILS_PATH}/include/sim
    ${UTILS_PATH}/include/utils
)

add_library(${PROJECT_NAME} STATIC
    src/car.cpp
    src/customized_box2d.cpp
    src/ego_handler.cpp
    src/main.cpp
    src/main_run_by_tick.cpp
    src/simulation.cpp
    src/simulation_control.cpp
    src/simulation_node.cpp
    src/waypoint_follower.cpp
    ${UTILS_PATH}/src/common/common_vehicle.cpp
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        include
        ${catkin_INCLUDE_DIRS}
        #${JSONCPP_INCLUDE_DIRS}
        ${simulation_INCLUDE_DIRS}
        ${UTILS_PATH}/include
        ${UTILS_PATH}/thirdparty
        /project/mmsl_simulation/src/esmini/includes
)

add_executable(${PROJECT_NAME}_node
    src/main.cpp
)

add_executable(${PROJECT_NAME}_with_tick_node
    src/main_run_by_tick.cpp
)

add_executable(trigger_time_test
    test/trigger_time_test.cpp
)

target_link_libraries(trigger_time_test
  ${PROJECT_NAME}
    Backward::Backward
    ${ESMINILIB}
)

add_dependencies(
  ${PROJECT_NAME}
  ${${PROJECT_NAME}_EXPORTED_TARGETS}
  ${catkin_EXPORTED_TARGETS}
)

add_dependencies(${PROJECT_NAME}
    ${catkin_EXPORTED_TARGETS}
    ${${PROJECT_NAME}_node_EXPORTED_TARGETS}
)

target_link_libraries(${PROJECT_NAME}
    Backward::Backward
    simulation_utils
    ${catkin_LIBRARIES}
    ${ESMINILIB}
)

target_link_libraries(${PROJECT_NAME}_node
    ${PCL_LIBRARIES}
    ${PROJECT_NAME}
    simulation_utils
    Backward::Backward
    ${ESMINILIB}
)

target_link_libraries(${PROJECT_NAME}_with_tick_node
    Backward::Backward
    ${PCL_LIBRARIES}
    ${PROJECT_NAME}
    simulation_utils
    ${ESMINILIB}
)
