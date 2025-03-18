#include <shuinan_passenger_carrying_simulator.h>
#include <ros/console.h>
#include <utils_default_color.h>

namespace shuinan {

// public func.

PassengerCarryingSimulator::PassengerCarryingSimulator()
    : Simulator()
    , mNodeHandle{}
    , mNavigationPathReadinessSubscriber{}
    , mBusStationManager{}
{
    mNavigationPathReadinessSubscriber = mNodeHandle.subscribe(
        "scenario/navigation_path_readiness",
        Simulator::DefaultQueueSize(),
        &PassengerCarryingSimulator::NavigationPathReadinessCallback,
        this);
}

void PassengerCarryingSimulator::Configure(const scenario::SimulatorConfig &config)
{
    Simulator::Configure(
        config,
        std::vector<unit::Model::Ptr>());

    const std::string busStationFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/bus_station.json");
    mBusStationManager.Configure(busStationFileName);
}

void PassengerCarryingSimulator::Update()
{
    Simulator::Update();
}

// protected func.

// private func.

void PassengerCarryingSimulator::NavigationPathReadinessCallback(
    const std_msgs::Bool &msg)
{
    if (!msg.data)
    {
        return;
    }

    const static constexpr bool canShowBusStationMarker{true};
    if (canShowBusStationMarker)
    {
        const auto busStationMap{mBusStationManager.GetBusStationMap()};
        for (auto busStationPair{busStationMap.cbegin()};
             busStationPair != busStationMap.cend();
             ++busStationPair)
        {
            mAuxiliaryVisualizer->AppendPointMarker(
                utils::PointMarker{
                .id = "bus_station_center_" + std::to_string(busStationPair->second.GetId()),
                .type = utils::PointMarkerType::Sphere,
                .pose = math::HomoXfm3d_t(busStationPair->second.GetCenter()),
                .scale = math::Vector3d_t::Ones() * 3.5,
                .lifeTime = ros::Duration(),
                .color = utils::Yellow()});
        }
    }
}

} // namespace shuinan {
