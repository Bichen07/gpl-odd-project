#include "std_msgs/Bool.h"
#include <hct_approaching_ego_simulator.h>

namespace hct {

// public func.

ApproachingEgoSimulator::ApproachingEgoSimulator()
  : Simulator()
  , mApproachingEgoVehicleModel{
      std::make_shared<unit::ConstantVelocityModel>()
  }
{
    mEndScenarioPublisher =
      mNodeHandle.advertise<std_msgs::Bool>("/end_scenario", 1);
}

void
ApproachingEgoSimulator::Configure(const scenario::SimulatorConfig& config)
{
    std::vector<unit::Model::Ptr> unitModels = {
        mApproachingEgoVehicleModel,
    };
    Simulator::Configure(config, unitModels);
}

void
ApproachingEgoSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

} // namespace hct
