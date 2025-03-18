#include <utils_marker_id_manager.h>
#include <ros/console.h>

namespace utils {

// public func.

MarkerIdManager::MarkerIdManager()
    : mBeginId{0}
    , mEndId{0}
    , mCurrentId{0}
    , mMarkerIdMap{}
{
}

MarkerIdManager::~MarkerIdManager()
{
}

void MarkerIdManager::Configure(const int32_t beginId, const int32_t endId)
{
    if (endId < beginId)
    {
        ROS_ERROR_STREAM("invalid beginId: " << beginId << ", endId: " << endId);
    }

    mBeginId = beginId;
    mEndId = endId;
    mCurrentId = mBeginId;
}

int32_t MarkerIdManager::QueryMarkerId(const std::string &objectId)
{
    const auto foundIdPair{mMarkerIdMap.find(objectId)};
    int32_t outputMarkerId{0};
    if (mMarkerIdMap.end() != foundIdPair)
    {
        outputMarkerId = foundIdPair->second;
    }
    else
    {
        outputMarkerId = this->EvaluateNewId();
        mMarkerIdMap.emplace(objectId, outputMarkerId);
    }

    return outputMarkerId;
}

// protected func.

// private func.

int32_t MarkerIdManager::EvaluateNewId()
{
    const int32_t outputId = mCurrentId;
    if (mCurrentId < mEndId)
    {
        ++mCurrentId;
    }
    else
    {
        mCurrentId = mBeginId;
    }

    return outputId;
}

} // namespace utils {
