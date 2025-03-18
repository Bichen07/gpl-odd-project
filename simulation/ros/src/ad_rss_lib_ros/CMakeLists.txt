project(ad_rss_lib)
cmake_minimum_required(VERSION 3.0)

find_package(catkin REQUIRED)

catkin_package(
    LIBRARIES
        ad_map_access
        ad_rss
        ad_rss_map_integration
)

add_subdirectory(PROJ)
add_subdirectory(spdlog)
add_subdirectory(map/ad_physics)

set(PROJ_LIBRARIES proj)
set(PROJ_INCLUDE_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/PROJ/src")
add_subdirectory(map/ad_map_opendrive_reader)

add_subdirectory(map/ad_map_access)
add_subdirectory(ad-rss-lib/ad_rss)
add_subdirectory(ad-rss-lib/ad_rss_map_integration)
