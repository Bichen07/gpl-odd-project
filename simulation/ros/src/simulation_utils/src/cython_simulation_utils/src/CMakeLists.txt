# If the pyx file is a C++ file, we should specify that here.
#set_source_files_properties(
#  ${CMAKE_CURRENT_SOURCE_DIR}/quaternion.pyx
#  PROPERTIES CYTHON_IS_CXX TRUE )
  
# Multi-file cython modules do not appear to be working at the moment.
cython_add_module(cython_catkin_example 
  cy_quaternion.pyx
  cy_converter.pyx
  cy_coord_transform.pyx
  cy_bounding_box_utils.pyx
  )

# target_link_libraries(cython_catkin_example ${PCL_LIBRARIES})

if(${cython_simulation_utils_ROS})
    # set_target_properties(cython_simulation_utils PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CATKIN_DEVEL_PREFIX}/${CATKIN_PACKAGE_PYTHON_DESTINATION})
    install(TARGETS cython_catkin_example
      ARCHIVE DESTINATION ${CATKIN_PACKAGE_PYTHON_DESTINATION}
      LIBRARY DESTINATION ${CATKIN_PACKAGE_PYTHON_DESTINATION}
    )
endif(${cython_simulation_utils_ROS})