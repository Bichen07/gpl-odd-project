#include <ros/ros.h>
#include <ros/rate.h>
#include <ros/param.h>
#include <ros/console.h>
#include <std_msgs/Bool.h>
#include <geometry_msgs/Twist.h>
#include <itri_msgs/CarState.h>
#include <Box2D.h>
#include <math.h>
#include <simulation.h>
#include <sim_vehicle.h>
#include <utils_converter.h>

static const int16 EGO_GROUP_INDEX = 1;
static const int16 AGENT_GROUP_INDEX = 2;
#define DEFAULT_DT 0.01
#define PI 3.1415926536
#define NEW_AGENT_VEL_THRESHOLD 50.0f  // For agent with same id that have speed calculated bigger than this threshold, it will be updated as a whole new agent.

CarStatus AgentDataToCarStatus(const scenario_msgs::AgentData msg)
{
    CarStatus status;
    status.id = msg.agent_id;
    status.position = b2Vec2(msg.pose.position.x, msg.pose.position.y);
    status.orientation =
        utils::ConvertToGeometryMsgsVector3(msg.pose.orientation).z;
    status.dimensions = b2Vec2(msg.size.x, msg.size.y);
    status.turnSignal = msg.turn_signal.turn_signal;
    return status;
}

void Simulation::CallbackAgentDataCmd(
    const simulation_msgs::SimulationAgentDataControl cmd)
{
    for(auto & agent: cmd.agents)
    {
        CarStatus current = AgentDataToCarStatus(agent);
        auto dt = (cmd.dt > 0) ? cmd.dt : 0.01;
        if (mAgentList.find(agent.agent_id) != mAgentList.end())
        {
            CarStatus previous = mAgentList[agent.agent_id]->GetStatus();
            if (cmd.assignVelocity)
            {
                current.velocity = b2Vec2(
                    (current.position.x - previous.position.x) / dt,
                    (current.position.y - previous.position.y) / dt);
                if (current.orientation - previous.orientation > PI)
                    current.yawRate =
                        (current.orientation -
                            previous.orientation -
                            2 * PI) / dt;
                else if (current.orientation - previous.orientation < - PI)
                    current.yawRate =
                        (current.orientation -
                            previous.orientation +
                            2 * PI) / dt;
                else
                    current.yawRate =
                        (current.orientation - previous.orientation) / dt;
                mAgentList[agent.agent_id]->SetStatus(current);
                mAgentList[agent.agent_id]->mCarBody->SetLinearVelocity(current.velocity);
                mAgentList[agent.agent_id]->mCarBody->SetAngularVelocity(current.yawRate);
            }
            else
            {
                mAgentList[agent.agent_id]->SetStatus(current);
            }

        }
        else if (cmd.spawnIfNotExist)
        {
            ROS_DEBUG_STREAM("[Simulation::CallbackAgentDataCmd] " <<
                "Create " << agent.agent_id);
            simulation_srvs::SimulationCreateAgent::Request request;
            request.agentId = agent.agent_id;
            request.pose.position.x = current.position.x;
            request.pose.position.y = current.position.y;
            request.pose.orientation.z = current.orientation;
            request.size = agent.size;
            request.turnSignalCmd = agent.turn_signal;
            CreateAgent(request);
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::CallbackAgentDataCmd] "\
                "Agent ID not found: " << agent.agent_id);
            continue;
        }
    }
}

void Simulation::CallbackAgentVelocityCmd(
    const simulation_msgs::SimulationAgentVelocityControl cmd)
{

    for(int i = 0; i < cmd.agentIds.size(); i++)
    {
        std::string agentId = cmd.agentIds[i];
        if (mAgentList.find(agentId) != mAgentList.end())
        {
            geometry_msgs::Twist twist = cmd.twists[i];
            b2Vec2 velocity = b2Vec2(twist.linear.x, twist.linear.y);
            float yawRate = twist.angular.z;
            mAgentList[agentId]->mCarBody->SetLinearVelocity(velocity);
            mAgentList[agentId]->mCarBody->SetAngularVelocity(yawRate);
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::CallbackAgentVelocityCmd] "\
                "Agent ID not found: " << agentId);
            continue;
        }
    }
}

void Simulation::CallbackAgentStateCmd(
    const simulation_msgs::SimulationAgentStateControl cmd)
{
    for(int i = 0; i < cmd.agentIds.size(); i++)
    {
        std::string agentId = cmd.agentIds[i];
        itri_msgs::CarState state = cmd.carStates[i];
        if (mAgentList.find(agentId) != mAgentList.end())
        {
            CarStatus status;
            status.position = b2Vec2(
                state.pose.pose.position.x, state.pose.pose.position.y);
            status.orientation = state.pose.pose.orientation.z;
            status.velocity = b2Vec2(
                state.twist.twist.linear.x, state.twist.twist.linear.y);
            status.yawRate = state.twist.twist.angular.z;

            // Calculate Velocity From last 2 Position ||
            // Calculate Heading From last 2 Position
            if (cmd.onlyPose || cmd.onlyPoint)
            {
                float dt = (cmd.dt == 0.0) ? (DEFAULT_DT) : (cmd.dt);
                CarStatus current = mStatusHistory->back().status[agentId];
                auto dx = state.pose.pose.position.x - current.position.x;
                auto dy = state.pose.pose.position.y - current.position.y;
                if (cmd.onlyPoint)
                    status.orientation = atan2(dy, dx);
                status.velocity = b2Vec2(dx/dt, dy/dt);
                status.yawRate = (status.orientation - current.orientation) / dt;
            }

            mAgentList[agentId]->mCarBody->SetTransform(
                status.position, status.orientation);
            mAgentList[agentId]->mCarBody->SetLinearVelocity(
                status.velocity);
            mAgentList[agentId]->mCarBody->SetAngularVelocity(
                status.yawRate);
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::CallbackAgentStateCmd] "\
                "Agent ID not found: " << agentId);
            continue;
        }
    }
}

void Simulation::CallbackAgentCmd(
    const simulation_msgs::SimulationAgentControl cmd)
{
    for(int i = 0; i < cmd.agentIds.size(); i++ )
    {
        std::string agentId = cmd.agentIds[i];
        if (mAgentList.find(agentId) != mAgentList.end())
        {
            float speed_cmd = cmd.speed_cmds[i];
            float steer_cmd = cmd.steer_cmds[i];
            mCommandList.find(agentId)->second.speed = speed_cmd;
            mCommandList.find(agentId)->second.steering = steer_cmd;
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::CallbackAgentCmd] "\
                "Agent ID not found: " << agentId);
            continue;
        }
    }
}


// Control By Services
bool Simulation::RunCreateAgentService(
    simulation_srvs::SimulationCreateAgent::Request &request,
    simulation_srvs::SimulationCreateAgent::Response &response)
{
    if (mAgentList.find(request.agentId) != mAgentList.end())
    {
        /*
        This is to avoid the re-creating of the ego handler
        which causes error because of advertising a same service.
        */
        DeleteEgoLeaveHandler(request.agentId);
        CreateEgoWithoutHandler(request);
    }
    else
    {
        CreateAgent(request);
    }
    response.isSuccess = true;
    return true;
}

bool Simulation::RunCreateAgentByDefaultPoseService(
    simulation_srvs::SimulationCreateAgentByDefaultPose::Request &request,
    simulation_srvs::SimulationCreateAgentByDefaultPose::Response &response)
{
    if (mAgentList.find(request.agentId) != mAgentList.end())
    {
        /*
        This is to avoid the re-creating of the ego handler
        which causes error because of advertising a same service.
        */
        DeleteEgoLeaveHandler(request.agentId);
        CreateEgoWithoutHandler(request);
    }
    else
    {
        CreateAgent(request);
    }
    response.isSuccess = true;
    return true;
}

bool Simulation::RunCreatePropService(
    simulation_srvs::SimulationUpdateAgentsData::Request &request,
    simulation_srvs::SimulationUpdateAgentsData::Response &response)
{
    ROS_INFO_STREAM("[Simulation] Update props by service.");
    int id_offset = 10000;
    scenario_msgs::AgentData agent;
    scenario_msgs::AgentDataArray agentDataArray;
    for(int i = 0; i < request.agents.size(); i++)
    {
        request.agents[i].detected_object_id = i + id_offset;
    }
    RunUpdateAgentsDataService(request, response);
    return true;
}

bool Simulation::RunDeleteAgentService(
    simulation_srvs::SimulationDeleteAgent::Request &request,
    simulation_srvs::SimulationDeleteAgent::Response &response)
{
    DeleteAgent(request.agentId);
    response.isSuccess = true;
    return true;
}

bool Simulation::RunUpdateAgentsService(
    simulation_srvs::SimulationUpdateAgents::Request &request,
    simulation_srvs::SimulationUpdateAgents::Response &response)
{
    std::vector<bool> successStates;

    for(int i = 0 ; i < request.agentIds.size() ; i++)
    {
        std::string agentId = request.agentIds[i];
        itri_msgs::CarState agentState = request.agentStates[i];
        if (mAgentList.find(agentId) != mAgentList.end())
        {
            CarStatus agentStatus;

            agentStatus.id = agentId;
            agentStatus.turnSignal = request.turnSignalCmds[i].turn_signal;

            CarStatus current = mStatusHistory->back().status[agentId];

            if (request.onlyPoint)
            {
                auto dx = agentState.pose.pose.position.x - current.position.x;
                auto dy = agentState.pose.pose.position.y - current.position.y;
                agentState.pose.pose.orientation.z = atan2(dy, dx);
            }
            if (request.onlyPose)
            {
                // float dt = request.dt > 0.001 ? request.dt : 0.001;
                float dt = request.dt > 0 ? request.dt: 0.01;

                agentStatus.velocity = b2Vec2(
                    (agentState.pose.pose.position.x - current.position.x) / dt,
                    (agentState.pose.pose.position.y - current.position.y) / dt);
                agentStatus.yawRate = (
                    agentState.pose.pose.orientation.z - current.orientation) / dt;


                float velocitySquare = pow(agentStatus.velocity.x, 2) +
                    pow(agentStatus.velocity.y, 2);
                if (velocitySquare > pow(NEW_AGENT_VEL_THRESHOLD, 2))
                {
                    agentStatus.velocity = b2Vec2(0.0f, 0.0f);
                    agentStatus.yawRate = 0.0f;
                }
                else
                {
                    agentStatus.velocity = b2Vec2(
                        agentStatus.velocity.x * 0.6 +
                            current.velocity.x * 0.4,
                        agentStatus.velocity.y * 0.6 +
                            current.velocity.y * 0.4);

                    agentStatus.yawRate = agentStatus.yawRate * 0.6 +
                        current.yawRate * 0.4;
                }
            }
            else
            {
                agentStatus.velocity = b2Vec2(
                    agentState.twist.twist.linear.x,
                    agentState.twist.twist.linear.y);
                agentStatus.yawRate = agentState.twist.twist.angular.z;
            }
            agentStatus.position = b2Vec2(
                agentState.pose.pose.position.x,
                agentState.pose.pose.position.y);
            agentStatus.orientation = agentState.pose.pose.orientation.z;
            const CarStatus carStatusFinal = agentStatus;

            mAgentList[agentId]->mCarBody->SetTransform(
                agentStatus.position, agentStatus.orientation);
            mAgentList[agentId]->mCarBody->SetLinearVelocity(
                agentStatus.velocity);
            mAgentList[agentId]->mCarBody->SetAngularVelocity(
                agentStatus.yawRate);
            mAgentList[agentId]->SetTurnSignal(request.turnSignalCmds[i].turn_signal);
            response.isSuccess.push_back(true);
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::RunUpdateAgentsService] "\
                "Agent ID not found: " << agentId);
            continue;
        }
    }

    return true;
}

bool Simulation::RunUpdateAgentsDataService(
    simulation_srvs::SimulationUpdateAgentsData::Request &request,
    simulation_srvs::SimulationUpdateAgentsData::Response &response)
{
    std::vector<bool> successStates;
    simulation_srvs::SimulationUpdateAgents::Request transRequest;
    simulation_srvs::SimulationUpdateAgents::Response transResponse;

    for(auto & agentData: request.agents)
    {
        std::string agentId = agentData.agent_id;
        itri_msgs::turn_signal_cmd turnSignalCmd = agentData.turn_signal;
        if (mAgentList.find(agentId) != mAgentList.end())
        {
            itri_msgs::CarState carState;

            carState.pose.pose.position.x = agentData.pose.position.x;
            carState.pose.pose.position.y = agentData.pose.position.y;
            carState.pose.pose.orientation.z =
                utils::ConvertToGeometryMsgsVector3(
                    agentData.pose.orientation).z;
            carState.twist.twist.linear = agentData.linear_velocity;

            transRequest.agentIds.push_back(agentId);
            transRequest.agentStates.push_back(carState);
            transRequest.turnSignalCmds.push_back(turnSignalCmd);
            transRequest.onlyPose = request.onlyPose;
            transRequest.onlyPoint = request.onlyPoint;
            transRequest.dt = request.dt;

            RunUpdateAgentsService(transRequest, transResponse);
            response.isSuccess = transResponse.isSuccess;
        }
        else if (request.spawnIfNotExist)
        {
            ROS_DEBUG_STREAM(
                "[Simulation::RunUpdateAgentsDataService] " <<
                "Create " << agentData.agent_id);
            simulation_srvs::SimulationCreateAgent::Request request;
            request.agentId = agentData.agent_id;
            request.pose.position.x = agentData.pose.position.x;
            request.pose.position.y = agentData.pose.position.y;
            request.pose.orientation.z =
                utils::ConvertToGeometryMsgsVector3(
                    agentData.pose.orientation).z;
            request.size = agentData.size;
            CreateAgent(request);
        }
        else
        {
            ROS_WARN_STREAM("[Simulation::RunUpdateAgentsDataService] "\
                "Agent ID not found: " << agentId);
            continue;
        }
    }

    return true;
}

bool Simulation::PlayStateControlService(
    simulation_srvs::SimulationPlayStateControl::Request &request,
    simulation_srvs::SimulationPlayStateControl::Response &response)
{
    switch (request.command.playState)
    {
        case 0:
            mPlayStatus = PlayStatus::PAUSE;
            break;
        case 1:
            mPlayStatus = PlayStatus::FORWARD;
            break;
        case 2:
            mPlayStatus = PlayStatus::BACKWARD;
            break;
        case 3:
            mPlayStatus = PlayStatus::RESET;
            break;
    }
    response.isSuccess = true;
    return true;
}

