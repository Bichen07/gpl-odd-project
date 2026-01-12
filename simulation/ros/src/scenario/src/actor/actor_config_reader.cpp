#include <actor_config_reader.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <actor_object_class_id.h>
#include <actor_utils.h>

namespace actor {

template <typename AgentConfigType>
void ParseAgentConfigs(
    const Json::Value &configJsonValue,
    const Json::Value &agentModelJsonValue,
    std::vector<AgentConfigType> *outputAgentConfigs)
{
    if (nullptr == outputAgentConfigs)
    {
        ROS_ERROR_STREAM("outputAgentConfigs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
    const std::size_t size{configJsonValue.size()};
    outputAgentConfigs->resize(size);
    auto outputAgentConfig{outputAgentConfigs->begin()};
    for (const auto &value: configJsonValue)
    {
        actor::ParseAgentConfig(value, agentModelJsonValue, &(*outputAgentConfig));
        ++outputAgentConfig;
    }
}


/* 
    TypeSpecific was called in ParseAgentConfig
    to deal with different agent type.
*/

void ParseAgentConfigTypeSpecific(  
    const Json::Value &configJsonValue,
    ObstacleConfig *outputAgentConfig)
{
}

void ParseAgentConfigTypeSpecific(
    const Json::Value &configJsonValue,
    PedestrianConfig *outputAgentConfig)
{
}

void ParseAgentConfigTypeSpecific(
    const Json::Value &configJsonValue,
    VehicleConfig *outputAgentConfig)
{
    outputAgentConfig->frontWarningRegionSize = math::Vector2d_t(
    utils::GetDoubleJsonValue(configJsonValue["front_warning_region_size"]["x"]),
    utils::GetDoubleJsonValue(configJsonValue["front_warning_region_size"]["y"]));
}

template <typename AgentConfigType>
void ParseAgentConfig(
    const Json::Value &configJsonValue,
    const Json::Value &agentModelJsonValue,
    AgentConfigType *outputAgentConfig)
{

    bool sizeSet = false;

    if (nullptr == outputAgentConfig)
    {
        ROS_ERROR_STREAM("outputAgentConfig is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputAgentConfig->color.r =
        utils::GetFloatJsonValue(configJsonValue["color"]["r"]);
    outputAgentConfig->color.g =
        utils::GetFloatJsonValue(configJsonValue["color"]["g"]);
    outputAgentConfig->color.b =
        utils::GetFloatJsonValue(configJsonValue["color"]["b"]);
    outputAgentConfig->color.a =
        utils::GetFloatJsonValue(configJsonValue["color"]["a"]);
    outputAgentConfig->safetyMargin = SafetyMargin(
        utils::GetDoubleJsonValue(configJsonValue["safety_margin"]["left"]),
        utils::GetDoubleJsonValue(configJsonValue["safety_margin"]["right"]),
        utils::GetDoubleJsonValue(configJsonValue["safety_margin"]["front"]),
        utils::GetDoubleJsonValue(configJsonValue["safety_margin"]["rear"]));
    outputAgentConfig->objectClassId = actor::ToObjectClassId(
        utils::GetStringJsonValue(configJsonValue["object_class_id"]));

    ParseAgentConfigTypeSpecific(configJsonValue, outputAgentConfig);

    // Set agent size

    if (utils::IsMemberKey(configJsonValue, "size_overwrite"))
    {
        outputAgentConfig->size = math::Vector3d_t(
            utils::GetDoubleJsonValue(configJsonValue["size_overwrite"]["x"]),
            utils::GetDoubleJsonValue(configJsonValue["size_overwrite"]["y"]),
            utils::GetDoubleJsonValue(configJsonValue["size_overwrite"]["z"]));
        ROS_WARN_STREAM(outputAgentConfig->size);
        ROS_WARN_STREAM("Overwrite agent's model size.");
        sizeSet = true;
    }
    else if (utils::IsMemberKey(configJsonValue, "carla"))
    {
        if (utils::IsMemberKey(configJsonValue["carla"], "model_type"))
        {
            const auto modelTypeKey = 
                utils::GetStringJsonValue(configJsonValue["carla"]["model_type"]);
            if (utils::IsMemberKey(agentModelJsonValue, modelTypeKey.c_str()))
            {
                outputAgentConfig->size = math::Vector3d_t(
                    utils::GetDoubleJsonValue(agentModelJsonValue[modelTypeKey]["x"]),
                    utils::GetDoubleJsonValue(agentModelJsonValue[modelTypeKey]["y"]),
                    utils::GetDoubleJsonValue(agentModelJsonValue[modelTypeKey]["z"]));
                ROS_WARN_STREAM(
                    "Assign size of agent model type \""<< modelTypeKey.c_str() << 
                    "\" with carla agents' bounding boxes.");
                sizeSet = true;
            }
            else
            {
                ROS_WARN_STREAM(
                    "Agent model type \""<< modelTypeKey.c_str() << 
                    "\" not found, use default size instead.");
            }
        }
        else
        {
            ROS_WARN_STREAM(
                "Agent model type not assigned in config file." << 
                " Use default size instead.");
        }
    }
    else
    {
        ROS_WARN_STREAM(
            "Carla agent model details not assigned in config file." << 
            " Use default size instead.");
    }

    if (!sizeSet)  // Default size
    {
        if (outputAgentConfig->objectClassId == ObjectClass::Car)
        {
            outputAgentConfig->size = math::Vector3d_t(4.2, 1.8, 1.45);
        }
        else if (outputAgentConfig->objectClassId == ObjectClass::Motorbike)
        {
            outputAgentConfig->size = math::Vector3d_t(1.5, 0.8, 1.6);   
        }
        else if (outputAgentConfig->objectClassId == ObjectClass::Person)
        {
            outputAgentConfig->size = math::Vector3d_t(0.335, 0.558, 0.74);   
        }
        else if (outputAgentConfig->objectClassId == ObjectClass::Bicycle)
        {
            outputAgentConfig->size = math::Vector3d_t(1.2, 0.7, 1.4);   
        }

        else
        {
            ROS_ERROR_STREAM("Unknown Vehicle objectClassId: " << 
                outputAgentConfig->objectClassId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }
    ROS_WARN_STREAM(outputAgentConfig->objectClassId);
    ROS_WARN_STREAM(outputAgentConfig->size);
}

void DummyFunctionForTemplateConstruction()
{
    const Json::Value jsonValue;
    const Json::Value agentModelJsonValue;
    std::vector<PedestrianConfig> pedestrianConfig;
    std::vector<VehicleConfig> vehicleConfig;
    std::vector<ObstacleConfig> obstacleConfig;
    ParseAgentConfigs<PedestrianConfig>(
        jsonValue, agentModelJsonValue, &pedestrianConfig);
    ParseAgentConfigs<VehicleConfig>(
        jsonValue, agentModelJsonValue, &vehicleConfig);
    ParseAgentConfigs<ObstacleConfig>(
        jsonValue, agentModelJsonValue, &obstacleConfig);
}

} // namespace actor {
