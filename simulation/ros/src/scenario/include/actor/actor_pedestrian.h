#ifndef _ACTOR_PEDESTRIAN_H_
#define _ACTOR_PEDESTRIAN_H_

#include <actor_agent.h>
#include <actor_pedestrian_config.h>

namespace actor {

class Pedestrian final : public Agent
{

public:

    typedef std::shared_ptr<Pedestrian> Ptr;

    Pedestrian();
    explicit Pedestrian(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    explicit Pedestrian(
        const std::string &id,
        const PedestrianConfig &config);
    Pedestrian(const Pedestrian &other);
    Pedestrian &operator=(const Pedestrian &other);
    virtual ~Pedestrian();

    void Configure(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    void Configure(
        const std::string &id,
        const PedestrianConfig &config);

protected:

private:

};

} // namespace actor {

#endif // #ifndef _ACTOR_PEDESTRIAN_H_
