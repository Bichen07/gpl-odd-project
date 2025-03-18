#include <algorithm>
#include <car.h>
#include <ros/console.h>

static const float ALMOST_STOP_SPEED = 0.1f;
static const std::string DEFAULT_ID = "object_car";
static const float GEAR_ROTIO = 19.0f;
static const float GRAVITY = 9.81f;
static const float HALF = 0.5f;
static const float KPH_RATIO = 3.6f;
static const float LONGITUDINAL_DAMPING = 0.03f;
static const float PI_IN_DEGREE = 180.0f;
static const float RESTITUTION_COEFFICIENT = 0.05f;
static const float ROAD_FRICTION_COEFFICIENT = 0.8f;
static const float SMALL_SPEED = 1.0f;
static const float SPEED_CONTROL_GAIN = 10000.0f;
static const float TIRE_COEFFICIRNT_CURVATURE = 0.97f;
static const float TIRE_COEFFICIRNT_SHAPE = 1.9f;

static float inline Clamp(
    const float value, const float bottom, const float top)
{
    return std::max(std::min(value, top), bottom);
}

static inline float GetDegreeToRadian(const float degree)
{
    return degree / PI_IN_DEGREE * M_PI;
}

static inline float GetRadianToDegree(const float radian)
{
    return radian * PI_IN_DEGREE / M_PI;
}

static inline b2Vec2 AngularTransform(
    const b2Vec2 & sourceVec2, const float angle)
{
    b2Vec2 transformVec2;
    transformVec2.x =
        sourceVec2.x * std::cos(angle) + sourceVec2.y * std::sin(angle);
    transformVec2.y =
        -sourceVec2.x * std::sin(angle) + sourceVec2.y * std::cos(angle);
    return transformVec2;
}

static inline b2Vec2 LinearTransform(
    const b2Vec2 & sourceVec2, const b2Vec2 & value)
{
    return sourceVec2 + value;
}

static inline float TireForceModel(
    const float slipAngle, const float normalForce, const float tireStiffness)
{
    // https://en.wikipedia.org/wiki/Hans_B._Pacejka
    const float coefficientForce = slipAngle * tireStiffness /
        normalForce / TIRE_COEFFICIRNT_SHAPE;

    return normalForce * std::sin(TIRE_COEFFICIRNT_SHAPE * std::atan2(
        coefficientForce - TIRE_COEFFICIRNT_CURVATURE * (
            coefficientForce - std::atan2(coefficientForce, 1.0f)), 1.0f));
}

static inline float GetSupplementaryAngle(const float angle)
{
    if (angle > M_PI_2)
    {
        return M_PI - angle;
    }
    else if (angle < -M_PI_2)
    {
        return -M_PI - angle;
    }
    else
    {
        return angle;
    }
}

static inline float GetPrincipleAngleMinusPi(const float angle)
{
    return std::atan2(std::sin(angle), std::cos(angle));
}


Car::Car(const Json::Value & parameters, b2World & world, int16 groupIndex)
    : Vehicle(parameters, world, groupIndex)
{
}

Car::~Car()
{
    ROS_INFO_STREAM("Destroy " << mId);
    mCarBody->GetWorld()->DestroyBody(mCarBody);
}

void Car::SetControlCommand(const float steering, const float speed)
{
    Vehicle::SetControlCommand(steering, speed);
}

void Car::SetSteeringCommand(const float steering)
{
    Vehicle::SetSteeringCommand(steering);
}

void Car::SetZeroThrust(const bool set)
{
    Vehicle::SetZeroThrust(set);
}

CarStatus Car::GetStatus()
{
    return Vehicle::GetStatus();
}

void Car::SetStatus(const CarStatus & status)
{
    Vehicle::SetStatus(status);
}

std::vector<b2Vec2> Car::GetShape()
{
    Vehicle::GetShape();
}

void Car::StepOnce()
{
    Vehicle::StepOnce();
}

void Car::LongitudinalDynamic(const b2Vec2 & carVelocity)
{
    Vehicle::LongitudinalDynamic(carVelocity);
}

void Car::LateralDynamic(const b2Vec2 & carVelocity)
{
    Vehicle::LateralDynamic(carVelocity);
}
