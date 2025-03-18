cmake_minimum_required(VERSION 2.8.3)
project(scenario_visualization)
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  std_msgs
  visualization_msgs
  scenario_msgs
  rss_msgs
  simulation_utils
)

catkin_package(
)

file (GLOB files LIST_DIRECTORIES false */*.cpp)
foreach(file IN LISTS files)
    get_filename_component(FNAME ${file} NAME)
    set(SRC_FILES ${SRC_FILES} src/${FNAME})
endforeach()
list(REMOVE_ITEM SRC_FILES "src/visualization_main.cpp")

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_library(${PROJECT_NAME} STATIC
    ${SRC_FILES}
 )

add_executable(${PROJECT_NAME}_node src/visualization_main.cpp)

target_include_directories(${PROJECT_NAME}
    PUBLIC
)
target_link_libraries(${PROJECT_NAME}
    ${catkin_LIBRARIES}
)

target_link_libraries(${PROJECT_NAME}_node
    ${PROJECT_NAME}
)

## Add gtest based cpp test target and link libraries
#catkin_add_gtest(${PROJECT_NAME}-test test/test_visualization.cpp)
#if(TARGET ${PROJECT_NAME}-test)
#  target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
#endif()

## Add folders to be run by python nosetests
#catkin_add_nosetests(test)
