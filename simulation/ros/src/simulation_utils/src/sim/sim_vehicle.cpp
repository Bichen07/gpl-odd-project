#include <sim_vehicle.h>
#include <algorithm>
// #include <car.h>
#include <ros/console.h>
#include <ros/param.h>

static const float       ALMOST_STOP_SPEED          = 0.1f;
static const std::string DEFAULT_ID                 = "object_car";
static const float       GRAVITY                    = 9.81f;
static const float       HALF                       = 0.5f;
static const float       KPH_RATIO                  = 3.6f;
static const float       LONGITUDINAL_DAMPING       = 0.03f;
static const float       PI_IN_DEGREE               = 180.0f;
static const float       RESTITUTION_COEFFICIENT    = 0.05f;
static const float       ROAD_FRICTION_COEFFICIENT  = 0.8f;
static const float       SMALL_SPEED                = 1.0f;
static const float       SPEED_CONTROL_GAIN         = 10000.0f;
static const float       TIRE_COEFFICIRNT_CURVATURE = 0.97f;
static const float       TIRE_COEFFICIRNT_SHAPE     = 1.9f;

static float inline Clamp(const float value, const float bottom, const float top)
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

static inline b2Vec2 AngularTransform(const b2Vec2& sourceVec2, const float angle)
{
    b2Vec2 transformVec2;
    transformVec2.x = sourceVec2.x * std::cos(angle) + sourceVec2.y * std::sin(angle);
    transformVec2.y = -sourceVec2.x * std::sin(angle) + sourceVec2.y * std::cos(angle);
    return transformVec2;
}

static inline b2Vec2 LinearTransform(const b2Vec2& sourceVec2, const b2Vec2& value)
{
    return sourceVec2 + value;
}

static inline float TireForceModel(const float slipAngle, const float normalForce, const float tireStiffness)
{
    // https://en.wikipedia.org/wiki/Hans_B._Pacejka
    const float coefficientForce = slipAngle * tireStiffness / normalForce / TIRE_COEFFICIRNT_SHAPE;

    return normalForce *
           std::sin(TIRE_COEFFICIRNT_SHAPE *
                    std::atan2(coefficientForce - TIRE_COEFFICIRNT_CURVATURE * (coefficientForce - std::atan2(coefficientForce, 1.0f)), 1.0f));
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

static void ParseJsonFromFile(Json::Value& value)
{
    std::string fileName;
    ros::param::get("/simulation/vehicle_configurations", fileName);
    std::ifstream file(fileName);
    Json::Reader  jsonReader;
    jsonReader.parse(file, value);
    file.close();
}

Vehicle::Vehicle(const Json::Value& parameters, b2World& world, bool isEgo)
{
    CreateCarBody(parameters["id"].asString(),
                  world,
                  isEgo,
                  b2Vec2(parameters["position"]["x"].asFloat(), parameters["position"]["y"].asFloat()),
                  parameters["orientation"].asFloat(),
                  parameters["speed"].asFloat(),
                  parameters["yaw_rate"].asFloat());

    LoadFromJson(world, parameters);

    mIsZeroThrust = parameters["zero_thrust"].asBool();
    if (parameters.isMember("follow_waypoint"))
        mFollowWaypoint = parameters["follow_waypoint"].asBool();
    if (parameters.isMember("longitudinal_noise_scale"))
        mLongitudinalNoiseScale = parameters["longitudinal_noise_scale"].asFloat();
}

Vehicle::Vehicle(const std::string& id,
                 b2Vec2&            position,
                 float              orientation,
                 float              longitudinalNoiseScale,
                 b2Vec3&            size,
                 b2World&           world,
                 bool               isEgo,
                 uint64_t           uniqueId)
{
    mUniqueId = uniqueId;
    CreateCarBody(id, world, isEgo, position, orientation, 0.0f, 0.0f);
    uint8 groupIndex = (mIsEgo) ? (1) : (2);

    b2PolygonShape dynamicBox;
    if (size.x == 0.)
        size.x = 5.4;
    if (size.y == 0.)
        size.y = 2.2;
    dynamicBox.SetAsBox(HALF * size.x, HALF * size.y);
    mDimensions = b2Vec2(size.x, size.y);
    b2FixtureDef fixtureDef;
    fixtureDef.shape             = &dynamicBox;
    fixtureDef.density           = 1200.0f / (size.x * size.y);
    fixtureDef.friction          = ROAD_FRICTION_COEFFICIENT;
    fixtureDef.restitution       = RESTITUTION_COEFFICIENT;
    fixtureDef.filter.groupIndex = groupIndex;
    mCarBody->CreateFixture(&fixtureDef);

    CarBodyUserData* userData = new CarBodyUserData;
    userData->id              = mId;
    userData->size            = size;
    mCarBody->SetUserData(userData);
    // mCarBody->SetUserData(&mId);

    mLongitudinalOffset = longitudinalNoiseScale;

    mDynamicParam.frontBaseLength = 1.5f;
    mDynamicParam.rearBaseLength  = 1.11f;
    mDynamicParam.wheelBaseLength = mDynamicParam.frontBaseLength + mDynamicParam.rearBaseLength;
    mDynamicParam.frontStiffness  = 30000.0f;
    mDynamicParam.rearStiffness   = 60000.0f;
    mDynamicParam.dragCoefficient = 0.3f;
}

Vehicle::Vehicle(const std::string& id,
                 const std::string& model,
                 const std::string& route,
                 const std::string& fileName,
                 float              longitudinalNoiseScale,
                 int                defaultSequence,
                 b2World&           world,
                 bool               isEgo,
                 uint64_t           uniqueId)
{
    mUniqueId = uniqueId;
    Json::Value jsonValue;
    ParseJsonFromFile(jsonValue);

    auto parameters  = jsonValue[model];
    auto defaultPose = parameters["default_pose"];

    if (defaultSequence == -1)
    {
        CreateCarBody(id, world, isEgo, b2Vec2(0.0f, 0.0f), 0.0f, 0.0f, 0.0f);
        ROS_INFO_STREAM("[sim_vehicle] Create ego by default: \n"
                        << "model: " << model << "\n"
                        << "route: " << route << "\n"
                        << "fileName: " << fileName << "\n"
                        << "sequence: " << defaultSequence << "\n");
    }
    else
    {
        CheckDefaultPoseKey(jsonValue, model, route, fileName, defaultSequence);
        CreateCarBody(
            id,
            world,
            isEgo,
            b2Vec2(defaultPose[route][fileName][defaultSequence]["x"].asFloat(), defaultPose[route][fileName][defaultSequence]["y"].asFloat()),
            defaultPose[route][fileName][defaultSequence]["orientation"].asFloat(),
            0.0f,
            0.0f);
        ROS_INFO_STREAM("[sim_vehicle] Create ego by default: \n"
                        << "model: " << model << "\n"
                        << "route: " << route << "\n"
                        << "fileName: " << fileName << "\n"
                        << "sequence: " << defaultSequence << "\n"
                        << "pose: " << defaultPose[route][fileName][defaultSequence]);
    }

    LoadFromJson(world, parameters);

    mLongitudinalOffset = parameters["longitudinal_offset"].asFloat();
    if (parameters.isMember("longitudinal_noise_scale"))
        mLongitudinalNoiseScale = parameters["longitudinal_noise_scale"].asFloat();
}

Vehicle::Vehicle(const std::string& id, const std::string& model, b2Vec2& position, float orientation, b2World& world, bool isEgo, uint64_t uniqueId)
{
    mUniqueId = uniqueId;
    Json::Value jsonValue;
    ParseJsonFromFile(jsonValue);

    auto parameters = jsonValue[model];

    CreateCarBody(id, world, isEgo, position, orientation, 0.0f, 0.0f);
    LoadFromJson(world, parameters);

    mLongitudinalOffset = parameters["longitudinal_offset"].asFloat();
}

void Vehicle::CreateCarBody(const std::string& id, b2World& world, bool isEgo, b2Vec2 position, float orientation, float speed, float yawRate)
{
    mId                     = id;
    mFollowWaypoint         = false;
    mIsEgo                  = isEgo;
    mSteeringAngle          = 0.0f;
    mSpeedCommand           = 0.0f;
    mLongitudinalOffset     = -1.0f;
    mIsZeroThrust           = false;
    mEpsModel               = nullptr;
    mLongitudinalNoiseScale = 0.0f;
    mClassId                = "car";
    mTurnSignal             = uint8_t(0);

    mCarDefinition.type = b2_dynamicBody;
    mCarDefinition.position.Set(position.x, position.y);
    mCarDefinition.angle = orientation;
    const b2Vec2 carSpeed(speed / KPH_RATIO, 0.0f);
    mCarDefinition.linearVelocity  = AngularTransform(carSpeed, -mCarDefinition.angle);
    mCarDefinition.angularVelocity = yawRate;
    mCarBody                       = world.CreateBody(&mCarDefinition);
    ROS_DEBUG_STREAM("Create " << mId << " with unique id " << mUniqueId);
}

void Vehicle::LoadFromJson(b2World& world, const Json::Value& parameters)
{
    uint8 groupIndex = (mIsEgo) ? (1) : (2);

    b2PolygonShape dynamicBox;
    dynamicBox.SetAsBox(HALF * parameters["length"].asFloat(), HALF * parameters["width"].asFloat());
    mDimensions = b2Vec2(parameters["length"].asFloat(), parameters["width"].asFloat());
    b2FixtureDef fixtureDef;
    fixtureDef.shape             = &dynamicBox;
    fixtureDef.density           = parameters["mass"].asFloat() / (parameters["length"].asFloat() * parameters["width"].asFloat());
    fixtureDef.friction          = ROAD_FRICTION_COEFFICIENT;
    fixtureDef.restitution       = RESTITUTION_COEFFICIENT;
    fixtureDef.filter.groupIndex = groupIndex;
    mCarBody->CreateFixture(&fixtureDef);

    CarBodyUserData* userData = new CarBodyUserData;
    userData->id              = mId;
    userData->size            = b2Vec3(parameters["length"].asFloat(), parameters["width"].asFloat(), float(1.8));
    mCarBody->SetUserData(userData);

    mDynamicParam.frontBaseLength = parameters["front_axis"].asFloat();
    mDynamicParam.rearBaseLength  = parameters["rear_axis"].asFloat();
    mDynamicParam.wheelBaseLength = mDynamicParam.frontBaseLength + mDynamicParam.rearBaseLength;
    mDynamicParam.frontStiffness  = parameters["front_stiffness"].asFloat();
    mDynamicParam.rearStiffness   = parameters["rear_stiffness"].asFloat();
    mDynamicParam.dragCoefficient = parameters["drag_coefficient"].asFloat();
    if (parameters.isMember("gear_ratio"))
        mDynamicParam.gearRatio = parameters["gear_ratio"].asFloat();
    if (parameters.isMember("eps_model"))
        mEpsModel = std::make_shared<ODE23>(parameters["eps_model"], 0.01f);
}

Vehicle::~Vehicle()
{
    ROS_DEBUG_STREAM("Destroy " << mId);
    mCarBody->GetWorld()->DestroyBody(mCarBody);
}

void Vehicle::SetControlCommand(const float steering, const float speed)
{
    if (mEpsModel)
        mSteeringAngle = -GetDegreeToRadian(mEpsModel->OneStep(steering)) / mDynamicParam.gearRatio;
    else
        mSteeringAngle = -GetDegreeToRadian(steering) / mDynamicParam.gearRatio;
    mSpeedCommand = speed / KPH_RATIO;
}

void Vehicle::SetSteeringCommand(const float steering)
{
    if (mEpsModel)
        mSteeringAngle = -GetDegreeToRadian(mEpsModel->OneStep(steering)) / mDynamicParam.gearRatio;
    else
        mSteeringAngle = -GetDegreeToRadian(steering) / mDynamicParam.gearRatio;
}

void Vehicle::SetZeroThrust(const bool set)
{
    mIsZeroThrust = set;
}

CarStatus Vehicle::GetStatus()
{
    return {mId,
            mCarBody->GetPosition(),
            mCarBody->GetAngle(),
            mCarBody->GetLinearVelocity(),
            mCarBody->GetAngularVelocity(),
            -GetRadianToDegree(mSteeringAngle) * mDynamicParam.gearRatio,
            mCarBody->GetContactList(),
            GetShape(),
            mDimensions,
            mLongitudinalNoiseScale,
            mTurnSignal};
}

void Vehicle::SetStatus(const CarStatus& status)
{
    mCarBody->SetTransform(status.position, status.orientation);
    mCarBody->SetLinearVelocity(status.velocity);
    mCarBody->SetAngularVelocity(status.yawRate);
    SetTurnSignal(status.turnSignal);
}

uint8_t Vehicle::GetTurnSignal()
{
    return mTurnSignal;
}

void Vehicle::SetTurnSignal(const uint8_t turnSignal)
{
    if (turnSignal != mTurnSignal)
    {
        mTurnSignal = turnSignal;
    }
}

std::string Vehicle::GetClassId()
{
    return mClassId;
}

void Vehicle::SetClassId(std::string classId)
{
    mClassId = classId;
}

std::vector<b2Vec2> Vehicle::GetShape()
{
    b2Fixture       fixture       = *mCarBody->GetFixtureList();
    b2PolygonShape* carShapeLocal = (b2PolygonShape*)fixture.GetShape();

    std::vector<b2Vec2> vertices(std::begin(carShapeLocal->m_vertices), std::begin(carShapeLocal->m_vertices) + 4);
    for (auto& vertex : vertices)
    {
        vertex = mCarBody->GetWorldPoint(vertex);
    }
    return vertices;
}

void Vehicle::StepOnce()
{
    const b2Vec2 carVelocity = AngularTransform(mCarBody->GetLinearVelocity(), mCarBody->GetAngle());
    LongitudinalDynamic(carVelocity);
    LateralDynamic(carVelocity);
}

void Vehicle::LongitudinalDynamic(const b2Vec2& carVelocity)
{
    b2Vec2      acceleration;
    const float frictionLimit = ROAD_FRICTION_COEFFICIENT * GRAVITY * mCarBody->GetMass();
    if (mIsZeroThrust)
    {
        const float resistance = -LONGITUDINAL_DAMPING * mCarBody->GetMass() * GRAVITY * carVelocity.x;
        const float airDrag    = std::copysign(mDynamicParam.dragCoefficient * std::pow(carVelocity.x, 2.0f), -carVelocity.x);
        acceleration.Set(Clamp(resistance + airDrag, -frictionLimit, frictionLimit), 0.0f);
    }
    else
    {
        acceleration.Set(Clamp(SPEED_CONTROL_GAIN * (mSpeedCommand - carVelocity.x), -frictionLimit, frictionLimit), 0.0f);
    }
    mCarBody->ApplyForceToCenter(AngularTransform(acceleration, -mCarBody->GetAngle()), true);
}

void Vehicle::LateralDynamic(const b2Vec2& carVelocity)
{
    float frontSlip;
    if (std::abs(carVelocity.x) > ALMOST_STOP_SPEED)
    {
        frontSlip = GetSupplementaryAngle(
            GetPrincipleAngleMinusPi(mSteeringAngle - std::atan2(carVelocity.y + mDynamicParam.frontBaseLength * mCarBody->GetAngularVelocity(),
                                                                 carVelocity.x + std::copysign(SMALL_SPEED, carVelocity.x))));
    }
    else
    {
        frontSlip =
            GetSupplementaryAngle(GetPrincipleAngleMinusPi(-std::atan2(carVelocity.y + mDynamicParam.frontBaseLength * mCarBody->GetAngularVelocity(),
                                                                       carVelocity.x + std::copysign(SMALL_SPEED, carVelocity.x))));
    }

    const float rearSlip = GetSupplementaryAngle(-std::atan2(carVelocity.y - mDynamicParam.rearBaseLength * mCarBody->GetAngularVelocity(),
                                                             carVelocity.x + std::copysign(SMALL_SPEED, carVelocity.x)));

    const float frontNormalForce = GRAVITY * mCarBody->GetMass() *
                                   // mDynamicParam.rearBaseLength / mDynamicParam.wheelBaseLength;
                                   mDynamicParam.frontBaseLength / mDynamicParam.wheelBaseLength;
    const float  frontTireForce = TireForceModel(frontSlip, frontNormalForce, mDynamicParam.frontStiffness);
    const b2Vec2 frontTireForceVec2(0.0f, frontTireForce);
    const b2Vec2 frontForce = AngularTransform(frontTireForceVec2, -mCarBody->GetAngle() - mSteeringAngle);
    const b2Vec2 frontBaseLength(mDynamicParam.frontBaseLength, 0.0f);
    const b2Vec2 frontPoint = LinearTransform(AngularTransform(frontBaseLength, -mCarBody->GetAngle()), mCarBody->GetPosition());
    mCarBody->ApplyForce(frontForce, frontPoint, true);

    const float  rearNormalForce = GRAVITY * mCarBody->GetMass() * mDynamicParam.rearBaseLength / mDynamicParam.wheelBaseLength;
    const float  rearTireForce   = TireForceModel(rearSlip, rearNormalForce, mDynamicParam.rearStiffness);
    const b2Vec2 rearTireForceVec2(0.0f, rearTireForce);
    const b2Vec2 rearForce = AngularTransform(rearTireForceVec2, -mCarBody->GetAngle());
    const b2Vec2 rearBaseLength(-mDynamicParam.rearBaseLength, 0.0f);
    const b2Vec2 rearPoint = LinearTransform(AngularTransform(rearBaseLength, -mCarBody->GetAngle()), mCarBody->GetPosition());
    mCarBody->ApplyForce(rearForce, rearPoint, true);
}

void Vehicle::CheckDefaultPoseKey(const Json::Value& jsonValue,
                                  const std::string& model,
                                  const std::string& route,
                                  const std::string& fileName,
                                  int                defaultSequence)
{
    if (!jsonValue.isMember(model))
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid model key: " << model << " - Check the json structure in "
                                                             << "simulation_utils/data/vehicle_parameters.json as well");
        ROS_ERROR_STREAM("Value: " << jsonValue);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }
    if (!jsonValue[model].isMember("default_pose"))
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid default_pose key."
                         << " - Check the json structure in "
                         << "simulation_utils/data/vehicle_parameters.json as well");
        ROS_ERROR_STREAM("Value: " << jsonValue[model]);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }
    if (!jsonValue[model]["default_pose"].isMember(route))
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid route key: " << route << " - Check the json structure in "
                                                             << "simulation_utils/data/vehicle_parameters.json as well");
        ROS_ERROR_STREAM("Value: " << jsonValue[model]["default_pose"]);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }
    if (!jsonValue[model]["default_pose"][route].isMember(fileName))
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid fileName key: " << fileName);
        ROS_ERROR_STREAM("Value: " << jsonValue[model]["default_pose"][route]);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    auto presetPoses = jsonValue[model]["default_pose"][route][fileName];

    if (presetPoses.size() < defaultSequence + 1)
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid defaultSequence key: " << defaultSequence << " for values: " << presetPoses
                                                                       << " - Check the json structure in "
                                                                       << "simulation_utils/data/vehicle_parameters.json as well");
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    auto pose = presetPoses[defaultSequence];

    if (!pose.isMember("x") || !pose.isMember("y") || !pose.isMember("orientation"))
    {
        ROS_ERROR_STREAM("[sim_vehicle] Invalid pose key for value: " << pose << " - Check the json structure in "
                                                                      << "simulation_utils/data/vehicle_parameters.json as well");
        ROS_ERROR_STREAM("Value: " << pose);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    if (pose["x"].isNull() || pose["y"].isNull() || pose["orientation"].isNull())
    {
        ROS_ERROR_STREAM("Defulat settings are null. "
                         << "Check the json structure in simulation_utils/data/vehicle_parmeters.json");
        ROS_ERROR_STREAM("Value: " << pose);
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }
}
