#ifndef __RRT_STAR_NODE__
#define __RRT_STAR_NODE__

#include <ros/ros.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseArray.h>
#include <geometry_msgs/PointStamped.h>
#include <itri_msgs/WaypointArrays.h>
#include <itri_msgs/RRTRequest.h>
#include <itri_msgs/Waypoint.h>
#include <itri_msgs/WaypointArray.h>
#include <nav_msgs/OccupancyGrid.h>
#include <visualization_msgs/Marker.h>
#include <jsk_recognition_msgs/PolygonArray.h>
#include <tf/transform_listener.h>
#include <rrt_planning/StateSampler/StateSampler.hpp>
#include <rrt_planning/Steer/ReedsSheppSteer.hpp>
#include <rrt_planning/Steer/Steer.hpp>
#include <rrt_planning/Occupancy/GridMap_utils.hpp>
#include <rrt_planning/Occupancy/OccupancyGrid2D.hpp>
#include <rrt_planning/State/Pose2D.hpp>
#include <rrt_planning/RRTStar.hpp>
#include <rrt_planning/ros_utils.hpp>
#include <rrt_planning/Steer/CCReedsShepp.hpp>
#include <sensor_msgs/PointCloud2.h>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <pcl/point_types.h>
#include <pcl_conversions/pcl_conversions.h>

template <class T>
class TopicBind
{
public:
    TopicBind()
        : mFptr{ nullptr }
        , mObj{ nullptr }
        , mStr{}
    {}

    TopicBind(void (T::*fp)(
            const sensor_msgs::PointCloud2 &, const std::string &),
        T * obj, const std::string & str)
        : mFptr{ fp }
        , mObj{ obj }
        , mStr{ str }
    {}

    void call(const sensor_msgs::PointCloud2 & msg)
    {
        assert(mFptr != nullptr && mObj != nullptr);
        (mObj->*mFptr)(msg, mStr);
    }

private:
    void(T::*mFptr)(const sensor_msgs::PointCloud2 &, const std::string &);
    T * mObj;
    std::string mStr;
};

class RRTStarNode
{
public:
    // The origin of the rrt search
    std::vector<double> mStartWeights = {3., 1.};
    std::vector<double> mGoalWeights = {2. ,1.};
    Pose2D mStart = {.x = 0., .y = 0., .theta = 0.};
    Pose2D mGoal = {.x = -3, .y = 5, .theta = 5 * M_PI_4};

    // Detected object array
    std::vector<std::vector<Pose2D>> mObjsPoly;
    std::map<std::string, std::vector<std::vector<Pose2D>>> mClusterPoints;
    std::vector<std::vector<Pose2D>> mFreeSpacePoly;

    std::shared_ptr<Car> mCar;

    // TransformListener
    tf::TransformListener mTFListener;

    // The ccupancy grid
    OccupancyGrid2D<Pose2D> mOccupancy;

    // The steering function
    std::shared_ptr<Steer<Pose2D>> mSteer;
    std::shared_ptr<Steer<Pose2D>> mCCsteer;

    // A variety of sampling functions
    UniformSampler<Pose2D> mFreeSampler;
    BridgeSampler mBridgeSampler;
    MixedSampler<Pose2D> mSampler;
    MixedSampler<Pose2D> mGoalSampler;

    // A ROS node
    ros::NodeHandle n;

    // Visualization publishers
    ros::Publisher mModelPub;
    ros::Publisher mMapPub;
    ros::Publisher mForwardPathPub;
    ros::Publisher mBackwardPathPub;
    ros::Publisher mStartSideTreePub;
    ros::Publisher mGoalSideTreePub;
    ros::Publisher mRoughPathPub;
    ros::Publisher mBestRoughPathPub;
    ros::Publisher mCurrentPathPub;
    ros::Publisher mResultPathPub;
    ros::Publisher mSmoothResultPathPub;
    ros::Publisher mCCPathPub;
    ros::Publisher mCCModelPub;
    ros::Publisher mCCRoughPathPub;
    ros::Publisher mRrtResponsePub;

    // Visualization subscribers
    ros::Subscriber mStartSub;
    ros::Subscriber mEndSub;
    ros::Subscriber mVehPosSub;
    ros::Subscriber mRrtRequestSub;
    ros::Subscriber mDetectedObjSub;
    ros::Subscriber mMapSub;
    ros::Subscriber mFreeSpaceSub;
    std::vector<ros::Subscriber> mClusterPointsSub;
    std::vector<TopicBind<RRTStarNode>> mClusterPointsCallbackBind;

    RRTStarNode();
    void FreeSpaceCallback(const visualization_msgs::MarkerArray::Ptr& msg);
    void DetectedObjCallback(const itri_msgs::DetectedObjectArray::Ptr& msg);
    void ClusterPointsCallback(
        const sensor_msgs::PointCloud2 &, const std::string & topic);
    void VehPosCallback(const itri_msgs::CarStateConstPtr & msg);
    void MapCallback(const nav_msgs::OccupancyGrid::ConstPtr & msg);
    void StartCallback(const geometry_msgs::PoseWithCovarianceStamped::ConstPtr & msg);
    void EndCallback(const geometry_msgs::PoseStamped::ConstPtr & msg);
    void RRTRequestCallback(const itri_msgs::RRTRequest::ConstPtr & msg);
    std::vector<std::vector<Pose2D>> FindPath(itri_msgs::WaypointArrays & response);
    void PickPath(itri_msgs::WaypointArrays & response);
    RRTStar<Pose2D>::Node * TreeConnect(
        RRTStar<Pose2D>::Node * startSideNode,
        RRTStar<Pose2D>::Node * goalSideNode,
        double & pathCost,
        std::vector<Pose2D> & firstSampledPath,
        std::vector<Pose2D> & sampledPath);
    void BuildResponse(const std::vector<std::vector<Pose2D>> & forwardVector,
        const std::vector<std::vector<Pose2D>> & backwardVector,
        itri_msgs::WaypointArrays & response);
    void PathVectorToWaypointArray(
        const std::vector<Pose2D> & pathVector,
        uint8_t direction,
        itri_msgs::WaypointArray & waypointArray);
private:
    std::vector<StateSampler<Pose2D>*> mStartSamplers;
    std::vector<StateSampler<Pose2D>*> mGoalSamplers;
    // Check start and goal and updat status
    bool mStartUpdated = false;
    bool mGoalUpdated = false;
    bool mFreeSpaceUpdated = false;
    bool mClusterPointsUpdated = false;
    bool mDetectedObjUpdate = false;
    bool mFreeSpaceON = false;
    bool mUseParkingSpace = false;
    double mLength;
    double mWidth;
    double mWheelBase;
    double mFrontLength;
    double mRearLength;
    double mRadiusOfGyration;
    double mSideMirrorWidth;

    int mStartRadSampler;
    int mGoalRadSampler;
    float mWaitTime;
};

#endif
