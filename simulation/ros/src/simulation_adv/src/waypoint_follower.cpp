
#include <algorithm>
#include <waypoint_follower.h>

static const auto AHEAD_TIME{ 1.0f };
static const auto DISTANCE_THRESHOLD{ 15.0f };
static const auto GEAR_RATIO{ 19.6f };

static inline float AngleErrToSteering(const float angleErr)
{
    const auto tireAngle = 0.4f * std::atan(3.0f * std::sin(angleErr) /
        (0.5f * 3.0f));
    return std::min(std::max(
        -GEAR_RATIO * 180.0f / M_PI * tireAngle, -600.0), 600.0);
}

WaypointFollower::WaypointFollower(
    const itri_msgs::Path & path)
    : mClosestWaypointIndex()
    , mPath(path)
{}

void WaypointFollower::SetSteeringCommand(Vehicle & car)
{
    FindClosestWaypointIndex(car);
    if (mClosestWaypointIndex[car.GetStatus().id] != -1)
    {
        const auto lookAheadDistance = std::max(3.0f,
            AHEAD_TIME * car.GetStatus().velocity.Length());
        const auto lookAheadPosition = lookAheadDistance +
            mPath.waypoints[mClosestWaypointIndex[car.GetStatus().id]].s;
        const auto targetWaypointIter = std::find_if(
            mPath.waypoints.begin() +
                mClosestWaypointIndex[car.GetStatus().id],
            mPath.waypoints.end(),
            [&] (const itri_msgs::Waypoint & pt)
            {
                return pt.s > lookAheadPosition;
            });
        const auto targetWaypoint =
            targetWaypointIter != mPath.waypoints.end() ?
                *targetWaypointIter : mPath.waypoints.back();
        const auto offset = lookAheadPosition - targetWaypoint.s;
        const auto diffX = targetWaypoint.pose.pose.position.x +
            offset * std::cos(targetWaypoint.pose.pose.orientation.z) -
            car.GetStatus().position.x;
        const auto diffY = targetWaypoint.pose.pose.position.y +
            offset * std::sin(targetWaypoint.pose.pose.orientation.z) -
            car.GetStatus().position.y;
        const auto lateralError =
            -diffX * std::sin(car.GetStatus().orientation) +
            diffY * std::cos(car.GetStatus().orientation);
        car.SetSteeringCommand(
            AngleErrToSteering(lateralError / lookAheadDistance));
    }
}

void WaypointFollower::FindClosestWaypointIndex(Vehicle & car)
{
    const auto & carStatus = car.GetStatus();
    const auto indexIter = mClosestWaypointIndex.find(carStatus.id);
    auto searchStartIndex = mPath.waypoints.begin();
    auto searchEndIndex = mPath.waypoints.end();
    if (indexIter != mClosestWaypointIndex.end() &&
        indexIter->second != -1)
    {
        searchStartIndex = std::max(mPath.waypoints.begin(),
            mPath.waypoints.begin() + (indexIter->second - 2));
        searchEndIndex = std::min(mPath.waypoints.end(),
            mPath.waypoints.begin() + (indexIter->second + 2));
    }

    const auto closestIndexIter = std::min_element(
        searchStartIndex, searchEndIndex,
        [&] (const itri_msgs::Waypoint & lhs,
            const itri_msgs::Waypoint & rhs)
        {
            return std::hypot(
                    carStatus.position.x - lhs.pose.pose.position.x,
                    carStatus.position.y - lhs.pose.pose.position.y) <
                std::hypot(
                    carStatus.position.x - rhs.pose.pose.position.x,
                    carStatus.position.y - rhs.pose.pose.position.y);
        });
    if (std::hypot(
            carStatus.position.x - closestIndexIter->pose.pose.position.x,
            carStatus.position.y - closestIndexIter->pose.pose.position.y) >
        DISTANCE_THRESHOLD)
        mClosestWaypointIndex[carStatus.id] = -1;
    else
        mClosestWaypointIndex[carStatus.id] = std::distance(
            mPath.waypoints.begin(), closestIndexIter);
}
