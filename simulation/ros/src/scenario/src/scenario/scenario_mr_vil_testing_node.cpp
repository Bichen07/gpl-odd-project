#include <scenario_mr_vil_testing_node.h>
#include <ros/console.h>
#include <ros/rate.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <scenario_msgs/AgentDataArray.h>
#include <scenario_detected_agent_data.h>
#include <utils_converter.h>
#include <actor_object_class_id.h>

namespace scenario {

// public func.

scenario_msgs::AgentData DetectedAgentDataToAgentData(
    DetectedAgentData &detectedAgentData)
{
    scenario_msgs::AgentData agentData;
    agentData.agent_id = detectedAgentData.attribute.id;
    agentData.pose = utils::ConvertToGeometryMsgsPose(
        detectedAgentData.state.position, 
        detectedAgentData.state.orientation);
    agentData.linear_velocity = utils::ConvertToGeometryMsgsVector3(
        detectedAgentData.state.linearVelocity);
    agentData.size = utils::ConvertToGeometryMsgsVector3(
        detectedAgentData.attribute.size);
    // agentData.polygon
    // agentData.distance
    agentData.color = detectedAgentData.attribute.color;
    agentData.objectClassId = actor::ToObjectClassLabel(
        detectedAgentData.attribute.objectClassId);
    return agentData;
}

MrVilTestingNode::MrVilTestingNode()
    : mNodeHandle{}
    , mDetectedObjectEvaluationService{}
    , mNodeFrequency{DefaultNodeFrequency()}
    , mDetectedObjectIdOffset{DefaultDetectedObjectIdOffset()}
    , mSimulatorManager{}
    , mDetectedObjectFrequencyEvaluator{}
    , mDesiredVisualizationFrequencyEvaluator{}
    , mDetectedAgentDatas{}
    , mDetectedObjectMsgGenerator{}
    , mDetectedAgentDataMutex{}
{
    mDetectedObjectEvaluationService = mNodeHandle.advertiseService(
        "mr_vil_testing/detected_object_evaluation_service",
        &MrVilTestingNode::RunDetectedObjectEvaluationService,
        this);
    mAgentDataArrayEvaluationService = mNodeHandle.advertiseService(
        "scenaio/agent_data_array_evaluation_service",
        &MrVilTestingNode::RunAgentDataArrayEvaluationService,
        this);
}

MrVilTestingNode::~MrVilTestingNode()
{
}

void MrVilTestingNode::Configure(
    const double nodeFrequency,
    const double desiredDetectedObjectFrequency,
    const double desiredVisualizationFrequency,
    const int32_t detectedObjectIdOffset)
{
    mNodeFrequency = nodeFrequency;
    mDetectedObjectFrequencyEvaluator.Configure(
        desiredDetectedObjectFrequency);
    mDesiredVisualizationFrequencyEvaluator.Configure(
        desiredVisualizationFrequency);
    mDetectedObjectIdOffset = detectedObjectIdOffset;
    mSimulatorManager.Configure(mNodeFrequency);
}

bool MrVilTestingNode::RunAgentDataArrayEvaluationService(
    AgentDataArrayEvaluation::Request &request,
    AgentDataArrayEvaluation::Response &response)
{
    response.agents.header.stamp = ros::Time::now();
    response.agents.header.frame_id = "map";
    for (auto & agent: mDetectedAgentDatas)
    {
        response.agents.id_list.push_back(agent.attribute.id);
        response.agents.data.push_back(
            DetectedAgentDataToAgentData(agent));
    }
    return true;   
}

bool MrVilTestingNode::RunDetectedObjectEvaluationService(
    DetectedObjectEvaluation::Request &request,
    DetectedObjectEvaluation::Response &response)
{
    std::lock_guard<std::mutex> guard(mDetectedAgentDataMutex);
    ros::Time stamp;
    stamp.sec = request.stamp.sec;
    stamp.nsec = request.stamp.nsec;
    mDetectedObjectMsgGenerator.ComputeMsg(
        mDetectedAgentDatas,
        stamp,
        static_cast<Coord_t>(request.coord),
        request.objectIdOffset,
        &response.objects);
    return true;
}

void MrVilTestingNode::RunMainLoop()
{
    ros::Rate nodeRate(mNodeFrequency);
    while (ros::ok())
    {
        mSimulatorManager.Update();
        this->Publish();
        ros::spinOnce();
        nodeRate.sleep();
    }
}

// protected func.

// private func.

void MrVilTestingNode::Publish()
{
    if (mDesiredVisualizationFrequencyEvaluator.CanTriggerEvent())
    {
        mSimulatorManager.PublishVisualization();
    }

    if (mDetectedObjectFrequencyEvaluator.CanTriggerEvent())
    {
        std::lock_guard<std::mutex> guard(mDetectedAgentDataMutex);
        mSimulatorManager.ExtractDetectedAgentData(&mDetectedAgentDatas);
    }
}

} // namespace scenario {
