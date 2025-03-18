cmake_minimum_required(VERSION 3.0.2)
project(scenario_tools)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

add_compile_options(-std=c++11)
set(OVERLAID_WORKSPACE "/repository/ros")
set(UTILS_PATH "${CMAKE_SOURCE_DIR}/simulation_utils")

# Dependencies

find_package(catkin REQUIRED COMPONENTS
    simulation_adv
)

# Package definition

catkin_package(
    CATKIN_DEPENDS
        simulation_adv
)

# Targets

# target_link_libraries(
# )


catkin_python_setup()
catkin_install_python(
  PROGRAMS
  src/reproducing_tools/detected_objects_marker.py
  src/scenario_tools/rosbag_replay_tool.py
  src/scenario_tools/tf_static_remapper.py
  DESTINATION
  ${CATKIN_PACKAGE_BIN_DESTINATION})
