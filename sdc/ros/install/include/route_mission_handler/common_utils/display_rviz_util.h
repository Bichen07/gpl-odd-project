#ifndef _COMMON_DISPLAY_RVIZ_UTILS_HPP_
#define _COMMON_DISPLAY_RVIZ_UTILS_HPP_

#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Point.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <cmath>
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include <tf/transform_broadcaster.h>
#include <tf/tf.h>
#include <common_utils/utils.h>

using Marker = visualization_msgs::Marker;

extern std::map<int, std_msgs::ColorRGBA> mMarkerColorsMap;
extern std_msgs::ColorRGBA mIntersectionColor;

std::string GetNamespace(int type);

Marker GetTextMarker(
    bool isAdd,
    int type,
    int index,
    float scaleSize,
    std::string text,
    geometry_msgs::Point &position,
    std_msgs::ColorRGBA color);

Marker GetMarker(
    bool isAdd,
    int type,
    int index,
    float scaleSize,
    geometry_msgs::Point &position,
    std_msgs::ColorRGBA color);

Marker GetBoundaryLineMarker(
    bool isAdd,
    int index,
    std_msgs::ColorRGBA color,
    std::vector<geometry_msgs::Point> &points);

std_msgs::ColorRGBA GetTrafficLightColor();

std_msgs::ColorRGBA GetParkingLotColor(int id);

std_msgs::ColorRGBA GetIntersectionColor();

std_msgs::ColorRGBA GetTypeColor(int type);

Marker GetLineStripWithColor(
    int index,
    bool isAdd,
    int type,
    std_msgs::ColorRGBA color);

Marker GetArrowMarker(
    bool isAdd,
    int type,
    int index,
    float scaleSize,
    std::vector<geometry_msgs::Point> &points,
    std_msgs::ColorRGBA color);

#endif
