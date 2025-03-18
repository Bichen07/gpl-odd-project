#include "actor_agent_manager.h"
#include <stdexcept>
#include <ros/console.h>

namespace actor {

// public func.

AgentManager::AgentManager()
    : mAgents{}
    , mVehicles{}
    , mPedestrians{}
    , mObstacles{}
{
}

const std::vector<Agent::Ptr> &AgentManager::GetAgents() const
{
    return mAgents;
}

const std::vector<Vehicle::Ptr> &AgentManager::GetVehicles() const
{
    return mVehicles;
}

void AgentManager::Append(const std::shared_ptr<Vehicle> &agent)
{
    this->AppendVehicle(agent);
}

void AgentManager::Append(const std::shared_ptr<Pedestrian> &agent)
{
    this->AppendPedestrian(agent);
}

void AgentManager::Append(const std::shared_ptr<Obstacle> &agent)
{
    this->AppendObstacle(agent);
}

void AgentManager::AppendVehicle(const std::shared_ptr<Vehicle> &vehicle)
{
    if (this->IsExistedId(vehicle->GetAttribute().id))
    {
        ROS_ERROR_STREAM("agent id: " <<
            vehicle->GetAttribute().id << " is existed");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mVehicles.push_back(vehicle);
    mAgents.push_back(vehicle);
}

void AgentManager::AppendPedestrian(const std::shared_ptr<Pedestrian> &pedestrian)
{
    if (this->IsExistedId(pedestrian->GetAttribute().id))
    {
        ROS_ERROR_STREAM("agent id: " <<
            pedestrian->GetAttribute().id << " is existed");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mPedestrians.push_back(pedestrian);
    mAgents.push_back(pedestrian);
}

void AgentManager::AppendObstacle(const std::shared_ptr<Obstacle> &obstacle)
{
    if (this->IsExistedId(obstacle->GetAttribute().id))
    {
        ROS_ERROR_STREAM(
            "agent id: " <<
            obstacle->GetAttribute().id << " is existed");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mObstacles.push_back(obstacle);
    mAgents.push_back(obstacle);
}

void AgentManager::Reset()
{
    mAgents.clear();
    mVehicles.clear();
    mPedestrians.clear();
    mObstacles.clear();
}

// protected func.

// private func.

bool AgentManager::IsExistedId(const std::string &inputId) const
{
    const auto foundAgent = std::find_if(
        mAgents.begin(),
        mAgents.end(),
        [&inputId](const std::shared_ptr<Agent> &agent)
        {return agent->GetAttribute().id == inputId;});

    return mAgents.end() != foundAgent ? true : false;
}

} // namespace actor {
