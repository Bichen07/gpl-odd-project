#include <hct_route_moving_simulator.h>
#include <motion_alks_cut_in_config.h>
#include <unit_route_moving_model.h>

namespace hct
{

    // public func.

    RouteMovingSimulator::RouteMovingSimulator() : Simulator(), mRouteMovingModel{std::make_shared<unit::RouteMovingModel>()}
    {
    }

    void RouteMovingSimulator::Configure(const scenario::SimulatorConfig& config)
    {
        std::vector<unit::Model::Ptr> unitModels = {
            mRouteMovingModel,
        };
        Simulator::Configure(config, unitModels);
    }

    void RouteMovingSimulator::Update()
    {
        Simulator::Update();
    }

    // protected func.

    // private func.

}  // namespace hct
