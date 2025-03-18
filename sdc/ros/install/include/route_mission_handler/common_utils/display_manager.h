#ifndef _DISPLAY_MANAGER_HPP_
#define _DISPLAY_MANAGER_HPP_

#include <ros/ros.h>
#include <string>
#include <sstream>
#include <fstream>
#include <string>
#include <std_msgs/String.h>
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include <route_mission_handler/RoadLine.h>
#include <route_mission_handler/ParkingSpace.h>
#include <route_mission_handler/ParkingLot.h>
#include <route_mission_handler/TrafficLight.h>
#include <route_mission_handler/MarkerPolygonArray.h>
#include <route_mission_handler/MarkerPolygon.h>
#include <route_mission_handler/Waypoints.h>
#include <route_mission_handler/Lane.h>
#include <route_mission_handler/Lanes.h>
#include <route_mission_handler/Croad.h>
#include <common_utils/display_rviz_util.h>
#include <common_utils/utils.h>
#include <geometry_msgs/PoseArray.h>
#include <jsk_recognition_msgs/PolygonArray.h>

// #define DEBUG

using Marker = visualization_msgs::Marker;
using MarkerArray = visualization_msgs::MarkerArray;

class DisplayManager
{

public:

    static DisplayManager* GetInstance(ros::NodeHandle &n);

    void Dispose();

    void DisplayWaypointMarkers(bool isDisplay, LanesMap &lanes);

    void DisplayRouteLaneMarkers(bool isDisplay, LaneMap &lanes);

    void DisplayNavgRoads(const NavgRoadMap &navgRoads);

    void DisplayRouteCroads(
        bool isDisplay,
        std::vector<route_mission_handler::Croad> &navgRoads);

    void DisplayRoadLines(const RoadLineMap &lines);

    void DisplayRoadMarkers(int markerType, const MarkerPolygonMap &markers);

    void DisplayParkingSpaces(const ParkingSpaceMap &spaces);

    void DisplayParkingLots(
        bool isDisplay,
        const ParkingLotMap &lots,
        const NavgRoadMap &navgRoadMap,
        const LanesMap &lanes);

    void DisplayTrafficLights(const TrafficLightMap &lights);

    void DisplayPolygons(std::vector<geometry_msgs::Polygon> &polygons);

private:

    static constexpr auto DOUBLE_LINE_INTERVAL = 0.2;
    static constexpr auto LANE_COLOR_TYPE = 5;
    static DisplayManager* mSingleton;

    std::map<int, std::string> mMarkerTypes;
    std::map<std::string, int> mMarkerIndexes;
    std::vector<std_msgs::ColorRGBA> mColorsMap;

    ros::Publisher mMarkerArrayPub;
    ros::Publisher mRoadMarkersPub;
    ros::Publisher mPolygonsPub;

    DisplayManager(ros::NodeHandle &n);
    DisplayManager(const DisplayManager&);
    DisplayManager& operator=(const DisplayManager&);

    geometry_msgs::PolygonStamped MakePolygon(
        std::vector<geometry_msgs::Point> &points);

    geometry_msgs::PolygonStamped MakePolygon(
        std::vector<geometry_msgs::Point32> &points);

    Marker MakeBall(float scale);

    Marker MakeArrow(float scale, geometry_msgs::Pose &pose);

    Marker GetLineWithType(int index, bool isAdd, LaneType type);

    Marker GetDoubleLineMarker(
        int index,
        bool isAdd,
        LaneType type,
        std::vector<geometry_msgs::Point> &points);

    std::vector<Marker> GetLineStripMarker(
        int index,
        bool isAdd,
        std::vector<route_mission_handler::RoadLinePoint> points);
};

#endif
