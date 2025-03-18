#ifndef __EGO_HANDLER_H__
#define __EGO_HANDLER_H__

#define USE_PREDICT_STATE

#include <memory>
#include <random>
#include <string.h>
#include <ros/node_handle.h>
#include <ros/ros.h>
#include <sensor_msgs/Imu.h>
#include <std_srvs/SetBool.h>
#include <tf/transform_broadcaster.h>
#include <tf/tf.h>
#include <itri_msgs/VehicleState.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <itri_msgs/speed_cmd.h>
#include <itri_msgs/steer_cmd.h>
#include <itri_msgs/CarState.h>
#include <itri_msgs/turn_signal_cmd.h>
#include <itri_msgs/Path.h>
#include <visualization_msgs/MarkerArray.h>
#include <visualization_msgs/Marker.h>
#include <jsk_recognition_msgs/PolygonArray.h>
#include <geometry_msgs/PolygonStamped.h>
#include <geometry_msgs/Polygon.h>
#include <geometry_msgs/PoseStamped.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/point_cloud.h>
#include <context.h>
#include <sim_vehicle.h>

#ifdef USE_PREDICT_STATE
    #include <itri_msgs/PredictState.h>
#endif

class EgoHandler
{
public:
    EgoHandler(
        std::string carId,
        bool simWithEgo,
        float longitudinalOffset,
        ros::NodeHandle &,
        const std::shared_ptr<GlobalPathHandler> &,
        const std::shared_ptr<std::vector<StatusOneStep>> &);
    ~EgoHandler();

    void SetLocalAgents(
        const scenario_msgs::AgentDataArray);
    void StepOnceAndPublish(bool simulationPaused);
    void StepOnceAndPublish();

    bool IsSimWithExternalVehicle();
    ControlCommand GetControlCommand();
    uint8_t GetTurnSignal();
    CarStatus GetRealWorldStatus();  // Not Implemented yet

protected:

    void CalculateEgoCarTransform();

    void PublishBaseLink();
    void PublishEgoCarInformation();
    void PublishObjects();
    void PublishNdtState(bool simulationPaused);

    void CalculateObjectPolygon(
        const CarStatus & car,
        geometry_msgs::PolygonStamped & polygonObject);
    void CalculateCarPose(geometry_msgs::PoseStamped & carPose);
    void CalculateCarState(itri_msgs::VehicleState &);
    void CalculateImuData(sensor_msgs::Imu &);

private:
    bool ServiceAllowMoving(
        std_srvs::SetBool::Request &req,
        std_srvs::SetBool::Response &res);
    void CallbackSpeedCmd(const itri_msgs::speed_cmd &);
    void CallbackSteerCmd(const itri_msgs::steer_cmd &);
    void CallbackTurnSignalCmd(const itri_msgs::turn_signal_cmd &);
    void CallbackRealWorldEgo(const itri_msgs::CarState &);
    void CallbackExternalDetectedObjects (const itri_msgs::DetectedObjectArray &);

    bool FrequencyFlag(const float hz);
    float AddNoise(const float value, const float noiseScale);
    float GetAltitude(const float x, const float y);

    std::string mCarId;
    std::string mNamespace;
    std::string mBaseLinkId;

    ros::NodeHandle mNodeHandle;
    ros::ServiceServer mSrvAllowMoving;
    ros::Publisher mPubNdtPose;
    ros::Publisher mPubNdtState;
    ros::Publisher mPubPredStat;
    ros::Publisher mPubImuData;
    ros::Publisher mPubCarPose;
    ros::Publisher mPubCarState;
    ros::Publisher mPubDetectedObjects;
    ros::Publisher mPubAgentDataArray;
    ros::Publisher mPubGlobalAgentDataArray;
    ros::Publisher mPubScenarioVisualization;
    ros::Subscriber mSubSpeedCmd;
    ros::Subscriber mSubSteerCmd;
    ros::Subscriber mSubTurnSignalCmd;
    ros::Subscriber mSubRealWorldEgo;
    ros::Subscriber mSubExternalDetectedObjects;
    tf::TransformBroadcaster mTransformBroadcaster;

    bool mAllowMoving;
    bool mUseCarla;
    bool mSimWithExternalVehicle;
    bool mPublishDetectedObjects100hz;
    int mDetectedObjectsIdOffset;
    std::string mDetectedObjectsTopic;
    bool mVelocityInEgoCoord;
    bool mDisableNoise;

    tf::Transform mCarTransform;
    CarStatus mRealWorldEgo;

    ControlCommand mControlCommand;
    uint8_t mTurnSignalCmd;
    itri_msgs::DetectedObjectArray mDetectedObjects;
    const std::shared_ptr<std::vector<StatusOneStep>> mStatusHistory;

    float mEgoVehicleLongitudinalOffset;
    float mDetectRange;
    double mPreviousTimeStamp;

    const std::shared_ptr<GlobalPathHandler> mGlobalPathHandler;
    std::default_random_engine mNoiseGenerator;
    std::normal_distribution<float> mNormalDistribution;

    std::mutex mDetectedObjectsMutex;
    itri_msgs::DetectedObjectArray mExternalDetectedObjects;

#ifdef USE_PREDICT_STATE
    itri_msgs::PredictState mPredictStat;
#endif
};

#endif // __EGO_HANDLER_H__
