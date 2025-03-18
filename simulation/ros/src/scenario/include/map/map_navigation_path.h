#ifndef _MAP_NAVIGATION_PATH_H_
#define _MAP_NAVIGATION_PATH_H_

#include <map>
#include <vector>
#include <ros/ros.h>
#include <jsoncpp/json/json.h>
#include <pcl/point_cloud.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose2D.h>
#include <route_mission_handler/Path.h>
#include <route_mission_handler/LanesArray.h>
#include <route_mission_handler/MarkerPolygonArray.h>
#include <path_msgs/EgoVehicleGlobalPath.h>
#include <path_msgs/NavigationData.h>
#include <path_msgs/RouteWaypoint.h>
#include <path_msgs/RouteWaypointsArray.h>
#include <path_msgs/BidirectionalRouteWaypointsArray.h>
#include <math_type.h>
#include <math_frenet_coord.h>
#include <map_type.h>
#include <map_intersection_waypoint_data.h>
#include <map_navigation_path_config.h>
#include <map_waypoint_id.h>

namespace map {

class NavigationPath final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    typedef std::shared_ptr<NavigationPath> Ptr;

    NavigationPath();
    NavigationPath(const NavigationPath &) = delete;
    NavigationPath &operator=(const NavigationPath &) = delete;
    virtual ~NavigationPath() = default;

    const NavigationPathConfig &GetNavigationPathConfig() const;

    const std::vector<int32_t> &GetEgoVehicleGlobalLaneIds() const;
    const std::vector<int32_t> &GetForwardLaneIds() const;
    const std::vector<int32_t> &GetOppositeLaneIds() const;

    const std::vector<math::Vector3d_t> &GetEgoVehicleGlobalPath();
    const std::vector<math::Vector3d_t> &GetForwardWaypoints() const;
    const std::vector<math::Vector3d_t> &GetOppositeWaypoints() const;

    const std::vector<path_msgs::RouteWaypoints> &GetForwardRouteWaypointsArray() const;
    const std::vector<path_msgs::RouteWaypoints> &GetOppositeRouteWaypointsArray() const;

    const std::vector<route_mission_handler::Waypoint> &GetForwardRouteWaypoints() const;
    const std::vector<route_mission_handler::Waypoint> &GetOppositeRouteWaypoints() const;

    const std::vector<std::pair<int32_t, int32_t>> &GetForwardIntersectionWaypointIndices() const;
    const std::vector<std::pair<int32_t, int32_t>> &GetOppositeIntersectionWaypointIndices() const;

    const std::vector<Vector3dPair> &GetForwardIntersectionWaypoints() const;
    const std::vector<Vector3dPair> &GetOppositeIntersectionWaypoints() const;

    const std::vector<IntersectionWaypointData> &GetForwardIntersectionWaypointDatas() const;
    const std::vector<IntersectionWaypointData> &GetOppositeIntersectionWaypointDatas() const;

    const route_mission_handler::Waypoint &GetForwardRouteWaypoint(
        const int32_t idx) const;
    const route_mission_handler::Waypoint &GetOppositeRouteWaypoint(
        const int32_t idx) const;
    const IntersectionWaypointData &GetForwardIntersectionWaypointData(
        const int32_t intersectionId) const;
    const IntersectionWaypointData &GetOppositeIntersectionWaypointData(
        const int32_t intersectionId) const;

    void Configure(const NavigationPathConfig &navigationPathConfig);

    path_msgs::RouteWaypoint QueryRouteWaypoint(
        const WaypointId &waypointId);
    path_msgs::RouteWaypoint QueryRouteWaypoint(
        const int32_t laneId,
        const int32_t pointId);
    math::Vector3d_t QueryWaypoint(const WaypointId &waypointId);
    math::Vector3d_t QueryWaypoint(
        const int32_t laneId,
        const int32_t pointId);

    int32_t SearchNearestForwardWaypoint(const math::Vector3d_t &givenQueryPoint) const;
    int32_t SearchNearestForwardWaypoint(const geometry_msgs::Pose2D &givenQueryPose2D) const;
    int32_t SearchNearestForwardWaypoint(
        const math::Vector3d_t &givenQueryPoint,
        math::Vector3d_t *resultantPoint) const;
    int32_t SearchNearestOppositeWaypoint(const math::Vector3d_t &givenQueryPoint) const;
    int32_t SearchNearestOppositeWaypoint(const geometry_msgs::Pose2D &givenQueryPose2D) const;
    int32_t SearchNearestOppositeWaypoint(
        const math::Vector3d_t &givenQueryPoint,
        math::Vector3d_t *resultantPoint) const;

    std::vector<math::Vector3d_t> QuerySequentialWaypoints(
        const WaypointId &beginId,
        const WaypointId &endId) const;
    std::vector<math::Vector3d_t> QuerySequentialWaypoints(
        const int32_t beginLaneId,
        const int32_t beginPointId,
        const int32_t endLaneId,
        const int32_t endPointId) const;
    std::vector<math::Vector3d_t> QuerySequentialForwardWaypoints(
        const int32_t beginLaneId,
        const int32_t beginPointId,
        const int32_t endLaneId,
        const int32_t endPointId) const;
    std::vector<math::Vector3d_t> QuerySequentialOppositeWaypoints(
        const int32_t beginLandId,
        const int32_t beginPointId,
        const int32_t endLaneId,
        const int32_t endPointId) const;

    int32_t QueryForwardWaypointIdx(const int32_t laneId, const int32_t pointId) const;
    int32_t QueryOppositeWaypointIdx(const int32_t laneId, const int32_t pointId) const;

    bool IsIntersection(const math::Vector3d_t &givenQueryPoint);
    bool IsIntersection(const geometry_msgs::Pose2D &givenQueryPose2D);

    bool IsReady();

protected:

private:

    // lane_id, lane
    using LaneMap = std::map<int32_t, route_mission_handler::Lane>;
    // point_id, waypoint
    using WaypointMap = std::map<int32_t, route_mission_handler::Waypoint>;
    // lane_id, point_id, waypoint
    using LaneWaypointMap = std::map<int32_t, WaypointMap>;
    using TravelMap = std::map<int32_t, bool>;

    using RouteLanePointIdToWaypointIdxMap = std::map<std::pair<int32_t, int32_t>, int32_t>;
    using WaypointIdxToRouteWaypointIdMap = std::map<int32_t, std::pair<int32_t, int32_t>>;

    void ConnectForwardLanes(const int32_t laneId);
    void ConnectOppositeLanes(const int32_t laneId);
    void GenerateRouteWaypoints(
        const std::vector<int32_t> &laneIds,
        std::vector<route_mission_handler::Waypoint> *routeWaypoints,
        std::vector<std::pair<int32_t, int32_t>> *intersectionWaypointIndices);
    void ComputeWaypointSds(
        const std::vector<math::Vector3d_t> &waypoints,
        std::vector<math::FrenetCoord> *waypointSds);
    void ConstructKdTree(
        const std::vector<math::Vector3d_t> &points,
        pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr &kdTree);
    int32_t SearchNearestWaypoint(
        const math::Vector3d_t &targetPoint,
        const std::vector<math::Vector3d_t> &waypoints,
        const pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr &waypointKdTree,
        math::Vector3d_t *resultantPoint) const;

    std::vector<math::Vector3d_t> QuerySequentialWaypoints(const int32_t laneId) const;

    bool IsSameDirectionLane(
        const int32_t refLaneId,
        const int32_t testLaneId);
    bool IsValidSequentialForwardLaneIdPair(
        const int32_t beginLaneId,
        const int32_t endLaneId) const;
    bool IsValidSequentialOppositeLaneIdPair(
        const int32_t beginLaneId,
        const int32_t endLaneId) const;
    bool IsValidSequentialForwardWaypointIdPair(
        const int32_t beginLaneId,
        const int32_t beginPointId,
        const int32_t endLaneId,
        const int32_t endPointId) const;
    bool IsValidSequentialOppositeWaypointIdPair(
        const int32_t beginLaneId,
        const int32_t beginPointId,
        const int32_t endLaneId,
        const int32_t endPointId) const;

    void ValidateNavigationPathConfig() const;

    math::Vector3d_t Pose2DToVector3d(const geometry_msgs::Pose2D &pose2d) const;

    void EgoVehicleGlobalPathCallback(const path_msgs::EgoVehicleGlobalPath::Ptr &msg);
    void NavigationDataCallback(const path_msgs::NavigationData::Ptr &msg);
    void BidirectionalRouteWaypointsArrayCallback(
        const path_msgs::BidirectionalRouteWaypointsArray::Ptr &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mEgoVehicleGlobalPathSubscriber;
    ros::Subscriber mNavigationDataSubscriber;
    ros::Subscriber mBidirectionalRouteWaypointsArraySubscriber;
    ros::Publisher mNavigationPathReadinessPublisher;
    ros::ServiceClient mRouteWaypointQueryingService;
    ros::ServiceClient mWaypointQueryingService;
    ros::ServiceClient mRequestEgoVehicleGlobalPathService;

    pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr mForwardWaypointKdTree;
    pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr mOppositeWaypointKdTree;

    NavigationPathConfig mNavigationPathConfig;

    route_mission_handler::Path mPath;
    LaneMap mLaneMap;
    LaneWaypointMap mLaneWaypointMap;

    RouteLanePointIdToWaypointIdxMap mForwardRouteLanePointIdToWaypointIdxMap;
    RouteLanePointIdToWaypointIdxMap mOppositeRouteLanePointIdToWaypointIdxMap;

    std::vector<int32_t> mEgoVehicleGlobalLaneIds;
    std::vector<int32_t> mForwardLaneIds;
    std::vector<int32_t> mOppositeLaneIds;
    std::vector<int32_t> mCandidateOppositeLaneIds;
    TravelMap mForwardTravelMap;
    TravelMap mOppositeTravelMap;

    std::vector<path_msgs::RouteWaypoints> mForwardRouteWaypointsArray;
    std::vector<path_msgs::RouteWaypoints> mOppositeRouteWaypointsArray;
    std::vector<route_mission_handler::Waypoint> mForwardRouteWaypoints;
    std::vector<route_mission_handler::Waypoint> mOppositeRouteWaypoints;
    std::vector<std::pair<int32_t, int32_t>> mForwardIntersectionWaypointIndices;
    std::vector<std::pair<int32_t, int32_t>> mOppositeIntersectionWaypointIndices;
    std::vector<Vector3dPair> mForwardIntersectionWaypoints;
    std::vector<Vector3dPair> mOppositeIntersectionWaypoints;
    std::vector<IntersectionWaypointData> mForwardIntersectionWaypointDatas;
    std::vector<IntersectionWaypointData> mOppositeIntersectionWaypointDatas;
    std::vector<math::Vector3d_t> mEgoVehicleGlobalPath;
    std::vector<math::Vector3d_t> mForwardWaypoints;
    std::vector<math::Vector3d_t> mOppositeWaypoints;
    std::vector<math::FrenetCoord> mForwardWaypointSds;
    std::vector<math::FrenetCoord> mOppositeWaypointSds;

    std::vector<int32_t> mIntersectionLanes;

    bool mIsReady;
    uint mRetryBeforeRequestEgoVehicleGlobalPath;
};

} // namespace map {

#endif // #ifndef _MAP_NAVIGATION_PATH_H_
