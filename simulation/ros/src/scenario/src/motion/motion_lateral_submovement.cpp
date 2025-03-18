#include <motion_lateral_submovement.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseLateralSubmovement(
    const Json::Value &configJsonValue,
    LateralSubmovement &outputLateralSubmovement)
{
    outputLateralSubmovement.distance =
        utils::GetDoubleJsonValue(configJsonValue["distance"]);
    outputLateralSubmovement.speedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["speed_kph"]));
}

} // namespace motion {
