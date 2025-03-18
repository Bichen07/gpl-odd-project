#ifndef _MAP_CROSSWALK_MANAGER_H_
#define _MAP_CROSSWALK_MANAGER_H_

#include <string>
#include <map>
#include <map_crosswalk.h>

namespace map {

class CrosswalkManager final
{

public:

    CrosswalkManager();
    CrosswalkManager(const CrosswalkManager &) = delete;
    CrosswalkManager &operator=(const CrosswalkManager &) = delete;
    virtual ~CrosswalkManager();

    const std::map<int32_t, Crosswalk> &GetCrosswalkMap() const;
    const Crosswalk QueryCrosswalk(const int32_t id) const;

    void Configure(const std::string &crosswalkFileName);

protected:

private:

    std::map<int32_t, Crosswalk> mCrosswalkMap;
};

} // namespace map {

#endif // #ifndef _MAP_CROSSWALK_MANAGER_H_
