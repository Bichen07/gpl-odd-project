#include <motion_spatial_relation_id.h>
#include <cctype>
#include <algorithm>
#include <stdexcept>
#include <ros/console.h>

namespace motion {

SpatialRelationId ToSpatialRelationId(const std::string &key)
{
    std::string lowercaseKey{key};
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char input)
        {return std::tolower(input);});

    static const std::map<std::string, SpatialRelationId> spatialRelationIdMap =
    {
        {
            ToSpatialRelationLabel(SpatialRelation::BehindEgoVehicle),
            SpatialRelation::BehindEgoVehicle
        },
        {
            ToSpatialRelationLabel(SpatialRelation::AheadOfEgoVehicle),
            SpatialRelation::AheadOfEgoVehicle,
        },
    };

    const auto foundPair{spatialRelationIdMap.find(lowercaseKey)};
    if (spatialRelationIdMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return SpatialRelation::Null instead");
        return SpatialRelation::Null;
    }

    return foundPair->second;
}

std::string ToSpatialRelationLabel(const SpatialRelationId &spatialRelationId)
{
    static const std::map<SpatialRelationId, const char *> spatialRelationLabelMap =
    {
        {SpatialRelation::BehindEgoVehicle,  "behind_ego_vehicle"},
        {SpatialRelation::AheadOfEgoVehicle, "ahead_of_ego_vehicle"},
    };

    const auto foundPair{spatialRelationLabelMap.find(spatialRelationId)};
    if (spatialRelationLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << spatialRelationId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

} // namespace motion {
