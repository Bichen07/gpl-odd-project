#include <esminiLib.hpp>
#include <itri_msgs/Waypoint.h>
#include <std_msgs/Bool.h>
#include <std_msgs/String.h>
#include <std_msgs/Float32.h>
#include <actor_obstacle_config.h>
#include <actor_utils.h>
#include <json/json.h>
#include <math_frenet_coord.h>
#include <math_utils.h>
#include <motion_config_reader.h>
#include <motion_frenet_state.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <ros/console.h>
#include <stdexcept>
#include <unit_alks_cut_in_model.h>
#include <unit_model.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <utils_xosc.h>
#include <exception>
#include "math_col_vector_2d.h"
#include <simulation_msgs/CollisionProfile.h>

struct UserData
{
    math::Vector3d_t        egoPosition;
    double                  egoYaw;
    double                  dx0;
    double                  dy0;
    double                  ve0;
    double                  vo0;
    double                  delay_seconds;
    bool                    isCutInTriggered  = false;
    bool                    isCutInStoryStart = false;
    math::FrenetTransformer frenetTransformer;
};

static UserData userData;

static void parameterDeclarationCallback(void* user_arg)
{
    auto root = *(static_cast<Json::Value*>(user_arg));
    SE_SetParameterDouble("dx0_m", utils::GetDoubleJsonValue(root["dx0_m"]));
    SE_SetParameterDouble("dy0_m", utils::GetDoubleJsonValue(root["dy0_m"]));
    SE_SetParameterDouble("ve0_kph", utils::GetDoubleJsonValue(root["ve0_kph"]));
    SE_SetParameterDouble("vo0_kph", utils::GetDoubleJsonValue(root["vo0_kph"]));
    SE_SetParameterDouble("vy_mps", utils::GetDoubleJsonValue(root["vy_mps"]));
    SE_SetParameterDouble("EgoX", userData.egoPosition.x());
    SE_SetParameterDouble("EgoY", userData.egoPosition.y());
    SE_SetParameterDouble("EgoH", userData.egoYaw);

    std::ostringstream oss;
    oss << "PARAMETER DECLARATION CALLBACK >>>>>>>>>>>>> \n" << root;
    SE_LogMessage(oss.str().c_str());
}

static void storyBoardElementStateChangeCallback(const char* name, int type, int state)
{
    std::ostringstream oss;
    oss << "STORY BOARD CALLBACK >>>>>>>>>>>>> " << name << " " << type << " " << state;
    SE_LogMessage(oss.str().c_str());

    if (std::string(name) == "CutInAction" && type == 6 && state == 2)
    {
        userData.isCutInTriggered = true;
    }

    if (std::string(name) == "CutInStoryStartDummyAct" && type == 2 && state == 2)
    {
        userData.isCutInStoryStart = true;

        auto egoEsminiId   = SE_GetId(0);
        auto agentEsminiId = SE_GetId(1);
        if (agentEsminiId == -1 || egoEsminiId == -1)
        {
            return;
        }

        double egoWidth;
        SE_GetParameterDouble("EgoWidth", &egoWidth);
        double egoLength;
        SE_GetParameterDouble("EgoLength", &egoLength);
        double agentWidth;
        SE_GetParameterDouble("CutInVehicleWidth", &agentWidth);
        double agentLength;
        SE_GetParameterDouble("CutInVehicleLength", &agentLength);

        auto agentFrenetCoord =
            userData.frenetTransformer.ConvertToFrenetCoord(math::ColVector2d<double>{userData.egoPosition.x(), userData.egoPosition.y()});
        agentFrenetCoord.set_s(agentFrenetCoord.s() + userData.dx0 + egoLength / 2 + agentLength / 2 +
                               userData.delay_seconds * (userData.ve0 - userData.vo0));
        agentFrenetCoord.set_d(egoWidth / 2 + agentWidth / 2 + userData.dy0);
        auto agentCartesianCoord = userData.frenetTransformer.ConvertToCartesianCoord(agentFrenetCoord);
        auto agentWaypointIdx    = userData.frenetTransformer.ComputeWaypointIdx(agentFrenetCoord);
        auto agentWaypointXy     = userData.frenetTransformer.WaypointXy(agentWaypointIdx);
        auto agentNextWaypointXy = userData.frenetTransformer.WaypointXy(agentWaypointIdx + 1);
        auto direction           = agentNextWaypointXy - agentWaypointXy;
        auto agentH              = std::atan2(direction.y(), direction.x());

        SE_ReportObjectPosXYH(agentEsminiId, 0, agentCartesianCoord.x(), agentCartesianCoord.y(), agentH);
    }
}

namespace unit
{

    static int32_t currentScenarioCount = 0;
    static int32_t scenarioCountRecord  = -1;

    // public func.

    AlksCutInModel::~AlksCutInModel()
    {
        SE_Close();
    }

    AlksCutInModel::AlksCutInModel()
        : Model(),
          mMovingVehicles{},
          mMotionConfigs{},
          mEgoStableSpeedFilter{std::size_t{300ul}},
          mYawRateFilter{std::size_t{20ul}},
          mEgoPosXFilter{std::size_t{5ul}},
          mEgoPosYFilter{std::size_t{5ul}},
          mEgoYawFilter{std::size_t{5ul}},
          mIsEsminiBegin{false},
          mEgoStable{false},
          mIsScenarioEnd{false},
          mLastSimulationTime{0.0f}
    {
        userData.isCutInTriggered  = false;
        userData.isCutInStoryStart = false;
        mDoneConfigureMotions      = false;

        mEgoVehicleWaypointsSubscriber =
            mNodeHandle.subscribe("global_path", Model::DefaultQueueSize(), &AlksCutInModel::EgoVehicleGlobalPathCallback, this);

        mScenarioCountSubscriber =
            mNodeHandle.subscribe("scenario_monitor/scenario_count", Model::DefaultQueueSize(), &AlksCutInModel::ScenarioCountCallback, this);

        mScenarioStableSubscriber =
            mNodeHandle.subscribe("scenario_monitor/scenario_stable", Model::DefaultQueueSize(), &AlksCutInModel::ScenarioStableCallback, this);

        mEsminiBeginSubscriber = mNodeHandle.subscribe("esmini_begin", Model::DefaultQueueSize(), &AlksCutInModel::EsminiBeginCallback, this);

        mEgoSpeedCmdPublisher = mNodeHandle.advertise<itri_msgs::speed_cmd>("scenario_control_speed_cmd", 1);

        mEndScenarioPublisher  = mNodeHandle.advertise<std_msgs::Bool>("end_scenario", 1);
        mEndScenarioSubscriber = mNodeHandle.subscribe("end_scenario", Model::DefaultQueueSize(), &AlksCutInModel::EndScenarioCallback, this);

        mStartEsminiPublisher = mNodeHandle.advertise<std_msgs::String>("start_esmini", 1);

        mNodeHandle.getParam("simulation_adv/headless", mHeadless);

        mEsminiRecordFilepathSubscriber = mNodeHandle.subscribe("esmini_record_filepath", 1, &AlksCutInModel::EsminiRecordFilepathCallback, this);

        mCollisionProfilePublisher = mNodeHandle.advertise<simulation_msgs::CollisionProfile>("/simulation/collision_profile", 1);

        mCanStartObservationSamplingPublisher = mNodeHandle.advertise<std_msgs::Bool>("/can_start_observation_sampling", 1);
        mEsminiSimulationTimePublisher        = mNodeHandle.advertise<std_msgs::Float32>("/esmini_simulation_time", 1);
    }

    std::string AlksCutInModel::GetId() const
    {
        return std::string(AgentIdPrefix()) + std::string("model");
    }

    void AlksCutInModel::Configure(const ModelConfig& config)
    {
        Model::Configure<actor::Vehicle, actor::VehicleConfig>(config, std::string(AgentIdPrefix()), mMovingVehicles);
        this->ConfigureMotions();
    }

    void AlksCutInModel::Update()
    {
        UpdateEgo();
        UpdateAgent();
        CheckEndCondition();

        static bool isCanStartObservationSamplingMessageSent = false;
        if (!isCanStartObservationSamplingMessageSent && userData.isCutInStoryStart)
        {
            std_msgs::Bool msg;
            msg.data = true;
            mCanStartObservationSamplingPublisher.publish(msg);
        }

        if (mScenarioStable && mEgoStable && !mIsEsminiBegin && !mDoneConfigureMotions)
        {
            InitEsmini();
        }

        if (mIsEsminiBegin)
        {
            float             simulationTime = SE_GetSimulationTime();
            std_msgs::Float32 msg;
            msg.data = simulationTime;
            mEsminiSimulationTimePublisher.publish(msg);

            SE_Step();
        }
    }

    void AlksCutInModel::CheckEndCondition()
    {
        if (!mIsEsminiBegin || mIsScenarioEnd)
        {
            return;
        }

        auto  motionConfig{mMotionConfigs.cbegin()};
        float simulationTime = SE_GetSimulationTime();

        bool simulationFailed = (simulationTime < fmin(motionConfig->delay_seconds, 3) && userData.isCutInTriggered) ||
                                (simulationTime > 2 * motionConfig->delay_seconds && !userData.isCutInTriggered);

        if (simulationFailed)
        {
            SE_Close();
            mIsEsminiBegin = false;

            std_msgs::Bool msg;
            msg.data = false;
            mEndScenarioPublisher.publish(msg);
        }

        if (simulationTime > 30 || (simulationTime != 0.0f && simulationTime == mLastSimulationTime))
        {
            SE_Close();
            mIsEsminiBegin = false;

            std_msgs::Bool msg;
            msg.data = userData.isCutInTriggered;
            mEndScenarioPublisher.publish(msg);
        }

        for (int j = 0; j < SE_GetNumberOfObjects(); j++)
        {
            for (int k = 0; k < SE_GetObjectNumberOfCollisions(j); k++)
            {
                int index = SE_GetObjectCollision(j, k);
                if (index != -1)
                {
                    SE_Close();
                    mIsEsminiBegin = false;

                    std_msgs::Bool msg;
                    msg.data = true;
                    mEndScenarioPublisher.publish(msg);
                }
            }
        }

        mLastSimulationTime = simulationTime;
    }

    void AlksCutInModel::UpdateEgo()
    {
        auto motionConfig{mMotionConfigs.cbegin()};

        auto speedCmd = itri_msgs::speed_cmd{};
        if (!userData.isCutInTriggered)
        {
            speedCmd.header.frame_id = "scenario_control";
            speedCmd.kph             = motionConfig->ve0_kph;
        }
        mEgoSpeedCmdPublisher.publish(speedCmd);

        const auto&  egoVelocity = mEgoVehicleObserver->GetState().linearVelocity;
        const double egoSpeed    = egoVelocity.norm();
        const double egoSpeedKph = egoSpeed * 3.6;
        if (!mIsEsminiBegin && !mEgoStable)
        {
            mEgoStableSpeedFilter.Push(egoSpeedKph);
            const double egoSpeedKphAvg = mEgoStableSpeedFilter.ComputeAverage();
            const double epsilon        = 0.1;
            if (std::abs(egoSpeedKphAvg - motionConfig->ve0_kph) < epsilon)
            {
                mEgoStable = true;
            }
        }

        const auto& egoOrientation = mEgoVehicleObserver->GetState().orientation;
        const auto  egoYaw         = utils::ConvertToVector3d(utils::ConvertToGeometryMsgsQuaternion(egoOrientation)).z();
        const auto& egoPosition    = mEgoVehicleObserver->GetState().position;

        if (mIsEsminiBegin)
        {
            mEgoPosXFilter.Push(egoPosition.x());
            mEgoPosYFilter.Push(egoPosition.y());
            mEgoYawFilter.Push(egoYaw);
            userData.egoPosition.set_x(mEgoPosXFilter.ComputeAverage());
            userData.egoPosition.set_y(mEgoPosYFilter.ComputeAverage());
            userData.egoYaw = mEgoYawFilter.ComputeAverage();
        }
        else
        {
            userData.egoPosition.set_x(egoPosition.x());
            userData.egoPosition.set_y(egoPosition.y());
            userData.egoYaw = egoYaw;
        }

        auto egoEsminiId = SE_GetId(0);
        if (egoEsminiId == -1)
        {
            return;
        }
        SE_ReportObjectPos(egoEsminiId,
                           0.0f,
                           userData.egoPosition.x(),
                           userData.egoPosition.y(),
                           std::nanf(""),
                           userData.egoYaw,
                           std::nanf(""),
                           std::nanf(""));
        SE_ReportObjectSpeed(egoEsminiId, egoSpeed);
    }

    void AlksCutInModel::UpdateAgent()
    {
        mVisualizer->AppendVehicles(mMovingVehicles);
        Model::AppendVelocityMarkers(mMovingVehicles);

        auto agentEsminiId = SE_GetId(1);
        if (agentEsminiId == -1)
        {
            return;
        }

        const auto&     egoPosition    = mEgoVehicleObserver->GetState().position;
        const auto&     egoOrientation = mEgoVehicleObserver->GetState().orientation;
        Eigen::Matrix3d rotationMatrix = egoOrientation.toRotationMatrix();

        SE_ScenarioObjectState agentEsminiState;
        SE_GetObjectState(agentEsminiId, &agentEsminiState);

        auto                   movingVehicle{mMovingVehicles.cbegin()};
        const auto&            agent         = (*movingVehicle);
        const auto&            agentPosition = agent->GetState().position;
        const math::Vector3d_t updatedPosition3d(agentEsminiState.x, agentEsminiState.y, egoPosition.z());

        auto updatedState = motion::ComputeUpdatedState(mTimeStep, agent->GetState(), updatedPosition3d);
        mYawRateFilter.Push(updatedState.angularVelocity.z());
        const math::Vector3d_t movingAverageAngularVelocity(math::real_t{0.0}, math::real_t{0.0}, mYawRateFilter.ComputeAverage());
        updatedState.angularVelocity = movingAverageAngularVelocity;

        agent->UpdateState(updatedState);
        agent->UpdateTransform(updatedState);
        const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(agent->GetState().linearVelocity, agent->GetTransform2d());
        const auto updatedFrenetState    = motion::FrenetState(agent->GetFrenetState().idx, agent->GetFrenetState().position, updatedFrenetVelocity);
        agent->UpdateFrenetState(updatedFrenetState);
    }

    void AlksCutInModel::InitEsmini()
    {
        auto motionConfig{mMotionConfigs.cbegin()};

        static Json::Value jsonData;
        jsonData["ve0_kph"] = motionConfig->ve0_kph;
        jsonData["vo0_kph"] = motionConfig->vo0_kph;
        jsonData["dx0_m"]   = motionConfig->dx0_m;
        jsonData["dy0_m"]   = motionConfig->dy0_m;
        jsonData["vy_mps"]  = motionConfig->vy_mps;
        SE_RegisterParameterDeclarationCallback(parameterDeclarationCallback, &jsonData);

        userData.delay_seconds = motionConfig->delay_seconds;
        userData.dx0           = motionConfig->dx0_m;
        userData.dy0           = motionConfig->dy0_m;
        userData.ve0           = motionConfig->ve0_kph / 3.6;
        userData.vo0           = motionConfig->vo0_kph / 3.6;

        std::string recordFilepath = "/tmp";
        if (!mEsminiRecordFilepath.empty())
        {
            recordFilepath = mEsminiRecordFilepath;
        }

        std::string templateFilepath = utils::GetStringJsonValue(mConfigJsonValue["openscenario_template"]);

        SE_SetDatFilePath(recordFilepath.c_str());
        SE_Init(templateFilepath.c_str(), 0, !mHeadless, 0, 1);
        SE_CollisionDetection(true);

        SE_RegisterStoryBoardElementStateChangeCallback(storyBoardElementStateChangeCallback);

        mIsEsminiBegin        = true;
        mDoneConfigureMotions = true;
        mLastSimulationTime   = 0.0f;

        std_msgs::Bool msg;
        msg.data = true;
        mStartEsminiPublisher.publish(msg);
    }

    void AlksCutInModel::AccessAgentAttributes(std::vector<scenario::AgentAttribute>* agentAttributes)
    {
        Model::AccessAgentAttributes<actor::Vehicle>(agentAttributes, mMovingVehicles);
    }

    void AlksCutInModel::RunCarlaUpdate(std::vector<carla::ActorUpdateData>* actorUpdateDatas)
    {
        this->Update();
        Model::RunCarlaUpdate(actorUpdateDatas, mMovingVehicles);
    }

    // protected func.

    // private func.

    void AlksCutInModel::ConfigureMotions()
    {
        mAgentInitialVelocity.setZero();
        Model::ConfigureMotions(mMovingVehicles);
        std::function<decltype(motion::ParseAlksCutInConfig)> parseFunc{motion::ParseAlksCutInConfig};
        motion::ParseMotionConfigs(mConfigJsonValue["motion_configs"], parseFunc, mMotionConfigs);
        if (mMovingVehicles.size() != mMotionConfigs.size())
        {
            ROS_ERROR_STREAM("diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n'
                                                                                << "mMovingVehicles: " << mMovingVehicles.size() << '\n'
                                                                                << "mMotionConfigs" << mMotionConfigs.size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        motion::WaypointSmoother   waypointSmoother;
        motion::WaypointTranslator waypointTranslator;

        auto motionConfig{mMotionConfigs.cbegin()};

        const map::WaypointId beginWaypointId{motionConfig->begin_lane_id, motionConfig->begin_point_id};
        const map::WaypointId endWaypointId{motionConfig->end_lane_id, motionConfig->end_point_id};

        std::vector<math::Vector3d_t> refWaypoints;
        Model::ExecuteDijkstraPlanning(beginWaypointId, endWaypointId, refWaypoints);
        refWaypoints                      = waypointTranslator.Compute(refWaypoints, math::FrenetCoord(0.0, 0.0), int32_t{0});
        const auto movingVehicleWaypoints = waypointSmoother.Compute(refWaypoints);

        mRefWaypoint3ds = refWaypoints;
        mRefWaypoint2ds.resize(mRefWaypoint3ds.size());
        std::transform(mRefWaypoint3ds.begin(),
                       mRefWaypoint3ds.end(),
                       mRefWaypoint2ds.begin(),
                       [](const math::Vector3d_t& waypoint3d) { return math::Vector2d_t(waypoint3d.x(), waypoint3d.y()); });
        userData.frenetTransformer.Configure(mRefWaypoint2ds, utils::FileLineNumPairInstance());
    }

    void AlksCutInModel::ScenarioCountCallback(const std_msgs::Int32 msg)
    {
        currentScenarioCount = msg.data;
    }

    void AlksCutInModel::ScenarioStableCallback(const std_msgs::Bool msg)
    {
        mScenarioStable = msg.data;
    }

    void AlksCutInModel::EsminiBeginCallback(const std_msgs::Bool msg)
    {
        mIsEsminiBegin = msg.data;
    }

    void AlksCutInModel::EgoVehicleGlobalPathCallback(const itri_msgs::Path& msg)
    {
        Model::EgoVehicleGlobalPathCallback(msg);

        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
        for (int i = 0; i < msg.waypoints.size(); i++)
        {
            const auto& pathWaypoint = msg.waypoints[i];
            const auto& position     = pathWaypoint.pose.pose.position;

            pcl::PointXYZ pclPoint;
            pclPoint.x = position.x;
            pclPoint.y = position.y;
            pclPoint.z = position.z;

            cloud->push_back(pclPoint);
            mKdtreeWaypointMap[i] = pathWaypoint;
        }
        mGlobalPathKdtree.setInputCloud(cloud);
        mEgoVehicleGlobalPathSubscriber.shutdown();
    }

    void AlksCutInModel::EsminiRecordFilepathCallback(const std_msgs::String msg)
    {
        mEsminiRecordFilepath = msg.data;
    }

    void AlksCutInModel::EndScenarioCallback(const std_msgs::Bool msg)
    {
        mIsScenarioEnd = true;
        mIsEsminiBegin = false;
        SE_Close();
    }

}  // namespace unit
