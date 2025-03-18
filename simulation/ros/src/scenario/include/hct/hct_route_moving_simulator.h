#ifndef _HCT_ROUTE_MOVING_SIMULATOR_H_
#define _HCT_ROUTE_MOVING_SIMULATOR_H_

#include <scenario_simulator.h>
#include <unit_route_moving_model.h>

namespace hct
{

    class RouteMovingSimulator final : public scenario::Simulator
    {
    public:
        RouteMovingSimulator();
        RouteMovingSimulator(const RouteMovingSimulator&)            = delete;
        RouteMovingSimulator& operator=(const RouteMovingSimulator&) = delete;
        virtual ~RouteMovingSimulator()                              = default;

        virtual void Configure(const scenario::SimulatorConfig& config) override;
        virtual void Update() override;

    protected:
    private:
        unit::RouteMovingModel::Ptr mRouteMovingModel;
    };

}  // namespace hct

#endif  // #ifndef _HCT_ROUTE_MOVING_SIMULATOR_H_
