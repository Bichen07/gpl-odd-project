#ifndef _RSS_LOGGER_H_
#define _RSS_LOGGER_H_

#include <fstream>
#include <string>
#include <ad/rss/world/TimeIndex.hpp>
#include <rss_type.h>
#include <rss_check_result.h>
#include <rss_ego_vehicle_input_param.h>

namespace rss {

class Logger final
{

public:

    static constexpr int32_t DefaultPrecisionDigits()
    {return 6;}

    Logger();
    Logger(const Logger &) = delete;
    Logger &operator=(const Logger &) = delete;
    virtual ~Logger();

    void Configure(
        const std::string &fileName,
        const int32_t precisionDigits = DefaultPrecisionDigits());
    void Record(
        const ad::rss::world::TimeIndex &timeIndex,
        const CheckResult &checkResult,
        const EgoVehicleInputParam &egoVehicleInputParam,
        const ObjectInputParamMap &objectInputParamMap);

protected:

private:

    void CollectDangerousDetectedObjectIds(
        const std::vector<CheckResultObjectState> &objectStates,
        std::vector<uint32_t> &outputDangerousDetectedObjectIds) const;
    void RecordEgoVehicleState(
        const EgoVehicleInputParam &egoVehicleInputParam);
    void RecordObjectState(
        const std::vector<uint32_t> &dangerousDetectedObjectIds,
        const std::vector<CheckResultObjectState> &objectStates);
    bool IsUnsafe(const CheckResultObjectState &objectState) const;

    std::ofstream mOutputFileStream;
};

} // namespace rss {

#endif // #ifndef _RSS_LOGGER_H_
