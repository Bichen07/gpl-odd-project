#ifndef _SCENARIO_DETECTED_OBJECT_ID_MANAGER_H_
#define _SCENARIO_DETECTED_OBJECT_ID_MANAGER_H_

#include <memory>
#include <utils_object_id_manager.h>

namespace scenario {

class DetectedObjectIdManager final
{

public:

    typedef std::shared_ptr<DetectedObjectIdManager> Ptr;

    DetectedObjectIdManager();
    DetectedObjectIdManager(const DetectedObjectIdManager &) = delete;
    DetectedObjectIdManager &operator=(const DetectedObjectIdManager &) = delete;
    virtual ~DetectedObjectIdManager() = default;

    void Configure(const uint32_t idOffset);
    void Reset();
    uint32_t QueryId(const std::string &key);

protected:

private:

    using IdManager = utils::ObjectIdManager<std::string, uint32_t>;

    IdManager mIdManager;
};

} // namespace scenario {

#endif // #ifndef _SCENARIO_DETECTED_OBJECT_ID_MANAGER_H_
