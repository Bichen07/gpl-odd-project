#ifndef _MAP_STOP_LINE_MANAGER_H_
#define _MAP_STOP_LINE_MANAGER_H_

#include <string>
#include <map>
#include <map_stop_line.h>

namespace map {

class StopLineManager final
{

public:

    StopLineManager();
    StopLineManager(const StopLineManager &) = delete;
    StopLineManager &operator=(const StopLineManager &) = delete;
    virtual ~StopLineManager();

    const std::map<int32_t, StopLine> &GetStopLineMap() const;
    const StopLine QueryStopLine(const int32_t id) const;
    const bool QueryStopLine(
        const int32_t id,
        StopLine *outputStopLine) const;
    const bool QueryStopLines(
        const int32_t laneId,
        std::vector<StopLine> *outputStopLines) const;

    void Configure(const std::string &roadMarkerFileName);

protected:

private:

    std::map<int32_t, StopLine> mStopLineMap;
};

} // namespace map {

#endif // #ifndef _MAP_STOP_LINE_MANAGER_H_
