#include <rss_verification_node.h>
#include <stdexcept>
#include "std_msgs/Bool.h"
#include <ros/console.h>
#include <utils_ros_param.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <rss_check_result.h>
#include <rss_proper_response.h>
#include <rss_converter.h>
#include <rss_utils.h>

namespace rss
{

    // public func.

    VerificationNode::VerificationNode()
        : mNodeHandle{},
          mDetectedObjectArraySubscriber{},
          mCheckResultPublisher{},
          mLandmarkArrayPublisher{},
          mDetectedObjectArrayMutex{},
          mNodeFrequency{DefaultNodeFrequency()},
          mVerifier{},
          mEgoVehicleDataGenerator{},
          mDetectedObjectStateEstimator{},
          mObjectClassEvaluator{},
          mDetectedObjectCoordConverter{},
          mObjectDataArray{},
          mIsDetectedObjectArrayReady{false},
          mCanStartObservationSampling{false}
    {
        mDetectedObjectArraySubscriber =
            mNodeHandle.subscribe("detected_objects", DefaultQueueSize(), &VerificationNode::DetectedObjectArrayCallback, this);
        mAgentStatesSubscriber =
            mNodeHandle.subscribe("/esmini_simulator/agent_states", DefaultQueueSize(), &VerificationNode::AgentStatesCallback, this);
        mCheckResultPublisher    = mNodeHandle.advertise<rss_msgs::CheckResult>("rss/check_result", DefaultQueueSize());
        mLandmarkArrayPublisher  = mNodeHandle.advertise<rss_msgs::LandmarkArray>("rss/landmark_array", DefaultQueueSize());
        mProperResponsePublisher = mNodeHandle.advertise<rss_msgs::ProperResponse>("rss/proper_response", DefaultQueueSize());

        mCanStartObservationSamplingSubscriber =
            mNodeHandle.subscribe("can_start_observation_sampling", DefaultQueueSize(), &VerificationNode::CanStartObservationSamplingCallback, this);
    }

    void VerificationNode::Configure(const double nodeFrequency)
    {
        ROS_ERROR_STREAM("RSS VERFI IN CONFIGURE");
        if (nodeFrequency < double{1.0})
        {
            ROS_ERROR_STREAM("nodeFrequency: " << nodeFrequency << " is too small");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        mNodeFrequency = nodeFrequency;

        mVerifier.Configure();

        geometry_msgs::Vector3 egoVehicleSize;
        egoVehicleSize.x = utils::GetRosParam<double>("vehicle_length");
        egoVehicleSize.y = utils::GetRosParam<double>("vehicle_width") + utils::GetRosParam<double>("side_mirror_length");
        egoVehicleSize.z = 1.777;
        static constexpr double minSize{0.5};
        if (egoVehicleSize.x < minSize || egoVehicleSize.y < minSize || egoVehicleSize.z < minSize)
        {
            ROS_ERROR_STREAM("invalid ego-vehicle size" << '\n'
                                                        << "x: " << egoVehicleSize.x << ", y: " << egoVehicleSize.y << ", z: " << egoVehicleSize.z);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        mEgoVehicleDataGenerator.Configure("ego_vehicle", egoVehicleSize);

        mLandmarkArrayPublisher.publish(mVerifier.GetLandmarkArray());
    }

    void VerificationNode::RunMainLoop()
    {
        ros::Rate                      nodeRate(mNodeFrequency);
        CheckResult                    checkResult;
        ad::rss::state::ProperResponse properResponse;

        bool canShowCheckResult{false};
        ros::param::get("/rss/can_show_check_result", canShowCheckResult);
        while (ros::ok())
        {
            // bool inSimulation{false};
            // ros::param::get("/rss/in_simulation", inSimulation);
            //
            // // ROS_ERROR_STREAM("[rss_verification_node] mCanStartObservationSampling: " << mCanStartObservationSampling
            // //                                                                           << ", inSimulation: " << inSimulation);
            // if (!mCanStartObservationSampling)
            // {
            //     continue;
            // }

            try
            {
                this->Verify(checkResult, properResponse);

                rss_msgs::CheckResult checkResultMsg;
                rss::ToCheckResultMsg(checkResult, checkResultMsg);

                rss_msgs::ProperResponse properResponseMsg;
                rss::ToProperResponseMsg(properResponse, properResponseMsg);

                // for (const auto &state : checkResultMsg.object_states)
                // {
                //     ROS_ERROR_STREAM("rss state: " << state.rss_state);
                //     ROS_ERROR_STREAM("situation type: " << state.situation_type);
                //     ROS_ERROR_STREAM("strutured safety: " << state.structured_safety);
                //     ROS_ERROR_STREAM("unstrutured response: " << state.unstructured_safety.response);
                //     ROS_ERROR_STREAM("unstrutured status: " << state.unstructured_safety.status);
                // }

                if (!checkResultMsg.object_states.empty())
                {
                    mCheckResultPublisher.publish(checkResultMsg);
                }
                mProperResponsePublisher.publish(properResponseMsg);
                ros::spinOnce();
                nodeRate.sleep();
            }
            catch (std::out_of_range error)
            {
                ROS_DEBUG_STREAM(error.what());
            }
        }
    }

    // protected func.

    // private func.

    void VerificationNode::Verify(CheckResult &outputCheckResult, ad::rss::state::ProperResponse &outputProperResponse)
    {
        // std::lock_guard<std::mutex> detectedObjectArrayGuard(mDetectedObjectArrayMutex);
        if (!mEgoVehicleDataGenerator.IsReady() || !mIsDetectedObjectArrayReady)
        {
            return;
        }

        // itri_msgs::DetectedObjectArray worldDetectedObjectArray;
        // mDetectedObjectCoordConverter.ToWorldCoord(mDetectedObjectArray, worldDetectedObjectArray);
        // mObjectClassEvaluator.Execute(worldDetectedObjectArray);
        // rss::ToObjectDataArrayMsg(worldDetectedObjectArray, mObjectDataArray);

        // for (auto objectData{mObjectDataArray.datas.begin()}; objectData != mObjectDataArray.datas.end(); ++objectData)
        // {
        //     objectData->accel    = mDetectedObjectStateEstimator.GetAccel(objectData->detected_object_id);
        //     objectData->yaw_rate = mDetectedObjectStateEstimator.GetYawRate(objectData->detected_object_id);
        // }

        mVerifier.Run(mEgoVehicleDataGenerator.ComputeRssEgoVehicleData(), mAgentStates, outputCheckResult, outputProperResponse);
    }

    void VerificationNode::DetectedObjectArrayCallback(const itri_msgs::DetectedObjectArray &msg)
    {
        // std::lock_guard<std::mutex> guard(mDetectedObjectArrayMutex);
        mDetectedObjectArray = msg;
        mDetectedObjectStateEstimator.Update(mDetectedObjectArray);
        mIsDetectedObjectArrayReady = true;
    }

    void VerificationNode::AgentStatesCallback(const scenario::AgentStates &msg)
    {
        // std::lock_guard<std::mutex> guard(mDetectedObjectArrayMutex);
        mAgentStates = msg;
    }

    void VerificationNode::CanStartObservationSamplingCallback(const std_msgs::Bool &msg)
    {
        mCanStartObservationSampling = msg.data;
        ROS_DEBUG_STREAM("[rss_verification_node] callback, set mCanStartObservationSampling: " << mCanStartObservationSampling);
    }

}  // namespace rss
