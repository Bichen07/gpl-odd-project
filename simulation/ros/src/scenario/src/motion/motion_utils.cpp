#include <motion_utils.h>
#include <ros/console.h>
#include <map>
#include <math_utils.h>

namespace motion {

math::real_t ConvertToMps(const math::real_t kph)
{
    static constexpr math::real_t kphToMpsCoef{1.0 / 3.6};
    return kphToMpsCoef * kph;
}

math::real_t ConvertToKph(const math::real_t mps)
{
    static constexpr math::real_t mpsToKphCoef{3.6};
    return mpsToKphCoef * mps;
}

math::real_t ComputeLongitudinalSpeed(
    const math::real_t resultantSpeed,
    const math::real_t lateralSpeed)
{
    if (std::fabs(resultantSpeed) < std::fabs(lateralSpeed))
    {
        ROS_ERROR_STREAM(
            "resultantSpeed < lateralSpeed" << '\n' <<
            "resultantSpeed: " << resultantSpeed << '\n' <<
            "lateralSpeed: " << lateralSpeed);
        return 0.0;
    }

    return sqrt(math::Square(resultantSpeed) - math::Square(lateralSpeed));
}

ComingDirectionId QueryComingDirectionId(const std::string &key)
{
    static const std::map<std::string, motion::ComingDirectionId> comingDirectionMap =
    {
        {"oncoming_side", motion::ComingDirection::OncomingSide},
        {"OncomingSide",  motion::ComingDirection::OncomingSide},
        {"left_side",     motion::ComingDirection::LeftSide},
        {"LeftSide",      motion::ComingDirection::LeftSide},
        {"right_side",    motion::ComingDirection::RightSide},
        {"RightSide",     motion::ComingDirection::RightSide},
    };

    const auto foundComingDirection = comingDirectionMap.find(key);
    if (comingDirectionMap.end() == foundComingDirection)
    {
        ROS_ERROR_STREAM("invalid key: " << key);
        return motion::ComingDirection::Null;
    }

    return foundComingDirection->second;
}

math::HomoXfm2d_t ComputeTransform2d(const motion::State &state)
{
    if (math::IsApprox(math::Quaternion_t::Identity(), state.orientation, 1.0e-6))
    {
        return math::HomoXfm2d_t();
    }

    const math::AngleAxis_t angleAxis(state.orientation);

    math::RotMat2d_t rotmat(math::RotMat2d_t::Identity());
    if (math::IsApprox(math::Vector3d_t::UnitZ(), angleAxis.axis(), math::real_t{1.0e-6}))
    {
        rotmat = Eigen::Rotation2D<math::real_t>(angleAxis.angle()).toRotationMatrix();
    }
    else if (math::IsApprox(-math::Vector3d_t::UnitZ(), angleAxis.axis(), math::real_t{1.0e-6}))
    {
        rotmat = Eigen::Rotation2D<math::real_t>(-angleAxis.angle()).toRotationMatrix();
    }
    else
    {
        ROS_ERROR_STREAM("wrong axis: " << angleAxis.axis().transpose());

        if (angleAxis.axis().z() > 0.0)
        {
            rotmat = Eigen::Rotation2D<math::real_t>(angleAxis.angle()).toRotationMatrix();
        }
        else
        {
            rotmat = Eigen::Rotation2D<math::real_t>(-angleAxis.angle()).toRotationMatrix();
        }
    }

    return math::HomoXfm2d_t(
        rotmat,
        math::Vector2d_t(state.position.x(), state.position.y()));
}

math::FrenetCoord ComputeFrenetVelocity(
    const math::Vector3d_t &worldLinearVelocity3d,
    const math::HomoXfm2d_t &localToWorldTransform2d)
{
    const math::Vector2d_t worldLinearVelocity2d(
        worldLinearVelocity3d.x(),
        worldLinearVelocity3d.y());
    const math::Vector2d_t localVelocity2d =
        localToWorldTransform2d.linear().transpose() *
        worldLinearVelocity2d;

    return math::FrenetCoord(localVelocity2d.x(), localVelocity2d.y());
}

State ComputeUpdatedState(
    const math::real_t timeStep,
    const State &lastState,
    const math::Vector3d_t &updatedPosition)
{
    if (math::IsApproxZero(timeStep, 1.0e-6))
    {
        return lastState;
    }

    const auto forwardVector = updatedPosition - lastState.position;
    if (math::IsApproxZero(forwardVector, 1.0e-6))
    {
        //ROS_WARN_STREAM("forwardVector is zero: " << forwardVector.transpose());
        return State(
            lastState.position,
            lastState.orientation,
            math::Vector3d_t::Zero(),
            math::Vector3d_t::Zero());
    }

    auto headingRadian = atan2(forwardVector.y(), forwardVector.x());
    //const math::real_t lastHeadingRadian =
    //    math::ToEulerAngleXyz(
    //        lastState.orientation.matrix()).z();
    //if (std::fabs(headingRadian- lastHeadingRadian) > double{0.05})
    //{
    //    headingRadian = lastHeadingRadian;
    //}

    const auto updatedOrientation = math::Quaternion_t(
        math::AngleAxis_t(headingRadian, math::Vector3d_t::UnitZ()));
    const auto updatedLinearVelocity = forwardVector / timeStep;

    math::Vector2d_t lastVel(
        lastState.linearVelocity.x(),
        lastState.linearVelocity.y());
    if (math::IsApproxZero(lastVel, math::real_t{1.0e-5}))
    {
        lastVel = math::Vector2d_t(
            updatedLinearVelocity.x(),
            updatedLinearVelocity.y());
    }

    const math::Vector2d_t currentVel(
        forwardVector.x(),
        forwardVector.y());
    const auto rotationalRadian{
        math::ComputeRotationalAngle(
            lastVel,
            currentVel)};
    const auto updatedAngularVelocity = math::Vector3d_t(
        math::real_t{0.0},
        math::real_t{0.0},
        rotationalRadian / timeStep);

    return State(
        updatedPosition,
        updatedOrientation,
        updatedLinearVelocity,
        updatedAngularVelocity);
}

std::vector<math::Vector3d_t> ExtendWaypoints(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const math::real_t beginExtendedDistance,
    const math::real_t endExtendedDistance)
{
    if (inputWaypoints.empty())
    {
        ROS_WARN_STREAM("empty inputWaypoints");
        return inputWaypoints;
    }

    std::vector<math::Vector3d_t> outputWaypoints;
    outputWaypoints.reserve(inputWaypoints.size() + 2ul);

    if (beginExtendedDistance > math::real_t{0.0})
    {
        const auto beginExtendedVector = (inputWaypoints.at(0) - inputWaypoints.at(1)).normalized();
        const auto beginExtendedWaypoint =
            inputWaypoints.front() +
            beginExtendedVector * beginExtendedDistance;
        outputWaypoints.push_back(beginExtendedWaypoint);
    }

    outputWaypoints.insert(
        outputWaypoints.cend(),
        inputWaypoints.cbegin(),
        inputWaypoints.cend());

    if (endExtendedDistance > math::real_t{0.0})
    {
        const auto endExtendedVector =
            (inputWaypoints.at(inputWaypoints.size() - 1ul) -
             inputWaypoints.at(inputWaypoints.size() - 2ul)).normalized();
        const auto endExtendedWaypoint =
            inputWaypoints.back() +
            endExtendedVector * endExtendedDistance;
        outputWaypoints.push_back(endExtendedWaypoint);
    }

    return outputWaypoints;
}

std::vector<math::Vector3d_t> ExtendWaypoints(
    const std::vector<math::Vector3d_t> &inputWaypoints,
    const math::real_t beginExtendedDistance,
    const math::real_t beginExtendedRadian,
    const math::real_t endExtendedDistance,
    const math::real_t endExtendedRadian)
{
    if (inputWaypoints.empty())
    {
        ROS_WARN_STREAM("empty inputWaypoints");
        return inputWaypoints;
    }

    std::vector<math::Vector3d_t> outputWaypoints;
    outputWaypoints.reserve(inputWaypoints.size() + 2ul);

    if (beginExtendedDistance > math::real_t{0.0})
    {
        const auto beginExtendedRotMat{
            math::ToRotMat(
                math::AngleAxis_t(beginExtendedRadian, math::Vector3d_t::UnitZ()))};
        const auto beginExtendedVector =
            (inputWaypoints.at(0) - inputWaypoints.at(1)).normalized();
        const auto beginExtendedWaypoint =
            inputWaypoints.front() +
            beginExtendedRotMat * beginExtendedVector * beginExtendedDistance;
        outputWaypoints.push_back(beginExtendedWaypoint);
    }

    outputWaypoints.insert(
        outputWaypoints.cend(),
        inputWaypoints.cbegin(),
        inputWaypoints.cend());

    if (endExtendedDistance > math::real_t{0.0})
    {
        const auto endExtendedRotMat{
            math::ToRotMat(math::AngleAxis_t(endExtendedRadian, math::Vector3d_t::UnitZ()))};
        //ROS_INFO_STREAM("endExtendedRotMat: " << endExtendedRotMat);
        const auto endExtendedVector =
            (inputWaypoints.at(inputWaypoints.size() - 1ul) -
             inputWaypoints.at(inputWaypoints.size() - 2ul)).normalized();
        //ROS_INFO_STREAM("endExtendedVector: " << endExtendedVector.transpose());
        //ROS_INFO_STREAM("rotated vector: " << endExtendedRotMat * endExtendedVector);
        const auto endExtendedWaypoint =
            inputWaypoints.back() +
            endExtendedRotMat * endExtendedVector * endExtendedDistance;
        outputWaypoints.push_back(endExtendedWaypoint);
    }

    return outputWaypoints;
}

math::Vector3d_t ComputeLinearAcceleration(const State &state)
{
    const math::RotMat3d_t rotmat{state.orientation.toRotationMatrix()};
    return rotmat.col(0) * state.longitudinalAcceleration +
        rotmat.col(1) * state.lateralAcceleration;
}

} // namespace motion {
