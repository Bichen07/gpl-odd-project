#include <motion_move_trigger_condition.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_json.h>
#include <motion_trigger_ref_position.h>
#include <actor_agent_based_trigger_ref_position.h>
#include <motion_position_based_trigger_ref_position.h>

namespace motion{

void ParseMoveTriggerCondition(
    const Json::Value &configJsonValue,
    MoveTriggerCondition &outputCondition)
{
    const TriggerRefPosition::TypeId triggerRefPositionTypeId =
        motion::ToTriggerRefPositionTypeId(
            utils::GetStringJsonValue(configJsonValue["trigger_ref_position"]["type_id"]));
    if (TriggerRefPosition::Type::PositionBased == triggerRefPositionTypeId)
    {
        const geometry::Vector3d refPosition(
            utils::GetDoubleJsonValue(configJsonValue["trigger_ref_position"]["ref_position"]["x"]),
            utils::GetDoubleJsonValue(configJsonValue["trigger_ref_position"]["ref_position"]["y"]),
            utils::GetDoubleJsonValue(configJsonValue["trigger_ref_position"]["ref_position"]["z"]));
        outputCondition.triggerRefPosition =
            std::make_shared<PositionBasedTriggerRefPosition>(
                refPosition);
    }
    else if (TriggerRefPosition::Type::AgentBased == triggerRefPositionTypeId)
    {
        outputCondition.triggerRefPosition =
            std::make_shared<actor::AgentBasedTriggerRefPosition>();
    }
    else
    {
        ROS_ERROR_STREAM("invalid " << triggerRefPositionTypeId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    outputCondition.spatialRelationId = motion::ToSpatialRelationId(
        utils::GetStringJsonValue(configJsonValue["spatial_relation_id"]));
    outputCondition.distance = utils::GetDoubleJsonValue(
        configJsonValue["distance"]);
}

} // namespace motion{
