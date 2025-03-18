#ifndef _MAP_PARKING_SPACE_H_
#define _MAP_PARKING_SPACE_H_

#include <map>
#include <math_type.h>
#include <geometry_convex_hull_2d.h>

namespace map {

class ParkingSpace final
{

public:

    typedef enum class Orientation: int32_t
    {
        Vertical = 0,
        Parallel,
        Oblique,
        Num,
        Null = Num,
    } OrientationType;

    ParkingSpace();
    explicit ParkingSpace(
        const int32_t parkingLotId,
        const int32_t spaceId,
        const int32_t laneId,
        const int32_t pointId,
        const OrientationType &orientationType,
        const std::vector<math::Vector3d_t> &corners);
    ParkingSpace(const ParkingSpace &other);
    ParkingSpace &operator=(const ParkingSpace &other);
    virtual ~ParkingSpace();

    const int32_t GetParkingLotId() const;
    const int32_t GetSpaceId() const;
    const int32_t GetLaneId() const;
    const int32_t GetPointId() const;

    const OrientationType GetOrientationType() const;
    const std::vector<math::Vector3d_t> &GetCorners() const;
    const math::HomoXfm3d_t &GetTransform() const;

protected:

private:

    math::HomoXfm3d_t ComputeTransform(
        const OrientationType &orientationType,
        const std::vector<math::Vector3d_t> &corners,
        std::vector<math::Vector2d_t> *closedCwCorner2ds) const;

    int32_t mParkingLotId;
    int32_t mSpaceId;
    int32_t mLaneId;
    int32_t mPointId;

    OrientationType mOrientationType;
    std::vector<math::Vector3d_t> mCorners;
    math::HomoXfm3d_t mTransform;
    geometry::ConvexHull2d mConvexHull2d;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const ParkingSpace::OrientationType &orientationType)
{
    static const std::map<ParkingSpace::OrientationType, const char *> orientationTypeMap =
    {
        {ParkingSpace::Orientation::Vertical, "ParkingSpace::Orientation::Vertical"},
        {ParkingSpace::Orientation::Parallel, "ParkingSpace::Orientation::Parallel"},
        {ParkingSpace::Orientation::Oblique,  "ParkingSpace::Orientation::Oblique"},
        {ParkingSpace::Orientation::Null,     "ParkingSpace::Orientation::Null"},
    };

    ostream << orientationTypeMap.find(orientationType)->second;
    return ostream;
}

} // namespace map {

#endif // #ifndef _MAP_PARKING_SPACE_H_
