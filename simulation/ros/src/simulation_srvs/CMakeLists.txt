cmake_minimum_required(VERSION 3.0.2)
project(simulation_srvs)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
    geometry_msgs
    itri_msgs
    scenario_msgs
    simulation_msgs
    std_msgs
)

add_service_files(
    DIRECTORY
    srv
    FILES
    SimulationCreateAgent.srv
    SimulationCreateAgentByDefaultPose.srv
    SimulationCreateCarlaAgent.srv
    SimulationDeleteAgent.srv
    SimulationGetAgentsWithinMeters.srv
    SimulationPlayStateControl.srv
    SimulationUpdateAgents.srv
    SimulationUpdateAgentsData.srv
    SimulationUpdateAgentsPose2D.srv
    RequestNavigationPath.srv
)

generate_messages(
    DEPENDENCIES
    geometry_msgs
    itri_msgs
    scenario_msgs
    simulation_msgs
    std_msgs
)

catkin_package(
  CATKIN_DEPENDS geometry_msgs message_generation std_msgs message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
