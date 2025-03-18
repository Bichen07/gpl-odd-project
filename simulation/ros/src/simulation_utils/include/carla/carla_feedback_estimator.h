#ifndef _CARLA_FEEDBACK_ESTIMATOR_H_
#define _CARLA_FEEDBACK_ESTIMATOR_H_

#include <mutex>
#include <ros/ros.h>
#include <itri_msgs/CarState.h>
#include <carla_state_2d.h>
#include <carla_topic_manager.h>

namespace carla {

class FeedbackEstimator final
{
    static constexpr int32_t DefaultQueueSize()
    {return int32_t{1};}

public:

    FeedbackEstimator();
    FeedbackEstimator(const FeedbackEstimator &) = delete;
    FeedbackEstimator &operator=(const FeedbackEstimator &) = delete;
    virtual ~FeedbackEstimator();

    const State2d &GetState2d() const;

protected:

private:

    void CarlaCarStateCallback(const itri_msgs::CarState &msg);

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mCarlaCarStateSubscriber;

    std::mutex mMutex;
    std::string mEgoVehicleName;
    State2d mState2d;

    TopicManager mTopicManager;
};

} // namespace carla {

#endif // #ifndef _CARLA_FEEDBACK_ESTIMATOR_H_
