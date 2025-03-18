#include <Box2D.h>
#include <fstream>
#include <geometry_msgs/Twist.h>
#include <itri_msgs/CarState.h>
#include <math.h>
#include <ros/param.h>
#include <ros/rate.h>
#include <sim_vehicle.h>
#include <simulation.h>
#include <simulation_constants.h>
#include <std_msgs/Bool.h>
#include <std_msgs/ColorRGBA.h>
#include <string>
#include <utils_converter.h>

// constants were defined in simulation_constants.h

bool EndsWith(const std::string& s, const std::string& suffix)
{
    return s.rfind(suffix) == std::fabs(s.size() - suffix.size());
}

static const float ARROW_LENGTH_SCALE = 1.2f;

static inline void CalculateArrowMarker(const geometry_msgs::Point& position, const b2Vec2& velocity, visualization_msgs::Marker& arrow)
{
    arrow.ns      = "arrow";
    arrow.action  = visualization_msgs::Marker::ADD;
    arrow.type    = visualization_msgs::Marker::ARROW;
    arrow.color.r = arrow.color.b = 1.;
    arrow.color.g                 = 0.12;
    arrow.color.a                 = 1.;
    arrow.scale.x                 = 0.24f;
    arrow.scale.y                 = 0.48f;

    geometry_msgs::Point startPoint;
    startPoint.x = position.x;
    startPoint.y = position.y;
    startPoint.z = position.z + 1.6f;
    arrow.points.push_back(startPoint);

    geometry_msgs::Point endPoint = startPoint;
    endPoint.x += ARROW_LENGTH_SCALE * velocity.x;
    endPoint.y += ARROW_LENGTH_SCALE * velocity.y;
    arrow.lifetime = ros::Duration(0.05);
    arrow.points.push_back(endPoint);
}

static inline void CalculateAgentMarker(const scenario_msgs::AgentData agent, visualization_msgs::Marker& agentViz)
{
    agentViz.ns       = "agent";
    agentViz.type     = visualization_msgs::Marker::CUBE;
    agentViz.pose     = agent.pose;
    agentViz.scale    = agent.size;
    agentViz.color    = agent.color;
    agentViz.lifetime = ros::Duration(0.05);
}

// Public Functions

Simulation::Simulation(bool publishScenarioVisualization)
    : mGlobalPathHandler(std::make_shared<GlobalPathHandler>()),
      mStatusHistory(std::make_shared<std::vector<StatusOneStep>>()),
      mWorld(),
      mUseCarla(false),
      mPublishScenarioVisualization(publishScenarioVisualization),
      mResetPoseCmd(),
      mContactListener(mNodeHandle),
      mLoopStamp(0),
      mPlayStatus(PlayStatus::FORWARD),
      mDetectedObjectIdCount(0)
{
    mWorld = std::make_shared<b2World>(GRAVITY);
    mWorld->SetContactFilter(&mContactFilter);
    mWorld->SetContactListener(&mContactListener);
    mStatusHistory->push_back(StatusOneStep(mAgentList));
    ros::param::param<bool>("simulation/using_carla", mUseCarla, false);

    if (mPublishScenarioVisualization)
    {
        mPubVelocityArrow         = mNodeHandle.advertise<visualization_msgs::MarkerArray>("/detection/lidar_tracker/arrow_markers", 1);
        mPubScenarioVisualization = mNodeHandle.advertise<visualization_msgs::MarkerArray>("/simulation/scenario_visualization", 1);
    }
    ros::param::param<std::string>("~filtered_cluster_hulls_topic", mFilteredClusterHullsTopic, "/filtered_cluster_hulls");

    mPubObjectViz      = mNodeHandle.advertise<jsk_recognition_msgs::PolygonArray>(mFilteredClusterHullsTopic, 1);
    mPubAgentDataArray = mNodeHandle.advertise<scenario_msgs::AgentDataArray>("/simulation/agent_data_array", 1);

    mAgentDataControlCmd     = mNodeHandle.subscribe("/simulation/agent_control/agent_data", 1, &Simulation::CallbackAgentDataCmd, this);
    mAgentControlCmd         = mNodeHandle.subscribe("/simulation/agent_control/command", 1, &Simulation::CallbackAgentCmd, this);
    mAgentVelocityControlCmd = mNodeHandle.subscribe("/simulation/agent_control/velocity_control", 1, &Simulation::CallbackAgentVelocityCmd, this);
    mAgentStateControlCmd    = mNodeHandle.subscribe("/simulation/agent_control/state_control", 1, &Simulation::CallbackAgentStateCmd, this);

    mScenarioControlSpeedCmd = mNodeHandle.subscribe("/scenario_control_speed_cmd", 1, &Simulation::CallbackScenarioControlSpeedCmd, this);

    mSubGlobalPath = mNodeHandle.subscribe("global_path", 1, &Simulation::CallbackGlobalPath, this);

    mCreateAgentService = mNodeHandle.advertiseService("/simulation/agent_srv/create", &Simulation::RunCreateAgentService, this);
    mCreateAgentByDefaultPoseService =
        mNodeHandle.advertiseService("/simulation/agent_srv/create_by_default_pose", &Simulation::RunCreateAgentByDefaultPoseService, this);
    mCreatePropService       = mNodeHandle.advertiseService("/simulation/prop/create", &Simulation::RunCreatePropService, this);
    mDeleteAgentService      = mNodeHandle.advertiseService("/simulation/agent_srv/delete", &Simulation::RunDeleteAgentService, this);
    mUpdateAgentsService     = mNodeHandle.advertiseService("/simulation/agent_srv/update", &Simulation::RunUpdateAgentsService, this);
    mUpdateAgentsDataService = mNodeHandle.advertiseService("/simulation/agent_srv/update_agent_data", &Simulation::RunUpdateAgentsDataService, this);
    mPlayStateControlService =
        mNodeHandle.advertiseService("/simulation/control/play_state_control_service", &Simulation::PlayStateControlService, this);

    mScenarioStableSubscriber = mNodeHandle.subscribe("scenario_monitor/scenario_stable", 1, &Simulation::ScenarioStableCallback, this);

    ROS_INFO_STREAM("[SimulationAdv] Settings:"
                    << "\n    filtered_cluster_hulls_topic: " << mFilteredClusterHullsTopic << "\n");
}

void Simulation::OneStepSync()
{
    // bool simulationPaused = true;
    HandleSimulationProcess();
    // RestoreStatus();
}

void Simulation::OneStep()
{
    HandleSimulationProcess();
}

void Simulation::RestoreStatus()
{
    if (mStatusHistory->size() > 0)
    {
        for (auto& agent : mAgentList)
        {
            agent.second->SetStatus(mStatusHistory->back().status[agent.first]);
            auto status = mStatusHistory->back().status[agent.first];
        }
    }
}

// Protected Functions

void Simulation::HandleSimulationProcess()
{
    bool simulationPaused = true;
    switch (mPlayStatus)
    {
        case PlayStatus::PAUSE:
            break;
        case PlayStatus::FORWARD:
            simulationPaused = false;
            if (!mAgentList.empty())
                mStatusHistory->push_back(StatusOneStep(mAgentList));
            break;
        case PlayStatus::BACKWARD:
            if (mStatusHistory->size() > 1)
                mStatusHistory->pop_back();
            break;
        case PlayStatus::RESET:
            mStatusHistory->clear();
            for (auto& agent : mAgentInitStatus)
                mAgentList[agent.first]->SetStatus(agent.second);
            mStatusHistory->push_back(StatusOneStep(mAgentList));
            break;
    }

    if (simulationPaused)
        RestoreStatus();

    mLoopStamp = mStatusHistory->size();

    UpdateSimulation(simulationPaused);
}

void Simulation::UpdateSimulation(bool simulationPaused)
{
    mWorld->Step(DEFAULT_SAMPLING_TIME, VELOCITY_ITERATIONS, POSITION_ITERATIONS);

    uint64_t trajDownSampleCoeff = std::max(1, int(0.1 / DEFAULT_SAMPLING_TIME));

    if (!simulationPaused)
    {
        for (auto& agent : mAgentList)
        {
            bool isSimWithExternalVehicle = false;

            if (agent.second->mIsEgo)
            {
                if (mEgoHandlers[agent.first]->IsSimWithExternalVehicle())
                {
                    isSimWithExternalVehicle = true;
                    agent.second->SetStatus(mEgoHandlers[agent.first]->GetRealWorldStatus());
                }
                else
                {
                    ControlCommand cmd = mEgoHandlers[agent.first]->GetControlCommand();

                    float speed = mScenarioStable && mScenarioControlSpeedCmdMsg.kph != 0.0 ? mScenarioControlSpeedCmdMsg.kph : cmd.speed;
                    agent.second->SetControlCommand(cmd.steering, speed);
                }
                agent.second->SetTurnSignal(mEgoHandlers[agent.first]->GetTurnSignal());
            }
            else
            {
                ControlCommand cmd = mCommandList.find(agent.first)->second;
                agent.second->SetControlCommand(cmd.steering, cmd.speed);
                if (agent.second->mFollowWaypoint && mGlobalPathHandler->waypointFollower)
                {
                    mGlobalPathHandler->waypointFollower->SetSteeringCommand(*agent.second);
                }
            }

            if (!isSimWithExternalVehicle)
                agent.second->StepOnce();

            // Keep track of vehicle trajectory in Box2D objects.
            // This is for data retrieving after getting collision callback.
            if (mLoopStamp % trajDownSampleCoeff == 0)
            {
                CarBodyUserData* userData = (CarBodyUserData*)agent.second->mCarBody->GetUserData();
                userData->trajs.push(agent.second->GetStatus());
                if (userData->trajs.size() > 20)
                {
                    userData->trajs.pop();
                }
            }
        }
    }

    jsk_recognition_msgs::PolygonArray polygonObjects;
    visualization_msgs::MarkerArray    velocityArrows;
    visualization_msgs::MarkerArray    scenarioVisualization;
    scenario_msgs::AgentDataArray      agentDataArray;

    CalculateGlobalObjects(polygonObjects, velocityArrows, scenarioVisualization, agentDataArray);

    for (auto& egoHandler : mEgoHandlers)
    {
        egoHandler.second->SetLocalAgents(agentDataArray);
        egoHandler.second->StepOnceAndPublish(simulationPaused);
    }

    mPubObjectViz.publish(polygonObjects);
    mPubAgentDataArray.publish(agentDataArray);
    if (mPublishScenarioVisualization)
    {
        mPubScenarioVisualization.publish(scenarioVisualization);
        mPubVelocityArrow.publish(velocityArrows);
    }
}

void Simulation::SetCreateCommon(const std::string& agentId, std::shared_ptr<Vehicle>& agent, bool simWithExternalVehicle, bool createEgoHandler)
{
    bool  isEgo = !agentId.rfind("ego", 0);
    int16 groupIndex;

    if (isEgo)
    {
        groupIndex         = EGO_GROUP_INDEX;
        size_t      endIdx = agentId.rfind('/');
        std::string ns     = "";

        if (endIdx == std::string::npos)
        {
            ROS_INFO_STREAM("Spawn ego with no namespace assigned.");
        }
        else
        {
            ns = agentId.substr(0, endIdx);
            ROS_INFO_STREAM("Spawn ego with namespace " << ns << ".");
        }
    }
    else
    {
        groupIndex = AGENT_GROUP_INDEX;
    }

    if (mUseCarla)
    {
        ROS_ERROR_STREAM("Ros param simulation/using_carla is set to "
                         << "true but it was not supported by sim_adv for now, "
                         << "please check the setting or use the "
                         << "carla_simulation_adv package.");
    }
    else if (simWithExternalVehicle)
    {
        mAgentList[agentId] = agent;
    }
    else
    {
        mAgentList[agentId] = agent;
    }

    mStatusHistory->back().status[agentId] = mAgentList[agentId]->GetStatus();
    mAgentInitStatus[agentId]              = mAgentList[agentId]->GetStatus();

    if (isEgo && createEgoHandler)
    {
        mEgoHandlers[agentId] = std::make_shared<EgoHandler>(agentId,
                                                             simWithExternalVehicle,
                                                             mAgentList[agentId]->mLongitudinalOffset,
                                                             mNodeHandle,
                                                             mGlobalPathHandler,
                                                             mStatusHistory);
    }
    else
    {
        // Commands of egos are recorded in EgoHandler
        mCommandList.emplace(std::make_pair(agentId, ControlCommand(agentId, 0.0f, 0.0f, false)));
    }
    mStatusHistory->push_back(StatusOneStep(mAgentList));
}

void Simulation::CreateAgent(simulation_srvs::SimulationCreateAgentByDefaultPose::Request& request)
{
    bool isEgo = !request.agentId.rfind("ego", 0);
    auto agent = std::make_shared<Vehicle>(request.agentId,
                                           request.model,
                                           request.route,
                                           request.fileName,
                                           request.simWithExternalVehicle,
                                           request.defaultPoseSequence,
                                           *mWorld,
                                           isEgo,
                                           mDetectedObjectIdCount);
    if (!request.objectClassId.empty())
    {
        agent->SetClassId(request.objectClassId);
    }
    mDetectedObjectIdCount++;
    SetCreateCommon(request.agentId, agent, request.simWithExternalVehicle, true);
}

void Simulation::CreateEgoWithoutHandler(simulation_srvs::SimulationCreateAgentByDefaultPose::Request& request)
{
    bool isEgo = !request.agentId.rfind("ego", 0);
    auto agent = std::make_shared<Vehicle>(request.agentId,
                                           request.model,
                                           request.route,
                                           request.fileName,
                                           request.simWithExternalVehicle,
                                           request.defaultPoseSequence,
                                           *mWorld,
                                           isEgo,
                                           mDetectedObjectIdCount);
    if (!request.objectClassId.empty())
    {
        agent->SetClassId(request.objectClassId);
    }
    mDetectedObjectIdCount++;
    SetCreateCommon(request.agentId, agent, request.simWithExternalVehicle, false);
}

void Simulation::CreateAgent(simulation_srvs::SimulationCreateAgent::Request& request)
{
    bool   isEgo       = !request.agentId.rfind("ego", 0);
    b2Vec2 position    = b2Vec2(request.pose.position.x, request.pose.position.y);
    b2Vec3 size        = b2Vec3(request.size.x, request.size.y, request.size.z);
    float  orientation = request.pose.orientation.z;

    auto agent = std::make_shared<Vehicle>(request.agentId,
                                           position,
                                           orientation,
                                           request.simWithExternalVehicle,
                                           size,
                                           *mWorld,
                                           isEgo,
                                           mDetectedObjectIdCount);
    if (!request.objectClassId.empty())
    {
        agent->SetClassId(request.objectClassId);
    }
    mDetectedObjectIdCount++;
    agent->mLongitudinalOffset = request.longitudinalOffset;
    SetCreateCommon(request.agentId, agent, request.simWithExternalVehicle, true);
}

void Simulation::CreateEgoWithoutHandler(simulation_srvs::SimulationCreateAgent::Request& request)
{
    bool   isEgo       = !request.agentId.rfind("ego", 0);
    b2Vec2 position    = b2Vec2(request.pose.position.x, request.pose.position.y);
    b2Vec3 size        = b2Vec3(request.size.x, request.size.y, request.size.z);
    float  orientation = request.pose.orientation.z;

    auto agent = std::make_shared<Vehicle>(request.agentId,
                                           position,
                                           orientation,
                                           request.simWithExternalVehicle,
                                           size,
                                           *mWorld,
                                           isEgo,
                                           mDetectedObjectIdCount);
    if (!request.objectClassId.empty())
    {
        agent->SetClassId(request.objectClassId);
    }
    mDetectedObjectIdCount++;
    agent->mLongitudinalOffset = request.longitudinalOffset;
    SetCreateCommon(request.agentId, agent, request.simWithExternalVehicle, false);
}

void Simulation::DeleteEgoLeaveHandler(const std::string& agentId)
{
    mAgentList.erase(agentId);
    mStatusHistory->back().status.erase(agentId);
    if (mAgentInitStatus.find(agentId) != mAgentInitStatus.end())
    {
        mAgentInitStatus.erase(agentId);
    }
    if (mCommandList.find(agentId) != mCommandList.end())
    {
        mCommandList.erase(agentId);
    }
}

void Simulation::DeleteAgent(const std::string& agentId)
{
    DeleteEgoLeaveHandler(agentId);
    if (mEgoHandlers.find(agentId) != mEgoHandlers.end())
    {
        mEgoHandlers.erase(agentId);
    }
}

// Private Functions

// Calculate global information
void Simulation::CalculateGlobalObjects(jsk_recognition_msgs::PolygonArray& polygonObjects,
                                        visualization_msgs::MarkerArray&    velocityArrows,
                                        visualization_msgs::MarkerArray&    scenarioVisualization,
                                        scenario_msgs::AgentDataArray&      agentDataArray)
{
    auto stamp                     = ros::Time::now();
    polygonObjects.header.frame_id = "map";
    polygonObjects.header.stamp    = stamp;
    agentDataArray.header          = polygonObjects.header;

    for (auto& carPair : mStatusHistory->back().status)
    {
        auto      vehicle = mAgentList[carPair.first];
        CarStatus car     = carPair.second;

        geometry_msgs::PolygonStamped polygonGlobal;
        polygonGlobal.header = polygonObjects.header;
        CalculateObjectPolygon(car, polygonGlobal);

        geometry_msgs::Point point;
        point.x = car.position.x;
        point.y = car.position.y;
        point.z = GetAltitude(point.x, point.y);

        // Calculate agentData
        scenario_msgs::AgentData agent;
        agent.agent_id                = carPair.first;
        agent.detected_object_id      = vehicle->mUniqueId;
        agent.objectClassId           = vehicle->mClassId;
        agent.pose.position           = point;
        agent.pose.orientation        = utils::ConvertToGeometryMsgsQuaternion(car.orientation);
        agent.turn_signal.turn_signal = car.turnSignal;

        CarBodyUserData* carBodyUserData = (CarBodyUserData*)vehicle->mCarBody->GetUserData();
        agent.size.x                     = carBodyUserData->size.x;
        agent.size.y                     = carBodyUserData->size.y;
        agent.size.z                     = carBodyUserData->size.z;
        agent.polygon                    = polygonGlobal.polygon;
        agent.linear_velocity.x          = car.velocity.x;
        agent.linear_velocity.y          = car.velocity.y;

        std::size_t foundEgo = agent.agent_id.find("ego");
        if (foundEgo != std::string::npos)
        {
            // Red for other ego agents.
            agent.color.g = 0.21;
            agent.color.b = 0.6;
            agent.color.r = 0.8;
            agent.color.a = 0.95;
            if (!mPublishScenarioVisualization)
            {
                // Disable ego's marker if topic scenario_visualization
                // is published by scenario_visualization node.
                // This is only used when multiple vehicles were applied,
                // and show different color on other vehicles.
                agent.color.a = 0;
            }
        }
        else
        {
            // For normal agents.
            agent.color.r = 255.0 / 255.0;
            agent.color.g = 145.0 / 255.0;
            agent.color.b = 36.0 / 255.0;
            agent.color.a = 0.9;
        }
        agentDataArray.id_list.push_back(carPair.first);
        agentDataArray.data.push_back(agent);

        if (car.velocity.x * car.velocity.x + car.velocity.y * car.velocity.y >= 0.5)
        {
            visualization_msgs::Marker arrow;
            arrow.header = polygonObjects.header;
            arrow.id     = agent.detected_object_id;
            CalculateArrowMarker(point, car.velocity, arrow);
            velocityArrows.markers.push_back(arrow);
        }
        if (!vehicle->mIsEgo)
        {
            visualization_msgs::Marker agentViz;
            agentViz.header = polygonObjects.header;
            agentViz.id     = agent.detected_object_id;
            CalculateAgentMarker(agent, agentViz);
            scenarioVisualization.markers.push_back(agentViz);
        }
        polygonObjects.polygons.push_back(polygonGlobal);
    }
}

void Simulation::CalculateObjectPolygon(const CarStatus& agentCar, geometry_msgs::PolygonStamped& polygonGlobal)
{
    geometry_msgs::Point32 point;
    for (size_t i = 0; i < OBJECT_LAYER; ++i)
    {
        for (size_t j = 0; j < LAYER_VERTICES; ++j)
        {
            point.x = agentCar.shape[j % RECTANGLE_VERTICES].x;
            point.y = agentCar.shape[j % RECTANGLE_VERTICES].y;
            point.z = GetAltitude(point.x, point.y) + (i == 0 ? 0.5 * CAR_OBJECT_HEIGHT : -0.5 * CAR_OBJECT_HEIGHT);
            polygonGlobal.polygon.points.push_back(point);
        }
    }
}

void Simulation::CallbackGlobalPath(const itri_msgs::Path& msg)
{
    mGlobalPathHandler->globalPath       = msg;
    mGlobalPathHandler->waypointFollower = std::make_shared<WaypointFollower>(msg);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
    cloud->width  = mGlobalPathHandler->globalPath.waypoints.size();
    cloud->height = 1;
    cloud->points.resize(cloud->width * cloud->height);
    for (size_t i = 0; i < cloud->points.size(); ++i)
    {
        cloud->points[i].x = mGlobalPathHandler->globalPath.waypoints[i].pose.pose.position.x;
        cloud->points[i].y = mGlobalPathHandler->globalPath.waypoints[i].pose.pose.position.y;
        cloud->points[i].z = 0.0f;
    }
    mGlobalPathHandler->globalPathKdtree.setInputCloud(cloud);
}

void Simulation::CallbackScenarioControlSpeedCmd(const itri_msgs::speed_cmd& msg)
{
    mScenarioControlSpeedCmdMsg = msg;
}

void Simulation::ScenarioStableCallback(const std_msgs::Bool msg)
{
    mScenarioStable = msg.data;
}

float Simulation::GetAltitude(const float x, const float y)
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
