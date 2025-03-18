#ifndef _CARLA_EGO_VEHICLE_H_
#define _CARLA_EGO_VEHICLE_H_

#include <sim_vehicle.h>
#include <carla_feedback_estimator.h>

namespace carla {

class EgoVehicle : public Vehicle
{

public:

    EgoVehicle(const Json::Value &parameters, b2World &world);
    EgoVehicle(const EgoVehicle &) = delete;
    EgoVehicle &operator=(const EgoVehicle &) = delete;
    virtual ~EgoVehicle();

    virtual void SetControlCommand(const float steering, const float speed);
    virtual void SetSteeringCommand(const float steering);
    virtual void SetZeroThrust(const bool set);
    virtual CarStatus GetStatus() override;
    virtual void SetStatus(const CarStatus &) override;
    virtual void StepOnce() override;

protected:

private:

    FeedbackEstimator mFeedbackEstimator;
};

} // namespace carla {

#endif // #ifndef _CARLA_EGO_VEHICLE_H_
