cmake_minimum_required(VERSION 3.0.2)
project(scenario_classification)

find_package(catkin REQUIRED COMPONENTS
    geometry_msgs
    itri_msgs
    roscpp
    rospy
    scenario_msgs
    simulation_msgs
    simulation_utils
    std_msgs
    message_runtime
    message_generation
)

find_package(Boost REQUIRED COMPONENTS python)
find_package(PythonLibs 2.7 REQUIRED)

catkin_python_setup()

## Generate messages in the 'msg' folder
add_message_files(
    FILES
    ClassificationObject.msg
    ClassificationObjectArray.msg
    TagCarriagewayUserType.msg
    TagInitialState.msg
    TagLateralActivity.msg
    TagLeadVehicle.msg
    TagLongitudinalActivity.msg
    TagRoadLayout.msg
    TagTrees.msg
)

generate_messages(
    DEPENDENCIES
    geometry_msgs
    itri_msgs
    std_msgs
)

catkin_package(
 #INCLUDE_DIRS include
 CATKIN_DEPENDS roscpp
 message_runtime
)

include_directories(
include
    ${catkin_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
    ${PYTHON_INCLUDE_DIRS}
)

add_library(utils src/tag_trees/identifier/utils.cpp)
add_library(_identifier_carriageway_user_type_cpp src/tag_trees/identifier/identifier_carriageway_user_type.cpp)
add_library(_identifier_longitudinal_activity_cpp src/tag_trees/identifier/identifier_longitudinal_activity.cpp)

target_link_libraries(utils ${catkin_LIBRARIES})
target_link_libraries(_identifier_carriageway_user_type_cpp utils ${catkin_LIBRARIES} ${Boost_LIBRARIES})
target_link_libraries(_identifier_longitudinal_activity_cpp utils ${catkin_LIBRARIES} ${Boost_LIBRARIES})

set_target_properties(
    _identifier_carriageway_user_type_cpp
    _identifier_longitudinal_activity_cpp
    PROPERTIES
        PREFIX ""
        LIBRARY_OUTPUT_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_PYTHON_DESTINATION}
)
