cmake_minimum_required(VERSION 3.0)
project(simulation_utils)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_LIST_DIR}/cmake")

add_compile_options(-std=c++11)
set(OVERLAID_WORKSPACE "/repository/ros")

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  itri_msgs
  scenario_msgs
  roscpp
  roslib
  tf
  trace
)

find_package(
  PkgConfig REQUIRED
)

pkg_check_modules(JSONCPP jsoncpp)
find_package(Eigen3 REQUIRED)
find_package(PCL 1.2 REQUIRED)
catkin_python_setup()

file(GLOB INC_DIRS LIST_DIRECTORIES true RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" include/*)
catkin_package(
  INCLUDE_DIRS
    ${INC_DIRS}
    ${EIGEN3_INCLUDE_DIR}
  LIBRARIES
    ${PROJECT_NAME}
  CATKIN_DEPENDS
    itri_msgs
    roscpp
    roslib
    tf
)

add_subdirectory(thirdparty/Box2D)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  ${INC_DIRS}
)

file (GLOB_RECURSE SRC_FILES RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" src/*/*.cpp)
list(REMOVE_ITEM SRC_FILES "src/math/math_generate_random_vector.cpp")
add_library(${PROJECT_NAME} STATIC
  ${SRC_FILES}
)

target_include_directories(${PROJECT_NAME}
  PUBLIC
    thirdparty/Box2D
    include
    ${catkin_INCLUDE_DIRS}
    ${JSONCPP_INCLUDE_DIRS}
)

target_link_libraries(
  ${PROJECT_NAME}
  ${catkin_LIBRARIES}
  ${JSONCPP_LIBRARIES}
  ${PCL_LIBRARIES}
  X11
  Xi
  Xcursor
  Box2D
)

catkin_add_gtest(${PROJECT_NAME}_test_node
    test/test_simulation_utils.cpp
    test/geometry_test.cpp
    test/math_test.cpp
    test/stl_test.cpp
    test/utils_test.cpp)
if(TARGET ${PROJECT_NAME}_test_node)
  target_link_libraries(${PROJECT_NAME}_test_node
      ${PROJECT_NAME}
      ${catkin_LIBRARIES})
endif()


# CYTHON MODULE
# set(cython_simulation_utils_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/src/cython_simulation_utils)
# set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${cython_simulation_utils_ROOT}/cmake)
# include(UseCython)
# add_custom_target(ReplicatePythonSourceTree ALL ${CMAKE_COMMAND} -P
#   ${cython_simulation_utils_ROOT}/cmake/ReplicatePythonSourceTree.cmake
#   ${CMAKE_CURRENT_BINARY_DIR}
#   WORKING_DIRECTORY ${cython_simulation_utils_ROOT})

# if not set, cython_simulation_utils will build as standalone project
# set(cython_simulation_utils_ROS TRUE)
# include_directories(${cython_simulation_utils_ROOT}/include ${PCL_INCLUDE_DIRS})
# link_directories(${PCL_LIBRARY_DIRS})
# add_definitions(${PCL_DEFINITIONS})
# set_source_files_properties(${cython_simulation_utils_ROOT}/src/cython_simulation_utils.pyx PROPERTIES CYTHON_IS_CXX TRUE)
# add_subdirectory(${cython_simulation_utils_ROOT}/src)