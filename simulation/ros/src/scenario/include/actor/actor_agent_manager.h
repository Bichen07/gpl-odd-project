#ifndef _ACTOR_AGENT_MANAGER_H_
#define _ACTOR_AGENT_MANAGER_H_

#include <memory>
#include <actor_agent.h>
#include <actor_vehicle.h>
#include <actor_pedestrian.h>
#include <actor_obstacle.h>

namespace actor {

class AgentManager final
{

public:

    AgentManager();
    AgentManager(const AgentManager &) = delete;
    AgentManager &operator=(const AgentManager &) = delete;
    virtual ~AgentManager() = default;

    const std::vector<Agent::Ptr> &GetAgents() const;
    const std::vector<Vehicle::Ptr> &GetVehicles() const;
    void Append(const Vehicle::Ptr &agent);
    void Append(const Pedestrian::Ptr &agent);
    void Append(const Obstacle::Ptr &agent);
    void AppendVehicle(const Vehicle::Ptr &vehicle);
    void AppendPedestrian(const Pedestrian::Ptr &pedestrian);
    void AppendObstacle(const Obstacle::Ptr &obstacle);
    void Reset();

protected:

private:

    bool IsExistedId(const std::string &inputId) const;

    std::vector<Agent::Ptr> mAgents;
    std::vector<Vehicle::Ptr> mVehicles;
    std::vector<Pedestrian::Ptr> mPedestrians;
    std::vector<Obstacle::Ptr> mObstacles;
};

} // namespace actor {

#endif // #ifndef _ACTOR_AGENT_MANAGER_H_
