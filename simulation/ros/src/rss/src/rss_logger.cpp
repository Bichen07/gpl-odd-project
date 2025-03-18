#include <rss_logger.h>
#include <iostream>
#include <stdexcept>
#include <ros/console.h>

namespace rss {

// public func.

Logger::Logger()
    : mOutputFileStream{}
{
}

Logger::~Logger()
{
    if (mOutputFileStream.is_open())
    {
        mOutputFileStream.flush();
        mOutputFileStream.close();
    }
}

void Logger::Configure(
    const std::string &fileName,
    const int32_t precisionDigits)
{
    mOutputFileStream.open(fileName, std::ofstream::out | std::ofstream::trunc);
    if (!mOutputFileStream.good())
    {
        ROS_ERROR_STREAM("file stream is not good, file name: " << fileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mOutputFileStream << std::setprecision(precisionDigits) << std::fixed;
    mOutputFileStream << std::boolalpha;
}

void Logger::Record(
    const ad::rss::world::TimeIndex &timeIndex,
    const CheckResult &checkResult,
    const EgoVehicleInputParam &egoVehicleInputParam,
    const ObjectInputParamMap &objectInputParamMap)
{
    std::vector<uint32_t> dangerousDetectedObjectIds;
    this->CollectDangerousDetectedObjectIds(
        checkResult.objectStates,
        dangerousDetectedObjectIds);
    if (dangerousDetectedObjectIds.empty())
    {
        return;
    }
    else
    {
        ROS_DEBUG_STREAM_COND(
            false,
            "rssTimeIndex: " << timeIndex <<
            ", dangerous objects exist");
    }

    mOutputFileStream << "rss time index: " << timeIndex << '\n';
    this->RecordEgoVehicleState(egoVehicleInputParam);
    this->RecordObjectState(
        dangerousDetectedObjectIds,
        checkResult.objectStates);
}

// protected func.

// private func.

void Logger::CollectDangerousDetectedObjectIds(
    const std::vector<CheckResultObjectState> &objectStates,
    std::vector<uint32_t> &outputDangerousDetectedObjectIds) const
{
    outputDangerousDetectedObjectIds.clear();
    outputDangerousDetectedObjectIds.reserve(objectStates.size());

    for (auto objectState{objectStates.cbegin()};
         objectState != objectStates.cend();
         ++objectState)
    {
        if (this->IsUnsafe(*objectState))
        {
            outputDangerousDetectedObjectIds.push_back(
                objectState->detectedObjectId);
        }
    }
}

void Logger::RecordEgoVehicleState(
    const EgoVehicleInputParam &egoVehicleInputParam)
{
    mOutputFileStream << "[ego-vhielce]" << '\n' <<
        "id: " << egoVehicleInputParam.id << '\n' <<
        "position: " << egoVehicleInputParam.transform.GetPosition().transpose() << '\n' <<
        "orientatino: " << egoVehicleInputParam.transform.GetQuaternion() << '\n' <<
        "linearVelocity: " << egoVehicleInputParam.linearVelocity.transpose() << '\n' <<
        "angularVelocity: " << egoVehicleInputParam.angularVelocity.transpose() << '\n' <<
        "linearAcceleration: " << egoVehicleInputParam.linearAcceleration.transpose() << '\n' <<
        "angularAcceleration: " << egoVehicleInputParam.angularAcceleration.transpose() << '\n' <<
        "speed: " << egoVehicleInputParam.speed << '\n' <<
        "yawRate: " << egoVehicleInputParam.yawRate << '\n' <<
        "steeringAngle: " << egoVehicleInputParam.steeringAngle << '\n' <<
        "speedCmd: " << egoVehicleInputParam.speedCmd << '\n' <<
        "steeringCmd: " << egoVehicleInputParam.steerCmd << '\n' <<
        "accelerationCmd: " << egoVehicleInputParam.accelerationCmd << '\n' <<
        "isProperResponse: " << static_cast<bool>(egoVehicleInputParam.accelerationCmd < 0.0) <<
        std::endl;
}

void Logger::RecordObjectState(
    const std::vector<uint32_t> &dangerousDetectedObjectIds,
    const std::vector<CheckResultObjectState> &objectStates)
{
    for (auto detectedObjectId{dangerousDetectedObjectIds.cbegin()};
         detectedObjectId != dangerousDetectedObjectIds.cend();
         ++detectedObjectId)
    {
        auto foundObjectState{
            std::find_if(
                objectStates.cbegin(),
                objectStates.cbegin(),
                [&detectedObjectId](const CheckResultObjectState &objectState)
                {return objectState.detectedObjectId == *detectedObjectId;})};
        if (objectStates.cend() == foundObjectState)
        {
            ROS_ERROR_STREAM("invalid detectedObjectId: " << *detectedObjectId);
            throw std::invalid_argument(std::string(__FILE__) + std::to_string(__LINE__));
        }

        mOutputFileStream <<
            "dangerous detected object id: " << foundObjectState->detectedObjectId << '\n' <<
            foundObjectState->objectClassId << '\n';
        if (ad::rss::situation::SituationType::Unstructured ==
            foundObjectState->rssSituation.situationType)
        {
            mOutputFileStream <<
                "[UnstructuredSafety]" << '\n' <<
                foundObjectState->unstructuredSafety.status << '\n' <<
                foundObjectState->unstructuredSafety.response << std::endl;
        }
        else
        {
            mOutputFileStream <<
                foundObjectState->structuredSafety << '\n' <<
                "longitudinalState" << '\n' <<
                foundObjectState->rssState.longitudinalState << '\n' <<
                "lateralStateRight" << '\n' <<
                foundObjectState->rssState.lateralStateRight << '\n' <<
                "lateralStateLeft" << '\n' <<
                foundObjectState->rssState.lateralStateLeft << std::endl;
        }
    }
}

bool Logger::IsUnsafe(const CheckResultObjectState &objectState) const
{
    if (ad::rss::situation::SituationType::Unstructured ==
        objectState.rssSituation.situationType)
    {
        if (SafetyStatus::Dangerous == objectState.unstructuredSafety.status)
        {
            ROS_DEBUG_STREAM_COND(
                false,
                "unstructuredSafetyStatus: " << objectState.unstructuredSafety.status);
            return true;
        }
    }
    else
    {
        if (SafetyStatus::Dangerous == objectState.structuredSafety.status)
        {
            ROS_DEBUG_STREAM_COND(
                false,
                "structuredSafetyStatus: " << objectState.structuredSafety.status);
            return true;
        }
    }

    return false;
}

} // namespace rss {
