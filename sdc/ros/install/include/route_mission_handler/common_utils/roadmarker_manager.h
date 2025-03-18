#ifndef ROUTE_MISSON_COMMON_TUILS_ROADMARKER_MANAGER_HPP_
#define ROUTE_MISSON_COMMON_TUILS_ROADMARKER_MANAGER_HPP_

#include <ros/ros.h>
#include <ros/package.h>
#include <geometry_msgs/Pose.h>
#include <common_utils/utils.h>
#include <route_mission_handler/Lanes.h>
#include <route_mission_handler/MarkerPolygon.h>
#include <sstream>
#include <fstream>
#include <math.h>
#include <stdio.h>

class RoadmarkerManager
{
    public:
        RoadmarkerManager();

        void AddCallbackHandler(std::function<void(int)> callback);

        void ConvertCoordinate(route_mission_handler::MarkerPolygon &obj);

        void LoadMarkers(
            std::vector<route_mission_handler::MarkerPolygon> &markers);

        void LoadNonAccessMarkers(
            std::vector<route_mission_handler::MarkerPolygon> &markers);

        MarkerPolygonMap GetDatas();

        MarkerPolygonMap GetNonAccessDatas();

    private:

          std::map<int, std::set<std::string>> mLaneMarkers;
          MarkerPolygonMap mRoadMarkerMap;

          MarkerPolygonMap mNonAccessMap;

          std::function<void(int)> mCallback;
};

#endif
