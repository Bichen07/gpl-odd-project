#include <unit_signalized_intersection_model.h>
#include <limits>
#include <geometry_utils.h>
#include <map_traffic_light_marker.h>
#include <motion_config_reader.h>
#include <utils_default_color.h>
#include <utils_line_strip_marker.h>

namespace unit {

// public func.

SignalizedIntersectionModel::SignalizedIntersectionModel()
    : Model()
    , mFakeTrafficLightSubscriber{}
    , mTrafficLightManager{}
    , mTrafficLightState{map::TrafficLightState::Null}
    , mFrenetDistanceEvaluator{}
    , mMotionConfigs{}
    , mLateralLaneTrafficLightIds{}
{
    mEgoVehicleSpeedCommandSubscriber = mNodeHandle.subscribe(
        "speed_cmd",
        Model::DefaultQueueSize(),
        &SignalizedIntersectionModel::EgoVehicleSpeedCommandCallback,
        this);
    mFakeTrafficLightSubscriber = mNodeHandle.subscribe(
        "traffic_light_status_fake",
        Model::DefaultQueueSize(),
        &SignalizedIntersectionModel::FakeTrafficLightCallback,
        this);
}

std::string SignalizedIntersectionModel::GetId() const
{
    return std::string(AgentIdPrefix()) + std::string("model");
}

void SignalizedIntersectionModel::Configure(const ModelConfig &config)
{
    Model::Configure(config);
    const std::string trafficLightFileName =
        std::string(MAP_DATA_DIR) +
        mNavigationPath->GetNavigationPathConfig().map +
        std::string("/traffic_light.json");
    mTrafficLightManager.Configure(trafficLightFileName);

    this->ConfigureMotions();
}

void SignalizedIntersectionModel::Update()
{
    for (auto trafficLightPair{mTrafficLightManager.GetTrafficLightMap().cbegin()};
         trafficLightPair != mTrafficLightManager.GetTrafficLightMap().cend();
         ++trafficLightPair)
    {
        this->AppendTrafficLightMarker(
            trafficLightPair->second,
            mTrafficLightState);

        static const bool canShowCorners{false};
        if (canShowCorners)
        {
            const auto corner3ds{trafficLightPair->second.GetCorner3ds()};
            for (auto corner{corner3ds.cbegin()}; corner != corner3ds.cend(); ++corner)
            {
                const auto idx{
                    std::distance(corner3ds.cbegin(), corner)};
                mAuxiliaryVisualizer->AppendPointMarker(
                    utils::PointMarker{
                    .id = std::string("traffic_light_corner_") +
                    std::to_string(trafficLightPair->second.GetId()) + "_" +
                    std::to_string(idx),
                    .type = utils::PointMarkerType::Sphere,
                    .pose = math::HomoXfm3d_t(*corner),
                    .scale = math::Vector3d_t::Ones() * 0.5,
                    .lifeTime = ros::Duration(),
                    .color = utils::Red()});
            }
        }

        static const bool canShowId{false};
        if (canShowId)
        {
            auto trafficLightPose{
                geometry::Transform3d(trafficLightPair->second.GetPose())};
            mAuxiliaryVisualizer->AppendTextMarker(
                utils::TextMarker{
                    .id = std::string("traffic_light_id_") +
                        std::to_string(trafficLightPair->second.GetId()),
                    .text = std::to_string(trafficLightPair->second.GetId()),
                    .pose = geometry::Transform3d(
                        trafficLightPose.GetQuaternion(),
                        trafficLightPose.GetPosition() + geometry::Vector3d::UnitZ()),
                    .scale = geometry::Vector3d::Ones() * 3.0,
                    .lifetime = ros::Duration(),
                    .color = utils::Yellow()});
        }
    }
}

void SignalizedIntersectionModel::AccessAgentAttributes(
    std::vector<scenario::AgentAttribute> *agentAttributes)
{
}

void SignalizedIntersectionModel::RunCarlaUpdate(
    std::vector<carla::ActorUpdateData> *actorUpdateDatas)
{
    this->Update();
}

// protected func.

// private func.

void SignalizedIntersectionModel::ConfigureMotions()
{
    if (!mConfigJsonValue.isMember("motion_configs"))
    {
        return;
    }

    std::function<decltype(motion::ParseSignalizedIntersectionConfig)> parseFunc{
        motion::ParseSignalizedIntersectionConfig};
    motion::ParseMotionConfigs(
        mConfigJsonValue["motion_configs"],
        parseFunc,
        mMotionConfigs);

    for (auto motionConfig{mMotionConfigs.cbegin()};
         motionConfig != mMotionConfigs.cend();
         ++motionConfig)
    {
        mLateralLaneTrafficLightIds.insert(
            mLateralLaneTrafficLightIds.cend(),
            motionConfig->lateralLaneTrafficLightIds.cbegin(),
            motionConfig->lateralLaneTrafficLightIds.cend());
    }
}

void SignalizedIntersectionModel::AppendTrafficLightMarker(
    const map::TrafficLight &trafficLight,
    const map::TrafficLightStateId &trafficLightStateId)
{
    const auto found{
        std::find(
            mLateralLaneTrafficLightIds.cbegin(),
            mLateralLaneTrafficLightIds.cend(),
            trafficLight.GetId())};
    const bool isLateralLaneTrafficLight{
        mLateralLaneTrafficLightIds.end() != found};

    mMapVisualizer->AppendTrafficLightMarker(
        map::TrafficLightMarker{
            .pose = trafficLight.GetPose(),
            .state = map::EvaluateTrafficLightState(
                trafficLightStateId,
                isLateralLaneTrafficLight)});
}

void SignalizedIntersectionModel::FakeTrafficLightCallback(
    const itri_msgs::TrafficLightObjects &msg)
{
    if (msg.lights.empty())
    {
        mTrafficLightState = map::TrafficLightState::Null;
    }

    if (msg.lights.front().red)
    {
        mTrafficLightState = map::TrafficLightState::Red;
    }
    else if (msg.lights.front().yellow)
    {
        mTrafficLightState = map::TrafficLightState::Yellow;
    }
    else if (msg.lights.front().green)
    {
        mTrafficLightState = map::TrafficLightState::Green;
    }
    else if (msg.lights.front().flashyellow)
    {
        mTrafficLightState = map::TrafficLightState::FlashingYellow;
    }
    else if (msg.lights.front().flashred)
    {
        mTrafficLightState = map::TrafficLightState::FlashingRed;
    }
    else
    {
        mTrafficLightState = map::TrafficLightState::Null;
    }
}

void SignalizedIntersectionModel::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
{
    if (msg.kph <= 0.0f)
    {
        return;
    }

    mFrenetDistanceEvaluator.Configure(mNavigationPath->GetEgoVehicleGlobalPath());
    mCanAccessAgentAttributes = true;
    mEgoVehicleSpeedCommandSubscriber.shutdown();
}

} // namespace unit {
