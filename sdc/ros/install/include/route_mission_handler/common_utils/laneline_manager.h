#ifndef ROUTE_MISSON_COMMON_TUILS_ROADLINE_MANAGER_HPP_
#define ROUTE_MISSON_COMMON_TUILS_ROADLINE_MANAGER_HPP_

#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Pose.h>
#include <route_mission_handler/RoadLine.h>
#include <route_mission_handler/RoadLineArray.h>
#include <route_mission_handler/Paths.h>
#include <route_mission_handler/Path.h>
#include <route_mission_handler/Lane.h>
#include <route_mission_handler/LaneNavgRoad.h>
#include <route_mission_handler/CroadLanes.h>
#include <route_mission_handler/CroadLanesArray.h>
#include <common_utils/utils.h>
#include <sstream>
#include <fstream>
#include <math.h>
#include <stdio.h>

struct LaneLineData
{
    route_mission_handler::Lanes lane;
    std::vector<route_mission_handler::RoadLine> lines;
    LaneLineData(route_mission_handler::Lanes laneItem)
    {
       lane = laneItem;
       lines = std::vector<route_mission_handler::RoadLine>();
    }
};

class LaneLineManager
{

public:

    static LaneLineManager* GetInstance();

    LaneLineManager();

    void AddCallbackHandler(std::function<void(int)> callback);

    bool GetNearRoadLine(
        int &matchedId,
        std::map<int, geometry_msgs::Point> &points);

    RoadLineMap GetDatas();

    LanesMap GetLaneDatas();

    LaneNavgMap GetLaneNavgs();

    NavgRoadMap GetNavgRoads();

    ParkingLotMap GetParkingLots();

    ParkingSpaceMap GetParkingSpaces();

    TrafficLightMap GetTrafficLights();

    std::vector<route_mission_handler::TrafficLight> GetTrafficLightsByLane(
        int laneId);

    float GetNearDistOfLane(int laneId, geometry_msgs::Point &pnt);

    bool CheckHasLane(int laneId);

    bool CheckRevert(std::vector<route_mission_handler::Lane> &results);

    void GetLane(
        int laneId,
        int checkRange,
        std::vector<geometry_msgs::Point> &checkPoints,
        route_mission_handler::Lane &lane,
        MarkerPolygonMap &markers);

    void LoadRoadLines(std::vector<route_mission_handler::RoadLine> &lines);

    void LoadLanes(std::vector<route_mission_handler::Paths> &paths);

    void LoadLaneInfo(std::vector<route_mission_handler::Lanes> &lanes);

    void LoadNavgRoads(std::vector<route_mission_handler::NavgRoad> &navgroads);

    void LoadLaneNavgRoads(
        std::vector<route_mission_handler::LaneNavgRoad> &lanenavgroads);

    void LoadParkingLots(
            std::vector<route_mission_handler::ParkingLot> &lots);

    void LoadParkingLanes(
        std::vector<route_mission_handler::ParkingLot> &lots);

    void LoadParkingSpaces(
        std::vector<route_mission_handler::ParkingSpace> &spaces);

    void LoadTrafficLights(
        std::vector<route_mission_handler::TrafficLight> &lights);

    void GetDataFromLanes(
        std::vector<route_mission_handler::Lane> &lanes,
        std::vector<LaneLineData> &arrays,
        float searchRange);

    int GetPointsOfNavgRoad(
        int number,
        int totalNum,
        route_mission_handler::Croad &nroad);

    void GetSelectedPoints(int index);

    route_mission_handler::Path ComputeRoadPath(
        std::vector<route_mission_handler::Croad> &routeNavgcroads,
        std::string &lanesStr,
        route_mission_handler::CroadLanesArray &outputArray,
        MarkerPolygonMap &markers);

    std::vector<route_mission_handler::ParkingLot> GetParkingLots(
        std::vector<route_mission_handler::Croad> &croads);

private:

    bool mRightHandDrive;
    int mLayerDefine;
    static LaneLineManager* mSingleton;

    RoadLineMap mRoadLineMap;
    LanesMap mLanes;
    LaneNavgMap mLaneNavgs;

    NavgRoadMap mNavgRoadMap;
    std::map<int, LaneNavg> mLaneNavgMap;
    ParkingLotMap mParkingLots;
    ParkingSpaceMap mParkingSpaces;

    std::map<int, std::vector<int>> mNavgParkingLotMap;
    TrafficLightMap mTrafficLightMap;
    std::map<int, std::vector<int>> mLaneTrafficLightMap;

    std::function<void(int)> mCallback;

    LaneLineManager(const LaneLineManager&);
    LaneLineManager& operator=(const LaneLineManager&);

    void GetRoadLinePair(
        int layer,
        std::set<int> &laneIds,
        int laneId,
        std::vector<LaneLineData> &arrays);

    std::vector<route_mission_handler::Lane> GetLanes(
        bool needFindSideLane,
        int checkRange,
        std::vector<geometry_msgs::Point> &checkPoints,
        std::vector<int> &laneIds,
        route_mission_handler::Croad &croad,
        route_mission_handler::Croad &nextCroad,
        MarkerPolygonMap &markers);

    std::vector<route_mission_handler::Lane> GetOppositeLanes(
        int checkRange,
        std::vector<geometry_msgs::Point> &checkPoints,
        route_mission_handler::Croad croad,
        route_mission_handler::Croad nextCroad,
        NavgRoadMap &navgRoadMap,
        std::map<int, LaneNavg> &laneNavgMap,
        MarkerPolygonMap &markers);

    void UpdateNavgRoadLanes(NavgRoadMap &navgRoads, LaneNavg &laneNavg);

    bool CheckConnected(
        std::vector<route_mission_handler::ConnectedNavgRoad> &conntNavgs,
        route_mission_handler::NavgRoad &checkNavg,
        route_mission_handler::ConnectedNavgRoad &navgId);

    void GetNavgPair(
        int navgId,
        std::vector<std::string> &temps,
        std::vector<route_mission_handler::ConnectedNavgRoad> &cnntNavgs);

    std::vector<route_mission_handler::ConnectedNavgRoad> GetLayerNavgs(
        int layer,
        std::vector<route_mission_handler::ConnectedNavgRoad> &checkNavgs,
        std::vector<std::string> &temps);

    std::vector<std::vector<std::string>> GetNeighborRoads(
        route_mission_handler::ConnectedNavgRoad &navg1,
        route_mission_handler::ConnectedNavgRoad &navg2,
        int searchLayer);
};

#endif
