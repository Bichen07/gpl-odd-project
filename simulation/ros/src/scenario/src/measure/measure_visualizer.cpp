#include <measure_visualizer.h>
#include <sstream>
#include <visualization_msgs/MarkerArray.h>
#include <math_utils.h>
#include <utils_default_color.h>
#include <utils_color.h>
#include <utils_visualization_msgs.h>
#include <utils_converter.h>
#include <motion_utils.h>

namespace measure {

// public func.

Visualizer::Visualizer()
    : mVisualizationMsgsManager{nullptr}

    , mAgentSafetyRegionDatas{}
    , mFrenetDistanceMarkers{}
    , mSpecMarkers{}
    , mVelocityMarkers{}
{
}

Visualizer::~Visualizer()
{
}

void Visualizer::Configure(
    const std::shared_ptr<scenario::VisualizationMsgsManager> &visualizationMsgsManager)
{
    mVisualizationMsgsManager = visualizationMsgsManager;
}

void Visualizer::SetAgentSafetyRegionDatas(const std::vector<SafetyRegionData> &datas)
{
    mAgentSafetyRegionDatas = datas;
}

void Visualizer::AppendFrenetDistanceMarker(const FrenetDistanceMarker &marker)
{
    mFrenetDistanceMarkers.push_back(marker);
}

void Visualizer::AppendSpecMarker(const SpecMarker &marker)
{
    mSpecMarkers.push_back(marker);
}

void Visualizer::AppendVelocityMarker(const VelocityMarker &marker)
{
    mVelocityMarkers.push_back(marker);
}

void Visualizer::Publish()
{
    this->PublishAgentSafetyRegions();
    this->PublishFrenetDistanceDatas();
    this->PublishSpecMarkers();
    //this->PublishVelocityMarkers();
}

// protected func.

// private func.

void Visualizer::PublishAgentSafetyRegions()
{
    if (mAgentSafetyRegionDatas.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mAgentSafetyRegionDatas.size());
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"agent_safety_regions"};
    auto marker{markerArray.markers.begin()};
    for (auto regionData{mAgentSafetyRegionDatas.begin()};
         regionData != mAgentSafetyRegionDatas.end();
         ++regionData)
    {
        const auto colorMsgs = regionData->isSafe ?
            utils::BlueViolet() :
            utils::ComputeComplementaryColor(utils::BlueViolet());
        const int32_t markerId = mVisualizationMsgsManager->QueryMarkerId(regionData->id);
        utils::GenerateVisualizationClosedLineStripMsgs(
            markerId,
            ns,
            stamp,
            regionData->safetyRegion,
            math::Vector3d_t(0.35, 0.2, 0.2),
            //math::Vector3d_t(0.25, 0.2, 0.2),
            ros::Duration(),
            colorMsgs,
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mAgentSafetyRegionDatas.clear();
}

void Visualizer::PublishFrenetDistanceDatas()
{
    if (mFrenetDistanceMarkers.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mFrenetDistanceMarkers.size() << 1);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"frenet_distance_datas"};
    auto marker{markerArray.markers.begin()};

    for (auto config{mFrenetDistanceMarkers.cbegin()};
         config != mFrenetDistanceMarkers.cend();
         ++config)
    {
        const int32_t textMarkerId = mVisualizationMsgsManager->QueryMarkerId(
            config->id + "_text");
        static constexpr math::real_t lateralOffset{5.0};
        if (config->data.isObserverBehindTarget)
        {
            std::stringstream distanceStream;
            distanceStream << std::setprecision(1) << std::fixed
                << config->data.distance.s();
            const math::Vector3d_t longitudinalVector(
                config->textTransform3d.linear().col(0).x(),
                config->textTransform3d.linear().col(0).y(),
                0.0);
            const math::Vector3d_t lateralVector(
                config->textTransform3d.linear().col(1).x(),
                config->textTransform3d.linear().col(1).y(),
                0.0);
            const math::Vector3d_t textPosition =
                config->data.observerPoint +
                longitudinalVector * config->textOffset.s() +
                lateralVector * config->textOffset.d();
            const math::HomoXfm3d_t textPose(
                math::RotMat3d_t::Identity(),
                textPosition);
            utils::GenerateVisualizationTextMsgs(
                distanceStream.str(),
                textMarkerId,
                ns,
                stamp,
                textPose,
                math::Vector3d_t(3.0, 3.0, 3.0),
                config->lifeTime,
                config->textColor,
                &(*marker));
        }
        else
        {
            utils::DeleteVisualizationMsgs(
                textMarkerId,
                ns,
                stamp,
                &(*marker));
        }
        ++marker;

        const int32_t dataMarkerId = mVisualizationMsgsManager->QueryMarkerId(config->id);
        if (config->data.isObserverBehindTarget && config->canShowSequentialPoints)
        {
            std::vector<math::Vector3d_t> observerToTargetPoints;
            observerToTargetPoints.reserve(config->data.sequentialPoints.size());
            observerToTargetPoints.push_back(config->data.observerPoint);
            observerToTargetPoints.insert(
                observerToTargetPoints.end(),
                config->data.sequentialPoints.begin(),
                config->data.sequentialPoints.end());
            observerToTargetPoints.push_back(config->data.targetPoint);

            utils::GenerateVisualizationLineStripMsgs(
                dataMarkerId,
                ns,
                stamp,
                observerToTargetPoints,
                math::Vector3d_t(0.5, 0.2, 0.2),
                ros::Duration(),
                utils::BlueViolet(),
                &(*marker));
        }
        else
        {
            utils::DeleteVisualizationMsgs(
                dataMarkerId,
                ns,
                stamp,
                &(*marker));
        }
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mFrenetDistanceMarkers.clear();
}

void Visualizer::PublishSpecMarkers()
{
    if (mSpecMarkers.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mSpecMarkers.size());
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"scenario_specs"};
    auto marker{markerArray.markers.begin()};

    for (const auto &config: mSpecMarkers)
    {
        const int32_t markerId = mVisualizationMsgsManager->QueryMarkerId(config.id);
        utils::GenerateVisualizationTextMsgs(
            config.text,
            markerId,
            ns,
            stamp,
            config.transform3d,
            config.scale,
            config.lifeTime,
            config.color,
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mSpecMarkers.clear();
}

void Visualizer::PublishVelocityMarkers()
{
    if (mVelocityMarkers.empty())
    {
        return;
    }

    std::size_t totalMarkerSize{0ul};
    for (const auto velocityMarker: mVelocityMarkers)
    {
        if (velocityMarker.speedTextScale > 0.0)
        {
            totalMarkerSize += 2ul;
        }
        else
        {
            totalMarkerSize += 1ul;
        }
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(totalMarkerSize);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"velocities"};
    auto marker{markerArray.markers.begin()};

    for (const auto &config: mVelocityMarkers)
    {
        const int32_t markerId = mVisualizationMsgsManager->QueryMarkerId(config.id);
        const auto orientation{math::ComputeOrientationXy(config.velocity)};
        const math::HomoXfm3d_t arrowPose(
            orientation.toRotationMatrix(),
            config.beginPosition);
        const math::Vector3d_t scale(config.velocity.norm(), 0.3, 0.3);
        utils::GenerateVisualizationArrowMsgs(
            markerId,
            ns,
            stamp,
            arrowPose,
            scale,
            config.lifeTime,
            config.color,
            &(*marker));
        ++marker;

        if (config.speedTextScale > 0.0)
        {
            std::stringstream speedStream;
            speedStream << std::setprecision(1) << std::fixed
                << motion::ConvertToKph(config.velocity.norm())
                << "kph";
            const int32_t textMarkerId = mVisualizationMsgsManager->QueryMarkerId(
                config.id + "_text");
            const math::Vector3d_t textOffsetPosition = math::ComputeOffsetPosition(
                arrowPose,
                math::FrenetCoord(config.velocity.norm(), -3.0));
            const math::HomoXfm3d_t textPose(
                arrowPose.linear(),
                textOffsetPosition);

            utils::GenerateVisualizationTextMsgs(
                speedStream.str(),
                textMarkerId,
                ns,
                stamp,
                textPose,
                math::Vector3d_t(0.0, 0.0, config.speedTextScale),
                config.lifeTime,
                config.color,
                &(*marker));
            ++marker;
        }
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mVelocityMarkers.clear();
}

} // namespace measure {
