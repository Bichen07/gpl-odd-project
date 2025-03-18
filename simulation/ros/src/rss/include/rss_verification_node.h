#ifndef _RSS_VERIFICATION_NODE_H_
#define _RSS_VERIFICATION_NODE_H_

#include <mutex>
#include <functional>
#include "std_msgs/Bool.h"
#include <ros/ros.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <utils_detected_object_coord_converter.h>
#include <actor_detected_object_state_estimator.h>
#include <actor_object_class_evaluator.h>
#include <rss_msgs/EgoVehicleData.h>
#include <rss_msgs/ObjectData.h>
#include <rss_msgs/ObjectDataArray.h>
#include <rss_ego_vehicle_data_generator.h>
#include <scenario_msgs/AgentDataArray.h>
#include <rss_verifier.h>

namespace rss
{

    class VerificationNode final
    {
        static constexpr int32_t DefaultQueueSize()
        {
            return int32_t{1};
        }

    public:
        static constexpr double DefaultNodeFrequency()
        {
            return double{10.0};
        }

        VerificationNode();
        VerificationNode(const VerificationNode &)            = delete;
        VerificationNode &operator=(const VerificationNode &) = delete;
        virtual ~VerificationNode()                           = default;

        void Configure(const double nodeFrequency = DefaultNodeFrequency());
        void RunMainLoop();

    protected:
    private:
        void Verify(CheckResult &outputCheckResult, ad::rss::state::ProperResponse &properResponse);

        void DetectedObjectArrayCallback(const itri_msgs::DetectedObjectArray &msg);
        void AgentStatesCallback(const scenario::AgentStates &msg);
        void CanStartObservationSamplingCallback(const std_msgs::Bool &msg);

        ros::NodeHandle                     mNodeHandle;
        ros::Subscriber                     mDetectedObjectArraySubscriber;
        ros::Subscriber                     mAgentStatesSubscriber;
        ros::Subscriber                     mCanStartObservationSamplingSubscriber;
        ros::Publisher                      mCheckResultPublisher;
        ros::Publisher                      mProperResponsePublisher;
        ros::Publisher                      mLandmarkArrayPublisher;
        std::mutex                          mDetectedObjectArrayMutex;
        double                              mNodeFrequency;
        Verifier                            mVerifier;
        EgoVehicleDataGenerator             mEgoVehicleDataGenerator;
        actor::DetectedObjectStateEstimator mDetectedObjectStateEstimator;
        actor::ObjectClassEvaluator         mObjectClassEvaluator;
        utils::DetectedObjectCoordConverter mDetectedObjectCoordConverter;
        rss_msgs::ObjectDataArray           mObjectDataArray;
        itri_msgs::DetectedObjectArray      mDetectedObjectArray;
        scenario::AgentStates               mAgentStates;
        bool                                mIsDetectedObjectArrayReady;
        bool                                mCanStartObservationSampling;
    };

}  // namespace rss

#endif  // #ifndef _RSS_VERIFICATION_NODE_H_
