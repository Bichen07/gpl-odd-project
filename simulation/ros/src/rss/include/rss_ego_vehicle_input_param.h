#ifndef _RSS_EGO_VEHICLE_INPUT_PARAM_H_
#define _RSS_EGO_VEHICLE_INPUT_PARAM_H_

#include <string>
#include <geometry_vector_3d.h>
#include <geometry_transform_3d.h>

namespace rss {

struct EgoVehicleInputParam final
{
    std::string id;
    geometry::Transform3d transform;
    geometry::Vector3d linearVelocity;
    geometry::Vector3d angularVelocity;
    geometry::Vector3d linearAcceleration;
    geometry::Vector3d angularAcceleration;
    geometry::Vector3d size;
    geometry::Vector3d target;
    double speed;
    double yawRate;
    double steeringAngle;
    double speedCmd;
    double steerCmd;
    double accelerationCmd;

    EgoVehicleInputParam()
        : id{}
        , transform{}
        , linearVelocity{}
        , angularVelocity{}
        , linearAcceleration{}
        , angularAcceleration{}
        , size{}
        , target{}
        , speed{0.0}
        , yawRate{0.0}
        , steeringAngle{0.0}
        , speedCmd{0.0}
        , steerCmd{0.0}
        , accelerationCmd{0.0}
    {
    }
    EgoVehicleInputParam(
        const std::string &inputId,
        const geometry::Transform3d &inputTransform,
        const geometry::Vector3d &inputLinearVelocity,
        const geometry::Vector3d &inputAngularVelocity,
        const geometry::Vector3d &inputLinearAcceleration,
        const geometry::Vector3d &inputAngularAcceleartion,
        const geometry::Vector3d &inputSize,
        const geometry::Vector3d &inputTarget,
        const double inputSpeed,
        const double inputYawRate,
        const double inputSteeringAngle,
        const double inputSpeedCmd,
        const double inputSteerCmd,
        const double inputAccelerationCmd)
        : id{inputId}
        , transform{inputTransform}
        , linearVelocity{inputLinearVelocity}
        , angularVelocity{inputAngularVelocity}
        , linearAcceleration{inputLinearAcceleration}
        , angularAcceleration{inputAngularAcceleartion}
        , size{inputSize}
        , target{inputTarget}
        , speed{inputSpeed}
        , yawRate{inputYawRate}
        , steeringAngle{inputSteeringAngle}
        , speedCmd{inputSpeedCmd}
        , steerCmd{inputSteerCmd}
        , accelerationCmd{inputAccelerationCmd}
    {
    }
    EgoVehicleInputParam(const EgoVehicleInputParam &) = default;
    EgoVehicleInputParam &operator=(const EgoVehicleInputParam &) = default;
    ~EgoVehicleInputParam() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const EgoVehicleInputParam &egoVehicleInputParam)
{
    ostream << "[EgoVehicleInputParam]" << '\n' <<
        "stransform" << '\n' <<
        egoVehicleInputParam.transform << '\n' <<
        "linearVelocity: " << egoVehicleInputParam.linearVelocity.transpose() << '\n' <<
        "angularVelocity: " << egoVehicleInputParam.angularVelocity.transpose() << '\n' <<
        "linearAcceleration: " << egoVehicleInputParam.linearAcceleration.transpose() << '\n' <<
        "angularAcceleration: " << egoVehicleInputParam.angularAcceleration.transpose() << '\n' <<
        "size: " << egoVehicleInputParam.size.transpose() << '\n' <<
        "target: " << egoVehicleInputParam.target.transpose() << '\n' <<
        "speed: " << egoVehicleInputParam.speed << '\n' <<
        "yawRate: " << egoVehicleInputParam.yawRate << '\n' <<
        "steeringAngle: " << egoVehicleInputParam.steeringAngle << '\n' <<
        "speedCmd: " << egoVehicleInputParam.speedCmd << '\n' <<
        "steerCmd: " << egoVehicleInputParam.steerCmd << '\n' <<
        "acceleartionCmd: " << egoVehicleInputParam.accelerationCmd;
    return ostream;
}

} // namespace rss {

#endif // #ifndef _RSS_EGO_VEHICLE_INPUT_PARAM_H_
