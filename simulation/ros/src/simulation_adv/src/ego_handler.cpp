#include <Box2D.h>
#include <assert.h>
#include <cmath>
#include <ego_handler.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Polygon.h>
#include <itri_msgs/NdtStatistics.h>
#include <ros/console.h>
#include <ros/param.h>
#include <ros/service.h>
#include <ros/time.h>
#include <simulation_constants.h>
#include <utils_converter.h>
#include <utils_coord_transform.h>

static inline b2Vec2 AngularTransform(const b2Vec2 &sourceVec2, const float angle)
{
    b2Vec2 transformVec2;
    transformVec2.x = sourceVec2.x * std::cos(angle) + sourceVec2.y * std::sin(angle);
    transformVec2.y = -sourceVec2.x * std::sin(angle) + sourceVec2.y * std::cos(angle);
    return transformVec2;
}

template <typename T>
static void PointCoordinateTransform(const tf::Transform &transform, T &point)
{
    const tf::Point tfPoint(point.x, point.y, point.z);
    tf::Point       tfPointTransform = transform.inverse() * tfPoint;
    point.x                          = tfPointTransform.x();
    point.y                          = tfPointTransform.y();
    point.z                          = tfPointTransform.z();
}

static inline float ConvertToYaw(const geometry_msgs::Quaternion &q)
{
    float siny_cosp = 2 * (q.w * q.z);
    float cosy_cosp = 1 - 2 * (q.z * q.z);
    return std::atan2(siny_cosp, cosy_cosp);
}

static void EulerAnglesToQuaternion(geometry_msgs::PoseStamped &pose)
{
    tf::Matrix3x3 mat3x3;
    mat3x3.setEulerYPR(pose.pose.orientation.z, pose.pose.orientation.y, pose.pose.orientation.x);
    tf::Quaternion quaternion;
    mat3x3.getRotation(quaternion);
    pose.pose.orientation.x = quaternion.getX();
    pose.pose.orientation.y = quaternion.getY();
    pose.pose.orientation.z = quaternion.getZ();
    pose.pose.orientation.w = quaternion.getW();
}

// Public Functions

EgoHandler::EgoHandler(std::string                                        carId,
                       bool                                               simWithExternalVehicle,
                       float                                              longitudinalOffset,
                       ros::NodeHandle                                   &nh,
                       const std::shared_ptr<GlobalPathHandler>          &globalPathHandler,
                       const std::shared_ptr<std::vector<StatusOneStep>> &statusHistory)
    : mNodeHandle(nh),
      mCarId(carId),
      mGlobalPathHandler(globalPathHandler),
      mStatusHistory(statusHistory),
      mCarTransform(),
      mNoiseGenerator(),
      mNormalDistribution()
#ifdef USE_PREDICT_STATE
      ,
      mPredictStat()
#endif
      ,
      mPreviousTimeStamp(ros::Time::now().toSec()),
      mTransformBroadcaster(),
      mEgoVehicleLongitudinalOffset{longitudinalOffset},
      mDetectRange{60.},
      mAllowMoving{true},
      mUseCarla{false},
      mSimWithExternalVehicle{simWithExternalVehicle},
      mPublishDetectedObjects100hz{false},
      mDetectedObjectsIdOffset{0},
      mControlCommand(carId, 0.0f, 0.0f, false),
      mTurnSignalCmd(uint8_t(0)),
      mVelocityInEgoCoord(false),
      mDisableNoise(false)
{
    ROS_INFO_STREAM("[EgoHandler] Construting.");

    mNormalDistribution.param(std::normal_distribution<float>(GAUSSIAN_MEAN, GAUSSIAN_DEVIATION).param());

    ros::param::param<bool>("~ego_handler/detected_objects_100hz", mPublishDetectedObjects100hz, false);
    ros::param::param<int>("~ego_handler/detected_objects_id_offset", mDetectedObjectsIdOffset, 0);
    ros::param::param<std::string>("~ego_handler/detected_objects_topic", mDetectedObjectsTopic, "/detected_objects");
    ros::param::param<float>("~ego_handler/detect_range", mDetectRange, 60.);
    ros::param::param<bool>("~ego_handler/velocity_in_ego_coord", mVelocityInEgoCoord, false);

    if (mDetectedObjectsTopic != "/detected_objects")
    {
        ROS_WARN_STREAM("[EgoHandler] detected objects was published to " << mDetectedObjectsTopic);
    }

    std::string ns     = "";
    size_t      endIdx = carId.rfind('/');
    if (endIdx != std::string::npos)
        ns = std::string(carId.substr(0, endIdx));
    mNamespace  = ns;
    mBaseLinkId = (ns == "") ? ("base_link") : (ns + std::string("/base_link"));

    auto prefix = (ns == "") ? "/" + ns : "";
    ros::param::set(prefix + "/ego_handler/useCarla", mUseCarla);
    ros::param::set(prefix + "/ego_handler/carId", mCarId);
    ros::param::set(prefix + "/ego_handler/longitudinalOffset", mEgoVehicleLongitudinalOffset);
    ros::param::set(prefix + "/ego_handler/detectRange", mDetectRange);
    ros::param::set(prefix + "/ego_handler/disable_noise", mDisableNoise);
    ros::param::set(prefix + "/ego_handler/simWithExternalVehicle", mSimWithExternalVehicle);

    ROS_INFO_STREAM("[EgoHandler] Settings:"
                    << "\n    Basic Configs:"
                    << "\n\tCar ID: " << mCarId << "\n\tNamespace: " << mNamespace << "\n\tBase Link ID: " << mBaseLinkId
                    << "\n\tLongitudinal Offset: " << mEgoVehicleLongitudinalOffset << "\n\tDisable Noise: " << (mDisableNoise ? "true" : "false")
                    << "\n\tSimulate With External Vehicle: " << (mSimWithExternalVehicle ? "true" : "false") << "\n    Detected Objects: "
                    << "\n\tDetect Range: " << mDetectRange << "\n\tDetected Objects 100hz: " << (mPublishDetectedObjects100hz ? "true" : "false")
                    << "\n\tDetected Objects ID Offset: " << mDetectedObjectsIdOffset << "\n\tDetected Objects Topic: " << mDetectedObjectsTopic
                    << "\n\tVelocity In Ego Coord: " << (mVelocityInEgoCoord ? "true" : "false") << "\n");

    if (!mSimWithExternalVehicle)
    {
        mPubCarPose  = mNodeHandle.advertise<geometry_msgs::PoseStamped>(ns + std::string("/predict_pose"), 1);
        mPubNdtPose  = mNodeHandle.advertise<geometry_msgs::PoseStamped>(ns + std::string("/ndt_pose"), 1);
        mPubNdtState = mNodeHandle.advertise<itri_msgs::NdtStatistics>(ns + std::string("/ndt_stat"), 1);

#ifdef USE_PREDICT_STATE
        mPubPredStat = mNodeHandle.advertise<itri_msgs::PredictState>(ns + std::string("/localizer_node/pred_stat"), 1);
#endif

        mPubCarState = mNodeHandle.advertise<itri_msgs::VehicleState>(ns + std::string("/vehicle_state"), 1);
        mPubImuData  = mNodeHandle.advertise<sensor_msgs::Imu>(ns + std::string("/imu/data"), 1);
        // mPubNdtPose =
        //     mNodeHandle.advertise<geometry_msgs::PoseStamped>(
        //         ns + std::string("/ndt_pose"), 1);
        // mPubNdtState =
        //     mNodeHandle.advertise<itri_msgs::NdtStatistics>(
        //         ns + std::string("/ndt_stat"), 1);
    }

    mSrvAllowMoving = mNodeHandle.advertiseService(ns + std::string("/allow_moving"), &EgoHandler::ServiceAllowMoving, this);

    mPubDetectedObjects       = mNodeHandle.advertise<itri_msgs::DetectedObjectArray>(ns + mDetectedObjectsTopic, 1);
    mPubAgentDataArray        = mNodeHandle.advertise<scenario_msgs::AgentDataArray>(ns + std::string("/agent_data_array"), 1);
    mPubGlobalAgentDataArray  = mNodeHandle.advertise<scenario_msgs::AgentDataArray>(ns + std::string("/agent_data_array/global"), 1);
    mPubScenarioVisualization = mNodeHandle.advertise<visualization_msgs::MarkerArray>(ns + std::string("/scenario_visualization"), 1);

    if (!mSimWithExternalVehicle)
    {
        mSubSpeedCmd = mNodeHandle.subscribe(ns + std::string("/speed_cmd"), 1, &EgoHandler::CallbackSpeedCmd, this);
        mSubSteerCmd = mNodeHandle.subscribe(ns + std::string("/steer_cmd"), 1, &EgoHandler::CallbackSteerCmd, this);
    }
    mSubTurnSignalCmd = mNodeHandle.subscribe(ns + std::string("/turn_signal_cmd"), 1, &EgoHandler::CallbackTurnSignalCmd, this);
    mSubRealWorldEgo  = mNodeHandle.subscribe(ns + std::string("/car_state"), 1, &EgoHandler::CallbackRealWorldEgo, this);
    mSubExternalDetectedObjects =
        mNodeHandle.subscribe(ns + std::string("/external_detected_objects"), 1, &EgoHandler::CallbackExternalDetectedObjects, this);
}

EgoHandler::~EgoHandler()
{
}

static inline float DistanceSquare(float dx, float dy)
{
    return dx * dx + dy * dy;
}

void EgoHandler::CalculateObjectPolygon(const CarStatus &car, geometry_msgs::PolygonStamped &polygonObject)
{
    polygonObject.header.frame_id = "/base_link";
    geometry_msgs::Point32 point;
    for (size_t i = 0; i < OBJECT_LAYER; ++i)
    {
        for (size_t j = 0; j < LAYER_VERTICES; ++j)
        {
            point.x = car.shape[j % RECTANGLE_VERTICES].x;
            point.y = car.shape[j % RECTANGLE_VERTICES].y;
            point.z = GetAltitude(point.x, point.y) + (i == 0 ? HALF * CAR_OBJECT_HEIGHT : -HALF * CAR_OBJECT_HEIGHT);
            point.x = AddNoise(point.x, 0.1f);
            point.y = AddNoise(point.y, 0.1f);
            PointCoordinateTransform(mCarTransform, point);
            polygonObject.polygon.points.push_back(point);
        }
    }
}

void EgoHandler::SetLocalAgents(const scenario_msgs::AgentDataArray agents)
{
    scenario_msgs::AgentDataArray   localAgents;
    itri_msgs::DetectedObjectArray  objects;
    scenario_msgs::AgentDataArray   globalAgents;
    visualization_msgs::MarkerArray vizMarkers;

    objects.header.stamp    = ros::Time::now();
    objects.header.frame_id = mBaseLinkId;
    localAgents.header      = objects.header;

    globalAgents.header.stamp    = objects.header.stamp;
    globalAgents.header.frame_id = "map";

    CarStatus egoCar = mStatusHistory->back().status[mCarId];

    for (auto &agent_ : agents.data)
    {
        scenario_msgs::AgentData agent = agent_;
        std::string              carId = agent.agent_id;
        if (carId.compare(mCarId) == 0)
            continue;

        auto car = mStatusHistory->back().status[carId];

        float longiNoise = 0.0f;

        if (car.longitudinalNoiseScale > 0.001f)
        {
            // If noise applied, only detected objects gets the noisy data.
            // localAgents and globalAgents remains the same.
            const auto distanceToEgo = std::hypot(car.position.x - egoCar.position.x, car.position.y - egoCar.position.y);
            longiNoise               = AddNoise(0.0f, car.longitudinalNoiseScale * distanceToEgo);

            car.position.x += longiNoise * std::cos(car.orientation);
            car.position.y += longiNoise * std::sin(car.orientation);
            for (auto &vertex : car.shape)
            {
                vertex.x += longiNoise * std::cos(car.orientation);
                vertex.y += longiNoise * std::sin(car.orientation);
            }

            agent.pose.position.x += longiNoise * std::cos(car.orientation);
            agent.pose.position.y += longiNoise * std::sin(car.orientation);
        }

        itri_msgs::DetectedObject  object;
        scenario_msgs::AgentData   localAgent;
        scenario_msgs::AgentData   globalAgent;
        visualization_msgs::Marker vizMarker;

        object.id             = agent.detected_object_id + mDetectedObjectsIdOffset;
        object.label          = agent.objectClassId;
        object.header         = objects.header;
        object.trackedPeriod  = 1.0;
        object.space_frame    = "lidar";
        object.behavior_state = 2;

        vizMarker.header = globalAgents.header;

        geometry_msgs::Pose resultPose = utils_coord::CoordinateTransform(mCarTransform, agent.pose);

        // Transform to local from here.
        float distanceSquare = DistanceSquare(resultPose.position.x, resultPose.position.y);
        if (distanceSquare > mDetectRange * mDetectRange)
            continue;

        // Object orientation was originally calculated
        // on global frame while points on local.
        // It was now changed to both on local frame.

        object.pose          = resultPose;
        object.dimensions    = agent.size;
        object.pose_reliable = true;

        if (mVelocityInEgoCoord)
        {
            object.velocity.linear = utils_coord::CoordinateTransform(mCarTransform, agent.linear_velocity);
            geometry_msgs::Point point;
            point.x = resultPose.position.x;
            point.y = resultPose.position.y;
            point.z = resultPose.position.z;
            object.predicted_poses.push_back(point);
            for (int i = 1; i <= 100; i++)
            {
                geometry_msgs::Point predPoint;
                predPoint.x = resultPose.position.x + float(i) * 0.1 * object.velocity.linear.x;
                predPoint.y = resultPose.position.y + float(i) * 0.1 * object.velocity.linear.y;
                predPoint.z = object.pose.position.z;
                object.predicted_poses.push_back(predPoint);
            }
        }
        else
        {
            object.velocity.linear     = agent.linear_velocity;
            auto velocity_on_ego_coord = object.velocity.linear = utils_coord::CoordinateTransform(mCarTransform, agent.linear_velocity);
            geometry_msgs::Point point;
            point.x = resultPose.position.x;
            point.y = resultPose.position.y;
            point.z = resultPose.position.z;
            object.predicted_poses.push_back(point);
            for (int i = 1; i <= 100; i++)
            {
                geometry_msgs::Point predPoint;
                predPoint.x = resultPose.position.x + float(i) * 0.1 * velocity_on_ego_coord.x;
                predPoint.y = resultPose.position.y + float(i) * 0.1 * velocity_on_ego_coord.y;
                predPoint.z = object.pose.position.z;
                object.predicted_poses.push_back(predPoint);
            }
        }

        globalAgents.id_list.push_back(agent.agent_id);
        globalAgent.agent_id           = agent.agent_id;
        globalAgent.detected_object_id = agent.detected_object_id;
        globalAgent.objectClassId      = agent.objectClassId;
        globalAgent.pose               = agent.pose;
        globalAgent.size               = agent.size;
        globalAgent.color              = agent.color;
        globalAgent.linear_velocity    = agent.linear_velocity;
        globalAgent.turn_signal        = agent.turn_signal;

        localAgents.id_list.push_back(agent.agent_id);
        localAgent                 = globalAgent;
        localAgent.pose            = resultPose;
        localAgent.distance        = pow(distanceSquare, 0.5);
        localAgent.linear_velocity = object.velocity.linear;
        localAgent.turn_signal     = agent.turn_signal;

        geometry_msgs::PolygonStamped itriConvexHull;
        CalculateObjectPolygon(car, itriConvexHull);
        object.convex_hull = itriConvexHull;
        localAgent.polygon = object.convex_hull.polygon;

        vizMarker.ns       = mNamespace + "_noisy";
        vizMarker.id       = globalAgents.data.size();
        vizMarker.type     = 1;
        vizMarker.lifetime = ros::Duration(0.05);
        vizMarker.pose     = globalAgent.pose;
        vizMarker.pose.position.z -= 1.;
        vizMarker.scale   = globalAgent.size;
        vizMarker.color.r = 1.0;
        vizMarker.color.g = 0.64;
        vizMarker.color.b = 0.28;
        vizMarker.color.a = 0.4;

        objects.objects.push_back(object);
        localAgents.data.push_back(localAgent);
        globalAgents.data.push_back(globalAgent);
        vizMarkers.markers.push_back(vizMarker);
    }
    std::lock_guard<std::mutex> detectedObjectsMutex(mDetectedObjectsMutex);
    mDetectedObjects = objects;
    mPubAgentDataArray.publish(localAgents);
    mPubGlobalAgentDataArray.publish(globalAgents);
    mPubScenarioVisualization.publish(vizMarkers);
}

void EgoHandler::StepOnceAndPublish()
{  // PublishStatus
    StepOnceAndPublish(false);
}

void EgoHandler::StepOnceAndPublish(bool simulationPaused)
{
    if (mStatusHistory->size() > 0)
    {
        CalculateEgoCarTransform();
        if (!mSimWithExternalVehicle)
        {
            PublishEgoCarInformation();
            PublishBaseLink();
            PublishEgoCarInformation();
            PublishNdtState(simulationPaused);
#ifdef USE_PREDICT_STATE
            mPubPredStat.publish(mPredictStat);
#endif
        }

        if (mPublishDetectedObjects100hz)
            PublishObjects();
        else if (FrequencyFlag(10.0f))
            PublishObjects();
    }
}

bool EgoHandler::IsSimWithExternalVehicle()
{
    return mSimWithExternalVehicle;
}

ControlCommand EgoHandler::GetControlCommand()
{
    return mControlCommand;
}

uint8_t EgoHandler::GetTurnSignal()
{
    return mTurnSignalCmd;
}

CarStatus EgoHandler::GetRealWorldStatus()
{
    return mRealWorldEgo;
}

// Protected Functions

void EgoHandler::CalculateEgoCarTransform()
{
    CarStatus egoCar = mStatusHistory->back().status[mCarId];
    egoCar.position.x -= mEgoVehicleLongitudinalOffset * std::cos(egoCar.orientation);
    egoCar.position.y -= mEgoVehicleLongitudinalOffset * std::sin(egoCar.orientation);

    mCarTransform.setOrigin(tf::Vector3(egoCar.position.x, egoCar.position.y, GetAltitude(egoCar.position.x, egoCar.position.y) + 0.9f));
    tf::Quaternion q;
    q.setRPY(0.0, 0.0, egoCar.orientation);
    mCarTransform.setRotation(q);
}

void EgoHandler::PublishBaseLink()
{
    assert(!mSimWithExternalVehicle);
    mTransformBroadcaster.sendTransform(tf::StampedTransform(mCarTransform, ros::Time::now(), "map", mBaseLinkId));
}

void EgoHandler::PublishEgoCarInformation()
{
    assert(!mSimWithExternalVehicle);
    sensor_msgs::Imu imu;
    CalculateImuData(imu);
    mPubImuData.publish(imu);
    itri_msgs::VehicleState carState;
    CalculateCarState(carState);
    mPubCarState.publish(carState);
    geometry_msgs::PoseStamped carPose;
    CalculateCarPose(carPose);
    mPubCarPose.publish(carPose);
    mPubNdtPose.publish(carPose);
#ifdef USE_PREDICT_STATE
    mPredictStat.speed = carState.speed * KPH_TO_MS;
#endif
}

void EgoHandler::PublishObjects()
{
    std::lock_guard<std::mutex> detectedObjectsMutex(mDetectedObjectsMutex);
    if (mExternalDetectedObjects.objects.size())
    {
        for (auto &object : mExternalDetectedObjects.objects)
        {
            mDetectedObjects.objects.push_back(object);
        }
        if (mDetectedObjects.header.stamp - mExternalDetectedObjects.header.stamp > ros::Duration(0.5))
        {
            mExternalDetectedObjects.objects.clear();
        }
    }
    mPubDetectedObjects.publish(mDetectedObjects);
}

void EgoHandler::PublishNdtState(bool simulationPaused)
{
    assert(!mSimWithExternalVehicle);
    itri_msgs::NdtStatistics ndtState;
    if (!simulationPaused)
        ndtState.fitness_score = 0.0;
    else
        ndtState.fitness_score = 10000.0;
    mPubNdtState.publish(ndtState);
}

void EgoHandler::CalculateCarPose(geometry_msgs::PoseStamped &carPose)
{
    const CarStatus egoCar     = mStatusHistory->back().status[mCarId];
    carPose.header.stamp       = ros::Time::now();
    carPose.pose.orientation.z = AddNoise(egoCar.orientation, ORIENTATION_NOISE);
    carPose.pose.position.x    = AddNoise(egoCar.position.x, POSITION_NOISE) - mEgoVehicleLongitudinalOffset * std::cos(carPose.pose.orientation.z);
    carPose.pose.position.y    = AddNoise(egoCar.position.y, POSITION_NOISE) - mEgoVehicleLongitudinalOffset * std::sin(carPose.pose.orientation.z);
    carPose.pose.position.z    = GetAltitude(egoCar.position.x, egoCar.position.y);
    EulerAnglesToQuaternion(carPose);
}

void EgoHandler::CalculateCarState(itri_msgs::VehicleState &carState)
{
    const CarStatus egoCar  = mStatusHistory->back().status[mCarId];
    carState.header.stamp   = ros::Time::now();
    carState.speed          = KPH_RATIO * AngularTransform(egoCar.velocity, egoCar.orientation).x;
    carState.steering_angle = egoCar.steeringAngle;
    carState.mode           = itri_msgs::VehicleState::AUTO;
    carState.gear_state     = itri_msgs::VehicleState::GEAR_D;
    if (std::signbit(carState.speed))
        carState.gear_state = itri_msgs::VehicleState::GEAR_R;
    carState.eps_state      = itri_msgs::VehicleState::CONTROL_ENGAGED;
    carState.throttle_state = itri_msgs::VehicleState::CONTROL_ENGAGED;
}

void EgoHandler::CalculateImuData(sensor_msgs::Imu &imu)
{
    imu.header.stamp       = ros::Time::now();
    imu.angular_velocity.z = mStatusHistory->back().status[mCarId].yawRate;
}

// Private Functions

bool EgoHandler::ServiceAllowMoving(std_srvs::SetBool::Request &req, std_srvs::SetBool::Response &res)
{
    mAllowMoving             = req.data;
    mControlCommand.speed    = 0.0f;
    mControlCommand.steering = 0.0f;
    res.success              = true;
    return true;
}

void EgoHandler::CallbackSpeedCmd(const itri_msgs::speed_cmd &msg)
{
    assert(!mSimWithExternalVehicle);
    if (mAllowMoving)
    {
        mControlCommand.speed = msg.kph;
    }
    else
    {
        mControlCommand.speed = 0.0f;
    }
}
void EgoHandler::CallbackSteerCmd(const itri_msgs::steer_cmd &msg)
{
    assert(!mSimWithExternalVehicle);
    if (mAllowMoving)
    {
        mControlCommand.steering = msg.angle;
    }
    else
    {
        mControlCommand.steering = 0.0f;
    }
}

void EgoHandler::CallbackTurnSignalCmd(const itri_msgs::turn_signal_cmd &msg)
{
    mTurnSignalCmd = msg.turn_signal;
}

void EgoHandler::CallbackRealWorldEgo(const itri_msgs::CarState &msg)
{
    mRealWorldEgo.id          = mCarId;
    mRealWorldEgo.position    = b2Vec2(msg.pose.pose.position.x, msg.pose.pose.position.y);
    mRealWorldEgo.velocity    = b2Vec2(msg.twist.twist.linear.x, 0.0f);
    mRealWorldEgo.orientation = msg.pose.pose.orientation.z;
    mRealWorldEgo.yawRate     = msg.twist.twist.angular.z;
}

void EgoHandler::CallbackExternalDetectedObjects(const itri_msgs::DetectedObjectArray &msg)
{
    mExternalDetectedObjects = msg;
}

bool EgoHandler::FrequencyFlag(const float hz)
{
    const double now   = ros::Time::now().toSec();
    const bool   flag  = (now - mPreviousTimeStamp > 1.0 / hz - DEFAULT_SAMPLING_TIME);
    mPreviousTimeStamp = flag ? now : mPreviousTimeStamp;
    return flag;
}

inline float EgoHandler::AddNoise(const float value, const float noiseScale)
{
    if (mDisableNoise)
    {
        return value;
    }
    else
    {
        return value + noiseScale * mNormalDistribution(mNoiseGenerator);
    }
}

float EgoHandler::GetAltitude(const float x, const float y)
{
    if (mGlobalPathHandler->globalPath.waypoints.size() > 0)
    {
        pcl::PointXYZ               searchPoint(x, y, 0.0);
        std::vector<int>            idxNKNSearch(1);
        std::vector<float>          nKNSquaredDistance(1);
        std::lock_guard<std::mutex> guard(mGlobalPathHandler->mutex);
        mGlobalPathHandler->globalPathKdtree.nearestKSearch(searchPoint, 1, idxNKNSearch, nKNSquaredDistance);
        return mGlobalPathHandler->globalPath.waypoints[idxNKNSearch.front()].pose.pose.position.z;
    }
    return 0.0f;
}
