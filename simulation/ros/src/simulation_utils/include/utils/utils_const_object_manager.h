#ifndef _UTILS_CONST_OBJECT_MANAGER_H_
#define _UTILS_CONST_OBJECT_MANAGER_H_

#include <string>
#include <map>
#include <stdexcept>
#include <ros/console.h>

namespace utils {

template<typename ObjectType>
class ConstObjectManager final
{

public:

    ConstObjectManager();
    ConstObjectManager(const ConstObjectManager &) = delete;
    ConstObjectManager &operator=(const ConstObjectManager &) = delete;
    virtual ~ConstObjectManager();

    const ObjectType &QueryObject(const std::string &id) const;

    void Register(
        const std::string &id,
        const ObjectType &object);

protected:

private:

    using ObjectMap = std::map<std::string, ObjectType>;

    ObjectMap mObjectMap;
};

} // namespace utils {


namespace utils {

template<typename ObjectType>
ConstObjectManager<ObjectType>::ConstObjectManager()
    :mObjectMap{}
{
}

template<typename ObjectType>
ConstObjectManager<ObjectType>::~ConstObjectManager()
{
}

template<typename ObjectType>
const ObjectType &ConstObjectManager<ObjectType>::QueryObject(const std::string &id) const
{
    auto foundPair{mObjectMap.find(id)};
    if (mObjectMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid id: " << id);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

template<typename ObjectType>
void ConstObjectManager<ObjectType>::Register(
    const std::string &id,
    const ObjectType &object)
{
    const auto foundPair = mObjectMap.find(id);
    if (mObjectMap.end() != foundPair)
    {
        ROS_WARN_STREAM(id << " has be registered");
        return;
    }

    mObjectMap.emplace(id, object);
}

} // namespace utils {

#endif // #ifndef _UTILS_CONST_OBJECT_MANAGER_H_
