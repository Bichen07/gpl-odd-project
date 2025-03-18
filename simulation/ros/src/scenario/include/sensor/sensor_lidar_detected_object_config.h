#ifndef _SENSOR_LIDAR_DETECTED_OBJECT_CONFIG_H_
#define _SENSOR_LIDAR_DETECTED_OBJECT_CONFIG_H_

#include <geometry_convex_hull_2d.h>
#include <actor_object_class_id.h>

namespace sensor {

struct LidarDetectedObjectConfig
{
    geometry::ConvexHull2d boundingConvexHull;
    math::HomoXfm3d_t agentTransform;
    motion::State agentState;
    math::Vector3d_t agentSize;
    actor::ObjectClassId objectClassId;

    LidarDetectedObjectConfig()
        : boundingConvexHull{}
        , agentTransform{}
        , agentState{}
        , agentSize{}
        , objectClassId{actor::ObjectClass::Null}
    {
    }
    LidarDetectedObjectConfig(
        const geometry::ConvexHull2d &inputBoundingConvexHull,
        const math::HomoXfm3d_t &inputAgentTransform,
        const motion::State &inputAgentState,
        const math::Vector3d_t &inputAgentSize,
        const actor::ObjectClassId &inputObjectClassId)
        : boundingConvexHull{inputBoundingConvexHull}
        , agentTransform{inputAgentTransform}
        , agentState{inputAgentState}
        , agentSize{inputAgentSize}
        , objectClassId{inputObjectClassId}
    {
    }
    LidarDetectedObjectConfig(const LidarDetectedObjectConfig &other) = default;
    LidarDetectedObjectConfig &operator=(const LidarDetectedObjectConfig &other) = default;
    ~LidarDetectedObjectConfig() = default;
};

} // namespace sensor {

#endif // #ifndef _SENSOR_LIDAR_DETECTED_OBJECT_CONFIG_H_
