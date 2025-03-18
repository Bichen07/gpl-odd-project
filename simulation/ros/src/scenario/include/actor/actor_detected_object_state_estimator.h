#ifndef _ACTOR_DETECTED_OBJECT_STATE_ESTIMATOR_H_
#define _ACTOR_DETECTED_OBJECT_STATE_ESTIMATOR_H_

#include <mutex>
#include <map>
#include <ros/ros.h>
#include <geometry_msgs/Accel.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <math_moving_average_filter.h>
#include <utils_time_stamped_data.h>

namespace actor
{

    class DetectedObjectStateEstimator final
    {
        static constexpr double DefaultClearPeriodicSec()
        {
            return double{10.0};
        }

    public:
        DetectedObjectStateEstimator();
        DetectedObjectStateEstimator(const DetectedObjectStateEstimator &)            = delete;
        DetectedObjectStateEstimator &operator=(const DetectedObjectStateEstimator &) = delete;
        virtual ~DetectedObjectStateEstimator()                                       = default;

        const geometry_msgs::Accel &GetAccel(const uint32_t objectId);
        double                      GetYawRate(const uint32_t objectId);
        void                        Update(const itri_msgs::DetectedObjectArray &msg);

    protected:
    private:
        using TimeStampedVector6d   = utils::TimeStampedData<math::Vector6d_t>;
        using YawMap                = std::map<uint32_t, double>;
        using VelocityMap           = std::map<uint32_t, TimeStampedVector6d>;
        using AccelerationFilter    = math::MovingAverageFilter<math::Vector6d_t>;
        using YawRateFilter         = math::MovingAverageFilter<double>;
        using AccelerationFilterMap = std::map<uint32_t, AccelerationFilter>;
        using YawRateFilterMap      = std::map<uint32_t, YawRateFilter>;
        using GeometryMsgsAccelMap  = std::map<uint32_t, geometry_msgs::Accel>;
        using YawRateMap            = std::map<uint32_t, double>;
        static constexpr int32_t DefaultQueueSize()
        {
            return int32_t{1};
        }

        void UpdateObjectAccelMap(const AccelerationFilterMap &accelerationFilterMap, GeometryMsgsAccelMap &outputObjectAccelMap) const;
        void UpdateObjectYawRateMap(const YawRateFilterMap &yawRateFiltermap, YawRateMap &outputObjectYawRateMap) const;

        std::mutex            mDetectedObjectArrayMutex;
        ros::Time             mPreviousStamp;
        ros::Time             mPreviousClearStamp;
        double                mClearPeriodicSec;
        VelocityMap           mPreviousVelocityMap;
        AccelerationFilterMap mAccelerationFilterMap;
        GeometryMsgsAccelMap  mObjectAccelMap;
        YawRateMap            mObjectYawRateMap;
        YawMap                mPreviousYawMap;
        YawRateFilterMap      mYawRateFilterMap;
    };

}  // namespace actor

#endif  // #ifndef _ACTOR_DETECTED_OBJECT_STATE_ESTIMATOR_H_

