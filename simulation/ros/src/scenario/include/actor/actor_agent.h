#ifndef _ACTOR_AGENT_H_
#define _ACTOR_AGENT_H_

#include <memory>
#include <string>
#include <std_msgs/ColorRGBA.h>
#include <math_type.h>
#include <geometry_type.h>
#include <motion_state.h>
#include <motion_frenet_state.h>
#include <actor_attribute.h>

namespace actor {

class Agent
{

public:

    using Ptr = std::shared_ptr<Agent>;

    virtual ~Agent();

    const Attribute &GetAttribute() const;
    const motion::State &GetState() const;
    const motion::FrenetState &GetFrenetState() const;
    const math::HomoXfm3d_t &GetTransform3d() const;
    const math::HomoXfm2d_t &GetTransform2d() const;

    const geometry::Rect3d &GetWorldBoundingRect3d() const;
    const geometry::Rect2d &GetWorldBoundingRect2d() const;

    void UpdateState(const motion::State &state);
    void UpdateFrenetState(const motion::FrenetState &frenetState);
    void UpdateTransform(const motion::State &state);

protected:

    Agent();
    explicit Agent(
        const std::string &id,
        const math::Vector3d_t &size,
        const std_msgs::ColorRGBA &color,
        const SafetyMargin &safetyMargin,
        const ObjectClassId &objectClassId);
    Agent(const Agent &other);
    Agent &operator=(const Agent &other);

    void SetAttribute(const Attribute &attribute);

private:

    Attribute mAttribute;
    motion::State mState;
    motion::FrenetState mFrenetState;
    math::HomoXfm3d_t mTransform3d;
    math::HomoXfm2d_t mTransform2d;

    geometry::Rect3d mWorldBoundingRect3d;
    geometry::Rect2d mWorldBoundingRect2d;
};

} // namespace actor {

#endif // #ifndef _ACTOR_AGENT_H_
