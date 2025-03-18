#include <scenario_detected_object_id_manager.h>
#include <limits>
#include <string>
#include <stdexcept>
#include <ros/console.h>

namespace scenario {

// public func.

DetectedObjectIdManager::DetectedObjectIdManager()
    : mIdManager{}
{
}

void DetectedObjectIdManager::Configure(const uint32_t idOffset)
{
    mIdManager.Configure(
        idOffset,
        std::numeric_limits<IdManager::IdType_t>::max());
}

void DetectedObjectIdManager::Reset()
{
    mIdManager.Reset();
}

uint32_t DetectedObjectIdManager::QueryId(const std::string &key)
{
    if (key.empty())
    {
        ROS_ERROR_STREAM("key is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return mIdManager.QueryId(key);
}

// protected func.

// private func.

} // namespace scenario {
