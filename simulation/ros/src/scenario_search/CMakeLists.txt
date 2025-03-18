cmake_minimum_required(VERSION 3.0.2)
project(scenario_search)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

catkin_python_setup()

add_compile_options(-std=c++11)
set(OVERLAID_WORKSPACE "/repository/ros")
set(UTILS_PATH "${CMAKE_SOURCE_DIR}/simulation_utils")
set(SCENARIO_PATH "${CMAKE_SOURCE_DIR}/scenario")

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  message_generation
  message_runtime
  itri_msgs
  roscpp
  rospy
  simulation_msgs
  simulation_srvs
  simulation_utils
  scenario
  std_msgs
  visualization_msgs
)

add_message_files(
  FILES
    QuinticWaypoint.msg
    QuinticWaypointArray.msg
)

find_package(Eigen3 REQUIRED)
find_package(PCL 1.2 REQUIRED)

add_service_files(
  FILES
  GenerateAgentByWaypoint.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
  geometry_msgs
)


###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
${PCL_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  include
  include/quintic_trajectory_agent
  ${UTILS_PATH}/include/carla
  ${UTILS_PATH}/include/geometry
  ${UTILS_PATH}/include/logger
  ${UTILS_PATH}/include/math
  ${UTILS_PATH}/include/sim
  ${UTILS_PATH}/include/utils
  ${SCENARIO_PATH}/include/action
  ${SCENARIO_PATH}/include/actor
  ${SCENARIO_PATH}/include/collision
  ${SCENARIO_PATH}/include/ctrl
  ${SCENARIO_PATH}/include/map
  ${SCENARIO_PATH}/include/measure
  ${SCENARIO_PATH}/include/motion
  ${SCENARIO_PATH}/include/utils
)

## Declare a C++ library
add_library(${PROJECT_NAME} STATIC
  src/quintic_trajectory_agent/frenet_trajectory_agent_generator.cpp
  src/quintic_trajectory_agent_main.cpp
)

## Add cmake target dependencies of the library
## as an example, code may need to be generated before libraries
## either from message generation or dynamic reconfigure
add_dependencies(
  ${PROJECT_NAME}
  ${${PROJECT_NAME}_EXPORTED_TARGETS}
  ${catkin_EXPORTED_TARGETS})

## Declare a C++ executable
## With catkin_make all packages are built within a single CMake context
## The recommended prefix ensures that target names across packages don't collide

add_executable(scenario_search_node src/quintic_trajectory_agent_main.cpp)
target_link_libraries(scenario_search_node
    scenario_search
    simulation_utils
    scenario
)

## Rename C++ executable without prefix
## The above recommended prefix causes long target names, the following renames the
## target back to the shorter version for ease of user use
## e.g. "rosrun someones_pkg node" instead of "rosrun someones_pkg someones_pkg_node"
# set_target_properties(${PROJECT_NAME}_node PROPERTIES OUTPUT_NAME node PREFIX "")

## Add cmake target dependencies of the executable
## same as for the library above
# add_dependencies(${PROJECT_NAME}_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Specify libraries to link a library or executable target against
# target_link_libraries(${PROJECT_NAME}_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# catkin_install_python(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_executables.html
# install(TARGETS ${PROJECT_NAME}_node
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark libraries for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_libraries.html
# install(TARGETS ${PROJECT_NAME}
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_scenario_search.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
