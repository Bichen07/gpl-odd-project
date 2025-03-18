#include <actor_object_class_evaluator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <geometry_convex_hull_2d.h>
#include <geometry_utils.h>

namespace actor {

// public func.

ObjectClassEvaluator::ObjectClassEvaluator()
    : mObjectClassLabelMap{}
    , mObjectClassRefSizeMap{}
    , mObjectClassAreaPairs{}
{
    for (int32_t classIdx{0};
         classIdx < static_cast<int32_t>(ObjectClass::Num);
         ++classIdx)
    {
        const auto specifiedId{static_cast<ObjectClassId>(classIdx)};
        const bool isSuccessfulInserting = mObjectClassLabelMap.emplace(
            specifiedId,
            actor::ToObjectClassLabel(specifiedId)).second;
        if (!isSuccessfulInserting)
        {
            ROS_ERROR_STREAM("invalid " << specifiedId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    mObjectClassRefSizeMap = std::map<ObjectClassId, geometry::Vector2d>
    {
        {ObjectClass::Car,       geometry::Vector2d(double{5.0}, double{1.8})},
        //{ObjectClass::Truck,     geometry::Vector2d(double{12.5}, double{2.3})},
        {ObjectClass::Bus,       geometry::Vector2d(double{9.4}, double{2.3})},
        //{ObjectClass::Bicycle,   geometry::Vector2d(double{1.5}, double{0.7})},
        {ObjectClass::Motorbike, geometry::Vector2d(double{1.5}, double{0.7})},
        {ObjectClass::Person,    geometry::Vector2d(double{0.335}, double{0.558})}
    };

    mObjectClassAreaPairs.resize(mObjectClassRefSizeMap.size());
    auto objectClassAreaPair{mObjectClassAreaPairs.begin()};
    for (auto refSizePair{mObjectClassRefSizeMap.cbegin()};
         refSizePair != mObjectClassRefSizeMap.cend();
         ++refSizePair, ++objectClassAreaPair)
    {
        objectClassAreaPair->first = refSizePair->first;
        objectClassAreaPair->second =
            double{0.5} * refSizePair->second.x() * refSizePair->second.y();
    }

    std::sort(
        mObjectClassAreaPairs.begin(),
        mObjectClassAreaPairs.end(),
        [](const ObjectClassAreaPair &left, const ObjectClassAreaPair &right)
        {return left.second < right.second;});
}

void ObjectClassEvaluator::Execute(itri_msgs::DetectedObjectArray &detectedObjectArray)
{
    for (auto detectedObject{detectedObjectArray.objects.begin()};
         detectedObject != detectedObjectArray.objects.cend();
         ++detectedObject)
    {
        detectedObject->label = this->Execute(*detectedObject);
    }
}

std::string ObjectClassEvaluator::Execute(const itri_msgs::DetectedObject &detectedObject)
{
    if (this->IsValidLabel(detectedObject.label))
    {
        return detectedObject.label;
    }

    const auto outputLabel{this->EstimateBySize(detectedObject)};

    ROS_DEBUG_STREAM_COND(
        true,
        "evaluate object label" << '\n' <<
        "detected_object_id: " << detectedObject.id << '\n' <<
        "original label: " << detectedObject.label << '\n' <<
        "evaluated label: " << outputLabel);

    return outputLabel;
}

// protected func.

// private func.

std::string ObjectClassEvaluator::EstimateBySize(
    const itri_msgs::DetectedObject &detectedObject) const
{
    const auto detectedConvexHull{
        geometry::ConvexHull2d(detectedObject.convex_hull.polygon)};
    const double detectedObjectArea{
        geometry::ComputeArea(detectedConvexHull.GetPolygon())};
    const auto areaFilteringObjectClassPair{
        std::lower_bound(
            mObjectClassAreaPairs.cbegin(),
            mObjectClassAreaPairs.cend(),
            std::make_pair(ObjectClass::Null, detectedObjectArea),
            [](const ObjectClassAreaPair &left, const ObjectClassAreaPair &right)
            {return left.second < right.second;})};

    //auto areaFilteringObjectClassPair{mObjectClassAreaMap.cend()};
    //for (auto objectClassAreaPair{mObjectClassAreaMap.cbegin()};
    //     objectClassAreaPair != mObjectClassAreaMap.cend();
    //     ++objectClassAreaPair)
    //{
    //    if (math::IsGreaterThanOrApprox(
    //            objectClassAreaPair->second,
    //            detectedObjectArea,
    //            double{1.0e-5}))
    //    {
    //        areaFilteringObjectClassPair = objectClassAreaPair;
    //        break;
    //    }
    //}

    const ObjectClassId outputObjectClassId =
        mObjectClassAreaPairs.cend() == areaFilteringObjectClassPair ?
        mObjectClassAreaPairs.crbegin()->first :
        areaFilteringObjectClassPair->first;

    return actor::ToObjectClassLabel(outputObjectClassId);
}

bool ObjectClassEvaluator::IsValidLabel(const std::string &label) const
{
    if (label.empty())
    {
        return false;
    }

    const auto foundLabelPair{
        std::find_if(
            mObjectClassLabelMap.cbegin(),
            mObjectClassLabelMap.cend(),
            [&label](const std::pair<ObjectClassId, std::string> &labelPair)
            {return labelPair.second == label;})};

    return mObjectClassLabelMap.cend() != foundLabelPair ? true : false;
}

} // namespace actor {
