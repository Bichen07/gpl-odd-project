#ifndef _UTILS_MARKER_ID_MANAGER_H_
#define _UTILS_MARKER_ID_MANAGER_H_

#include <map>
#include <string>

namespace utils {

class MarkerIdManager final
{

public:

    MarkerIdManager();
    MarkerIdManager(const MarkerIdManager &) = delete;
    MarkerIdManager &operator=(const MarkerIdManager &) = delete;
    virtual ~MarkerIdManager();

    void Configure(const int32_t beginId, const int32_t endId);

    int32_t QueryMarkerId(const std::string &objectId);

protected:

private:

    int32_t EvaluateNewId();

    int32_t mBeginId;
    int32_t mEndId;
    int32_t mCurrentId;
    std::map<std::string, int32_t> mMarkerIdMap;
};

} // namespace utils {

#endif // #ifndef _UTILS_MARKER_ID_MANAGER_H_
