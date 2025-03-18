#include "math_frenet_transformer.h"
#include <stdexcept>
#include <ros/console.h>
#include <utils_empty_container_exception.h>
#include "math_utils.h"

namespace math {

// public func.

FrenetTransformer::FrenetTransformer()
    :ref_waypoints_xy_(new Vector2dColl_t),
    ref_waypoints_sd_(new std::vector<FrenetCoord>),
    ref_forward_vectors_xy_(new Vector2dColl_t),
    kd_tree_(new pcl::KdTreeFLANN<pcl::PointXYZ>),

    begin_point_pose_{},
    end_point_pose_{}
{
}

Vector2dColl_t FrenetTransformer::WaypointsXy() const
{
    return *ref_waypoints_xy_;
}

std::vector<FrenetCoord> FrenetTransformer::WaypointsSd() const
{
    return *ref_waypoints_sd_;
}

Vector2d_t FrenetTransformer::WaypointXy(const int32_t idx) const
{
    return ref_waypoints_xy_->at(idx);
}

FrenetCoord FrenetTransformer::WaypointSd(const int32_t idx) const
{
    return ref_waypoints_sd_->at(idx);
}

Vector2d_t FrenetTransformer::ForwardVector(const int32_t waypoint_idx) const
{
    if (waypoint_idx >= static_cast<int32_t>(ref_waypoints_xy_->size() - 2ul))
    {
        ref_forward_vectors_xy_->back();
    }

    return ref_forward_vectors_xy_->at(waypoint_idx);
}


Vector2d_t FrenetTransformer::ConvertToCartesianCoord(const FrenetCoord &frenet_coord) const
{
    const int32_t previous_point_idx{this->ComputeWaypointIdx(frenet_coord)};
    return this->ConvertToCartesianCoord(
        previous_point_idx,
        frenet_coord
        );
}

Vector2d_t FrenetTransformer::ConvertToCartesianCoord(
    const int32_t input_waypoint_idx,
    const FrenetCoord &frenet_coord
    ) const
{
    int32_t waypoint_idx = input_waypoint_idx;
    if (!this->IsValidIdxFrenetCoordPair(waypoint_idx, frenet_coord))
    {
        waypoint_idx = this->ComputeWaypointIdx(frenet_coord);
    }

    if (this->IsLastWaypointIdx(waypoint_idx))
    {
        const math::Vector2d_t lateral_vector =
            Eigen::Rotation2D<real_t>(math::HalfPi<real_t>()).toRotationMatrix() *
            ref_forward_vectors_xy_->back();
        return ref_waypoints_xy_->back() +
            ref_forward_vectors_xy_->back() * (frenet_coord.s() - ref_waypoints_sd_->back().s()) +
            lateral_vector * frenet_coord.d();
    }

    const Vector2d_t segment_vector =
        (ref_waypoints_xy_->at(waypoint_idx + 1) - ref_waypoints_xy_->at(waypoint_idx)).normalized();
    const FrenetCoord local_frenet_coord(
        frenet_coord.s() - ref_waypoints_sd_->at(waypoint_idx).s(),
        frenet_coord.d()
        );
    const real_t offset_angle = std::atan2(local_frenet_coord.d(), local_frenet_coord.s());
    const RotMat2d_t offset_rotmat = math::ComputeRotMat2d(offset_angle);

    const real_t local_length = std::hypot(local_frenet_coord.s(), local_frenet_coord.d());
    const Vector2d_t local_vector = offset_rotmat * segment_vector;

    const Vector2d_t offset_vector =
        Eigen::Rotation2D<real_t>(math::HalfPi<real_t>()).toRotationMatrix() *
        segment_vector;
 
    const Vector2d_t output1st = ref_waypoints_xy_->at(waypoint_idx) + local_vector * local_length;
    const Vector2d_t output2nd = ref_waypoints_xy_->at(waypoint_idx) +
        segment_vector * local_frenet_coord.s() +
        offset_vector * local_frenet_coord.d();

    if (!math::IsApprox(output1st, output2nd, 1.0e-6))
    {
        ROS_INFO_STREAM(
            "diff coordinate" << '\n' <<
            "1st: " << output1st.transpose() << '\n' <<
            "2nd: " << output2nd.transpose());
    }

    return ref_waypoints_xy_->at(waypoint_idx) +
        segment_vector * local_frenet_coord.s() +
        offset_vector * local_frenet_coord.d();
}

FrenetCoord FrenetTransformer::ConvertToFrenetCoord(const math::Vector2d_t &cartesian_coord) const
{
    const pcl::PointXYZ target_point(
        cartesian_coord.x(),
        cartesian_coord.y(),
        real_t{0.0}
        );
    std::vector<int32_t> resultant_indices;
    std::vector<float> resultant_squared_distances;
    kd_tree_->radiusSearch(
        target_point,
        10.0,
        resultant_indices,
        resultant_squared_distances
        );

    if (resultant_indices.empty())
    {
        resultant_indices.resize(1);
        resultant_squared_distances.resize(1);
        kd_tree_->nearestKSearch(
            target_point,
            1,
            resultant_indices,
            resultant_squared_distances
            );
    }

    const int32_t cloest_idx = resultant_indices.front();
    if (static_cast<int32_t>(ref_waypoints_xy_->size() - 1ul) == cloest_idx)
    {
        const auto local_coord = end_point_pose_.inverse() * cartesian_coord;
        return math::FrenetCoord(
            local_coord.x() + ref_waypoints_sd_->back().s(),
            local_coord.y() + ref_waypoints_sd_->back().d());
    }
    if (0 == cloest_idx)
    {
        const auto local_coord = begin_point_pose_.inverse() * cartesian_coord;
        return math::FrenetCoord(local_coord.x(), local_coord.y());
    }

    ParametrizedLine2d_t previous_line(
        ref_waypoints_xy_->at(cloest_idx - 1),
        ref_waypoints_xy_->at(cloest_idx)
        );
    ParametrizedLine2d_t current_line(
        ref_waypoints_xy_->at(cloest_idx),
        ref_waypoints_xy_->at(cloest_idx + 1)
        );
    const real_t distance_to_previous_line = previous_line.distance(ref_waypoints_xy_->at(cloest_idx));
    const real_t distance_to_current_line = current_line.distance(ref_waypoints_xy_->at(cloest_idx));

    const int32_t waypoint_idx =
        distance_to_previous_line > distance_to_current_line ? cloest_idx - 1 : cloest_idx;

    return this->ConvertToFrenetCoord(waypoint_idx, cartesian_coord);
}

math::FrenetCoord FrenetTransformer::ConvertToFrenetCoord(
    const int32_t waypoint_idx,
    const Vector2d_t &cartesian_coord
    ) const
{
    int32_t inner_idx{waypoint_idx};
    if (static_cast<int32_t>(ref_waypoints_xy_->size() - 1ul) == waypoint_idx)
    {
        inner_idx = static_cast<int32_t>(ref_waypoints_xy_->size() - 2ul);
    }
    const Vector2d_t segment_vector =
        ref_waypoints_xy_->at(inner_idx + 1) -
        ref_waypoints_xy_->at(inner_idx);
    const ParametrizedLine2d_t segment_line = ParametrizedLine2d_t::Through(
        ref_waypoints_xy_->at(inner_idx),
        ref_waypoints_xy_->at(inner_idx + 1)
        );
    const Vector2d_t projected_cartesian_coord = segment_line.projection(cartesian_coord);
    const real_t local_length = (projected_cartesian_coord - ref_waypoints_xy_->at(inner_idx)).norm();

    const math::Vector2d_t lateral_vector = cartesian_coord - projected_cartesian_coord;
    const real_t segment_lateral_cross = math::ComputeCross(segment_vector, lateral_vector);
    const real_t distance = segment_line.distance(cartesian_coord);
    const real_t lateral_distance = segment_lateral_cross > 0.0 ? distance : -distance;

    return FrenetCoord(
        local_length + ref_waypoints_sd_->at(inner_idx).s(),
        lateral_distance);
}

int32_t FrenetTransformer::ComputeWaypointIdx(const FrenetCoord &frenet_coord) const
{
    if (frenet_coord.s() < math::real_t{0.0})
    {
        return int32_t{0};
    }

    if (frenet_coord.s() > ref_waypoints_sd_->back().s())
    {
        return static_cast<int32_t>(ref_waypoints_sd_->size() - 1ul);
    }

    const auto next_point_iterator = std::upper_bound(
        ref_waypoints_sd_->begin(),
        ref_waypoints_sd_->end(),
        frenet_coord,
        [](const FrenetCoord &first, const FrenetCoord &second)
        {return first.s() < second.s();}
        );
    if (ref_waypoints_sd_->end() == next_point_iterator)
    {
        return static_cast<int32_t>(ref_waypoints_sd_->size() - 1ul);
    }

    const int32_t next_point_idx = std::distance(
        ref_waypoints_sd_->begin(),
        next_point_iterator
        );
    const int32_t output_waypoint_idx = next_point_idx - int32_t{1};

    if (frenet_coord.s() < ref_waypoints_sd_->at(output_waypoint_idx).s())
    {
        ROS_INFO_STREAM(
            "output_waypoint_idx: " << output_waypoint_idx <<
            ", frenet_coord.s(): " << frenet_coord.s() <<
            ", ref_path_d: " << ref_waypoints_sd_->at(output_waypoint_idx)
            );
    }

    return output_waypoint_idx;
}

std::vector<int32_t> FrenetTransformer::ComputeWaypointIdx(
    const FrenetCoord &begin_sd,
    const FrenetCoord &end_sd
    ) const
{
    if (end_sd.s() < begin_sd.s())
    {
        return std::vector<int32_t>();
    }

    const int32_t begin_idx = this->ComputeWaypointIdx(begin_sd);
    const int32_t end_idx = this->ComputeWaypointIdx(end_sd);
    const int32_t size = end_idx - begin_idx + int32_t{1};

    std::vector<int32_t> output_idx_coll(size);
    for (int32_t count = 0; count < size; ++count)
    {
        output_idx_coll[count] = begin_idx + count;
    }

    return output_idx_coll;
}

void FrenetTransformer::Configure(
    const Vector2dColl_t &ref_waypoints_xy,
    const std::vector<FrenetCoord> &ref_waypoints_sd,
    const utils::FileLineNumPair &file_line_num_pair
    )
{
    if (ref_waypoints_xy.empty())
    {
        std::string errorMessage("ref_waypoints_xy is empty");
        utils::AppendFileLineNumMessage(
            file_line_num_pair,
            errorMessage,
            utils::FileLineNumPairInstance());
        ROS_ERROR_STREAM(errorMessage.c_str());
        throw utils::EmptyContainerException(__FILE__": " + std::to_string(__LINE__));
    }

    *ref_waypoints_xy_ = ref_waypoints_xy;
    *ref_waypoints_sd_ = ref_waypoints_sd;

    if (ref_forward_vectors_xy_->empty())
    {
        ref_forward_vectors_xy_->resize(ref_waypoints_xy_->size());
        auto ref_waypoint{ref_waypoints_xy_->begin()};
        auto ref_forward_vector{ref_forward_vectors_xy_->begin()};
        ++ref_waypoint;
        while (ref_waypoint != ref_waypoints_xy_->end())
        {
            *ref_forward_vector = (*ref_waypoint - *(ref_waypoint - 1)).normalized();
            ++ref_waypoint;
            ++ref_forward_vector;
        }
        ref_forward_vectors_xy_->back() = ref_forward_vectors_xy_->at(
            ref_forward_vectors_xy_->size() - 2ul
            );
    }

    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);
    cloud->height = 1;
    cloud->points.resize(ref_waypoints_xy_->size());

    std::transform(
        ref_waypoints_xy_->begin(),
        ref_waypoints_xy_->end(),
        cloud->points.begin(),
        [](const math::Vector2d_t &path_point)
        {return pcl::PointXYZ(path_point.x(), path_point.y(), math::real_t{0.0});}
        );
    cloud->width = cloud->points.size();

    kd_tree_->setInputCloud(cloud);

    const auto begin_heading_radian = std::atan2(
        ref_forward_vectors_xy_->front().y(), ref_forward_vectors_xy_->front().x());
    begin_point_pose_ = math::HomoXfm2d_t(
        Eigen::Rotation2D<real_t>(begin_heading_radian).toRotationMatrix(),
        ref_waypoints_xy_->front());

    const auto end_heading_radian = std::atan2(
        ref_forward_vectors_xy_->back().y(), ref_forward_vectors_xy_->back().x());
    end_point_pose_ = math::HomoXfm2d_t(
        Eigen::Rotation2D<real_t>(end_heading_radian).toRotationMatrix(),
        ref_waypoints_xy_->back());
}

void FrenetTransformer::Configure(
    const Vector2dColl_t &ref_waypoints_xy,
    const utils::FileLineNumPair &file_line_num_pair
    )
{
    if (ref_waypoints_xy.empty())
    {
        std::string errorMessage("ref_waypoints_xy is empty");
        utils::AppendFileLineNumMessage(
            file_line_num_pair,
            errorMessage,
            utils::FileLineNumPairInstance());
        ROS_ERROR_STREAM(errorMessage.c_str());
        throw utils::EmptyContainerException(__FILE__": " + std::to_string(__LINE__));
    }

    *ref_waypoints_xy_ = ref_waypoints_xy;
    ref_waypoints_sd_->resize(ref_waypoints_xy_->size());
    ref_forward_vectors_xy_->resize(ref_waypoints_xy_->size());

    auto ref_xy{ref_waypoints_xy_->begin()};
    auto ref_sd{ref_waypoints_sd_->begin()};
    auto ref_forward_vector{ref_forward_vectors_xy_->begin()};

    *ref_sd = FrenetCoord();

    ++ref_xy;
    ++ref_sd;
    math::real_t accumulated_distance{0.0};

    while (ref_xy != ref_waypoints_xy_->end())
    {
        *ref_forward_vector = *ref_xy - *(ref_xy - 1);
        accumulated_distance += ref_forward_vector->norm();
        ref_sd->set_s(accumulated_distance);
        ref_forward_vector->normalize();

        ++ref_xy;
        ++ref_forward_vector;
        ++ref_sd;
    }

    ref_forward_vectors_xy_->back() = ref_forward_vectors_xy_->at(
        ref_forward_vectors_xy_->size() - 2u
        );
    this->Configure(
        *ref_waypoints_xy_,
        *ref_waypoints_sd_,
        file_line_num_pair
        );
}

bool FrenetTransformer::IsEmpty() const
{
    if (ref_waypoints_xy_->empty())
    {
        return true;
    }

    if (ref_waypoints_sd_->empty())
    {
        return true;
    }

    return false;
}

bool FrenetTransformer::IsLastWaypointIdx(const int32_t input_waypoint_idx) const
{
    if (ref_waypoints_sd_->size() == 0ul)
    {
        return true;
    }

    if (static_cast<int32_t>(ref_waypoints_sd_->size() - 1ul) == input_waypoint_idx)
    {
        return true;
    }

    return false;
}

// protected func.

// private func.

bool FrenetTransformer::IsValidIdxFrenetCoordPair(
    const int32_t waypoint_idx,
    const FrenetCoord &frenet_coord
    ) const
{
    if (waypoint_idx < 0)
    {
        return false;
    }

    if (waypoint_idx >= static_cast<int32_t>(ref_waypoints_sd_->size() - 1ul))
    {
        return false;
    }

    if (frenet_coord.s() < ref_waypoints_sd_->at(waypoint_idx).s())
    {
        return false;
    }

    if (frenet_coord.s() > ref_waypoints_sd_->at(waypoint_idx + 1).s())
    {
        return false;
    }

    return true;
}

} // namespace math {
