#ifndef _MEASURE_SAFETY_REGION_DATA_H_
#define _MEASURE_SAFETY_REGION_DATA_H_

#include <vector>
#include <string>
#include <map>
#include <math_type.h>

namespace measure {

struct SafetyRegionData final
{
    std::string id;
    std::vector<math::Vector3d_t> safetyRegion;
    bool isSafe;

    SafetyRegionData()
        : id{}
        , safetyRegion{}
        , isSafe{true}
    {
    }
    explicit SafetyRegionData(
        const std::string &inputId,
        const std::vector<math::Vector3d_t> &inputSafetyRegion,
        const bool inputIsSafe)
        : id{inputId}
        , safetyRegion{inputSafetyRegion}
        , isSafe{inputIsSafe}
    {
    }
    SafetyRegionData(const SafetyRegionData &) = default;
    SafetyRegionData &operator=(const SafetyRegionData &) = default;
    ~SafetyRegionData() = default;
};

} // namespace measure {

#endif // #ifndef _MEASURE_SAFETY_REGION_VISUALIZATION_DATA_H_
