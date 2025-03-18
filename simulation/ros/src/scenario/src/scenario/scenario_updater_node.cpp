#include <scenario_updater_node.h>
#include <ros/console.h>
#include <ros/rate.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <scenario_msgs/AgentData.h>
#include <scenario_msgs/AgentDataArray.h>
#include <simulation_srvs/SimulationUpdateAgentsData.h>
#include <actor_object_class_id.h>
#include <scenario_detected_agent_data.h>
#include <utils_converter.h>
#include <stdio.h>

namespace scenario
{

    // public func.

    scenario_msgs::AgentData DetectedAgentDataToAgentData(DetectedAgentData &detectedAgentData)
    {
        scenario_msgs::AgentData agentData;
        agentData.agent_id        = detectedAgentData.attribute.id;
        agentData.pose            = utils::ConvertToGeometryMsgsPose(detectedAgentData.state.position, detectedAgentData.state.orientation);
        agentData.linear_velocity = utils::ConvertToGeometryMsgsVector3(detectedAgentData.state.linearVelocity);
        agentData.size            = utils::ConvertToGeometryMsgsVector3(detectedAgentData.attribute.size);
        // agentData.polygon
        // agentData.distance
        agentData.color         = detectedAgentData.attribute.color;
        agentData.objectClassId = actor::ToObjectClassLabel(detectedAgentData.attribute.objectClassId);
        return agentData;
    }

    UpdaterNode::UpdaterNode()
        : mNodeHandle{},
          mNodeFrequency{DefaultNodeFrequency()},
          mDetectedObjectIdOffset{DefaultDetectedObjectIdOffset()},
          mSimulatorManager{},
          mDetectedObjectFrequencyEvaluator{},
          mDesiredVisualizationFrequencyEvaluator{},
          mDetectedAgentDatas{},
          mDetectedAgentDataMutex{}
    {
        // mDetectedObjectEvaluationService = mNodeHandle.advertiseService(
        //     "/mr_vil_testing/detected_object_evaluation_service",
        //     &UpdaterNode::RunDetectedObjectEvaluationService,
        //     this);
        mRequestAgentUpdate = mNodeHandle.serviceClient<simulation_srvs::SimulationUpdateAgentsData>("/simulation/agent_srv/update_agent_data");
    }

    UpdaterNode::~UpdaterNode()
    {
    }

    void UpdaterNode::Configure(const double  nodeFrequency,
                                const double  desiredDetectedObjectFrequency,
                                const double  desiredVisualizationFrequency,
                                const int32_t detectedObjectIdOffset)
    {
        std::string scenarioConfigFile;
        while (!mNodeHandle.getParam("scenario/config/file", scenarioConfigFile))
        {
            ros::Duration(3.0).sleep();
            ROS_INFO_STREAM("Waiting for param scenario/config/file...");
        }
        ROS_INFO_STREAM("Get scenarioConfigFile " << scenarioConfigFile << " from parameter scenario/config/file");
        mNodeFrequency = nodeFrequency;
        mDetectedObjectFrequencyEvaluator.Configure(desiredDetectedObjectFrequency);
        mDesiredVisualizationFrequencyEvaluator.Configure(desiredVisualizationFrequency);
        mDetectedObjectIdOffset = detectedObjectIdOffset;
        mSimulatorManager.Configure(mNodeFrequency);
    }

    // bool UpdaterNode::RunDetectedObjectEvaluationService(
    //     DetectedObjectEvaluation::Request &request,
    //     DetectedObjectEvaluation::Response &response)
    // {
    //     std::lock_guard<std::mutex> guard(mDetectedAgentDataMutex);
    //     ros::Time stamp;
    //     stamp.sec = request.stamp.sec;
    //     stamp.nsec = request.stamp.nsec;
    //     mDetectedObjectMsgGenerator.ComputeMsg(
    //         mDetectedAgentDatas,
    //         stamp,
    //         static_cast<Coord_t>(request.coord),
    //         request.objectIdOffset,
    //         &response.objects);
    //     return true;
    // }

    void UpdaterNode::RunMainLoop()
    {
        ros::Rate nodeRate(mNodeFrequency);
        std::cout << "nodeRate: " << mNodeFrequency << std::endl;
        while (ros::ok())
        {
            mSimulatorManager.Update();
            this->Update();
            ros::spinOnce();
            nodeRate.sleep();
        }
    }

    // protected func.

    // private func.

    void UpdaterNode::Update()
    {
        std::lock_guard<std::mutex> guard(mDetectedAgentDataMutex);
        mSimulatorManager.ExtractDetectedAgentData(&mDetectedAgentDatas);
        simulation_srvs::SimulationUpdateAgentsData request;
        request.request.spawnIfNotExist = true;
        request.request.onlyPose        = false;
        request.request.onlyPoint       = false;
        request.request.dt              = 1.0 / mNodeFrequency;
        for (auto &detectedAgent : mDetectedAgentDatas)
        {
            request.request.agents.push_back(DetectedAgentDataToAgentData(detectedAgent));
        }
        mRequestAgentUpdate.call(request);
    }

}  // namespace scenario

