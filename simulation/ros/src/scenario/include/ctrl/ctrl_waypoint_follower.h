#ifndef _CTRL_WAYPOINT_FOLLOWER_H_
#define _CTRL_WAYPOINT_FOLLOWER_H_

#include <memory>
#include <vector>
#include <math_frenet_transformer.h>
#include <math_moving_average_filter.h>
#include <actor_agent.h>

namespace ctrl {

class WaypointFollower final
{

public:

    WaypointFollower();
    WaypointFollower(const WaypointFollower &) = delete;
    WaypointFollower &operator=(const WaypointFollower &) = delete;
    virtual ~WaypointFollower() = default;

    const std::vector<math::Vector3d_t> &GetRefWaypoints() const;
    bool IsReachingTheEnd() const;

    void Configure(
        const math::real_t timeStep,
        const std::shared_ptr<actor::Agent> &agent,
        const std::vector<math::Vector3d_t> &waypoint3ds);
    void Update(const math::real_t longitudinalSpeed);
    void Update(
        const math::real_t longitudinalSpeed,
        const math::real_t lateralSpeed);

protected:

private:

    using YawRateFilter = math::MovingAverageFilter<math::real_t>;

    math::real_t mTimeStep;
    std::shared_ptr<actor::Agent> mAgent;
    std::vector<math::Vector3d_t> mRefWaypoint3ds;
    std::vector<math::Vector2d_t> mRefWaypoint2ds;
    math::FrenetTransformer mFrenetTransformer;
    YawRateFilter mYawRateFilter;
    bool mIsReachingTheEnd;
};

} // namespace ctrl {

#endif // #ifndef _CTRL_WAYPOINT_FOLLOWER_H_
