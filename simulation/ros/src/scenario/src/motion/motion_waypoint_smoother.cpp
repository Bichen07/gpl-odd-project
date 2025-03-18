#include <motion_waypoint_smoother.h>
#include <ros/console.h>
#include <utils_converter.h>

namespace motion {

// public func.

WaypointSmoother::WaypointSmoother()
{
}

WaypointSmoother::~WaypointSmoother()
{
}

std::vector<math::Vector3d_t> WaypointSmoother::Compute(
    const std::vector<math::Vector3d_t> &refWaypoint3ds,
    const math::real_t distanceThreshold)
{
    if (refWaypoint3ds.empty())
    {
        ROS_WARN_STREAM("refWaypoint3ds is empty");
        return std::vector<math::Vector3d_t>();
    }

    std::vector<math::Vector3d_t> smoothedWaypoint3ds;
    smoothedWaypoint3ds.reserve(refWaypoint3ds.size());
    std::size_t idx{0ul};
    smoothedWaypoint3ds.push_back(refWaypoint3ds.at(idx));
    ++idx;
    smoothedWaypoint3ds.push_back(refWaypoint3ds.at(idx));
    for (; idx < refWaypoint3ds.size() - 1ul; ++idx)
    {
        const std::size_t smoothedSize{smoothedWaypoint3ds.size()};
        const math::Vector3d_t previousForwardVector3d =
            smoothedWaypoint3ds.at(smoothedSize - 1ul) -
            smoothedWaypoint3ds.at(smoothedSize - 2ul);
        const math::Vector3d_t currentForwardVector3d =
            refWaypoint3ds.at(idx + 1ul) -
            smoothedWaypoint3ds.at(smoothedSize - 1ul);

        //ROS_INFO_STREAM('\n' <<
        //    "smoothedSize: " << smoothedSize << '\n' <<
        //    "smoothedSize - 1ul: " << smoothedSize - 1ul << '\n' <<
        //    "smoothedSize - 2ul: " << smoothedSize - 2ul << '\n' <<
        //    "idx + 1ul: " << idx + 1ul << '\n' <<
        //    "smoothedWaypoint3ds.at(smoothedSize - 1ul): " <<
        //    smoothedWaypoint3ds.at(smoothedSize - 1ul).transpose() << '\n' <<
        //    "smoothedWaypoint3ds.at(smoothedSize - 2ul): " <<
        //    smoothedWaypoint3ds.at(smoothedSize - 2ul).transpose());

        const math::Vector2d_t previousForwardVector2d =
            utils::ConvertToVector2d(previousForwardVector3d).normalized();
        const math::Vector2d_t currentForwardVector2d =
            utils::ConvertToVector2d(currentForwardVector3d).normalized();
        const math::real_t dotProduct = previousForwardVector2d.dot(currentForwardVector2d);

        const math::real_t currentDistance = utils::ConvertToVector2d(currentForwardVector3d).norm();
        const bool canAddThisWaypoint =
            dotProduct > 0.0 &&
            currentDistance > distanceThreshold;
        //const bool canAddThisWaypoint = dotProduct > 0.0;
        if (canAddThisWaypoint)
        {
            smoothedWaypoint3ds.push_back(refWaypoint3ds.at(idx + 1));
        }
    }

//    ROS_WARN_STREAM("refWaypoint3ds");
//    for (auto refWaypoint{refWaypoint3ds.begin()};
//         refWaypoint != refWaypoint3ds.end();
//         ++refWaypoint)
//    {
//        std::cout << std::setprecision(5) << std::fixed <<
//            refWaypoint->transpose() << '\n';
//    }
//
//    ROS_WARN_STREAM("smoothedWaypoint3ds");
//    for (auto smoothedWaypoint{smoothedWaypoint3ds.begin()};
//         smoothedWaypoint != smoothedWaypoint3ds.end();
//         ++smoothedWaypoint)
//    {
//        std::cout << std::setprecision(5) << std::fixed <<
//            smoothedWaypoint->transpose() << '\n';
//    }

    return smoothedWaypoint3ds;
}

// protected func.

// private func.

} // namespace motion {
