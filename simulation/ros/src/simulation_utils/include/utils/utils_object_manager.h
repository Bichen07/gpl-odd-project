#ifndef _UTILS_OBJECT_MANAGER_H_
#define _UTILS_OBJECT_MANAGER_H_

#include <map>
#include <memory>
#include <ros/console.h>
#include <stdexcept>
#include <string>

namespace utils {

template<typename ObjectType>
class ObjectManager final
{

  public:
    ObjectManager();
    ObjectManager(const ObjectManager&) = delete;
    ObjectManager& operator=(const ObjectManager&) = delete;
    virtual ~ObjectManager();

    std::shared_ptr<ObjectType>& QueryObject(const std::string& id);

    bool Register(const std::string& id,
                  const std::shared_ptr<ObjectType>& object);

  protected:
  private:
    using ObjectMap = std::map<std::string, std::shared_ptr<ObjectType>>;

    ObjectMap mObjectMap;
};

} // namespace utils {

namespace utils {

// public func.

template<typename ObjectType>
ObjectManager<ObjectType>::ObjectManager()
  : mObjectMap{}
{
}

template<typename ObjectType>
ObjectManager<ObjectType>::~ObjectManager()
{
}

template<typename ObjectType>
std::shared_ptr<ObjectType>&
ObjectManager<ObjectType>::QueryObject(const std::string& id)
{
    auto foundPair{ mObjectMap.find(id) };
    if (mObjectMap.end() == foundPair) {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__ ":") +
                                    std::to_string(__LINE__));
    }

    return foundPair->second;
}

template<typename ObjectType>
bool
ObjectManager<ObjectType>::Register(const std::string& id,
                                    const std::shared_ptr<ObjectType>& object)
{
    const auto foundPair = mObjectMap.find(id);
    if (mObjectMap.end() != foundPair) {
        ROS_WARN_STREAM(id << " has been registered");
        return true;
    }

    mObjectMap.emplace(id, object);
    return false;
}

} // namespace utils {

#endif // #ifndef _UTILS_OBJECT_MANAGER_H_
