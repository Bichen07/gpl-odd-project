#include "Collision/Shapes/b2PolygonShape.h"
#include "Collision/b2Collision.h"
#include "Common/b2Math.h"
#include "Dynamics/Contacts/b2Contact.h"
#include "Dynamics/b2Body.h"
#include "Dynamics/b2World.h"
#include "math_col_vector_2d.h"
#include "simulation_msgs/CollisionState.h"
#include <actor_obstacle_config.h>
#include <actor_utils.h>
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
#include <simulation_msgs/CollisionProfile.h>
#include <simulation_msgs/CollisionState.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Float32.h>
#include <std_msgs/String.h>
#include <stdexcept>
#include <unit_model.h>
#include <unit_route_moving_model.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <utils_xosc.h>
#include <simulation_msgs/CollisionProfile.h>

struct UserData
{
    math::Vector3d_t egoPosition;
    double           egoYaw;
    bool             isStoryStart            = false;
    bool             isEgoStuck              = false;
    bool             isEgoReachedDestination = false;
};

static UserData userData;

static void resetUserData()
{
    userData.egoPosition.setZero();
    userData.egoYaw                  = 0;
    userData.isStoryStart            = false;
    userData.isEgoStuck              = false;
    userData.isEgoReachedDestination = false;
}

static void parameterDeclarationCallback(void *user_arg)
{
    auto root = *(static_cast<Json::Value *>(user_arg));

    SE_SetParameterDouble("vo0_kph", utils::GetDoubleJsonValue(root["vo0_kph"]));
    SE_SetParameterDouble("dlon", utils::GetDoubleJsonValue(root["dlon"]));
    SE_SetParameterDouble("alpha", utils::GetDoubleJsonValue(root["alpha"]));
    SE_SetParameterDouble("beta", utils::GetDoubleJsonValue(root["beta"]));
    SE_SetParameterDouble("rho", utils::GetDoubleJsonValue(root["rho"]));

    SE_SetParameterDouble("EgoX", userData.egoPosition.x());
    SE_SetParameterDouble("EgoY", userData.egoPosition.y());
    SE_SetParameterDouble("EgoH", userData.egoYaw);

    std::ostringstream oss;
    oss << "PARAMETER DECLARATION CALLBACK >>>>>>>>>>>>> \n" << root;
    SE_LogMessage(oss.str().c_str());
}

static void storyBoardElementStateChangeCallback(const char *name, int type, int state)
{
    std::ostringstream oss;
    oss << "STORY BOARD CALLBACK >>>>>>>>>>>>> " << name << " " << type << " " << state;
    SE_LogMessage(oss.str().c_str());

    if (std::string(name) == "MainStory" && type == 2 && state == 2)
    {
        userData.isStoryStart = true;
    }
}

static void conditionTriggeredCallback(const char *name, double timestamp)
{
    if (std::string(name) == "EgoStuckCondition")
    {
        std::ostringstream oss;
        oss << "CONDITION TRIGGERED CALLBACK >>>>>>>>>>>>> " << name;
        SE_LogMessage(oss.str().c_str());

        userData.isEgoStuck = true;
    }
    else if (std::string(name) == "EgoReachDestinationCondition")
    {
        std::ostringstream oss;
        oss << "CONDITION TRIGGERED CALLBACK >>>>>>>>>>>>> " << name;
        SE_LogMessage(oss.str().c_str());

        userData.isEgoReachedDestination = true;
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

namespace unit
{

    static int32_t currentScenarioCount = 0;
    static int32_t scenarioCountRecord  = -1;

    // public func.

    RouteMovingModel::~RouteMovingModel()
    {
        SE_Close();
    }

    RouteMovingModel::RouteMovingModel()
        : Model(),
          mMovingVehicles{},
          mMotionConfigs{},
          mEgoSpeedFilter{std::size_t{20ul}},
          mYawRateFilter{std::size_t{20ul}},
          mEgoPosXFilter{std::size_t{5ul}},
          mEgoPosYFilter{std::size_t{5ul}},
          mEgoYawFilter{std::size_t{5ul}},
          mIsEsminiBegin{false},
          mEgoStable{false},
          mIsScenarioEnd{false},
          mScenarioStable{false},
          mLastSimulationTime{0.0f}
    {
        resetUserData();
        mDoneConfigureMotions = false;

        mEgoVehicleWaypointsSubscriber =
            mNodeHandle.subscribe("global_path", Model::DefaultQueueSize(), &RouteMovingModel::EgoVehicleGlobalPathCallback, this);

        mScenarioCountSubscriber =
            mNodeHandle.subscribe("scenario_monitor/scenario_count", Model::DefaultQueueSize(), &RouteMovingModel::ScenarioCountCallback, this);

        mScenarioStableSubscriber =
            mNodeHandle.subscribe("scenario_monitor/scenario_stable", Model::DefaultQueueSize(), &RouteMovingModel::ScenarioStableCallback, this);

        mEsminiBeginSubscriber = mNodeHandle.subscribe("esmini_begin", Model::DefaultQueueSize(), &RouteMovingModel::EsminiBeginCallback, this);

        mEgoSpeedCmdPublisher = mNodeHandle.advertise<itri_msgs::speed_cmd>("scenario_control_speed_cmd", 1);
        mEgoStuckPublisher    = mNodeHandle.advertise<std_msgs::Bool>("ego_stuck", 1);

        mEndScenarioPublisher  = mNodeHandle.advertise<std_msgs::Bool>("end_scenario", 1);
        mEndScenarioSubscriber = mNodeHandle.subscribe("end_scenario", Model::DefaultQueueSize(), &RouteMovingModel::EndScenarioCallback, this);

        mStartEsminiPublisher = mNodeHandle.advertise<std_msgs::String>("start_esmini", 1);

        mNodeHandle.getParam("simulation_adv/headless", mHeadless);

        mEsminiRecordFilepathSubscriber = mNodeHandle.subscribe("esmini_record_filepath", 1, &RouteMovingModel::EsminiRecordFilepathCallback, this);

        mCollisionProfilePublisher = mNodeHandle.advertise<simulation_msgs::CollisionProfile>("/simulation/collision_profile", 1);

        mCanStartObservationSamplingPublisher = mNodeHandle.advertise<std_msgs::Bool>("/can_start_observation_sampling", 1);
        mEsminiSimulationTimePublisher        = mNodeHandle.advertise<std_msgs::Float32>("/esmini_simulation_time", 1);
    }

    std::string RouteMovingModel::GetId() const
    {
        return std::string(AgentIdPrefix()) + std::string("model");
    }

    void RouteMovingModel::Configure(const ModelConfig &config)
    {
        Model::Configure<actor::Vehicle, actor::VehicleConfig>(config, std::string(AgentIdPrefix()), mMovingVehicles);
        this->ConfigureMotions();
    }

    void RouteMovingModel::Update()
    {
        UpdateEgo();
        UpdateAgent();
        CheckEndCondition();

        if (mScenarioStable && !mIsEsminiBegin && !mDoneConfigureMotions)
        {
            InitEsmini();

            std_msgs::Bool msg;
            msg.data = true;
            mCanStartObservationSamplingPublisher.publish(msg);
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

    void RouteMovingModel::CheckEndCondition()
    {
        if (!mIsEsminiBegin || mIsScenarioEnd)
        {
            return;
        }

        if (userData.isEgoReachedDestination)
        {
            SE_Close();
            mIsEsminiBegin = false;

            std_msgs::Bool msg;
            msg.data = true;
            mEndScenarioPublisher.publish(msg);
        }

        if (userData.isEgoStuck)
        {
            SE_Close();
            mIsEsminiBegin = false;

            std_msgs::Bool msg;
            msg.data = true;
            mEgoStuckPublisher.publish(msg);
        }

        for (int j = 0; j < SE_GetNumberOfObjects(); j++)
        {
            for (int k = 0; k < SE_GetObjectNumberOfCollisions(j); k++)
            {
                int index = SE_GetObjectCollision(j, k);
                if (index != -1)
                {
                    auto agentEsminiId = SE_GetId(1);
                    auto egoEsminiId   = SE_GetId(0);
                    if (egoEsminiId == -1 || agentEsminiId == -1)
                    {
                        continue;
                    }
                    SE_ScenarioObjectState agentEsminiState;
                    SE_GetObjectState(agentEsminiId, &agentEsminiState);
                    SE_ScenarioObjectState egoEsminiState;
                    SE_GetObjectState(egoEsminiId, &egoEsminiState);

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
                    collisionProfile.header.frame_id    = "esmini_collision";
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

                    SE_Close();
                    mIsEsminiBegin = false;
                }
            }
        }
    }

    void RouteMovingModel::UpdateEgo()
    {
        auto motionConfig{mMotionConfigs.cbegin()};

        const auto &egoVelocity    = mEgoVehicleObserver->GetState().linearVelocity;
        double      egoSpeed       = egoVelocity.norm();
        const auto &egoOrientation = mEgoVehicleObserver->GetState().orientation;
        const auto  egoYaw         = utils::ConvertToVector3d(utils::ConvertToGeometryMsgsQuaternion(egoOrientation)).z();
        const auto &egoPosition    = mEgoVehicleObserver->GetState().position;

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

    void RouteMovingModel::UpdateAgent()
    {
        static bool initialUpdate = true;

        mVisualizer->AppendVehicles(mMovingVehicles);
        Model::AppendVelocityMarkers(mMovingVehicles);

        auto agentEsminiId = SE_GetId(1);
        if (agentEsminiId == -1)
        {
            return;
        }

        const auto     &egoPosition    = mEgoVehicleObserver->GetState().position;
        const auto     &egoOrientation = mEgoVehicleObserver->GetState().orientation;
        Eigen::Matrix3d rotationMatrix = egoOrientation.toRotationMatrix();

        SE_ScenarioObjectState agentEsminiState;
        SE_GetObjectState(agentEsminiId, &agentEsminiState);

        auto                   movingVehicle{mMovingVehicles.cbegin()};
        const auto            &agent         = (*movingVehicle);
        const auto            &agentPosition = agent->GetState().position;
        const math::Vector3d_t updatedPosition3d(agentEsminiState.x + 0.0001, agentEsminiState.y, 0);

        auto updatedState = motion::ComputeUpdatedState(mTimeStep, agent->GetState(), updatedPosition3d);
        mYawRateFilter.Push(updatedState.angularVelocity.z());
        const math::Vector3d_t movingAverageAngularVelocity(math::real_t{0.0}, math::real_t{0.0}, mYawRateFilter.ComputeAverage());
        updatedState.angularVelocity = movingAverageAngularVelocity;

        if (initialUpdate || agentEsminiState.speed < 0.01)
        {
            initialUpdate            = false;
            updatedState.orientation = Eigen::AngleAxisd(agentEsminiState.h, Eigen::Vector3d::UnitZ());
        }

        agent->UpdateState(updatedState);
        agent->UpdateTransform(updatedState);
        const auto updatedFrenetVelocity = motion::ComputeFrenetVelocity(agent->GetState().linearVelocity, agent->GetTransform2d());
        const auto updatedFrenetState    = motion::FrenetState(agent->GetFrenetState().idx, agent->GetFrenetState().position, updatedFrenetVelocity);
        agent->UpdateFrenetState(updatedFrenetState);
    }

    void RouteMovingModel::InitEsmini()
    {
        auto motionConfig{mMotionConfigs.cbegin()};

        static Json::Value jsonData;
        jsonData["vo0_kph"] = motionConfig->vo0_kph;
        jsonData["dlon"]    = motionConfig->dlon;
        jsonData["alpha"]   = motionConfig->alpha;
        jsonData["beta"]    = motionConfig->beta;
        jsonData["rho"]     = motionConfig->rho;
        SE_RegisterParameterDeclarationCallback(parameterDeclarationCallback, &jsonData);

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
        SE_RegisterConditionCallback(conditionTriggeredCallback);

        mIsEsminiBegin        = true;
        mDoneConfigureMotions = true;
        mLastSimulationTime   = 0.0f;

        std_msgs::Bool msg;
        msg.data = true;
        mStartEsminiPublisher.publish(msg);
    }

    void RouteMovingModel::AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes)
    {
        Model::AccessAgentAttributes<actor::Vehicle>(agentAttributes, mMovingVehicles);
    }

    void RouteMovingModel::RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas)
    {
        this->Update();
        Model::RunCarlaUpdate(actorUpdateDatas, mMovingVehicles);
    }

    // protected func.

    // private func.

    void RouteMovingModel::ConfigureMotions()
    {
        mAgentInitialVelocity.setZero();
        Model::ConfigureMotions(mMovingVehicles);
        std::function<decltype(motion::ParseRouteMovingConfig)> parseFunc{motion::ParseRouteMovingConfig};
        motion::ParseMotionConfigs(mConfigJsonValue["motion_configs"], parseFunc, mMotionConfigs);
        if (mMovingVehicles.size() != mMotionConfigs.size())
        {
            ROS_ERROR_STREAM("diff. sizes b/t mMovingVehicles & mMotionConfigs" << '\n'
                                                                                << "mMovingVehicles: " << mMovingVehicles.size() << '\n'
                                                                                << "mMotionConfigs" << mMotionConfigs.size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void RouteMovingModel::ScenarioCountCallback(const std_msgs::Int32 msg)
    {
        currentScenarioCount = msg.data;
    }

    void RouteMovingModel::ScenarioStableCallback(const std_msgs::Bool msg)
    {
        mScenarioStable = msg.data;
    }

    void RouteMovingModel::EsminiBeginCallback(const std_msgs::Bool msg)
    {
        mIsEsminiBegin = msg.data;
    }

    void RouteMovingModel::EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg)
    {
        Model::EgoVehicleGlobalPathCallback(msg);

        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
        for (int i = 0; i < msg.waypoints.size(); i++)
        {
            const auto &pathWaypoint = msg.waypoints[i];
            const auto &position     = pathWaypoint.pose.pose.position;

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

    void RouteMovingModel::EsminiRecordFilepathCallback(const std_msgs::String msg)
    {
        mEsminiRecordFilepath = msg.data;
    }

    void RouteMovingModel::EndScenarioCallback(const std_msgs::Bool msg)
    {
        mIsScenarioEnd = true;
        mIsEsminiBegin = false;
        SE_Close();
    }

}  // namespace unit
