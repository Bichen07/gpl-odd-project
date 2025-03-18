#ifndef _MOTION_SPATIAL_RELATION_ID_H_
#define _MOTION_SPATIAL_RELATION_ID_H_

#include <map>
#include <string>
#include <iostream>

namespace motion {

typedef enum class SpatialRelation: int32_t
{
    BehindEgoVehicle = 0,
    AheadOfEgoVehicle,
    Num,
    Null = Num,
} SpatialRelationId;

SpatialRelationId ToSpatialRelationId(const std::string &key);
std::string ToSpatialRelationLabel(const SpatialRelationId &spatialRelationId);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const SpatialRelationId &spatialRelationId)
{
    static const std::map<SpatialRelationId, const char *> spatialRelationMap =
    {
        {SpatialRelation::BehindEgoVehicle,  "SpatialRelation::BehindEgoVehicle"},
        {SpatialRelation::AheadOfEgoVehicle, "SpatialRelation::AheadOfEgoVehicle"},
        {SpatialRelation::Null,              "SpatialRelation::Null"},
    };

    ostream << spatialRelationMap.find(spatialRelationId)->second;
    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_SPATIAL_RELATION_ID_H_
