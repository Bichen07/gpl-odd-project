#include <motion_longitudinal_submovement.h>
#include <utils_json.h>
#include <motion_utils.h>

namespace motion {

void ParseLongitudinalSubmovement(
    const Json::Value &configJsonValue,
    LongitudinalSubmovement &outputLongitudinalSubmovement)
{
    outputLongitudinalSubmovement.triggerDistance =
        utils::GetDoubleJsonValue(configJsonValue["trigger_distance"]);
    outputLongitudinalSubmovement.speedMps = motion::ConvertToMps(
        utils::GetDoubleJsonValue(configJsonValue["speed_kph"]));
}

} // namespace motion {
