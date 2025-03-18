#ifndef _PATH_CONNECTED_LANE_EVALUATOR_H_
#define _PATH_CONNECTED_LANE_EVALUATOR_H_

#include <memory>
#include <map>
#include <string>
#include <path_type.h>

namespace path {

class ConnectedLaneEvaluator final
{

public:

    typedef std::shared_ptr<ConnectedLaneEvaluator> Ptr;

    ConnectedLaneEvaluator();
    ConnectedLaneEvaluator(const ConnectedLaneEvaluator &) = delete;
    ConnectedLaneEvaluator &operator=(const ConnectedLaneEvaluator &) = delete;
    virtual ~ConnectedLaneEvaluator() = default;

    void Configure(const std::string &lanesInfoFileName);
    bool IsConnectedLanePair(
        const int32_t precedingLaneId,
        const int32_t succeedingLaneId) const;

protected:

private:

    void ParseLanesInfo(const std::string &lanesInfoFileName);

    std::map<int32_t, LaneIds> mNextLaneIdMap;
};

} // namespace path {

#endif // #ifndef _PATH_CONNECTED_LANE_EVALUATOR_H_
