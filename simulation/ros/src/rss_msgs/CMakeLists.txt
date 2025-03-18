cmake_minimum_required(VERSION 2.8.3)
project(rss_msgs)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  message_generation
  std_msgs
)

add_message_files(
  FILES
  CheckResult.msg
  CheckResultEgoVehicleState.msg
  CheckResultObjectState.msg
  EgoVehicleData.msg
  Landmark.msg
  LandmarkArray.msg
  LateralState.msg
  LongitudinalState.msg
  ObjectData.msg
  ObjectDataArray.msg
  ProperResponse.msg
  RssState.msg
  SafetyState.msg
  StructuredSafety.msg
  UnstructuredSafety.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
)

catkin_package(
  CATKIN_DEPENDS geometry_msgs message_generation std_msgs message_runtime
)
include_directories(
  ${catkin_INCLUDE_DIRS}
)
