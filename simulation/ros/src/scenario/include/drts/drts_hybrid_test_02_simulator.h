#ifndef _DRTS_HYBRID_TEST_02_SIMULATOR_H_
#define _DRTS_HYBRID_TEST_02_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_lane_roadside_moving_model.h>
#include <unit_stationary_object_model.h>


namespace drts {

class HybridTest02Simulator final : public scenario::Simulator
{

public:

    HybridTest02Simulator();
    HybridTest02Simulator(const HybridTest02Simulator &) = delete;
    HybridTest02Simulator &operator=(const HybridTest02Simulator &) = delete;
    virtual ~HybridTest02Simulator() = default;

    virtual void Configure(const scenario::SimulatorConfig &config) override;
    virtual void Update() override;

protected:

private:
    unit::LaneRoadsideMovingModel::Ptr mLaneRoadsideMovingModel;
    unit::StationaryObjectModel::Ptr mIllegalParkingVehicleModel;
};

} // namespace drts {


#endif // #ifndef _DRTS_HYBRID_TEST_02_SIMULATOR_H_