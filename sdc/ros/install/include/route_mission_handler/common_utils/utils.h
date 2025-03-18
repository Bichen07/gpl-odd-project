#ifndef _COMMON_UTILS_HPP_
#define _COMMON_UTILS_HPP_

#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose.h>

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <cmath>
#include <jsoncpp/json/json.h>
#include <route_mission_handler/MarkerPolygon.h>
#include <route_mission_handler/RoadLine.h>
#include <route_mission_handler/ParkingSpace.h>
#include <route_mission_handler/TrafficLight.h>
#include <route_mission_handler/Waypoint.h>
#include <route_mission_handler/Waypoints.h>
#include <route_mission_handler/Croad.h>
#include <route_mission_handler/NavgRoad.h>
#include <route_mission_handler/LaneNavgRoad.h>
#include <route_mission_handler/Lanes.h>
#include <route_mission_handler/Lane.h>
#include <route_mission_handler/ParkingLot.h>
#include <GeographicLib/Geocentric.hpp>
#include <GeographicLib/LocalCartesian.hpp>
#include <jsoncpp/json/json.h>

// #define DEBUG

using namespace GeographicLib;

using MarkerPolygonMap = std::map<std::string, route_mission_handler::MarkerPolygon>;
using LaneMap = std::map<int, route_mission_handler::Lane>;
using LanesMap = std::map<int, route_mission_handler::Lanes>;
using RoadLineMap = std::map<int, route_mission_handler::RoadLine>;
using NavgRoadMap = std::map<int, route_mission_handler::NavgRoad>;
using LaneNavgMap = std::map<int, route_mission_handler::LaneNavgRoad>;
using ParkingLotMap = std::map<int, route_mission_handler::ParkingLot>;
using ParkingSpaceMap = std::map<int, route_mission_handler::ParkingSpace>;
using TrafficLightMap = std::map<int, route_mission_handler::TrafficLight>;

extern std::string marker_types;
extern std::string sign_types;

static constexpr auto twoDigitalThreshold = 10;
static constexpr auto threeDigitalThreshold = 100;

enum class EditType
{
    NONE,
    WAYPOINT,
    LANE,
    ROAD_MARKER,
    ROAD_LINE,
    NAVG_ROAD, // 5
    INTERSECTION_POINT,
    PARKING_SPACE,
    TRAFFIC_LIGHT,
    ROUTE_ROAD,
    OPPOSITE_LANE,
    PARKING_LOT,
    NON_DRIVING_AREA,
    OTHER_MARKERS // 13
};

struct LaneNavg
{
    bool isPositive1;
    bool isPositive2;

    int navgroad1_id;
    int navgroad2_id;

    int laneId;
    int laneOrder;
    std::string seqner;
};

enum class LaneType {
    EMPTY = 0,
    WHITE_DASHED_LINE,
    WHITE_SOLID_LINE,
    WHITE_DOUBLE_LINE,
    YELLOW_DASHED_LINE,
    YELLOW_SOLID_LINE,
    YELLOW_DOUBLE_LINE, // 6
    RED_SOLID_LINE,
    STRAIGHT_ARROW,
    TURN_LEFT_ARROW,
    TURN_RIGHT_ARROW,
    STRAIGHT_OR_LEFT_ARROW, // 11
    STRAIGHT_OR_RIGHT_ARROW,
    TURN_RIGHT_ONLY,
    STOP_LINE,
    LONGER_BUMP,
    SHORTER_BUMP, // 16
    SLOWDOWN,
    YIELD,
    STOP_SIGN,
    SPEED_LIMIT_20KPH, // 20
    SPEED_LIMIT_30KPH,
    SPEED_LIMIT_50KPH,
    SCOOTER_PARKING_PLACE,
    PARKING_SPACE,
    ZEBRACROSS,
    INTERSECTION_AREA,  // 26
    NON_DRIVING_AREA, // grass and building
    INTERSECTION_POINT,
    LOW_SPEED,
    LOW_SPEED_LINE, // 30
    YIELD_LINE,
    NO_TEMPPARKING_AREA,
    TEMPPARKING_AREA,
    MAX_SPEED_LIMIT,
    PARKING_WARNING, // 35
    ROAD_WARNING,
    SPEED_WARNING,
    FIRE_HYDRANT,
    ROAD_GUIDE,
    NO_PARKING, //40
    TURNUNG_LINE,
    DRIVING_DRIECTIONS,
    STOP_FOR_INSPECTION,
    WIGHT_RESTRICTION,
    NO_CHANGING_LANES, // 45
    NO_ENTRY,
    PROHIBIT_RIGHT,
    BIKE_LANE, //48
    SPEED_LIMIT_40KPH,
    TRAFFIC_LIGHT, // 50
    PEDESTRIAN_LIGHT,
    TURN_LEFT_RIGHT_ARROW, // 52
    SPEED_LIMIT_25KPH,
    SLOWEST, // 54
    NO_MOTORCYCLES,
    CURB,  // 56
    VIRTUAL_LINE,
    TRIPLE_ARROW,
    HSR_STATION
};

enum class SignType {
    Railroad_crossing = 101,
    Traffic_signal,
    Closed_to_cars,
    No_driving,
    Designated_direction_only,
    No_parking,
    Speed_limit,
    Oneway,
    Slow,
    Stop
};

struct CroadNode
{
    bool positive;
    float length;
    int g;
    int h;

    CroadNode *parent_node = NULL; // previous navcroad node

    route_mission_handler::Croad croad; // self own navcroad

    CroadNode()
    {
        g = 0;
    }

    CroadNode(route_mission_handler::Croad road)
    {
        g = 0;
        croad = road;
        positive = road.isPositive;
    }
};

bool CheckFileExist(const std::string& filepath);

float GetPrincipalAngle(const float &angle);

float GetDistanceBetweenPoints(
    geometry_msgs::Point &point1,
    geometry_msgs::Point &point2);

std::vector<int> ParseStringToIntArray(
    std::string &dataStr,
    char symbol);

std::vector<std::string> ParseStringToArray(
    std::string &dataStr,
    char symbol);

std::map<std::string, std::string> ParseKeyValues(
    std::string &dataStr,
    char symbol,
    char symbol2);

std::vector<route_mission_handler::Croad> ParseRouteCroad(
    std::string &dataStr,
    char symbol,
    char symbol2);

void FindSideLanesByValue(
    std::vector<LaneNavg> &vec,
    std::map<int, LaneNavg> &mapOfElemen,
    LaneNavg &value);

std::string trim(const std::string& str);

void RemoveIntFromVector(std::vector<int> &list, int value);

Json::Value ParseJsonFile(std::string &filePath);

void SetReferenceLatLng(float lat, float lng, float high);

void ReadReferenceLatLng(std::string &filePath, std::string &route);

geometry_msgs::Point TransformLocalCartesian(double lat, double lon);

geometry_msgs::Point TransformLocalCartesian(double x, double y, double z);

int GetNearPointId(
    bool isHead,
    route_mission_handler::Lanes &lane,
    geometry_msgs::Point &pnt);

int GetNearCroad(
    route_mission_handler::Waypoint waypnt,
    LaneNavg &laneNavg,
    NavgRoadMap &navgRoadMap);

bool GetMatchedNavgRoad(
    geometry_msgs::Pose &tempPnt,
    NavgRoadMap &navgRoads,
    route_mission_handler::Croad &nearRoad);

std::vector<route_mission_handler::Croad> GetSelectedPointsOfNavgRoad(
    bool webRequest,
    std::vector<geometry_msgs::Pose> &checkPoints,
    NavgRoadMap &navgRoads);

int GetDirection(
    route_mission_handler::Croad &lastCr,
    route_mission_handler::Croad &tmpCr,
    NavgRoadMap &navgMaps,
    int &connectPntId);

geometry_msgs::Point GetMiddlePoint(
    geometry_msgs::Point pnt1,
    geometry_msgs::Point pnt2);

bool ConvertIfIsEcef(geometry_msgs::Point &point);

bool HasLaneByNavg(
    int navg1,
    bool positive1,
    int navg2,
    bool positive2,
    const LaneNavgMap &laneNavgs,
    const LanesMap &lanes);

float GetDegree(float radius);

float GetDiffAngle(float hdg1, float hdg2);

std::vector<route_mission_handler::ConnectedNavgRoad> GetNextRoads(
    bool isStartNode,
    route_mission_handler::Croad &croad,
    NavgRoadMap &navgRoadMap,
    const LaneNavgMap &laneNavgs,
    const LanesMap &lanes);

std::vector<CroadNode> ParseNeighbourCroads(
    std::vector<route_mission_handler::ConnectedNavgRoad> &nexts,
    int endNavgCroadId,
    NavgRoadMap &navgRoadMap);

std::vector<CroadNode> GetNeighbourCroads(
    bool isStartNode,
    CroadNode &node,
    int endNavgCroadId,
    NavgRoadMap &navgRoadMap,
    const LaneNavgMap &laneNavgs,
    const LanesMap &lanes);

#endif
