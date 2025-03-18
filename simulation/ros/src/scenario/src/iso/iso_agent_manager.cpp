#include <iso_agent_manager.h>
#include <ros/console.h>
#include <iso_utils.h>

namespace iso {

// public func.

AgentManager::AgentManager()
    : mAgentMap{}
    , mVehicleMap{}
{
}

AgentManager::~AgentManager()
{
}

std::shared_ptr<actor::Vehicle> AgentManager::QueryVehicle(const std::string &id) const
{
    const auto foundVehiclePair{mVehicleMap.find(id)};
    if (mVehicleMap.end() == foundVehiclePair)
    {
        return nullptr;
    }

    return foundVehiclePair->second;
}

bool AgentManager::QueryVehicle(
    const std::string &id,
    std::shared_ptr<actor::Vehicle> *vehicle) const
{
    const auto foundVehiclePair{mVehicleMap.find(id)};
    if (mVehicleMap.end() == foundVehiclePair)
    {
        return false;
    }

    *vehicle = foundVehiclePair->second;

    return true;
}

VehicleState AgentManager::QueryVehicleState(const std::string &id) const
{
    const auto vehicle{this->QueryVehicle(id)};
    return iso::ExtractVehicleState(*vehicle);
}

bool AgentManager::QueryVehicleState(
    const std::string &id,
    VehicleState *outputVehicleState) const
{
    std::shared_ptr<actor::Vehicle> vehicle;
    if (!this->QueryVehicle(id, &vehicle))
    {
        return false;
    }

    if (nullptr == outputVehicleState)
    {
        ROS_WARN_STREAM("outputVehicle is nullptr");
        return false;
    }

    *outputVehicleState = iso::ExtractVehicleState(*vehicle);

    return true;
}

VehicleAttribute AgentManager::QueryVehicleAttribute(const std::string &id) const
{
    const auto vehicle{this->QueryVehicle(id)};
    if (!vehicle)
    {
        ROS_ERROR_STREAM("invlid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return iso::ExtractVehicleAttribute(*vehicle);
}

bool AgentManager::QueryVehicleAttribute(
    const std::string &id,
    VehicleAttribute *outputVehicleAttribute) const
{
    std::shared_ptr<actor::Vehicle> vehicle;
    if (!this->QueryVehicle(id, &vehicle))
    {
        return false;
    }

    if (nullptr == outputVehicleAttribute)
    {
        ROS_WARN_STREAM("outputVehicleAttribute is nullptr");
        return false;
    }

    *outputVehicleAttribute = iso::ExtractVehicleAttribute(*vehicle);

    return true;
}

std::string AgentManager::QueryAgentId(const std::string &id) const
{
    const auto vehicle{this->QueryVehicle(id)};
    return vehicle->GetAttribute().id;
}

bool AgentManager::QueryAgentId(
    const std::string &isoAgentId,
    std::string *scenarioAgentId) const
{
    std::shared_ptr<actor::Vehicle> vehicle;
    if (!this->QueryVehicle(isoAgentId, &vehicle))
    {
        return false;
    }

    if (nullptr == scenarioAgentId)
    {
        ROS_WARN_STREAM("scenarioAgentId is nullptr");
        return false;
    }

    *scenarioAgentId = vehicle->GetAttribute().id;

    return true;
}

void AgentManager::Register(
    const std::string &id,
    const std::shared_ptr<actor::Vehicle> &vehicle)
{
    if (this->IsExistedId(id))
    {
        ROS_ERROR_STREAM("vehicle id: " << id << " is existed");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (!iso::IsValidAgentId(id))
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mAgentMap.insert(std::make_pair(id, vehicle));
    mVehicleMap.insert(std::make_pair(id, vehicle));
}

// protected func.

// private func.

bool AgentManager::IsExistedId(const std::string &id) const
{
    const auto foundAgentPair = mAgentMap.find(id);
    return mAgentMap.end() != foundAgentPair ? true : false;
}

} // namespace iso {
