#ifndef _RSS_SCENE_MODE_EVALUATOR_H_
#define _RSS_SCENE_MODE_EVALUATOR_H_

#include <map>
#include <functional>
#include <ad/rss/map/RssObjectData.hpp>
#include <ad/rss/map/RssSceneCreation.hpp>
#include <rss_pedestrian_lane_status.h>
#include <rss_vehicle_lane_status.h>

namespace rss {

class SceneModeEvaluator final
{

public:

    SceneModeEvaluator();
    SceneModeEvaluator(const SceneModeEvaluator &) = delete;
    SceneModeEvaluator &operator=(const SceneModeEvaluator &) = delete;
    virtual ~SceneModeEvaluator() = default;

    ad::rss::map::RssMode Execute(
        ad::rss::map::RssObjectData &egoVehicleObjectData,
        ad::rss::map::RssObjectData &otherObjectData);

protected:

private:

    using EvaluateFunc = std::function<ad::rss::map::RssMode (
        ad::rss::map::RssObjectData &,
        ad::rss::map::RssObjectData &)>;
    using EvaluateFuncMap = std::map<ad::rss::world::ObjectType, EvaluateFunc>;
    using ChangeToUnstructuredPositionMap =
        std::map<ad::rss::world::ObjectId, ad::map::match::ENUObjectPosition>;

    ad::rss::map::RssMode EvaluateOtherVehicleSceneMode(
        ad::rss::map::RssObjectData &egoVehicleObjectData,
        ad::rss::map::RssObjectData &otherVehicleObjectData);
    ad::rss::map::RssMode EvaluatePedestrianSceneMode(
        ad::rss::map::RssObjectData &egoVehicleObjectData,
        ad::rss::map::RssObjectData &pedestrianObjectData);
    void EvaluateEgoVehicleLaneStatus(
        const ad::rss::map::RssObjectData &egoVehicleObjectData,
        VehicleLaneStatus &outputStatus) const;
    void EvaluateOtherVehicleLaneStatus(
        const ad::rss::map::RssObjectData &otherVehicleObjectData,
        VehicleLaneStatus &outputStatus) const;
    void EvaluatePedestrianLaneStatus(
        const ad::rss::map::RssObjectData &pedestrianObjectData,
        PedestrianLaneStatus &outputStatus) const;
    double ComputeDistanceXy(
        const ad::rss::map::RssObjectData &firstObjectData,
        const ad::rss::map::RssObjectData &secondObjectData) const;
    double ComputeHeadingDifference(
        const ad::rss::map::RssObjectData &firstObjectData,
        const ad::rss::map::RssObjectData &secondObjectData) const;
    void EmplaceChangeToUnstructuredPositionMap(
        const ad::rss::map::RssObjectData &objectData);
    void RemoveElementFromChangeToUnstructuredPositionMap(
        const ad::rss::map::RssObjectData &objectData);
    bool IsIdenticalPositionToLastRecord(
        const ad::rss::map::RssObjectData &objectData) const;

    EvaluateFuncMap mEvaluateFuncMap;
    ChangeToUnstructuredPositionMap mChangeToUnstructuredPositionMap;
};

} // namespace rss {

#endif // #ifndef _RSS_SCENE_MODE_EVALUATOR_H_
