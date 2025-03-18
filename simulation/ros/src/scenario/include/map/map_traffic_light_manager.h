#ifndef _MAP_TRAFFIC_LIGHT_MANAGER_H_
#define _MAP_TRAFFIC_LIGHT_MANAGER_H_

#include <string>
#include <map>
#include <map_traffic_light.h>

namespace map {

class TrafficLightManager final
{

public:

    TrafficLightManager();
    TrafficLightManager(const TrafficLightManager &) = delete;
    TrafficLightManager &operator=(const TrafficLightManager &) = delete;
    virtual ~TrafficLightManager() = default;

    const std::map<int32_t, TrafficLight> &GetTrafficLightMap() const;
    const TrafficLight &QueryTrafficLight(const int32_t id) const;
    const bool QueryTrafficLight(
        const int32_t id,
        TrafficLight &outputTrafficLight) const;

    void Configure(const std::string &trafficLightFileName);

protected:

private:

    std::map<int32_t, TrafficLight> mTrafficLightMap;
};

} // namespace map {

#endif // #ifndef _MAP_TRAFFIC_LIGHT_MANAGER_H_
