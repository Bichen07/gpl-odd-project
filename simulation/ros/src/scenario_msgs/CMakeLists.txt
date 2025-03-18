cmake_minimum_required(VERSION 2.8.3)
project(scenario_msgs)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  message_generation
  std_msgs
  itri_msgs
)

add_message_files(
  FILES
    AgentData.msg
    AgentDataArray.msg
    LineStripMarker.msg
    LineStripMarkerArray.msg
    PointMarker.msg
    PointMarkerArray.msg
    TextMarker.msg
    TextMarkerArray.msg
)

generate_messages(
  DEPENDENCIES
  geometry_msgs
  std_msgs
  itri_msgs
)

catkin_package(
  CATKIN_DEPENDS geometry_msgs message_generation std_msgs message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
)
