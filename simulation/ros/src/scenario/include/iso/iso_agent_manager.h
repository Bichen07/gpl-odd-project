#ifndef _ISO_AGENT_MANAGER_H_
#define _ISO_AGENT_MANAGER_H_

#include <memory>
#include <map>
#include <actor_vehicle.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>

namespace iso {

class AgentManager final
{

public:

    AgentManager();
    AgentManager(const AgentManager &) = delete;
    AgentManager &operator=(const AgentManager &) = delete;
    virtual ~AgentManager();

    std::shared_ptr<actor::Vehicle> QueryVehicle(const std::string &id) const;
    bool QueryVehicle(
        const std::string &id,
        std::shared_ptr<actor::Vehicle> *vehicle) const;
    VehicleState QueryVehicleState(const std::string &id) const;
    bool QueryVehicleState(
        const std::string &id,
        VehicleState *outputVehicleState) const;
    VehicleAttribute QueryVehicleAttribute(const std::string &id) const;
    bool QueryVehicleAttribute(
        const std::string &id,
        VehicleAttribute *outputVehicleAttribute) const;
    std::string QueryAgentId(const std::string &id) const;
    bool QueryAgentId(
        const std::string &isoAgentId,
        std::string *scenarioAgentId) const;

    void Register(
        const std::string &id,
        const std::shared_ptr<actor::Vehicle> &vehicle);

protected:

private:

    using AgentMap = std::map<std::string, std::shared_ptr<actor::Agent>>;
    using VehicleMap = std::map<std::string, std::shared_ptr<actor::Vehicle>>;

    bool IsExistedId(const std::string &id) const;

    AgentMap mAgentMap;
    VehicleMap mVehicleMap;
};

} // namespace iso {

#endif // #ifndef _ISO_AGENT_MANAGER_H_
