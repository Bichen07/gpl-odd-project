#include <rss_scene_mode_evaluator.h>
#include <cmath>
#include <stdexcept>
#include <ros/console.h>
#include <ad/map/lane/Lane.hpp>
#include <ad/map/lane/LaneOperation.hpp>
#include <ad/map/lane/LaneType.hpp>

namespace rss {

// public func.

SceneModeEvaluator::SceneModeEvaluator()
    : mEvaluateFuncMap{}
    , mChangeToUnstructuredPositionMap{}
{
    mEvaluateFuncMap = EvaluateFuncMap
    {
        {
            ad::rss::world::ObjectType::OtherVehicle,
            std::bind(
                &SceneModeEvaluator::EvaluateOtherVehicleSceneMode,
                this,
                std::placeholders::_1,
                std::placeholders::_2)
        },
        {
            ad::rss::world::ObjectType::Pedestrian,
            std::bind(
                &SceneModeEvaluator::EvaluatePedestrianSceneMode,
                this,
                std::placeholders::_1,
                std::placeholders::_2)
        },
    };
}

ad::rss::map::RssMode SceneModeEvaluator::Execute(
    ad::rss::map::RssObjectData &egoVehicleObjectData,
    ad::rss::map::RssObjectData &otherObjectData)
{
    auto foundPair{
        mEvaluateFuncMap.find(otherObjectData.type)};
    if (mEvaluateFuncMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << otherObjectData.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second(
        egoVehicleObjectData,
        otherObjectData);
}

// protected func.

// private func.

ad::rss::map::RssMode SceneModeEvaluator::EvaluateOtherVehicleSceneMode(
    ad::rss::map::RssObjectData &egoVehicleObjectData,
    ad::rss::map::RssObjectData &otherVehicleObjectData)
{
    if (ad::rss::world::ObjectType::OtherVehicle != otherVehicleObjectData.type)
    {
        ROS_ERROR_STREAM("invalid " << otherVehicleObjectData.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    otherVehicleObjectData.rssDynamics.responseTime = ad::physics::Duration(2.0);

    VehicleLaneStatus egoVehicleLaneStatus;
    this->EvaluateEgoVehicleLaneStatus(
        egoVehicleObjectData,
        egoVehicleLaneStatus);

    VehicleLaneStatus otherVehicleLaneStatus;
    this->EvaluateOtherVehicleLaneStatus(
        otherVehicleObjectData,
        otherVehicleLaneStatus);

    const bool isNotRelevantMode =
        egoVehicleLaneStatus.isOnRouteableRoad &&
        !egoVehicleLaneStatus.isOnSidewalk &&
        !otherVehicleLaneStatus.isOnRouteableRoad &&
        otherVehicleLaneStatus.isOnSidewalk;
    ad::rss::map::RssMode outputSceneMode{ad::rss::map::RssMode::NotRelevant};
    if (!isNotRelevantMode)
    {
        const bool isUnstructuredMode =
            !egoVehicleLaneStatus.isOnRouteableRoad ||
            egoVehicleLaneStatus.isOnSidewalk ||
            egoVehicleLaneStatus.isOnIntersection ||
            !otherVehicleLaneStatus.isOnRouteableRoad ||
            otherVehicleLaneStatus.isOnSidewalk ||
            otherVehicleLaneStatus.isOnIntersection;
        outputSceneMode =
            isUnstructuredMode ?
            ad::rss::map::RssMode::Unstructured :
            ad::rss::map::RssMode::Structured;
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "initially determined outputSceneMode: " << outputSceneMode);
    if (otherVehicleObjectData.speed < ad::physics::Speed(0.01))
    {
        otherVehicleObjectData.rssDynamics.responseTime = ad::physics::Duration(1.0);
        if (ad::rss::map::RssMode::Structured == outputSceneMode)
        {
            const double egoVehicleObjectDistance{
                this->ComputeDistanceXy(
                    egoVehicleObjectData,
                    otherVehicleObjectData)};
            if (egoVehicleObjectData.speed < ad::physics::Speed(0.01))
            {
                if (egoVehicleObjectDistance < double{10.0})
                {
                    bool otherVehicleOutsideRouteableRoad{false};
                    for (auto laneOccupiedRegion{
                            otherVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin()};
                         laneOccupiedRegion !=
                             otherVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cend();
                         ++laneOccupiedRegion)
                    {
                        const ad::map::lane::Lane &otherVehicleLane{
                            ad::map::lane::getLane(laneOccupiedRegion->laneId)};
                        if (!ad::map::lane::isRouteable(otherVehicleLane))
                        {
                            otherVehicleOutsideRouteableRoad = true;
                        }
                    }

                    if (otherVehicleOutsideRouteableRoad)
                    {
                        outputSceneMode = ad::rss::map::RssMode::Unstructured;
                    }
                    else
                    {
                        const double headingDelta{
                            this->ComputeHeadingDifference(
                                egoVehicleObjectData,
                                otherVehicleObjectData)};
                        if (headingDelta > double{0.2})
                        {
                            outputSceneMode = ad::rss::map::RssMode::Unstructured;
                            this->EmplaceChangeToUnstructuredPositionMap(
                                otherVehicleObjectData);
                        }
                    }
                } // if (egoVehicleObjectDistance < double{10.0})
            } // if (egoVehicleObjectData.speed < ad::physics::Speed(0.01))
            else
            {
                // the ego-vehicle moves
                if (egoVehicleObjectDistance < double{10.0})
                {
                    if (this->IsIdenticalPositionToLastRecord(otherVehicleObjectData))
                    {
                        const auto headingDelta{
                            this->ComputeHeadingDifference(
                                egoVehicleObjectData,
                                otherVehicleObjectData)};
                        ROS_DEBUG_STREAM_COND(
                            false,
                            "headingDelta: " << headingDelta);
                        if (headingDelta > double{0.2})
                        {
                            outputSceneMode = ad::rss::map::RssMode::Unstructured;
                        }
                        else
                        {
                            this->RemoveElementFromChangeToUnstructuredPositionMap(
                                otherVehicleObjectData);
                        }
                    }
                } // if (egoVehicleObjectDistance < double{10.0})
                else
                {
                    this->RemoveElementFromChangeToUnstructuredPositionMap(
                        otherVehicleObjectData);
                } // if (egoVehicleObjectDistance < double{10.0})
            }
        }
        
        if (ad::rss::map::RssMode::Structured == outputSceneMode)
        {
            ROS_DEBUG_STREAM_COND(
                false,
                "chage the accelMax of object id: " << otherVehicleObjectData.id <<
                ", to 0.0");
            otherVehicleObjectData.rssDynamics.alphaLon.accelMax =
                ad::physics::Acceleration{0.0};
        }
    }
    else
    {
        ROS_DEBUG_STREAM_COND(
            false,
            "other vehicle object speed: " << otherVehicleObjectData.speed);
    }

    ROS_DEBUG_STREAM_COND(
        false,
        "outputSceneMode: " << outputSceneMode);

    return outputSceneMode;
}

ad::rss::map::RssMode SceneModeEvaluator::EvaluatePedestrianSceneMode(
    ad::rss::map::RssObjectData &egoVehicleObjectData,
    ad::rss::map::RssObjectData &pedestrianObjectData)
{
    VehicleLaneStatus egoVehicleLaneStatus;
    this->EvaluateEgoVehicleLaneStatus(
        egoVehicleObjectData,
        egoVehicleLaneStatus);

    PedestrianLaneStatus pedestrianLaneStatus;
    this->EvaluatePedestrianLaneStatus(
        pedestrianObjectData,
        pedestrianLaneStatus);

    const bool isNotRelevantMode =
        egoVehicleLaneStatus.isOnRouteableRoad &&
        !egoVehicleLaneStatus.isOnSidewalk &&
        !pedestrianLaneStatus.isOnRoad &&
        pedestrianLaneStatus.isOnSidewalk;

    ad::rss::map::RssMode outputSceneMode =
        isNotRelevantMode ?
        ad::rss::map::RssMode::NotRelevant :
        ad::rss::map::RssMode::Unstructured;

    return outputSceneMode;
}

void SceneModeEvaluator::EvaluateEgoVehicleLaneStatus(
    const ad::rss::map::RssObjectData &egoVehicleObjectData,
    VehicleLaneStatus &outputStatus) const
{
    if (ad::rss::world::ObjectType::EgoVehicle != egoVehicleObjectData.type)
    {
        ROS_ERROR_STREAM("invalid " << egoVehicleObjectData.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputStatus.isOnSidewalk = false;
    outputStatus.isOnRouteableRoad = false;
    outputStatus.isOnIntersection = false;

    for (auto laneOccupiedRegion{
             egoVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin()};
         laneOccupiedRegion !=
             egoVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cend();
         ++laneOccupiedRegion)
    {
        const ad::map::lane::Lane &egoVehicleLane{
            ad::map::lane::getLane(laneOccupiedRegion->laneId)};

        if (ad::map::lane::LaneType::PEDESTRIAN == egoVehicleLane.type)
        {
            outputStatus.isOnSidewalk = true;
        }

        if (ad::map::lane::isRouteable(egoVehicleLane))
        {
            outputStatus.isOnRouteableRoad = true;
        }

        if (ad::map::lane::LaneType::INTERSECTION == egoVehicleLane.type)
        {
            outputStatus.isOnIntersection = true;
        }

        const auto idx{
            std::distance(
                egoVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin(),
                laneOccupiedRegion)};
        ROS_DEBUG_STREAM_COND(
            false,
            "egoVehicle " << idx << ", " << egoVehicleLane.type);
    }
}

void SceneModeEvaluator::EvaluateOtherVehicleLaneStatus(
    const ad::rss::map::RssObjectData &otherVehicleObjectData,
    VehicleLaneStatus &outputStatus) const
{
    if (ad::rss::world::ObjectType::OtherVehicle != otherVehicleObjectData.type)
    {
        ROS_ERROR_STREAM("invalid " << otherVehicleObjectData.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputStatus.isOnSidewalk = false;
    outputStatus.isOnRouteableRoad = false;
    outputStatus.isOnIntersection = false;

    for (auto laneOccupiedRegion{
            otherVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin()};
         laneOccupiedRegion !=
            otherVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cend();
         ++laneOccupiedRegion)
    {
        const ad::map::lane::Lane &otherVehicleLane{
            ad::map::lane::getLane(laneOccupiedRegion->laneId)};
        if (ad::map::lane::LaneType::PEDESTRIAN == otherVehicleLane.type)
        {
            outputStatus.isOnSidewalk = true;
        }

        if (ad::map::lane::isRouteable(otherVehicleLane))
        {
            outputStatus.isOnRouteableRoad = true;
        }

        if (ad::map::lane::LaneType::INTERSECTION == otherVehicleLane.type)
        {
            outputStatus.isOnIntersection = true;
        }

        const auto idx{
            std::distance(
                otherVehicleObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin(),
                laneOccupiedRegion)};
        ROS_DEBUG_STREAM_COND(
            false,
            "otherVehicle " << idx << ", " << otherVehicleLane.type << '\n' <<
            "laneStatus" << outputStatus);
    }

    ROS_DEBUG_STREAM_COND(
        false,
        otherVehicleObjectData.matchObject.mapMatchedBoundingBox);
}

void SceneModeEvaluator::EvaluatePedestrianLaneStatus(
    const ad::rss::map::RssObjectData &pedestrianObjectData,
    PedestrianLaneStatus &outputStatus) const
{
    if (ad::rss::world::ObjectType::Pedestrian != pedestrianObjectData.type)
    {
        ROS_ERROR_STREAM("invalid " << pedestrianObjectData.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputStatus.isOnSidewalk = false;
    outputStatus.isOnRoad = false;

    for (auto laneOccupiedRegion{
             pedestrianObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cbegin()};
         laneOccupiedRegion !=
             pedestrianObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.cend();
         ++laneOccupiedRegion)
    {
        const ad::map::lane::Lane &pedestrianLane{
            ad::map::lane::getLane(laneOccupiedRegion->laneId)};

        if (ad::map::lane::LaneType::PEDESTRIAN == pedestrianLane.type)
        {
            outputStatus.isOnSidewalk = true;
        }
        else
        {
            outputStatus.isOnRoad = true;
        }
    }
}

double SceneModeEvaluator::ComputeDistanceXy(
    const ad::rss::map::RssObjectData &firstObjectData,
    const ad::rss::map::RssObjectData &secondObjectData) const
{
    const double distX =
        firstObjectData.matchObject.enuPosition.centerPoint.x -
        secondObjectData.matchObject.enuPosition.centerPoint.x;
    const double distY =
        firstObjectData.matchObject.enuPosition.centerPoint.y -
        secondObjectData.matchObject.enuPosition.centerPoint.y;

    return std::sqrt(distX * distX + distY * distY);
}

double SceneModeEvaluator::ComputeHeadingDifference(
    const ad::rss::map::RssObjectData &firstObjectData,
    const ad::rss::map::RssObjectData &secondObjectData) const
{
    const double headingDifference =
        firstObjectData.matchObject.enuPosition.heading -
        secondObjectData.matchObject.enuPosition.heading;

    return std::fabs(headingDifference);
}

void SceneModeEvaluator::EmplaceChangeToUnstructuredPositionMap(
    const ad::rss::map::RssObjectData &objectData)
{
    const bool isSuccessfulInserting{
        mChangeToUnstructuredPositionMap.emplace(
            objectData.id,
            objectData.matchObject.enuPosition).second};
    if (!isSuccessfulInserting)
    {
        ROS_ERROR_STREAM(
            "invalid inserting" <<
            "object id: " << objectData.id << '\n' <<
            "enuPosition: " << objectData.matchObject.enuPosition);
        //throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void SceneModeEvaluator::RemoveElementFromChangeToUnstructuredPositionMap(
    const ad::rss::map::RssObjectData &objectData)
{
    const auto foundPair{
        mChangeToUnstructuredPositionMap.find(objectData.id)};
    if (mChangeToUnstructuredPositionMap.end() != foundPair)
    {
        ROS_DEBUG_STREAM_COND(
            false,
            "remove object id: " << foundPair->first <<
            ", from mChangeToUnstructedPositionMap");
        mChangeToUnstructuredPositionMap.erase(foundPair);
    }
}

bool SceneModeEvaluator::IsIdenticalPositionToLastRecord(
    const ad::rss::map::RssObjectData &objectData) const
{
    const auto foundPair{
        mChangeToUnstructuredPositionMap.find(objectData.id)};
    if (mChangeToUnstructuredPositionMap.end() == foundPair)
    {
        ROS_DEBUG_STREAM_COND(
            false,
            "no matched object id: " << objectData.id);
        return false;
    }

    return objectData.matchObject.enuPosition == foundPair->second;
}

} // namespace rss {
