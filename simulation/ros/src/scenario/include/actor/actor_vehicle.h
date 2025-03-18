#ifndef _ACTOR_VEHICLE_H_
#define _ACTOR_VEHICLE_H_

#include <actor_agent.h>
#include <actor_vehicle_config.h>

namespace actor {

class Vehicle final : public Agent
{

public:

    typedef std::shared_ptr<Vehicle> Ptr;

    Vehicle();
    explicit Vehicle(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    explicit Vehicle(
        const std::string &id,
        const VehicleConfig &config);
    Vehicle(const Vehicle &other);
    Vehicle &operator=(const Vehicle &other);
    virtual ~Vehicle();

    const math::Vector2d_t &GetFrontWarningRegionSize() const;

    void SetFrontWarningRegionSize(const math::Vector2d_t &size);

    void Configure(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    void Configure(
        const std::string &id,
        const VehicleConfig &config);

protected:

private:

    math::Vector2d_t mFrontWarningRegionSize;
};

} // namespace actor {

#endif // #ifndef _ACTOR_VEHICLE_H_
