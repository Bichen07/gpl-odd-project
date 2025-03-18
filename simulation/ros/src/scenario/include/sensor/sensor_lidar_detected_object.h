#ifndef _SENSOR_LIDAR_DETECTED_OBJECT_H_
#define _SENSOR_LIDAR_DETECTED_OBJECT_H_

#include <memory>
#include <geometry_convex_hull_2d.h>
#include <geometry_polygonal_column.h>
#include <motion_state.h>
#include <sensor_lidar_detected_object_config.h>

namespace sensor {

class LidarDetectedObject final
{

public:

    using Ptr = std::shared_ptr<LidarDetectedObject>;

    LidarDetectedObject();
    LidarDetectedObject(const LidarDetectedObject &other) = delete;
    LidarDetectedObject &operator=(const LidarDetectedObject &other) = delete;
    virtual ~LidarDetectedObject();

    std::string GetId() const;
    const geometry::PolygonalColumn &GetBoundingPolygonalColumn() const;
    const motion::State &GetState() const;
    const math::Vector3d_t &GetSize() const;
    const actor::ObjectClassId &GetObjectClassId() const;

    void Update(const LidarDetectedObjectConfig &config);

protected:

private:

    math::Vector3d_t ComputeSize(
        const math::HomoXfm3d_t &agentTransform3d,
        const std::vector<math::Vector3d_t> &worldTopPolygonCorners,
        const math::real_t agentSizeZ) const;

    LidarDetectedObjectConfig mConfig;
    geometry::PolygonalColumn mBoundingPolygonalColumn;
    motion::State mState;
    math::Vector3d_t mSize;
};

} // namespace sensor {

#endif // #ifndef _SENSOR_LIDAR_DETECTED_OBJECT_H_
