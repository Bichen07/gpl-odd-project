#ifndef _SIM_VEHICLE_H__
#define _SIM_VEHICLE_H__

#include <Box2D.h>
#include <cstring>
#include <fstream>
#include <jsoncpp/json/json.h>
#include <queue>
#include <memory>
#include <sim_ode23.h>
#include <vector>

struct DynamicParameters
{
    float frontBaseLength;
    float rearBaseLength;
    float wheelBaseLength;
    float frontStiffness;
    float rearStiffness;
    float dragCoefficient;
    float gearRatio;

    DynamicParameters()
        : frontBaseLength(0.0f)
        , rearBaseLength(0.0f)
        , wheelBaseLength(0.0f)
        , frontStiffness(0.0f)
        , rearStiffness(0.0f)
        , dragCoefficient(0.0f)
        , gearRatio(19.6)
    {}
};

struct CarStatus
{
    std::string id;
    b2Vec2 position;
    float orientation;
    b2Vec2 velocity;
    float yawRate;
    float steeringAngle;
    bool isContacted;
    std::vector<b2Vec2> shape;
    b2Vec2 dimensions;
    float longitudinalNoiseScale;
    uint8_t turnSignal;
};

struct CarBodyUserData{
    std::string id;
    b2Vec3 size;
    std::queue<CarStatus> trajs;

    CarBodyUserData(std::string id, b2Vec3 size)
        : id(id)
        , size(size)
        , trajs()
    {}

    CarBodyUserData(std::string id, float size_x, float size_y, float size_z)
    {
        CarBodyUserData(id, b2Vec3(size_x, size_y, size_z));
    }

    CarBodyUserData()
        : id()
        , size()
        , trajs()
    {}

};

class Vehicle
{
public:

    /*
        Old way used in simulation package where in simulation node,
        the code load vehicle configuration from simulation/data.
    */
    Vehicle(const Json::Value & parameters, b2World &, bool isEgo);

    /*
        Most directly way to create vehicle from
        simulation_srv/SimulationCreatAgent,
        however the longitudinal offset was not able to set from this.
    */
    Vehicle(const std::string & id, b2Vec2 & position,
            float orientation, float longitudinalNoiseScale,
            b2Vec3 & size, b2World &, bool isEgo,
            uint64_t uniqueId);

    /*
        Create vehicles using
        simulation_srv/SimulationCreateAgentByDefaultPose.
    */
    Vehicle(const std::string & id, const std::string & model,
        const std::string & route, const std::string & fileName,
        float longitudinalNoiseScale,
        int defaultSequence, b2World &, bool isEgo,
        uint64_t uniqueId);

    /*
        Create vehicles using
        simulation_srv/SimulationCreateAgentByDefaultPose but
        overwrite the default pose.
    */
    Vehicle(const std::string & id, const std::string & model,
        b2Vec2 & position, float orientation, b2World &, bool isEgo,
        uint64_t uniqueId);
    virtual ~Vehicle();
    virtual void SetControlCommand(const float steering, const float speed);
    virtual void SetSteeringCommand(const float steering);
    virtual void SetZeroThrust(const bool set);

    virtual CarStatus GetStatus();
    virtual void SetStatus(const CarStatus &);
    virtual uint8_t GetTurnSignal();
    virtual void SetTurnSignal(const uint8_t turnSignal);
    virtual std::string GetClassId();
    virtual void SetClassId(std::string classId);  // default is set to "car"

    virtual void StepOnce();

protected:
    void CreateCarBody(
        const std::string & id, b2World & world, bool isEgo,
        b2Vec2 position, float orientation, float speed, float yawRate);
    void LoadFromJson(b2World &, const Json::Value & parameters);
    std::vector<b2Vec2> GetShape();
    void LongitudinalDynamic(const b2Vec2 & carVelocity);
    void LateralDynamic(const b2Vec2 & carVelocity);
    void CheckDefaultPoseKey(
        const Json::Value & jsonValue,
        const std::string & model,
        const std::string & route,
        const std::string & fileName,
        int defaultSequence);

public:
    std::string mId;
    
    DynamicParameters mDynamicParam;
    b2BodyDef mCarDefinition;
    b2Body * mCarBody;
    b2Vec2 mDimensions;
    std::shared_ptr<ODE23> mEpsModel;

    bool mFollowWaypoint;
    bool mIsEgo;
    uint8_t mTurnSignal;

    float mSteeringAngle;
    float mSpeedCommand;
    float mLongitudinalOffset;
    bool mIsZeroThrust;
    uint64_t mUniqueId;

    float mLongitudinalNoiseScale;
    std::string mClassId;
};

#endif // #ifndef _SIM_VEHICLE_H__
