#include <rss_intersection_manager.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <geometry_utils.h>

namespace rss {

// public func.

IntersectionManager::IntersectionManager()
    : mIntersections{}
    , mValidIds{}
    , mIntersectionEvaluator{}
{
}

const std::vector<int32_t> &IntersectionManager::GetIds() const
{
    return mValidIds;
}

const std::vector<Intersection::Ptr> &IntersectionManager::GetIntersections() const
{
    return mIntersections;
}

void IntersectionManager::Configure(const std::string &fileName)
{
    Json::Value inputJasonValue;
    utils::ParseJsonValue(
        fileName,
        &inputJasonValue);
    static constexpr const char *intersectionSetKey{"intersections"};
    utils::VerifyMemberKey(inputJasonValue, intersectionSetKey);

    const Json::Value &intersectionSetValue{inputJasonValue[intersectionSetKey]};
    const std::size_t size{intersectionSetValue.size()};
    mIntersections.reserve(size);
    mValidIds.reserve(size);
    for (const auto &intersectionValue: intersectionSetValue)
    {
        const int32_t id{
            utils::GetIntJsonValue(intersectionValue["id"])};
        const std::size_t pointSetSize{
            intersectionValue["points"].size()};
        std::vector<geometry::Vector3d> intersectionPoints{pointSetSize};
        auto intersectionPoint{intersectionPoints.begin()};
        for (const auto pointValue: intersectionValue["points"])
        {
            *intersectionPoint = geometry::Vector3d(
                utils::GetDoubleJsonValue(pointValue["x"]),
                utils::GetDoubleJsonValue(pointValue["y"]),
                utils::GetDoubleJsonValue(pointValue["z"]));
            ++intersectionPoint;
        }

        mIntersections.push_back(
            std::make_shared<Intersection>(id, intersectionPoints));
        mValidIds.push_back(id);
    }
}

const Intersection::Ptr IntersectionManager::QueryIntersection(const int32_t id) const
{
    const auto foundIntersection{
        std::find_if(
            mIntersections.cbegin(),
            mIntersections.cend(),
            [&id](const Intersection::Ptr &intersection)
            {return id == intersection->GetId();})};

    if (mIntersections.cend() == foundIntersection)
    {
        ROS_WARN_STREAM("invalid id: " << id);
        return Intersection::Ptr(nullptr);
    }

    return *foundIntersection;
}

bool IntersectionManager::HasOverlapping(
    const geometry::Transform3d &targetTransform,
    const geometry::Vector3d &targetSize) const
{
    const auto rect3d{
        geometry::ComputeBoundingRect3d(targetTransform, targetSize.ToVectorXy())};
    const std::vector<math::Vector3d_t> closedCorner3ds{
        geometry::ExtractPolygonClosedCorners(rect3d)};
    std::vector<math::Vector2d_t> closedCorner2ds(closedCorner3ds.size());
    std::transform(
        closedCorner3ds.cbegin(),
        closedCorner3ds.cend(),
        closedCorner2ds.begin(),
        [](const math::Vector3d_t &vector3d)
        {return math::Vector2d_t(vector3d.x(), vector3d.y());});

    const auto targetPolygon{
        geometry::ComputePolygon(closedCorner2ds)};

    bool hasOverlapping{false};
    for (auto intersection{mIntersections.cbegin()};
         intersection != mIntersections.cend();
         ++intersection)
    {
        const auto intersectionArea{
            mIntersectionEvaluator.ComputeArea(
                (*intersection)->GetPolygon(),
                targetPolygon)};
        if (intersectionArea > double{0.0})
        {
            hasOverlapping = true;
            break;
        }
    }

    return hasOverlapping;
}

// protected func.

// private func.

} // namespace rss {
