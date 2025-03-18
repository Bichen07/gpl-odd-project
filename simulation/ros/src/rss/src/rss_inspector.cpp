#include <rss_inspector.h>
#include <stdexcept>
#include <ros/console.h>

namespace rss {

// public func.

Inspector::Inspector()
    : mEgoVehicleRssDynamics{}
    , mOtherVehicleRssDynamics{}
    , mUnequalInfo{}
    , mRssDynamicsCheckList{}
{
}

void Inspector::Check(
    const ad::rss::situation::SituationSnapshot &situationSnapshot,
    const ad::rss::state::RssStateSnapshot &stateSnapshot) const
{
    this->CheckSnapshotRssDynamics(
        situationSnapshot,
        stateSnapshot);
    this->CheckSituationRssDynamics(situationSnapshot);
    this->CheckPriority(situationSnapshot);
}

void Inspector::Configure(
    const ad::rss::world::RssDynamics &egoVehicleRssDynamics,
    const ad::rss::world::RssDynamics &otherVehicleRssDynamics)
{
    mEgoVehicleRssDynamics = egoVehicleRssDynamics;
    mOtherVehicleRssDynamics = otherVehicleRssDynamics;
}

// protected func.

// private func.

void Inspector::CheckSnapshotRssDynamics(
        const ad::rss::situation::SituationSnapshot &situationSnapshot,
        const ad::rss::state::RssStateSnapshot &stateSnapshot) const
{
    const bool isEqualSituationEgoVehicleDynamics =
        situationSnapshot.defaultEgoVehicleRssDynamics ==
        mEgoVehicleRssDynamics;
    if (!isEqualSituationEgoVehicleDynamics)
    {
        ROS_ERROR_STREAM(
            "diff. SituationEgoVehicleRssDynamics" << '\n' <<
            "ref: " << '\n' <<
            mEgoVehicleRssDynamics << '\n' <<
            "test: " << '\n' <<
            situationSnapshot.defaultEgoVehicleRssDynamics);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const bool isEqualStateEgoVehicleDynamics =
        stateSnapshot.defaultEgoVehicleRssDynamics ==
        mEgoVehicleRssDynamics;
    if (!isEqualStateEgoVehicleDynamics)
    {
        ROS_ERROR_STREAM(
            "diff. StateEgoVehicleRssDynamics" << '\n' <<
            "ref: " << '\n' <<
            mEgoVehicleRssDynamics << '\n' <<
            "test: " << '\n' <<
            stateSnapshot.defaultEgoVehicleRssDynamics);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void Inspector::CheckSituationRssDynamics(
    const ad::rss::situation::SituationSnapshot &situationSnapshot) const
{
    mRssDynamicsCheckList.maxSpeedOnAcceleration = false;
    for (auto situation{situationSnapshot.situations.cbegin()};
         situation != situationSnapshot.situations.cend();
         ++situation)
    {
        const bool isEqualEgoVehicleRssDynamics{
            this->IsEqualRssDynamics(
                mEgoVehicleRssDynamics,
                situation->egoVehicleState.dynamics)};
        if (!isEqualEgoVehicleRssDynamics)
        {
            ROS_WARN_STREAM(
                "diff. egoVehicleRssDynamics" << '\n' <<
                mUnequalInfo.str());
        }
        const bool isEqualOtherVehicleRssDynamics{
            this->IsEqualRssDynamics(
                mOtherVehicleRssDynamics,
                situation->otherVehicleState.dynamics)};
        if (!isEqualOtherVehicleRssDynamics)
        {
            ROS_WARN_STREAM(
                "diff. otherVehicleRssDynamics" << '\n' <<
                mUnequalInfo.str());
        }
    }
}

void Inspector::CheckPriority(
    const ad::rss::situation::SituationSnapshot &situationSnapshot) const
{
    for (auto situation{situationSnapshot.situations.cbegin()};
         situation != situationSnapshot.situations.cend();
         ++situation)
    {
        //if (ad::rss::situation::SituationType::SameDirection == situation->situationType ||
        //    ad::rss::situation::SituationType::OppositeDirection == situation->situationType)
        //{
        //    ROS_WARN_STREAM(
        //        "invalid situationType of objectId: " << situation->objectId << '\n' <<
        //        "situationType: " << situation->situationType);
        //}

        if (ad::rss::situation::SituationType::NotRelevant == situation->situationType ||
            ad::rss::situation::SituationType::SameDirection == situation->situationType ||
            ad::rss::situation::SituationType::OppositeDirection == situation->situationType)
        {
            if (situation->egoVehicleState.hasPriority ||
                situation->otherVehicleState.hasPriority)
            {
                ROS_ERROR_STREAM(std::boolalpha << '\n' <<
                    "invalid situationType of objectId: " << situation->objectId << '\n' <<
                    "situationType: " << situation->situationType << '\n' <<
                    "egoVehicle hasPriority: " << situation->egoVehicleState.hasPriority << '\n' <<
                    "otherVehicle hasPriority: " << situation->otherVehicleState.hasPriority);
            }
        }

        if (ad::rss::situation::SituationType::IntersectionEgoHasPriority ==
            situation->situationType)
        {
            if (!situation->egoVehicleState.hasPriority ||
                situation->otherVehicleState.hasPriority)
            {
                ROS_ERROR_STREAM(std::boolalpha << '\n' <<
                    "invalid situationType to of objectId: " << situation->objectId << '\n' <<
                    "situationType: " << situation->situationType << '\n' <<
                    "egoVehicle hasPriority: " << situation->egoVehicleState.hasPriority << '\n' <<
                    "otherVehicle hasPriority: " << situation->otherVehicleState.hasPriority);
            }
        }

        if (ad::rss::situation::SituationType::IntersectionObjectHasPriority ==
            situation->situationType)
        {
            if (situation->egoVehicleState.hasPriority ||
                !situation->otherVehicleState.hasPriority)
            {
                ROS_ERROR_STREAM(std::boolalpha << '\n' <<
                    "invalid situationType to of objectId: " << situation->objectId << '\n' <<
                    "situationType: " << situation->situationType << '\n' <<
                    "egoVehicle hasPriority: " << situation->egoVehicleState.hasPriority << '\n' <<
                    "otherVehicle hasPriority: " << situation->otherVehicleState.hasPriority);
            }
        }

        //ROS_INFO_STREAM(std::boolalpha << '\n' <<
        //    "objectId: " << situation->objectId << '\n' <<
        //    "situationType: " << situation->situationType << '\n' <<
        //    "egoVehicle" << '\n' <<
        //    "hasPriority: " << situation->egoVehicleState.hasPriority << '\n' <<
        //    "isInCorrectLane: " << situation->egoVehicleState.isInCorrectLane << '\n' <<
        //    "otherVehicle" << '\n' <<
        //    "hasPriority: " << situation->otherVehicleState.hasPriority << '\n' <<
        //    "isInCorrectLane: " << situation->otherVehicleState.isInCorrectLane);
    }
}

bool Inspector::IsEqualRssDynamics(
    const ad::rss::world::RssDynamics &ref,
    const ad::rss::world::RssDynamics &test) const
{
    mUnequalInfo = std::stringstream();
    if (ref == test)
    {
        return true;
    }

    bool isEqual{true};
    if (mRssDynamicsCheckList.alphaLon &&
        ref.alphaLon != test.alphaLon)
    {
        mUnequalInfo << "diff. alphaLon" << '\n' <<
            "ref" << '\n' <<
            ref.alphaLon << '\n' <<
            "test" << '\n' <<
            test.alphaLon;
        isEqual = false;
    }

    if (mRssDynamicsCheckList.alphaLat &&
        ref.alphaLat != test.alphaLat)
    {
        mUnequalInfo << "diff. alphaLat" << '\n' <<
            "ref" << '\n' <<
            ref.alphaLat << '\n' <<
            "test" << '\n' <<
            ref.alphaLat;
        isEqual = false;
    }

    if (mRssDynamicsCheckList.maxSpeedOnAcceleration &&
        ref.maxSpeedOnAcceleration != test.maxSpeedOnAcceleration)
    {
        mUnequalInfo << "diff. maxSpeedOnAcceleration" << '\n' <<
            "ref: " << ref.maxSpeedOnAcceleration << '\n' <<
            "test: " << test.maxSpeedOnAcceleration;
        isEqual = false;
    }

    if (mRssDynamicsCheckList.unstructuredSettings &&
        ref.unstructuredSettings != test.unstructuredSettings)
    {
        mUnequalInfo << "diff. unstructuredSettings" << '\n' <<
            "ref: " << '\n' <<
            ref.unstructuredSettings << '\n' <<
            "test: " << '\n' <<
            test.unstructuredSettings;
        isEqual = false;
    }

    return isEqual;
}

} // namespace rss {
