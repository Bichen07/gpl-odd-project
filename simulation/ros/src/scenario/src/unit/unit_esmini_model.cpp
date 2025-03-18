#include "Collision/Shapes/b2PolygonShape.h"
#include "Collision/b2Collision.h"
#include "Common/b2Math.h"
#include "Dynamics/Contacts/b2Contact.h"
#include "Dynamics/b2Body.h"
#include "Dynamics/b2World.h"
#include "actor_agent.h"
#include "actor_vehicle.h"
#include "actor_vehicle_config.h"
#include "geometry_msgs/Pose.h"
#include "geometry_msgs/Vector3.h"
#include "geometry_vector_3d.h"
#include "itri_msgs/CarState.h"
#include "math_col_vector_2d.h"
#include "scenario/AgentStates.h"
#include "simulation_msgs/CollisionState.h"
#include <actor_obstacle_config.h>
#include <actor_utils.h>
#include <algorithm>
#include <cmath>
#include <esminiLib.hpp>
#include <exception>
#include <itri_msgs/Waypoint.h>
#include <json/json.h>
#include <math_frenet_coord.h>
#include <math_utils.h>
#include <motion_config_reader.h>
#include <motion_frenet_state.h>
#include <motion_utils.h>
#include <motion_waypoint_smoother.h>
#include <motion_waypoint_translator.h>
#include <ros/console.h>
#include <rss_msgs/ProperResponse.h>
#include <simulation_msgs/CollisionProfile.h>
#include <simulation_msgs/CollisionState.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Float32.h>
#include <std_msgs/String.h>
#include <stdexcept>
#include <unordered_set>
#include <unit_esmini_model.h>
#include <unit_model.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <utils_xosc.h>

struct UserData
{
    math::Vector3d_t                      egoPosition;
    double                                egoYaw;
    bool                                  canReleaseEgoIniitalSpeed        = false;
    bool                                  isEgoStuck                       = false;
    std::string                           egoInitialSpeedReleasedCondition = "";
    std::unordered_map<std::string, bool> scenarioValidConditions;
    std::unordered_map<std::string, bool> startSamplingConditions;
    ros::Publisher                       *eventPublisherPtr = nullptr;
    std::unordered_set<std::string>       runnedEvents;
    std::unordered_set<std::string>       completedEvents;
};

static UserData userData;

static auto normalize_radians = [](double radians) -> double { return std::fmod(radians + M_PI, 2 * M_PI) - M_PI; };

static void resetUserData()
{
    userData.egoPosition.setZero();
    userData.egoYaw                           = 0;
    userData.canReleaseEgoIniitalSpeed        = false;
    userData.isEgoStuck                       = false;
    userData.egoInitialSpeedReleasedCondition = "";
    userData.scenarioValidConditions.clear();
    userData.startSamplingConditions.clear();
    userData.runnedEvents.clear();
    userData.completedEvents.clear();
}

// static void fillInAgentState(SE_ScenarioObjectState                                       esminiState,
//                              const std::unordered_map<std::string, scenario::AgentState> &lastAgentStates,
//                              scenario::AgentState                                        &outputAgentState)
// {
//     std::string name        = SE_GetObjectName(esminiState.id);
//     outputAgentState.name   = name;
//     outputAgentState.x      = esminiState.x;
//     outputAgentState.y      = esminiState.y;
//     outputAgentState.z      = esminiState.z;
//     outputAgentState.yaw    = esminiState.h;
//     outputAgentState.speed  = esminiState.speed;
//     outputAgentState.second = SE_GetSimulationTimeDouble();
//
//     if (lastAgentStates.find(name) != lastAgentStates.end())
//     {
//         double deltaSecond            = outputAgentState.second - lastAgentStates.at(name).second;
//         outputAgentState.yawRate      = (outputAgentState.yaw - lastAgentStates.at(name).yaw) / deltaSecond;
//         outputAgentState.acceleration = (outputAgentState.speed - lastAgentStates.at(name).speed) / deltaSecond;
//     }
//     else
//     {
//         outputAgentState.yawRate      = std::numeric_limits<double>::quiet_NaN();
//         outputAgentState.acceleration = std::numeric_limits<double>::quiet_NaN();
//     }
//
//     // geometry_msgs::Pose pose;
//     // pose.position.x  = esminiState.x;
//     // pose.position.y  = esminiState.y;
//     // pose.position.z  = esminiState.z;
//     // auto eulerAngles = geometry_msgs::Vector3();
//     // eulerAngles.z = esminiState.h;
//     // pose.orientation = utils::ConvertToGeometryMsgsQuaternion(eulerAngles);
// }

static void storyBoardElementStateChangeCallback(const char *name, int type, int state)
{
    std::ostringstream oss;
    oss << "STORY BOARD CALLBACK >>>>>>>>>>>>> " << name << " " << type << " " << state;
    SE_LogMessage(oss.str().c_str());
    oss.str("");
    oss.clear();

    bool startSamplingConditionsMeet = true;
    for (const auto &pair : userData.startSamplingConditions)
    {
        if (!pair.second)
        {
            startSamplingConditionsMeet = false;
            break;
        }
    }
    if (startSamplingConditionsMeet && type == 5 && userData.eventPublisherPtr != nullptr && (state == 2 || state == 3))
    {
        oss << name;

        if (state == 2 && userData.runnedEvents.count(oss.str()) == 0)
        {
            std_msgs::String msg;
            msg.data = "start" + oss.str();
            userData.eventPublisherPtr->publish(msg);

            userData.runnedEvents.insert(oss.str());
        }

        if (state == 3 && userData.completedEvents.count(oss.str()) == 0)
        {
            std_msgs::String msg;
            msg.data = "end" + oss.str();
            userData.eventPublisherPtr->publish(msg);

            userData.completedEvents.insert(oss.str());
        }
        oss.str("");
        oss.clear();
    }
}

static void esminiConditionCallback(const char *name, double timestamp)
{
    // std::ostringstream oss;
    // oss << "CONDITION CALLBACK >>>>>>>>>>>>> " << name << " " << timestamp;
    // SE_LogMessage(oss.str().c_str());

    if (std::string(name) == userData.egoInitialSpeedReleasedCondition)
    {
        std::ostringstream oss;
        oss << "CONDITION CALLBACK >>>>>>>>>>>>> " << name << " " << timestamp;
        SE_LogMessage(oss.str().c_str());
        ROS_INFO_STREAM("[unit_esmini_model] Set userdata.canReleaseEgoIniitalSpeed to true");
        userData.canReleaseEgoIniitalSpeed = true;
    }

    if (std::string(name) == "EgoStuckCondition")
    {
        std::ostringstream oss;
        oss << "CONDITION CALLBACK >>>>>>>>>>>>> " << name << " " << timestamp;
        SE_LogMessage(oss.str().c_str());
        ROS_INFO_STREAM("[unit_esmini_model] ego stuck detected");
        userData.isEgoStuck = true;
    }

    for (const auto pair : userData.scenarioValidConditions)
    {
        const auto &conditionName = pair.first;
        if (std::string(name) == conditionName)
        {
            std::ostringstream oss;
            oss << "CONDITION CALLBACK >>>>>>>>>>>>> " << name << " " << timestamp;
            SE_LogMessage(oss.str().c_str());
            ROS_ERROR_STREAM("[unit_esmini_model] esmini detect valid condition " << conditionName);
            userData.scenarioValidConditions[conditionName] = true;
        }
    }

    for (const auto pair : userData.startSamplingConditions)
    {
        const auto &conditionName = pair.first;
        if (std::string(name) == conditionName)
        {
            std::ostringstream oss;
            oss << "CONDITION CALLBACK >>>>>>>>>>>>> " << name << " " << timestamp;
            SE_LogMessage(oss.str().c_str());
            ROS_ERROR_STREAM("[unit_esmini_model] esmini detect start sampling condition " << conditionName);
            userData.startSamplingConditions[conditionName] = true;
        }
    }
}

static b2PolygonShape esminiBoundingBoxToB2PolygonShape(const SE_ScenarioObjectState &state)
{
    b2Vec2 center(state.centerOffsetX, state.centerOffsetY);

    std::vector<b2Vec2> vertices;
    vertices.emplace_back(center.x - state.length / 2.0, center.y + state.width / 2.0);
    vertices.emplace_back(center.x - state.length / 2.0, center.y - state.width / 2.0);
    vertices.emplace_back(center.x + state.length / 2.0, center.y - state.width / 2.0);
    vertices.emplace_back(center.x + state.length / 2.0, center.y + state.width / 2.0);

    b2PolygonShape polygon;
    polygon.Set(vertices.data(), vertices.size());

    return polygon;
}

static Eigen::Quaterniond euler_to_quaternion(double yaw, double pitch, double roll)
{
    Eigen::AngleAxisd  yaw_angle(yaw, Eigen::Vector3d::UnitZ());
    Eigen::AngleAxisd  pitch_angle(pitch, Eigen::Vector3d::UnitY());
    Eigen::AngleAxisd  roll_angle(roll, Eigen::Vector3d::UnitX());
    Eigen::Quaterniond quaternion = yaw_angle * pitch_angle * roll_angle;
    return quaternion;
}

namespace unit
{
    // public func.

    EsminiModel::~EsminiModel()
    {
        EndEsmini();
    }

    EsminiModel::EsminiModel()
        : Model(),
          mPedestrians{},
          mMovingVehicles{},
          mMotionConfig{},
          mEgoSpeedStableFilter{std::size_t{1000ul}},
          mEgoSpeedFilter{std::size_t{5ul}},
          mEgoPosXFilter{std::size_t{5ul}},
          mEgoPosYFilter{std::size_t{5ul}},
          mEgoYawFilter{std::size_t{5ul}},
          mIsEsminiBegin{false},
          mEgoInitialSpeedStable{false},
          mIsScenarioEnd{false},
          mIsReferenceModelTurn{false},
          mScenarioStable{false},
          mPublishedCanStartObservationSampling{false}
    {
        resetUserData();

        mDoneConfigureMotions = false;
        mNodeHandle.getParam("simulation_adv/headless", mHeadless);
        mNodeHandle.getParam("/single_parameterized_scenario_search/sim_with_external", mSimWithExternalEgo);

        mScenarioStableSubscriber =
            mNodeHandle.subscribe("scenario_monitor/scenario_stable", Model::DefaultQueueSize(), &EsminiModel::ScenarioStableCallback, this);
        mTtcSubscriber = mNodeHandle.subscribe("scenario_monitor/ttc", Model::DefaultQueueSize(), &EsminiModel::TtcCallback, this);

        mEsminiRecordFilepathSubscriber = mNodeHandle.subscribe("esmini_record_filepath", 1, &EsminiModel::EsminiRecordFilepathCallback, this);
        mProperResponseSubscriber       = mNodeHandle.subscribe("/rss/proper_response", 1, &EsminiModel::ProperResponseCallback, this);
        mIsReferenceModelTurnSubscriber = mNodeHandle.subscribe("is_reference_model_turn", 1, &EsminiModel::IsReferenceModelTurnCallback, this);

        mEsminiEventPublisher                 = mNodeHandle.advertise<std_msgs::String>("/esmini_event", 1);
        userData.eventPublisherPtr            = &mEsminiEventPublisher;
        mEgoSpeedCmdPublisher                 = mNodeHandle.advertise<itri_msgs::speed_cmd>("scenario_control_speed_cmd", 1);
        mEndScenarioPublisher                 = mNodeHandle.advertise<std_msgs::Bool>("end_scenario", 1);
        mStartEsminiPublisher                 = mNodeHandle.advertise<std_msgs::Bool>("start_esmini", 1);
        mCollisionProfilePublisher            = mNodeHandle.advertise<simulation_msgs::CollisionProfile>("/simulation/collision_profile", 1);
        mCanStartObservationSamplingPublisher = mNodeHandle.advertise<std_msgs::Bool>("/can_start_observation_sampling", 1);
        mEsminiSimulationTimePublisher        = mNodeHandle.advertise<std_msgs::Float32>("/esmini_simulation_time", 1);
        mEsminiEgoStuckPublisher              = mNodeHandle.advertise<std_msgs::Bool>("/esmini_ego_stuck", 1);

        mAgentStatesPublisher = mNodeHandle.advertise<scenario::AgentStates>("/esmini_simulator/agent_states", 1);

        mCarStatePublisher = mNodeHandle.advertise<itri_msgs::CarState>("/car_state", 1);

        std_msgs::Bool msg;
        msg.data = false;
        mStartEsminiPublisher.publish(msg);
        mCanStartObservationSamplingPublisher.publish(msg);
    }

    std::string EsminiModel::GetId() const
    {
        return std::string(AgentIdPrefix()) + std::string("model");
    }

    void EsminiModel::Update()
    {
        mAgentStates.clear();

        UpdateEgo();
        UpdateAgents();

        scenario::AgentStates msg;
        for (const auto &pair : mAgentStates)
        {
            msg.agents.push_back(pair.second);
        }

        mAgentStatesPublisher.publish(msg);

        CheckEndCondition();

        // ROS_ERROR_STREAM("esmini update");
        // if (mScenarioStable && mDoneConfigureMotions && !mIsEsminiBegin && !mIsScenarioEnd && SE_GetSimulationTimeDouble() <= 0.0 &&
        //     !mEsminiRecordFilepath.empty())
        // {
        //     if (mSimWithExternalEgo || mEgoInitialSpeedStable)
        //     {
        //         InitEsmini();
        //     }
        // }

        // if (mScenarioStable && mSimWithExternalEgo && mDoneConfigureMotions && !mIsEsminiBegin && !mIsScenarioEnd &&
        //     SE_GetSimulationTimeDouble() <= 0.0)
        // {
        //     InitEsmini();
        // }
        if (mScenarioStable && !mIsEsminiBegin && mDoneConfigureMotions && mEgoInitialSpeedStable && !mIsScenarioEnd &&
            SE_GetSimulationTimeDouble() <= 0.0)
        {
            InitEsmini();
        }

        bool initialSpeedCondition =
            mDoneConfigureMotions && (userData.egoInitialSpeedReleasedCondition.empty() || userData.canReleaseEgoIniitalSpeed);
        bool startSamplingConditionsMeet = true;
        for (const auto &pair : userData.startSamplingConditions)
        {
            if (!pair.second)
            {
                startSamplingConditionsMeet = false;
                break;
            }
        }
        if (startSamplingConditionsMeet && !mPublishedCanStartObservationSampling && mIsEsminiBegin && initialSpeedCondition)
        {
            std_msgs::Bool msg;
            msg.data = true;
            mCanStartObservationSamplingPublisher.publish(msg);
            mPublishedCanStartObservationSampling = true;
            ROS_ERROR_STREAM("published can start observation sampling");
        }

        if (mIsEsminiBegin && !mIsScenarioEnd)
        {
            float             simulationTime = SE_GetSimulationTime();
            std_msgs::Float32 msg;
            msg.data = simulationTime;
            mEsminiSimulationTimePublisher.publish(msg);

            SE_Step();
        }

        mLastAgentStates = mAgentStates;
    }

    void EsminiModel::EndEsmini()
    {
        mIsScenarioEnd = true;
        mIsEsminiBegin = false;
        SE_Close();

        std_msgs::Bool msg;
        msg.data = false;
        mStartEsminiPublisher.publish(msg);
        mCanStartObservationSamplingPublisher.publish(msg);

        bool isValid = true;
        for (const auto &pair : userData.scenarioValidConditions)
        {
            ROS_ERROR_STREAM("[unit_esmini_model] " << pair.first << " isValid: " << isValid);
            if (!pair.second)
            {
                isValid = false;
                break;
            }
        }

        msg.data = isValid;
        ROS_ERROR_STREAM("[unit_esmini_model] end esmini, valid: " << int(msg.data));
        mEndScenarioPublisher.publish(msg);
    }

    void EsminiModel::CheckEndCondition()
    {
        if (SE_GetSimulationTimeDouble() <= 0.0 || mIsScenarioEnd)
        {
            return;
        }

        if (SE_GetQuitFlag() == 1)
        {
            EndEsmini();
            return;
        }

        auto egoEsminiId = SE_GetIdByName("Ego");
        for (int k = 0; k < SE_GetObjectNumberOfCollisions(egoEsminiId); k++)
        {
            int index = SE_GetObjectCollision(egoEsminiId, k);
            if (index != -1)
            {
                auto agentEsminiId = SE_GetId(index);
                if (egoEsminiId == -1 || agentEsminiId == -1)
                {
                    continue;
                }
                SE_ScenarioObjectState agentEsminiState;
                SE_GetObjectState(agentEsminiId, &agentEsminiState);
                SE_ScenarioObjectState egoEsminiState;
                SE_GetObjectState(egoEsminiId, &egoEsminiState);

                scenario::AgentState agentState;
                fillInAgentState(egoEsminiState, agentState);
                mAgentStates["Ego"] = agentState;

                auto updateAgentState = [&](const SE_ScenarioObjectState &agentEsminiState)
                {
                    bool       foundRecording  = false;
                    const auto esminiAgentName = SE_GetObjectName(agentEsminiState.id);
                    for (const auto &agentNameJson : mConfigJsonValue["state_recording_agents"])
                    {
                        const auto agentName = utils::GetStringJsonValue(agentNameJson);
                        if (agentName == esminiAgentName)
                        {
                            foundRecording = true;
                            break;
                        }
                    }
                    if (foundRecording)
                    {
                        scenario::AgentState agentState;
                        fillInAgentState(agentEsminiState, agentState);
                        mAgentStates[esminiAgentName] = agentState;
                    }
                };

                for (int i = 0; i < mMotionConfig.vehicles.size(); i++)
                {
                    const auto &agent = mMotionConfig.vehicles[i];

                    auto agentEsminiId = SE_GetIdByName(agent.name.c_str());
                    if (agentEsminiId == -1)
                    {
                        continue;
                    }

                    SE_ScenarioObjectState agentEsminiState;
                    SE_GetObjectState(agentEsminiId, &agentEsminiState);

                    auto movingVehicle{mMovingVehicles[i]};
                    updateAgentState(agentEsminiState);
                }

                scenario::AgentStates msg;
                for (const auto &pair : mAgentStates)
                {
                    msg.agents.push_back(pair.second);
                }
                msg.id = std::string("collision");
                mAgentStatesPublisher.publish(msg);

                b2World world({0, 0});

                b2BodyDef egoBodyDef;
                egoBodyDef.type = b2_dynamicBody;
                egoBodyDef.position.Set(egoEsminiState.x, egoEsminiState.y);
                egoBodyDef.angle = egoEsminiState.h;

                b2BodyDef agentBodyDef;
                agentBodyDef.type = b2_dynamicBody;
                agentBodyDef.position.Set(agentEsminiState.x, agentEsminiState.y);
                agentBodyDef.angle = agentEsminiState.h;

                const auto egoBody   = world.CreateBody(&egoBodyDef);
                const auto agentBody = world.CreateBody(&agentBodyDef);

                const auto agentPolygon = esminiBoundingBoxToB2PolygonShape(agentEsminiState);
                const auto egoPolygon   = esminiBoundingBoxToB2PolygonShape(egoEsminiState);

                egoBody->CreateFixture(&egoPolygon, 0.0f);
                agentBody->CreateFixture(&agentPolygon, 0.0f);

                world.Step(0.1, 6, 4);
                const auto roundDecimals = [](float value, int decimal) { return std::round(value * 10 * decimal) / (10 * decimal); };
                const auto getPointSide  = [&](b2Vec2 localPoint)
                {
                    int    precision = 1;
                    b2Vec2 center(egoEsminiState.centerOffsetX, egoEsminiState.centerOffsetY);
                    if (roundDecimals(localPoint.x, precision) == roundDecimals(center.x + egoEsminiState.length / 2, precision))
                    {
                        return simulation_msgs::CollisionState::COLLISION_SIDE_FRONT;
                    }
                    if (roundDecimals(localPoint.x, precision) == -roundDecimals(center.x - egoEsminiState.length / 2, precision))
                    {
                        return simulation_msgs::CollisionState::COLLISION_SIDE_REAR;
                    }
                    if (roundDecimals(localPoint.y, precision) == roundDecimals(center.y + egoEsminiState.width / 2, precision))
                    {
                        return simulation_msgs::CollisionState::COLLISION_SIDE_LEFT;
                    }
                    if (roundDecimals(localPoint.y, precision) == -roundDecimals(center.y - egoEsminiState.width / 2, precision))
                    {
                        return simulation_msgs::CollisionState::COLLISION_SIDE_RIGHT;
                    }
                    return simulation_msgs::CollisionState::COLLISION_SIDE_UNKNOWN;
                };

                simulation_msgs::CollisionProfile collisionProfile;
                collisionProfile.ego.d_vel = egoEsminiState.speed;
                ROS_INFO_STREAM("ego collision speed: " << egoEsminiState.speed);
                collisionProfile.header.frame_id    = "esmini_collision/" + std::string(SE_GetObjectName(agentEsminiState.id));
                collisionProfile.ego.collision_side = simulation_msgs::CollisionState::COLLISION_SIDE_UNKNOWN;
                for (b2Contact *contact = world.GetContactList(); contact; contact = contact->GetNext())
                {
                    b2WorldManifold worldManifold;
                    contact->GetWorldManifold(&worldManifold);

                    const auto contactPointCount = contact->GetManifold()->pointCount;
                    ROS_INFO_STREAM("Contact point count: " << contactPointCount);

                    b2Vec2 localPointA                  = egoBody->GetLocalPoint(worldManifold.points[0]);
                    auto   localPointASide              = getPointSide(localPointA);
                    collisionProfile.ego.collision_side = localPointASide;

                    break;
                }

                mCollisionProfilePublisher.publish(collisionProfile);

                EndEsmini();
            }
        }
    }

    void EsminiModel::UpdateEgo()
    {
        if (userData.isEgoStuck)
        {
            std_msgs::Bool msg;
            msg.data = true;
            mEsminiEgoStuckPublisher.publish(msg);
        }

        if (mSimWithExternalEgo)
        {
            auto egoEsminiId = SE_GetIdByName("Ego");
            if (egoEsminiId == -1)
            {
                return;
            }
            SE_ScenarioObjectState esminiState;
            SE_GetObjectState(egoEsminiId, &esminiState);

            itri_msgs::CarState carState{};
            carState.pose.pose.position.x    = esminiState.x;
            carState.pose.pose.position.y    = esminiState.y;
            carState.pose.pose.position.z    = esminiState.z;
            carState.pose.pose.orientation.z = esminiState.h;

            carState.is_stable = true;

            mCarStatePublisher.publish(carState);
        }
        else
        {
            const auto &motionConfig = mMotionConfig;

            const auto &egoVelocity        = mEgoVehicleObserver->GetState().linearVelocity;
            const auto &egoAngularVelocity = mEgoVehicleObserver->GetState().angularVelocity;
            double      egoSpeed           = egoVelocity.norm();
            const auto &egoOrientation     = mEgoVehicleObserver->GetState().orientation;
            auto        egoYaw             = utils::ConvertToVector3d(utils::ConvertToGeometryMsgsQuaternion(egoOrientation)).z();

            // Normalize yaw to be in the range [0, 2π]
            if (egoYaw < 0)
            {
                egoYaw += 2 * M_PI;
            }
            // ROS_ERROR_STREAM("ego yaw: " << egoYaw << " " << egoYaw * 180 / 3.14);

            const auto &egoPosition = mEgoVehicleObserver->GetState().position;

            if (mYawRateFilters["Ego"].GetBufferSize() == 0)
            {
                mYawRateFilters["Ego"].Configure(mYawRateFilterWindowSize);
            }
            mYawRateFilters["Ego"].Push(egoAngularVelocity.z());

            auto speedCmd = itri_msgs::speed_cmd{};

            if (mIsReferenceModelTurn ||
                (mDoneConfigureMotions && !userData.egoInitialSpeedReleasedCondition.empty() && !userData.canReleaseEgoIniitalSpeed))
            {
                speedCmd.header.frame_id = "scenario_control";
                speedCmd.kph             = mEgoExternalSpeedKph;
            }

            if (!mEgoInitialSpeedStable && mDoneConfigureMotions && !userData.egoInitialSpeedReleasedCondition.empty() &&
                !userData.canReleaseEgoIniitalSpeed)
            {
                const double egoSpeed    = egoVelocity.norm();
                const double egoSpeedKph = egoSpeed * 3.6;
                mEgoSpeedStableFilter.Push(egoSpeedKph);
                const double egoSpeedKphAvg = mEgoSpeedStableFilter.ComputeAverage();
                const double epsilon        = 0.1;
                if (std::abs(egoSpeedKphAvg - mEgoExternalSpeedKph) < epsilon)
                {
                    mEgoInitialSpeedStable = true;
                }
            }

            if (!mEgoInitialSpeedStable && mDoneConfigureMotions && userData.egoInitialSpeedReleasedCondition.empty())
            {
                mEgoInitialSpeedStable = true;
            }

            // ROS_WARN_STREAM("[unit_esmini_model] ego external speed kph: " << speedCmd.kph);
            mEgoSpeedCmdPublisher.publish(speedCmd);

            if (mIsEsminiBegin)
            {
                mEgoPosXFilter.Push(egoPosition.x());
                mEgoPosYFilter.Push(egoPosition.y());
                mEgoYawFilter.Push(egoYaw);
                mEgoSpeedFilter.Push(egoSpeed);
                userData.egoPosition.set_x(mEgoPosXFilter.ComputeAverage());
                userData.egoPosition.set_y(mEgoPosYFilter.ComputeAverage());
                userData.egoYaw = mEgoYawFilter.ComputeAverage();
                egoSpeed        = mEgoSpeedFilter.ComputeAverage();
                if (egoSpeed < 0.3)
                {
                    egoSpeed = 0.0;
                }
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

        auto egoEsminiId = SE_GetId(0);
        if (egoEsminiId == -1)
        {
            return;
        }
        SE_ScenarioObjectState esminiState;
        SE_GetObjectState(egoEsminiId, &esminiState);
        scenario::AgentState agentState;
        fillInAgentState(esminiState, agentState);
        mAgentStates["Ego"] = agentState;
    }

    void EsminiModel::UpdateReferenceModelCarState()
    {
        auto egoEsminiId = SE_GetIdByName("Ego");
        if (egoEsminiId == -1)
        {
            return;
        }
        SE_ScenarioObjectState esminiState;
        SE_GetObjectState(egoEsminiId, &esminiState);

        itri_msgs::CarState carState{};
        carState.pose.pose.position.x = esminiState.x;
        carState.pose.pose.position.y = esminiState.y;
        carState.pose.pose.position.z = esminiState.z;

        carState.is_stable       = true;
        carState.header.frame_id = "reference_model";

        mCarStatePublisher.publish(carState);

        SE_ReportObjectAcc(egoEsminiId, 0, 3.5, 0, 0);
    }

    void EsminiModel::UpdateAgents()
    {
        static std::unordered_set<std::string> visited;

        mVisualizer->AppendVehicles(mMovingVehicles);
        Model::AppendVelocityMarkers(mMovingVehicles);

        mVisualizer->AppendPedestrians(mPedestrians);
        Model::AppendVelocityMarkers(mPedestrians);

        auto updateAgent = [&](const SE_ScenarioObjectState &agentEsminiState, actor::Agent &agent)
        {
            const auto      &agentPosition = agent.GetState().position;
            math::Vector3d_t updatedPosition3d(agentEsminiState.x + 0.0001, agentEsminiState.y, 0);

            auto updatedState = motion::ComputeUpdatedState(mTimeStep, agent.GetState(), updatedPosition3d);

            const double newSpeed       = std::max(agentEsminiState.speed - 4.0 * mTimeStep, 0.0);
            const bool   shouldTakeOver = agentEsminiState.speed > 0.1 && mTtc < 2.0;
            if (shouldTakeOver)
            {
                // ROS_ERROR_STREAM(mTimeStep);
                // ROS_ERROR_STREAM(newSpeed);
                updatedState.position.set_x(updatedState.position.x() + mTimeStep * newSpeed * std::cos(agentEsminiState.h));
                updatedState.position.set_y(updatedState.position.y() + mTimeStep * newSpeed * std::sin(agentEsminiState.h));
            }

            if (visited.find(agent.GetAttribute().id) == visited.end() && motion::ConvertToKph(abs(updatedState.linearVelocity.squaredNorm())) < 300)
            {
                updatedState.linearVelocity.setZero();
                updatedState.angularVelocity.setZero();
                visited.insert(agent.GetAttribute().id);
            }

            const auto agentName = SE_GetObjectName(agentEsminiState.id);
            if (mYawRateFilters[agentName].GetBufferSize() == 0)
            {
                mYawRateFilters[agentName].Configure(mYawRateFilterWindowSize);
            }
            mYawRateFilters[agentName].Push(updatedState.angularVelocity.z());

            const math::Vector3d_t movingAverageAngularVelocity(math::real_t{0.0}, math::real_t{0.0}, mYawRateFilters[agentName].ComputeAverage());
            updatedState.angularVelocity = movingAverageAngularVelocity;
            updatedState.orientation     = Eigen::AngleAxisd(agentEsminiState.h, Eigen::Vector3d::UnitZ());

            agent.UpdateState(updatedState);
            agent.UpdateTransform(updatedState);
            const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(agent.GetState().linearVelocity, agent.GetTransform2d());
            const auto updatedFrenetState = motion::FrenetState(agent.GetFrenetState().idx, agent.GetFrenetState().position, updatedFrenetVelocity);
            agent.UpdateFrenetState(updatedFrenetState);

            if (shouldTakeOver)
            {
                // ROS_ERROR_STREAM(updatedState.linearVelocity);
                SE_ReportObjectPos(agentEsminiState.id,
                                   0.0f,
                                   updatedState.position.x(),
                                   updatedState.position.y(),
                                   std::nanf(""),
                                   agentEsminiState.h,
                                   std::nanf(""),
                                   std::nanf(""));
                SE_ReportObjectSpeed(agentEsminiState.id, newSpeed);
            }
        };

        auto updateAgentState = [&](const SE_ScenarioObjectState &agentEsminiState)
        {
            bool       foundRecording  = false;
            const auto esminiAgentName = SE_GetObjectName(agentEsminiState.id);
            for (const auto &agentNameJson : mConfigJsonValue["state_recording_agents"])
            {
                const auto agentName = utils::GetStringJsonValue(agentNameJson);
                if (agentName == esminiAgentName)
                {
                    foundRecording = true;
                    break;
                }
            }
            if (foundRecording)
            {
                scenario::AgentState agentState;
                fillInAgentState(agentEsminiState, agentState);
                mAgentStates[esminiAgentName] = agentState;
            }
        };

        for (int i = 0; i < mMotionConfig.vehicles.size(); i++)
        {
            const auto &agent = mMotionConfig.vehicles[i];

            auto agentEsminiId = SE_GetIdByName(agent.name.c_str());
            if (agentEsminiId == -1)
            {
                continue;
            }

            SE_ScenarioObjectState agentEsminiState;
            SE_GetObjectState(agentEsminiId, &agentEsminiState);

            auto movingVehicle{mMovingVehicles[i]};
            updateAgent(agentEsminiState, *movingVehicle);

            updateAgentState(agentEsminiState);
        }

        for (int i = 0; i < mMotionConfig.pedestrians.size(); i++)
        {
            const auto &agent = mMotionConfig.pedestrians[i];

            auto agentEsminiId = SE_GetIdByName(agent.name.c_str());
            if (agentEsminiId == -1)
            {
                continue;
            }

            SE_ScenarioObjectState agentEsminiState;
            SE_GetObjectState(agentEsminiId, &agentEsminiState);

            auto pedestrian{mPedestrians[i]};
            updateAgent(agentEsminiState, *pedestrian);

            updateAgentState(agentEsminiState);
        }
    }

    void EsminiModel::InitEsmini()
    {
        std::string recordFilepath = "/tmp";
        if (!mEsminiRecordFilepath.empty())
        {
            recordFilepath = mEsminiRecordFilepath;
        }
        ROS_ERROR_STREAM("[unit_esmini_model] SE_SetDatFilePath: " << recordFilepath);

        std::string templateFilepath = utils::GetStringJsonValue(mConfigJsonValue["openscenario"]);

        SE_SetDatFilePath(recordFilepath.c_str());
        SE_Init(templateFilepath.c_str(), 0, !mHeadless, 0, 1);
        SE_CollisionDetection(true);
        SE_RegisterConditionCallback(esminiConditionCallback);
        SE_RegisterStoryBoardElementStateChangeCallback(storyBoardElementStateChangeCallback);

        mIsEsminiBegin = true;

        std_msgs::Bool msg;
        msg.data = true;
        mStartEsminiPublisher.publish(msg);
    }

    void EsminiModel::AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes)
    {
        Model::AccessAgentAttributes<actor::Vehicle>(agentAttributes, mMovingVehicles);
    }

    void EsminiModel::RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas)
    {
        this->Update();
        Model::RunCarlaUpdate(actorUpdateDatas, mMovingVehicles);
    }

    void EsminiModel::Configure(const ModelConfig &config)
    {
        Model::Configure<actor::Vehicle, actor::VehicleConfig>(config, std::string(AgentIdPrefix()), mMovingVehicles);
        Model::Configure<actor::Pedestrian, actor::PedestrianConfig>(config, std::string(AgentIdPrefix()), mPedestrians);
        this->ConfigureMotions();

        if (utils::IsMemberKey(mConfigJsonValue, "ego_initial_speed_required"))
        {
            ROS_INFO_STREAM("[unit_esmini_model] ego initial speed required");
            userData.egoInitialSpeedReleasedCondition =
                utils::GetStringJsonValue(mConfigJsonValue["ego_initial_speed_required"]["openscenario_released_condition"]);
            ROS_INFO_STREAM("[unit_esmini_model] egoInitialSpeedReleasedCondition: " << userData.egoInitialSpeedReleasedCondition);
            auto egoInitialSpeedParameterName = utils::GetStringJsonValue(mConfigJsonValue["ego_initial_speed_required"]["parameter"]);
            ROS_ERROR_STREAM(egoInitialSpeedParameterName);
            ROS_ERROR_STREAM(mConfigJsonValue["parameters"]);
            mEgoInitialSpeedKph  = utils::GetDoubleJsonValue(mConfigJsonValue["parameters"][egoInitialSpeedParameterName]);
            mEgoExternalSpeedKph = mEgoInitialSpeedKph;
            ROS_ERROR_STREAM("[unit_esmini_model] ego initial speed kph setting: " << mEgoInitialSpeedKph
                                                                                   << "\n, ego extenral speed kph: " << mEgoExternalSpeedKph);
        }

        if (utils::IsMemberKey(mConfigJsonValue, "scenario_valid_conditions"))
        {
            ROS_INFO_STREAM("[unit_esmini_model] setting scenario_valid_conditions");
            for (const auto condition : mConfigJsonValue["scenario_valid_conditions"])
            {
                ROS_INFO_STREAM(condition);
                userData.scenarioValidConditions[utils::GetStringJsonValue(condition)] = false;
            }
        }

        if (utils::IsMemberKey(mConfigJsonValue, "start_sampling_conditions"))
        {
            ROS_INFO_STREAM("[unit_esmini_model] setting start_sampling_conditions");
            for (const auto condition : mConfigJsonValue["start_sampling_conditions"])
            {
                ROS_INFO_STREAM(condition);
                userData.startSamplingConditions[utils::GetStringJsonValue(condition)] = false;
            }
        }

        mDoneConfigureMotions = true;
    }

    // protected func.

    // private func.

    void EsminiModel::ConfigureMotions()
    {
        Model::ConfigureMotions(mMovingVehicles);
        Model::ConfigureMotions(mPedestrians);
        std::function<decltype(motion::ParseEsminiConfig)> parseFunc{motion::ParseEsminiConfig};
        parseFunc(mConfigJsonValue["motion_configs"], mMotionConfig);
        if (mMovingVehicles.size() != mMotionConfig.vehicles.size())
        {
            ROS_ERROR_STREAM("diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n'
                                                                                << "mMovingVehicles: " << mMovingVehicles.size() << '\n'
                                                                                << "motion config counts" << mMotionConfig.vehicles.size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
        if (mPedestrians.size() != mMotionConfig.pedestrians.size())
        {
            ROS_ERROR_STREAM("diff. sizes b/t mPedestrians & mMotionConfigs" << '\n'
                                                                             << "mPedestrians: " << mPedestrians.size() << '\n'
                                                                             << "mMotionConfigs: " << mMotionConfig.pedestrians.size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void EsminiModel::ScenarioStableCallback(const std_msgs::Bool msg)
    {
        mScenarioStable = msg.data;
    }

    void EsminiModel::TtcCallback(const std_msgs::Float32 msg)
    {
        mTtc = msg.data;

        // ROS_ERROR_STREAM("mTtc: " << mTtc);
    }

    void EsminiModel::EsminiRecordFilepathCallback(const std_msgs::String msg)
    {
        mEsminiRecordFilepath = msg.data;
        ROS_ERROR_STREAM("[unit_esmini_model] mEsminiRecordFilepath: " << mEsminiRecordFilepath);
    }

    void EsminiModel::ProperResponseCallback(const rss_msgs::ProperResponse msg)
    {
        if (!mIsReferenceModelTurn || !mIsEsminiBegin ||
            (!userData.egoInitialSpeedReleasedCondition.empty() && !userData.canReleaseEgoIniitalSpeed) || !mEgoInitialSpeedStable)
        {
            return;
        }

        bool canLog;
        mNodeHandle.getParam("/rss/can_run_quantitative_analysis_logging", canLog);

        if (msg.longitudinalResponse == msg.LONGITUDINAL_RESPONSE_NONE && msg.lateralResponseLeft == msg.LATERAL_RESPONSE_NONE &&
            msg.lateralResponseRight == msg.LATERAL_RESPONSE_NONE && msg.unstructuredSceneResponse == msg.UNSTRUCTURED_SCENE_RESPONSE_NONE)
        {
            double accel = 0.0;
            mNodeHandle.getParam("/rss/ego_vehicle_dynamics/alphaLon/accelMax", accel);
            mEgoExternalSpeedKph += (accel * 0.1) * 3.6;
            mEgoExternalSpeedKph = std::min(mEgoExternalSpeedKph, mEgoInitialSpeedKph);
            ROS_ERROR_STREAM_COND(canLog,
                                  "[unit_esmini_model] no proper responses, set speed to initial "
                                  "speed. ego external speed: "
                                      << mEgoExternalSpeedKph << ". ego initial_speed_kph: " << mEgoInitialSpeedKph);
            return;
        }

        double brake = 0.0;

        switch (msg.longitudinalResponse)
        {
            case msg.LONGITUDINAL_RESPONSE_BRAKE_MIN:
            {
                double value = 0.0;
                mNodeHandle.getParam("/rss/ego_vehicle_dynamics/alphaLon/brakeMin", value);
                brake = std::min(value, brake);
                if (canLog)
                {
                    ROS_INFO_STREAM_COND(true, "[unit_esmini_model] LONGITUDINAL_RESPONSE_BRAKE_MIN");
                }
            }
            case msg.LONGITUDINAL_RESPONSE_BRAKE_MIN_CORRECT:
            {
                double value = 0.0;
                mNodeHandle.getParam("/rss/ego_vehicle_dynamics/alphaLon/brakeMinCorrect", value);
                brake = std::min(value, brake);
            }
            default:
                break;
        }

        switch (msg.unstructuredSceneResponse)
        {
            case msg.UNSTRUCTURED_SCENE_RESPONSE_BRAKE:
            {
                double value = 0.0;
                mNodeHandle.getParam("/rss/ego_vehicle_dynamics/alphaLon/brakeMin", value);
                brake = std::min(value, brake);
                if (canLog)
                {
                    ROS_INFO_STREAM_COND(true, "[unit_esmini_model] UNSTRUCTURED_SCENE_RESPONSE_BRAKE");
                }
            }
            default:
                break;
        }

        mEgoExternalSpeedKph += (brake * 0.1) * 3.6;  // HACK: should get node frequency from rss, default
                                                      // is 10 Hz so 0.1 second
        mEgoExternalSpeedKph = std::max(mEgoExternalSpeedKph, 0.0001);
        if (canLog)
        {
            ROS_INFO_STREAM_COND(true, "[unit_esmini_model] ego extenral speed kph: " << mEgoExternalSpeedKph);
            ROS_INFO_STREAM_COND(true, "[unit_esmini_model] brake: " << brake);
        }
    }

    void EsminiModel::IsReferenceModelTurnCallback(const std_msgs::Bool msg)
    {
        mIsReferenceModelTurn = msg.data;
        ROS_ERROR_STREAM("[unit_esmini_model] mIsReferenceModelTurn: " << mIsReferenceModelTurn);
        if (mIsReferenceModelTurn && utils::IsMemberKey(mConfigJsonValue, "reference_model"))
        {
            ROS_INFO_STREAM(
                "[unit_esmini_model] reference_model turn, set initail_speed_kph: " << mConfigJsonValue["reference_model"]["initial_speed_kph"]);
            mEgoInitialSpeedKph  = utils::GetDoubleJsonValue(mConfigJsonValue["reference_model"]["initial_speed_kph"]);
            mEgoExternalSpeedKph = mEgoInitialSpeedKph;
            ROS_ERROR_STREAM("[unit_esmini_model] ego initial speed kph setting: " << mEgoInitialSpeedKph
                                                                                   << "\n, ego extenral speed kph: " << mEgoExternalSpeedKph);
        }
    }

    void EsminiModel::fillInAgentState(SE_ScenarioObjectState esminiState, scenario::AgentState &outputAgentState)
    {
        // static auto normalize_radians = [](double radians) -> double { return std::fmod(radians + M_PI, 2 * M_PI) - M_PI; };
        // static auto normalize_radians = [](double angle) -> double
        // {
        //     while (angle <= -M_PI)
        //         angle += 2 * M_PI;
        //     while (angle > M_PI)
        //         angle -= 2 * M_PI;
        //     return angle;
        // };

        std::string name           = SE_GetObjectName(esminiState.id);
        outputAgentState.name      = name;
        outputAgentState.timestamp = ros::Time().now();
        outputAgentState.model_id  = esminiState.model_id;
        outputAgentState.seconds   = SE_GetSimulationTimeDouble();
        outputAgentState.x         = esminiState.x;
        outputAgentState.y         = esminiState.y;
        outputAgentState.z         = esminiState.z;
        // outputAgentState.h              = normalize_radians(esminiState.h);
        outputAgentState.h              = esminiState.h;
        outputAgentState.p              = esminiState.p;
        outputAgentState.r              = esminiState.r;
        outputAgentState.roadId         = esminiState.roadId;
        outputAgentState.junctionId     = esminiState.junctionId;
        outputAgentState.t              = esminiState.t;
        outputAgentState.laneId         = esminiState.laneId;
        outputAgentState.laneOffset     = esminiState.laneOffset;
        outputAgentState.s              = esminiState.s;
        outputAgentState.speed          = esminiState.speed;
        outputAgentState.centerOffsetX  = esminiState.centerOffsetX;
        outputAgentState.centerOffsetY  = esminiState.centerOffsetY;
        outputAgentState.centerOffsetZ  = esminiState.centerOffsetZ;
        outputAgentState.width          = esminiState.width;
        outputAgentState.length         = esminiState.length;
        outputAgentState.height         = esminiState.height;
        outputAgentState.objectType     = esminiState.objectType;
        outputAgentState.objectCategory = esminiState.objectCategory;

        outputAgentState.yawRate = mYawRateFilters[name].ComputeAverage();
        // ROS_ERROR_STREAM(name);
        // ROS_ERROR_STREAM("yaw: " << esminiState.h << ", lastYaw: " << mLastAgentStates[name].h);
        // ROS_ERROR_STREAM("seconds: " << outputAgentState.seconds << ", lastSeconds: " << mLastAgentStates[name].seconds
        //                              << ", delta: " << outputAgentState.seconds - mLastAgentStates[name].seconds);
        // ROS_ERROR_STREAM("timestamp: " << outputAgentState.timestamp << ", lastTimestamp: " << mLastAgentStates[name].timestamp
        //                                << ", delta: " << outputAgentState.timestamp - mLastAgentStates[name].timestamp);
        // const double yawRate = (outputAgentState.h - mLastAgentStates[name].h) / (outputAgentState.seconds - mLastAgentStates[name].seconds);
        // ROS_ERROR_STREAM("yawRate: " << yawRate);
        // outputAgentState.yawRate = yawRate;

        const double acceleration = (esminiState.speed - mLastAgentStates[name].speed) / (outputAgentState.seconds - mLastAgentStates[name].seconds);
        if (mAccelerationFilters[name].GetBufferSize() == 0)
        {
            mAccelerationFilters[name].Configure(mAccelerationFilterWindowSize);
        }
        mAccelerationFilters[name].Push(acceleration);
        outputAgentState.acceleration = mAccelerationFilters[name].ComputeAverage();

        // if (name == "Ego")
        // {
        //     ROS_ERROR_STREAM("ACC: " << acceleration << "\n"
        //                              << "current Speed: " << esminiState.speed << "\n"
        //                              << "last speed: " << mLastAgentStates[name].speed << "\n"
        //                              << "current seconds: " << outputAgentState.seconds << "\n"
        //                              << "last seconds: " << mLastAgentStates[name].seconds << "\n");
        // }
        // if (mAccelerationFilters[name].GetBufferSize() == 0)
        // {
        //     mAccelerationFilters[name].Configure(mAccelerationFilterWindowSize);
        // }
        // mAccelerationFilters[name].Push(acceleration);
        // outputAgentState.acceleration = mYawRateFilters[name].ComputeAverage();

        SE_RoadInfo roadInfo;
        SE_GetRoadInfoAtDistance(esminiState.id, 0.1, &roadInfo, 0, true);
        outputAgentState.laneHeading = normalize_radians(roadInfo.road_heading);
        outputAgentState.curvature   = roadInfo.curvature;
    }
}  // namespace unit
