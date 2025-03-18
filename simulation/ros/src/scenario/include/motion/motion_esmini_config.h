#ifndef _MOTION_ESMINI_CONFIG_H_
#define _MOTION_ESMINI_CONFIG_H_

#include <iostream>
#include <iterator>
#include <jsoncpp/json/json.h>
#include <esminiLib.hpp>

namespace motion
{

    struct EsminiConfig final
    {
        struct AgentBase
        {
            std::string name;
        };

        EsminiConfig()                                     = default;
        EsminiConfig(const EsminiConfig &other)            = default;
        EsminiConfig &operator=(const EsminiConfig &other) = default;
        ~EsminiConfig()                                    = default;

        std::vector<AgentBase> vehicles;
        std::vector<AgentBase> pedestrians;
    };

    void ParseEsminiConfig(const Json::Value &configJsonValue, EsminiConfig &outputconfig);

    template <typename charT, typename traits>
    std::basic_ostream<charT, traits> &operator<<(std::basic_ostream<charT, traits> &ostream, const EsminiConfig &config)
    {
        ostream << "[motion::EsminiConfig]:\n";
        ostream << "vehicles: "
                << "\n";
        for (const auto &agent : config.vehicles)
        {
            ostream << agent.name << "\n";
        }
        ostream << "\npedestrians: "
                << "\n";
        for (const auto &agent : config.pedestrians)
        {
            ostream << agent.name << "\n";
        }
        return ostream;
    }

}  // namespace motion

#endif  // #ifndef _MOTION_ESMINI_CONFIG_H_
