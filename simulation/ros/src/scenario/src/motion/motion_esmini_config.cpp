#include <motion_esmini_config.h>
#include <ros/console.h>
#include <utils_json.h>

namespace motion
{

    void ParseEsminiConfig(const Json::Value &configJsonValue, EsminiConfig &outputConfig)
    {
        for (const auto &config : configJsonValue)
        {
            EsminiConfig::AgentBase agent;
            agent.name = utils::GetStringJsonValue(config["name"]);

            if (config["object_class_id"] == "person")
            {
                outputConfig.pedestrians.emplace_back(agent);
            }
            else
            {
                outputConfig.vehicles.emplace_back(agent);
            }
        }
        ROS_INFO_STREAM(outputConfig);
    }

}  // namespace motion
