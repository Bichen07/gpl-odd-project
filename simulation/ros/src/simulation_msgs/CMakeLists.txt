cmake_minimum_required(VERSION 2.8.3)
project(simulation_msgs)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  std_msgs
  path_msgs
  visualization_msgs
  route_mission_handler
  itri_msgs
  message_runtime
  message_generation
)

add_message_files(
  FILES
  AgentPose2D.msg
  AgentPose2DArray.msg
  CollisionProfile.msg
  CollisionState.msg
  SimulationAgentControl.msg
  SimulationAgentPoseControl.msg
  SimulationAgentPose2DControl.msg
  SimulationAgentDataControl.msg
  SimulationAgentStateControl.msg
  SimulationAgentVelocityControl.msg
  SimulationPlayState.msg
)

generate_messages(
  DEPENDENCIES
  scenario_msgs
  geometry_msgs
  std_msgs
  path_msgs
  visualization_msgs
  route_mission_handler
  itri_msgs
)

catkin_package(
  CATKIN_DEPENDS
  scenario_msgs
  geometry_msgs
  std_msgs
  path_msgs
  visualization_msgs
  route_mission_handler
  itri_msgs
  message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
