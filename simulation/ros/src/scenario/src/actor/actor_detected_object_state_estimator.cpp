#include <actor_detected_object_state_estimator.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>
#include <vector>

namespace actor
{

    // public func.

    DetectedObjectStateEstimator::DetectedObjectStateEstimator()
        : mDetectedObjectArrayMutex{},
          mPreviousStamp{},
          mPreviousClearStamp{},
          mClearPeriodicSec{DefaultClearPeriodicSec()},
          mPreviousVelocityMap{},
          mAccelerationFilterMap{},
          mObjectAccelMap{}
    {
    }

    const geometry_msgs::Accel &DetectedObjectStateEstimator::GetAccel(const uint32_t objectId)
    {
        // std::lock_guard<std::mutex> guard(mDetectedObjectArrayMutex);
        const auto foundAccel{mObjectAccelMap.find(objectId)};
        if (mObjectAccelMap.end() == foundAccel)
        {
            static const auto zeroAccel{utils::GetZeroGeometryMsgsAccel()};
            ROS_WARN_STREAM("no matched object id: " << objectId << '\n' << "return zero Accel");
            return zeroAccel;
        }

        return foundAccel->second;
    }

    double DetectedObjectStateEstimator::GetYawRate(const uint32_t objectId)
    {
        // std::lock_guard<std::mutex> guard(mDetectedObjectArrayMutex);
        const auto found{mObjectYawRateMap.find(objectId)};
        if (mObjectYawRateMap.end() == found)
        {
            ROS_WARN_STREAM("no matched object id: " << objectId << '\n' << "return zero yaw rate");
            return 0.0;
        }

        return found->second;
    }

    void DetectedObjectStateEstimator::Update(const itri_msgs::DetectedObjectArray &msg)
    {
        // std::lock_guard<std::mutex> guard(mDetectedObjectArrayMutex);

        const double period = msg.header.stamp.toSec() - mPreviousStamp.toSec();
        if (math::IsLessThanOrApprox(period, double{0.0}, double{1.0e-6}))
        {
            ROS_WARN_STREAM("small time period: " << period);
        }

        for (auto object{msg.objects.cbegin()}; object != msg.objects.cend(); ++object)
        {
            auto                      foundPreviousVeloctiy{mPreviousVelocityMap.find(object->id)};
            const TimeStampedVector6d currentStampedVelocity(msg.header.stamp, utils::ConvertToVector6d(object->velocity));
            if (mPreviousVelocityMap.end() == foundPreviousVeloctiy)
            {
                const bool isValidVelocityEmplacement{mPreviousVelocityMap.emplace(object->id, currentStampedVelocity).second};
                if (!isValidVelocityEmplacement)
                {
                    ROS_WARN_STREAM(std::setprecision(7) << "invalid velocity emplacement with the detected object id: " << object->id);
                }

                AccelerationFilter accelerationFilter(10ul);
                accelerationFilter.Push(math::Vector6d_t::Zero());
                const bool isValidAccelerationEmplacement{mAccelerationFilterMap.emplace(object->id, accelerationFilter).second};
                if (!isValidAccelerationEmplacement)
                {
                    ROS_WARN_STREAM("invalid acceleration emplacemenet with the detected object id: " << object->id);
                }
                continue;
            }

            const double period = msg.header.stamp.toSec() - foundPreviousVeloctiy->second.stamp.toSec();
            if (math::IsLessThanOrApprox(period, double{0.0}, double{1.0e-6}))
            {
                ROS_WARN_STREAM(std::setprecision(7)
                                << std::fixed << "object id: " << foundPreviousVeloctiy->first << ", small time period: " << period);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            const math::Vector6d_t currentAcceleration = (currentStampedVelocity.data - foundPreviousVeloctiy->second.data) / period;

            auto foundAccelerationFilter{mAccelerationFilterMap.find(object->id)};
            foundAccelerationFilter->second.Push(currentAcceleration);
            foundPreviousVeloctiy->second = currentStampedVelocity;

            auto                   foundPreviousYaw{mPreviousYawMap.find(object->id)};
            const math::Vector3d_t rotationAngle = math::ToEulerAngleXyz(utils::ConvertToQuaternion(object->pose.orientation).toRotationMatrix());
            const double           currentYaw    = rotationAngle.z();
            if (mPreviousYawMap.end() == foundPreviousYaw)
            {
                const bool isValidYawEmplacement{mPreviousYawMap.emplace(object->id, currentYaw).second};
                if (!isValidYawEmplacement)
                {
                    ROS_WARN_STREAM(std::setprecision(7) << "invalid yaw emplacement with the detected object id: " << object->id);
                }

                YawRateFilter yawRateFilter(10ul);
                yawRateFilter.Push(0.0);
                const bool isValidYawRateEmplacement{mYawRateFilterMap.emplace(object->id, yawRateFilter).second};
                if (!isValidYawRateEmplacement)
                {
                    ROS_WARN_STREAM("invalid yaw rate emplacemenet with the detected object id: " << object->id);
                }
                continue;
            }

            if (math::IsLessThanOrApprox(period, double{0.0}, double{1.0e-6}))
            {
                ROS_WARN_STREAM(std::setprecision(7)
                                << std::fixed << "object id: " << foundPreviousVeloctiy->first << ", small time period: " << period);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            const double currentYawRate = (currentYaw - foundPreviousYaw->second) / period;
            auto         foundYawRateFilter{mYawRateFilterMap.find(object->id)};
            foundYawRateFilter->second.Push(currentYawRate);
            foundPreviousYaw->second = currentYaw;
        }

        const double lastClearPeriod = msg.header.stamp.toSec() - mPreviousClearStamp.toSec();

        if (lastClearPeriod > mClearPeriodicSec)
        {
            // clear the old data
            std::vector<uint32_t> idsToErase;
            for (auto velocityPair{mPreviousVelocityMap.begin()}; velocityPair != mPreviousVelocityMap.end(); ++velocityPair)
            {
                const double latestPeriod = msg.header.stamp.toSec() - velocityPair->second.stamp.toSec();
                if (latestPeriod > mClearPeriodicSec)
                {
                    idsToErase.push_back(velocityPair->first);
                }
            }
            for (auto &id : idsToErase)
            {
                mAccelerationFilterMap.erase(id);
                mPreviousVelocityMap.erase(id);

                mYawRateFilterMap.erase(id);
                mPreviousYawMap.erase(id);
            }
        }

        this->UpdateObjectAccelMap(mAccelerationFilterMap, mObjectAccelMap);
        this->UpdateObjectYawRateMap(mYawRateFilterMap, mObjectYawRateMap);

        mPreviousStamp = msg.header.stamp;
    }

    // protected func.

    // private func.

    void DetectedObjectStateEstimator::UpdateObjectAccelMap(const AccelerationFilterMap &accelerationFilterMap,
                                                            GeometryMsgsAccelMap        &outputObjectAccelMap) const
    {
        outputObjectAccelMap.clear();
        for (auto filterPair{accelerationFilterMap.cbegin()}; filterPair != accelerationFilterMap.cend(); ++filterPair)
        {
            const auto outputAccel{utils::ConvertToGeometryMsgsAccel(filterPair->second.ComputeAverage())};
            const bool isValid{outputObjectAccelMap.emplace(filterPair->first, outputAccel).second};
            if (!isValid)
            {
                ROS_ERROR_STREAM("invalid object id: " << filterPair->first);
            }
        }
    }

    void DetectedObjectStateEstimator::UpdateObjectYawRateMap(const YawRateFilterMap &yawRateFiltermap, YawRateMap &outputObjectYawRateMap) const
    {
        outputObjectYawRateMap.clear();
        for (auto filterPair{yawRateFiltermap.cbegin()}; filterPair != yawRateFiltermap.cend(); ++filterPair)
        {
            const auto outputYawRate{filterPair->second.ComputeAverage()};
            const bool isValid{outputObjectYawRateMap.emplace(filterPair->first, outputYawRate).second};
            if (!isValid)
            {
                ROS_ERROR_STREAM("invalid object id: " << filterPair->first);
            }
        }
    }

}  // namespace actor
