#include <map_traffic_light.h>
#include <ros/console.h>
#include <math_utils.h>

namespace map {

// public func.

TrafficLight::TrafficLight()
    : mId{0}
    , mCorner3ds{}
    , mPose{}
{
}

TrafficLight::TrafficLight(
    const int32_t inputId,
    const std::vector<math::Vector3d_t> &inputCorner3ds)
    : mId{0}
    , mCorner3ds{}
    , mPose{}
{
    this->Configure(
        inputId,
        inputCorner3ds);
}

TrafficLight::TrafficLight(const TrafficLight &other)
    : mId{0}
    , mCorner3ds{}
    , mPose{}
{
    this->Configure(
        other.GetId(),
        other.GetCorner3ds());
}

TrafficLight &TrafficLight::operator=(const TrafficLight &other)
{
    if (&other == this)
    {
        return *this;
    }

    this->Configure(
        other.GetId(),
        other.GetCorner3ds());

    return *this;
}

int32_t TrafficLight::GetId() const
{
    return mId;
}

const std::vector<math::Vector3d_t> &TrafficLight::GetCorner3ds() const
{
    return mCorner3ds;
}

const math::HomoXfm3d_t &TrafficLight::GetPose() const
{
    return mPose;
}

void TrafficLight::Configure(
    const int32_t id,
    const std::vector<math::Vector3d_t> &inputCorner3ds)
{
    if (inputCorner3ds.size() < std::size_t{3})
    {
        ROS_ERROR_STREAM(
            "invalid inputCorner3ds.size: " << inputCorner3ds.size() << '\n' <<
            "the size shall >= 3");
        return;
    }

    mId = id;
    mCorner3ds = inputCorner3ds;
    math::Vector3d_t accumulatedCorner;
    for (auto corner3d{inputCorner3ds.cbegin()};
         corner3d != inputCorner3ds.cend();
         ++corner3d)
    {
        accumulatedCorner += *corner3d;
    }

    const auto centroid3d = accumulatedCorner / static_cast<math::real_t>(inputCorner3ds.size());

    math::Vector3d_t rotmatLocalX;
    math::Vector3d_t rotmatLocalY;
    this->ComputeLocalXyAxes(
        inputCorner3ds,
        rotmatLocalX,
        rotmatLocalY);
    math::RotMat3d_t rotmat{math::RotMat3d_t::Identity()};
    rotmat.col(0) = rotmatLocalX;
    rotmat.col(1) = rotmatLocalY;

    mPose = math::HomoXfm3d_t(rotmat, centroid3d);
}

// protected func.

// private func.

void TrafficLight::ComputeLocalXyAxes(
    const std::vector<math::Vector3d_t> &inputCorner3ds,
    math::Vector3d_t &outputNormalX,
    math::Vector3d_t &outputNormalY) const
{
    auto plane3d{math::Hyperplane3d_t::Through(
            inputCorner3ds[0],
            inputCorner3ds[1],
            inputCorner3ds[2])};
    outputNormalX = plane3d.normal();
    outputNormalY =
        math::AngleAxis_t(math::HalfPi<math::real_t>(), math::Vector3d_t::UnitZ()) *
        outputNormalX;
}

} // namespace map {
