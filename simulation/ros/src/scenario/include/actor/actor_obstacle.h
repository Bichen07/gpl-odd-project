#ifndef _ACTOR_OBSTACLE_H_
#define _ACTOR_OBSTACLE_H_

#include <actor_agent.h>
#include <actor_obstacle_config.h>

namespace actor {

class Obstacle final : public Agent
{

public:

    typedef std::shared_ptr<Obstacle> Ptr;

    Obstacle();
    explicit Obstacle(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    explicit Obstacle(
        const std::string &id,
        const ObstacleConfig &config);
    Obstacle(const Obstacle &other);
    Obstacle &operator=(const Obstacle &other);
    virtual ~Obstacle();

    void Configure(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);

protected:

private:

};

} // namespace actor {

#endif // #ifndef _ACTOR_OBSTACLE_H_
