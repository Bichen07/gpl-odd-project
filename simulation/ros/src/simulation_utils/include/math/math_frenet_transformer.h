#ifndef _MATH_FRENET_TRANSFORMER_H_
#define _MATH_FRENET_TRANSFORMER_H_

#include <pcl/point_cloud.h>
#include <pcl/kdtree/kdtree_flann.h>
#include "utils_file_line_num_pair.h"
#include "math_type.h"
#include "math_frenet_coord.h"

namespace math {

class FrenetTransformer final
{

public:

    FrenetTransformer();
    FrenetTransformer(const FrenetTransformer &) = delete;
    FrenetTransformer &operator=(const FrenetTransformer &) = delete;
    virtual ~FrenetTransformer() = default;

    Vector2dColl_t WaypointsXy() const;
    std::vector<FrenetCoord> WaypointsSd() const;

    Vector2d_t WaypointXy(const int32_t idx) const;
    FrenetCoord WaypointSd(const int32_t idx) const;
    Vector2d_t ForwardVector(const int32_t idx) const;

    Vector2d_t ConvertToCartesianCoord(const FrenetCoord &frenet_coord) const;
    Vector2d_t ConvertToCartesianCoord(
        const int32_t input_waypoint_idx,
        const FrenetCoord &frenet_coord
        ) const;
    FrenetCoord ConvertToFrenetCoord(const Vector2d_t &cartesian_coord) const;
    FrenetCoord ConvertToFrenetCoord(
        const int32_t waypoint_idx,
        const Vector2d_t &cartesian_coord
        ) const;

    int32_t ComputeWaypointIdx(const FrenetCoord &frenet_coord) const;

    std::vector<int32_t> ComputeWaypointIdx(
        const FrenetCoord &begin_sd,
        const FrenetCoord &end_sd
        ) const;

    void Configure(
        const Vector2dColl_t &ref_waypoints_xy,
        const std::vector<FrenetCoord> &ref_waypoints_sd,
        const utils::FileLineNumPair &file_line_num_pair = utils::FileLineNumPair()
        );
    void Configure(
        const Vector2dColl_t &ref_waypoints_xy,
        const utils::FileLineNumPair &file_line_num_pair = utils::FileLineNumPair()
        );

    bool IsEmpty() const;
    bool IsLastWaypointIdx(const int32_t input_waypoint_idx) const;

protected:

private:

    bool IsValidIdxFrenetCoordPair(const int32_t waypoint_idx, const FrenetCoord &frenet_coord) const;

    std::unique_ptr<Vector2dColl_t> ref_waypoints_xy_;
    std::unique_ptr<std::vector<FrenetCoord>> ref_waypoints_sd_;
    std::unique_ptr<Vector2dColl_t> ref_forward_vectors_xy_;
    pcl::KdTreeFLANN<pcl::PointXYZ>::Ptr kd_tree_;

    math::HomoXfm2d_t begin_point_pose_;
    math::HomoXfm2d_t end_point_pose_;
};

} // namespace math {

#endif // #ifndef _MATH_FRENET_TRANSFORMER_H_
