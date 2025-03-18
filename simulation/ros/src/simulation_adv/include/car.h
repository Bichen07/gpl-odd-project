#ifndef __CAR_H__
#define __CAR_H__

#include <sim_vehicle.h>
#include <Box2D.h>
#include <cstring>
#include <jsoncpp/json/json.h>
#include <memory>
#include <vector>

class Car : public Vehicle
{
public:
    Car(const Json::Value & parameters, b2World &, int16 groupIndex);
    virtual ~Car();

    virtual void SetControlCommand(const float steering, const float speed);
    virtual void SetSteeringCommand(const float steering);
    virtual void SetZeroThrust(const bool set);
    virtual CarStatus GetStatus() override;
    virtual void SetStatus(const CarStatus &) override;
    virtual void StepOnce() override;

protected:
    std::vector<b2Vec2> GetShape();
    void LongitudinalDynamic(const b2Vec2 & carVelocity);
    void LateralDynamic(const b2Vec2 & carVelocity);

public:

};

#endif // __CAR_H__
