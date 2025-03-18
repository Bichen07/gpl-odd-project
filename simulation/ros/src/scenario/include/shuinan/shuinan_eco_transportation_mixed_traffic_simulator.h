#ifndef _SHUINAN_ECO_TRANSPORTATION_MIXED_TRAFFIC_SIMULATOR_H_
#define _SHUINAN_ECO_TRANSPORTATION_MIXED_TRAFFIC_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_zigzag_moving_model.h>

namespace shuinan {

class EcoTransportationMixedTrafficSimulator final : public scenario::Simulator
{

public:

    EcoTransportationMixedTrafficSimulator();
    EcoTransportationMixedTrafficSimulator(
        const EcoTransportationMixedTrafficSimulator &) = delete;
    EcoTransportationMixedTrafficSimulator &operator=(
        const EcoTransportationMixedTrafficSimulator &) = delete;
    virtual ~EcoTransportationMixedTrafficSimulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:

    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
    unit::ZigzagMovingModel::Ptr mZigzagMovingModel;
};

} // namespace shuinan {

#endif // #ifndef _SHUINAN_ECO_TRANSPORTATION_MIXED_TRAFFIC_SIMULATOR_H_
