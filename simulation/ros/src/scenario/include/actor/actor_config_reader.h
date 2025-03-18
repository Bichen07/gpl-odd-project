#ifndef _ACTOR_CONFIG_READER_H_
#define _ACTOR_CONFIG_READER_H_

#include <vector>
#include <jsoncpp/json/json.h>
#include <actor_obstacle_config.h>
#include <actor_pedestrian_config.h>
#include <actor_vehicle_config.h>

namespace actor {

template <typename AgentConfigType>
void ParseAgentConfigs(
    const Json::Value &configJsonValue,
    const Json::Value &agentModelJsonValue,
    std::vector<AgentConfigType> *outputAgentConfigs);

void ParseAgentConfigTypeSpecific(
    const Json::Value &configJsonValue,
    ObstacleConfig *outputAgentConfig);

void ParseAgentConfigTypeSpecific(
    const Json::Value &configJsonValue,
    PedestrianConfig *outputAgentConfig);

void ParseAgentConfigTypeSpecific(
    const Json::Value &configJsonValue,
    VehicleConfig *outputAgentConfig);

template <typename AgentConfigType>
void ParseAgentConfig(
    const Json::Value &configJsonValue,
    const Json::Value &agentModelJsonValue,
    AgentConfigType *outputAgentConfig);

} // namespace actor {


#endif // #ifndef _ACTOR_CONFIG_READER_H_
