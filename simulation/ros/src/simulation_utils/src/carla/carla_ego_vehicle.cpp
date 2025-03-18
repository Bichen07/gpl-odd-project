#include <carla_ego_vehicle.h>

namespace carla {

// public func.

EgoVehicle::EgoVehicle(const Json::Value &parameters, b2World &world)
    : Vehicle(parameters, world, true)
    , mFeedbackEstimator{}
{
}

EgoVehicle::~EgoVehicle()
{
}

void EgoVehicle::SetStatus(const CarStatus &carStatus)
{
}

void EgoVehicle::SetControlCommand(const float steering, const float speed)
{
}

void EgoVehicle::SetSteeringCommand(const float steering)
{
}

void EgoVehicle::SetZeroThrust(const bool set)
{
}

CarStatus EgoVehicle::GetStatus()
{
    CarStatus outputCarStatus{Vehicle::GetStatus()};
    outputCarStatus.position = b2Vec2(
        mFeedbackEstimator.GetState2d().position.x(),
        mFeedbackEstimator.GetState2d().position.y());
    outputCarStatus.orientation = mFeedbackEstimator.GetState2d().orientation;
    outputCarStatus.velocity = b2Vec2(
        mFeedbackEstimator.GetState2d().velocity.x(),
        mFeedbackEstimator.GetState2d().velocity.y());
    outputCarStatus.yawRate = mFeedbackEstimator.GetState2d().yawRate;
    outputCarStatus.dimensions = mDimensions;

    return outputCarStatus;
}

void EgoVehicle::StepOnce()
{
}

// protected func.

// private func.

} // namespace carla {
