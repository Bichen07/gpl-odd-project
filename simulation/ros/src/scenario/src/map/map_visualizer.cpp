#include <map_visualizer.h>
#include <ros/console.h>
#include <utils_converter.h>
#include <utils_visualization_msgs.h>
#include <utils_default_color.h>

namespace map {

// public func.

Visualizer::Visualizer()
    : mVisualizationMsgsManager{nullptr}

    , mForwardWaypoints{}
    , mOppositeWaypoints{}
    , mCrosswalkMap{}
    , mStopLineMap{}
    , mTrafficLightController{}
    , mTrafficLightMarkers{}

    , mForwardIntersectionWaypointDatas{}
    , mOppositeIntersectionWaypointDatas{}
{
}

void Visualizer::Configure(
    const std::shared_ptr<scenario::VisualizationMsgsManager> &visualizationMsgsManager)
{
    mVisualizationMsgsManager = visualizationMsgsManager;
}

void Visualizer::SetForwardWaypoints(const std::vector<math::Vector3d_t> &forwardWaypoints)
{
    mForwardWaypoints = forwardWaypoints;
}

void Visualizer::SetOppositeWaypoints(const std::vector<math::Vector3d_t> &oppositeWaypoints)
{
    mOppositeWaypoints = oppositeWaypoints;
}

void Visualizer::SetForwardIntersectionWaypointDatas(
    const std::vector<IntersectionWaypointData> &forwardIntersectionWaypointDatas)
{
    mForwardIntersectionWaypointDatas = forwardIntersectionWaypointDatas;
}

void Visualizer::SetOppositeIntersectionWaypointDatas(
    const std::vector<IntersectionWaypointData> &oppositeIntersectionWaypointDatas)
{
    mOppositeIntersectionWaypointDatas = oppositeIntersectionWaypointDatas;
}

void Visualizer::SetCrosswalkMap(const std::map<int32_t, Crosswalk> &crosswalkMap)
{
    mCrosswalkMap = crosswalkMap;
}

void Visualizer::SetStopLineMap(const std::map<int32_t, StopLine> &stopLineMap)
{
    mStopLineMap = stopLineMap;
}

void Visualizer::AppendTrafficLightMarker(const TrafficLightMarker &trafficLightMarker)
{
    mTrafficLightMarkers.push_back(trafficLightMarker);
}

void Visualizer::Publish()
{
    this->PublishForwardWaypoints();
    this->PublishOppositeWaypoints();
    this->PublishCrosswalks();
    this->PublishStopLines();
    this->PublishTrafficLightMarkers();

    this->PublishForwardIntersectionWaypoints();
    this->PublishOppositeIntersectionWaypoints();
}

// protected func.

// private func.

void Visualizer::PublishForwardWaypoints()
{
    if (mForwardWaypoints.empty())
    {
        return;
    }

    visualization_msgs::Marker waypointMarker;
    static const std::string forwardWaypointId{"route_forward_waypoints"};
    this->GenerateWaypointMsgs(
        mVisualizationMsgsManager->QueryMarkerId(forwardWaypointId),
        mForwardWaypoints,
        utils::Purple(),
        &waypointMarker);
    mVisualizationMsgsManager->Publish(waypointMarker);
}

void Visualizer::PublishOppositeWaypoints()
{
    if (mOppositeWaypoints.empty())
    {
        return;
    }

    visualization_msgs::Marker waypointMarker;
    static const std::string oppositeWaypointId{"route_opposite_waypoints"};
    this->GenerateWaypointMsgs(
        mVisualizationMsgsManager->QueryMarkerId(oppositeWaypointId),
        mOppositeWaypoints,
        utils::Teal(),
        &waypointMarker);
    mVisualizationMsgsManager->Publish(waypointMarker);
}

void Visualizer::PublishCrosswalks()
{
    if (mCrosswalkMap.empty())
    {
        return;
    }

    std::size_t totalMarkerSize{0ul};
    for (const auto &crosswalkPair: mCrosswalkMap)
    {
        totalMarkerSize += (crosswalkPair.second.GetEdges().size() * 2ul + 2ul);
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(totalMarkerSize);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"crosswalks"};
    auto marker{markerArray.markers.begin()};

    for (auto crosswalkPair{mCrosswalkMap.cbegin()};
         crosswalkPair != mCrosswalkMap.cend();
         ++crosswalkPair)
    {
        const std::string crosswalkId =
            "crosswalk_" + std::to_string(crosswalkPair->first);
        const auto edges{crosswalkPair->second.GetEdges()};
        for (auto edge{edges.cbegin()}; edge != edges.cend(); ++edge)
        {
            const math::real_t edgeHeadingRadian = atan2(
                edge->GetDirection().y(),
                edge->GetDirection().x());
            const math::Quaternion_t edgeOrientation{
                math::AngleAxis_t(edgeHeadingRadian, math::Vector3d_t::UnitZ())};
            const math::HomoXfm3d_t pose(
                edgeOrientation.toRotationMatrix(),
                edge->GetBeginPosition());
            const math::Vector3d_t scale(edge->GetNorm(), 0.2, 0.2);

            const std::string edgeId =
                crosswalkId +
                "_edge_" +
                std::to_string(std::distance(edges.cbegin(), edge));

            utils::GenerateVisualizationArrowMsgs(
                mVisualizationMsgsManager->QueryMarkerId(edgeId),
                ns,
                stamp,
                pose,
                scale,
                ros::Duration(),
                utils::Tomato(),
                &(*marker));
            ++marker;

            const std::string edgeLabelNum = std::to_string(
                std::distance(edges.cbegin(), edge));
            const math::Vector3d_t edgeCenter =
                edge->GetBeginPosition() +
                0.5 * edge->GetNorm() * edge->GetDirection();
            const math::Vector3d_t edgeLabelNumPosition =
                edgeCenter + math::Vector3d_t::UnitZ();
            const std::string edgeLabelNumId = edgeId + "_label";

            utils::GenerateVisualizationTextMsgs(
                edgeLabelNum,
                mVisualizationMsgsManager->QueryMarkerId(edgeLabelNumId),
                ns,
                stamp,
                math::HomoXfm3d_t(edgeLabelNumPosition),
                math::Vector3d_t(1.5, 1.5, 1.5),
                ros::Duration(),
                utils::Green(0.8),
                &(*marker));
            ++marker;
        }

        const math::Vector3d_t centroid3d{crosswalkPair->second.GetCentroid()};
        const std::string crosswalkCentroidId = crosswalkId + "_centroid";
        utils::GenerateVisualizationSphereMsgs(
            mVisualizationMsgsManager->QueryMarkerId(crosswalkCentroidId),
            ns,
            stamp,
            math::HomoXfm3d_t(centroid3d),
            math::Vector3d_t::Ones(),
            ros::Duration(),
            utils::Tomato(0.8),
            &(*marker));
        ++marker;

        const math::Vector3d_t crosswalkLabelPosition =
            centroid3d +
            math::Vector3d_t::Ones();
        const math::Vector3d_t crosswalkLabelScale(2.0, 2.0, 2.0);
        const std::string crosswalkLabelNumId = crosswalkId + "_label";

        utils::GenerateVisualizationTextMsgs(
            std::to_string(crosswalkPair->first),
            mVisualizationMsgsManager->QueryMarkerId(crosswalkLabelNumId),
            ns,
            stamp,
            math::HomoXfm3d_t(crosswalkLabelPosition),
            crosswalkLabelScale,
            ros::Duration(),
            utils::Tomato(0.8),
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
}

void Visualizer::PublishStopLines()
{
    if (mStopLineMap.empty())
    {
        return;
    }

    std::size_t totalMarkerSize{mStopLineMap.size() * 3ul};

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(totalMarkerSize);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"stop_lines"};
    auto marker{markerArray.markers.begin()};

    static const math::Vector3d_t stopLineScale(0.2, 0.2, 0.2);
    for (auto stopLinePair{mStopLineMap.cbegin()};
         stopLinePair != mStopLineMap.cend();
         ++stopLinePair)
    {
        const std::string stopLineId =
            "stop_line_" + std::to_string(stopLinePair->first);
        utils::GenerateVisualizationClosedLineStripMsgs(
            mVisualizationMsgsManager->QueryMarkerId(stopLineId),
            ns,
            stamp,
            stopLinePair->second.GetCorner3ds(),
            stopLineScale,
            ros::Duration(),
            utils::Teal(0.5),
            &(*marker));
        ++marker;

        const std::string stopLineCentroidId = stopLineId + "_centroid";
        utils::GenerateVisualizationSphereMsgs(
            mVisualizationMsgsManager->QueryMarkerId(stopLineCentroidId),
            ns,
            stamp,
            math::HomoXfm3d_t(stopLinePair->second.GetCentroid3d()),
            math::Vector3d_t::Ones(),
            ros::Duration(),
            utils::Teal(),
            &(*marker));
        ++marker;

        const math::Vector3d_t textPosition =
            stopLinePair->second.GetCentroid3d() +
            math::Vector3d_t(1.0, 1.0, 1.0);
        const math::HomoXfm3d_t textPose(math::RotMat3d_t::Identity(), textPosition);
        const math::Vector3d_t textScale(2.0, 2.0, 2.0);
        const std::string stopLineLabelNumId = stopLineId + "_label";
        utils::GenerateVisualizationTextMsgs(
            std::to_string(stopLinePair->first),
            mVisualizationMsgsManager->QueryMarkerId(stopLineLabelNumId),
            ns,
            stamp,
            textPose,
            textScale,
            ros::Duration(),
            utils::Teal(),
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
}

void Visualizer::PublishTrafficLightMarkers()
{
    if (mTrafficLightMarkers.empty())
    {
        return;
    }

    const char *ns{"traffic_light"};
    static constexpr math::real_t lateralOffset{1.75};
    static constexpr math::real_t scale{1.5};
    std::size_t totalMarkerSize{mTrafficLightMarkers.size() * 3ul};
    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(totalMarkerSize);
    auto marker{markerArray.markers.begin()};
    const ros::Time stamp{ros::Time::now()};

    for (auto trafficLightMarker{mTrafficLightMarkers.cbegin()};
         trafficLightMarker != mTrafficLightMarkers.cend();
         ++trafficLightMarker)
    {
        const auto idx = std::distance(
            mTrafficLightMarkers.cbegin(),
            trafficLightMarker);
        const std::string trafficLightId =
            "traffic_light_" + std::to_string(idx);

        const auto lateralVector = trafficLightMarker->pose.linear().col(1);
        const auto yellowPosition = trafficLightMarker->pose.translation();
        const auto redPosition = yellowPosition + lateralOffset * lateralVector;
        const auto greenPosition = yellowPosition - lateralOffset * lateralVector;

        const std::string yellowId = trafficLightId + "_yellow";
        const std::string redId = trafficLightId + "_red";
        const std::string greenId = trafficLightId + "_green";

        std_msgs::ColorRGBA redLightColor;
        std_msgs::ColorRGBA yellowLightColor;
        std_msgs::ColorRGBA greenLightColor;
        mTrafficLightController.ComputeUpdatedSignal(
            trafficLightMarker->state,
            redLightColor,
            yellowLightColor,
            greenLightColor);
        //const auto yellowLightColor =
        //    TrafficLightState::Yellow == trafficLightMarker->state ?
        //    utils::Yellow() : utils::Gray();
        //const auto redLightColor =
        //    TrafficLightState::Red == trafficLightMarker->state ?
        //    utils::Red() : utils::Gray();
        //const auto greenLightColor =
        //    TrafficLightState::Green == trafficLightMarker->state ?
        //    utils::Green() : utils::Gray();

        utils::GenerateVisualizationSphereMsgs(
            mVisualizationMsgsManager->QueryMarkerId(yellowId),
            ns,
            stamp,
            math::HomoXfm3d_t(trafficLightMarker->pose.linear(), yellowPosition),
            math::Vector3d_t::Ones() * scale,
            ros::Duration(0.1),
            yellowLightColor,
            &(*marker));
        ++marker;

        utils::GenerateVisualizationSphereMsgs(
            mVisualizationMsgsManager->QueryMarkerId(redId),
            ns,
            stamp,
            math::HomoXfm3d_t(trafficLightMarker->pose.linear(), redPosition),
            math::Vector3d_t::Ones() * scale,
            ros::Duration(0.1),
            redLightColor,
            &(*marker));
        ++marker;

        utils::GenerateVisualizationSphereMsgs(
            mVisualizationMsgsManager->QueryMarkerId(greenId),
            ns,
            stamp,
            math::HomoXfm3d_t(trafficLightMarker->pose.linear(), greenPosition),
            math::Vector3d_t::Ones() * scale,
            ros::Duration(0.1),
            greenLightColor,
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
    mTrafficLightMarkers.clear();
}

void Visualizer::PublishForwardIntersectionWaypoints()
{
    if (mForwardIntersectionWaypointDatas.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mForwardIntersectionWaypointDatas.size() * 2ul);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"forward_intersection_waypoints"};
    auto marker{markerArray.markers.begin()};
    for (auto waypointData{mForwardIntersectionWaypointDatas.cbegin()};
         waypointData != mForwardIntersectionWaypointDatas.cend();
         ++waypointData)
    {
        const std::string forwardIntersectionWaypointId =
            "forward_intersection_waypoint_" +
            std::to_string(std::distance(
                    mForwardIntersectionWaypointDatas.cbegin(), waypointData));
        utils::GenerateVisualizationLineStripMsgs(
            mVisualizationMsgsManager->QueryMarkerId(forwardIntersectionWaypointId),
            ns,
            stamp,
            waypointData->waypoints,
            math::Vector3d_t(0.5, 0.2, 0.2),
            ros::Duration(),
            utils::Lime(),
            &(*marker));
        ++marker;

        const std::string labelNum = std::to_string(
            std::distance(mForwardIntersectionWaypointDatas.cbegin(), waypointData));
        const math::Vector3d_t textPosition =
            0.5 * (waypointData->waypoints.front() + waypointData->waypoints.back()) +
            math::Vector3d_t(1.0, 1.0, 1.0);
        const math::HomoXfm3d_t textPose(math::RotMat3d_t::Identity(), textPosition);
        const math::Vector3d_t textScale(3.0, 3.0, 3.0);

        const std::string forwardIntersectionWaypointLabelNumId =
            forwardIntersectionWaypointId + "_label";

        utils::GenerateVisualizationTextMsgs(
            labelNum,
            mVisualizationMsgsManager->QueryMarkerId(forwardIntersectionWaypointLabelNumId),
            ns,
            stamp,
            textPose,
            textScale,
            ros::Duration(),
            utils::Lime(),
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
}

void Visualizer::PublishOppositeIntersectionWaypoints()
{
    if (mOppositeIntersectionWaypointDatas.empty())
    {
        return;
    }

    visualization_msgs::MarkerArray markerArray;
    markerArray.markers.resize(mOppositeIntersectionWaypointDatas.size() * 2ul);
    const ros::Time stamp{ros::Time::now()};
    const char *ns{"opposite_intersection_waypoints"};
    auto marker{markerArray.markers.begin()};
    for (auto waypointData{mOppositeIntersectionWaypointDatas.cbegin()};
         waypointData != mOppositeIntersectionWaypointDatas.cend();
         ++waypointData)
    {
        const std::string oppositeIntersectionWaypointId =
            "opposite_intersection_waypoint_" +
            std::to_string(std::distance(
                    mOppositeIntersectionWaypointDatas.cbegin(), waypointData));
        utils::GenerateVisualizationLineStripMsgs(
            mVisualizationMsgsManager->QueryMarkerId(oppositeIntersectionWaypointId),
            ns,
            stamp,
            waypointData->waypoints,
            math::Vector3d_t(0.5, 0.2, 0.2),
            ros::Duration(),
            utils::DarkOrange(),
            &(*marker));
        ++marker;

        const std::string labelNum = std::to_string(
            std::distance(mOppositeIntersectionWaypointDatas.cbegin(), waypointData));
        const math::Vector3d_t textPosition =
            0.5 * (waypointData->waypoints.front() + waypointData->waypoints.back()) +
            math::Vector3d_t(1.0, 1.0, 1.0);
        const math::HomoXfm3d_t textPose(math::RotMat3d_t::Identity(), textPosition);
        const math::Vector3d_t textScale(3.0, 3.0, 3.0);

        const std::string oppositeIntersectionWaypointLabelNumId =
            oppositeIntersectionWaypointId + "_label";

        utils::GenerateVisualizationTextMsgs(
            labelNum,
            mVisualizationMsgsManager->QueryMarkerId(oppositeIntersectionWaypointLabelNumId),
            ns,
            stamp,
            textPose,
            textScale,
            ros::Duration(),
            utils::DarkOrange(),
            &(*marker));
        ++marker;
    }

    mVisualizationMsgsManager->Publish(markerArray);
}

void Visualizer::GenerateWaypointMsgs(
    const int32_t id,
    const std::vector<math::Vector3d_t> &waypoints,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs) const
{
    static constexpr const char *ns{"route_waypoints"};
    utils::GenerateVisualizationLineStripMsgs(
        id,
        ns,
        ros::Time::now(),
        waypoints,
        math::Vector3d_t(0.5, 0.2, 0.2),
        ros::Duration(),
        colorMsgs,
        markerMsgs);
}

void Visualizer::GeneratePolygonMsgs(
    const int32_t id,
    const std::string &ns,
    const std::vector<math::Vector3d_t> &corners,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs) const
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        return;
    }

    if (corners.empty())
    {
        ROS_WARN_STREAM("corners is empty");
        return;
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->header.stamp = ros::Time::now();
    markerMsgs->ns = ns;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::LINE_STRIP;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        math::Quaternion_t::Identity(),
        math::Vector3d_t::Zero());
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(
        math::Vector3d_t(0.3, 0.0, 0.0));
    markerMsgs->lifetime = ros::Duration();

    markerMsgs->points.resize(corners.size() + 1u);
    markerMsgs->colors.resize(corners.size() + 1u);

    auto corner{corners.begin()};
    auto point{markerMsgs->points.begin()};
    auto color{markerMsgs->colors.begin()};
    for (; corner != corners.end(); ++corner, ++point, ++color)
    {
        *point = utils::ConvertToGeometryMsgsPoint(*corner);
        *color = colorMsgs;
    }

    markerMsgs->points.back() = utils::ConvertToGeometryMsgsPoint(corners.front());
    markerMsgs->colors.back() = colorMsgs;
}

} // namespace map {
