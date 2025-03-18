#ifndef _UTILS_OBJECT_ID_MANAGER_H_
#define _UTILS_OBJECT_ID_MANAGER_H_

#include <memory>
#include <mutex>
#include <map>
#include <algorithm>
#include <type_traits>
#include <stdexcept>
#include <ros/console.h>

namespace utils {

template<typename KeyType, typename IdType>
class ObjectIdManager final
{

public:

    using IdType_t = IdType;
    using Ptr = std::shared_ptr<ObjectIdManager<KeyType, IdType>>;

    ObjectIdManager();
    ObjectIdManager(const ObjectIdManager &) = delete;
    ObjectIdManager &operator=(const ObjectIdManager &) = delete;
    virtual ~ObjectIdManager() = default;

    void Configure(
        const IdType &beginId,
        const IdType &endId);
    void Reset();
    IdType QueryId(const KeyType &key);
    bool IsInitialized() const;

protected:

private:

    using IdMap = std::map<KeyType, IdType>;

    IdType EvaluateNewId();

    IdType mBeginId;
    IdType mEndId;
    IdType mCurrentId;
    IdMap mIdMap;
    std::mutex mQueryMutex;
};

} // namespace utils {

namespace utils {

// public func.

template<typename KeyType, typename IdType>
ObjectIdManager<KeyType, IdType>::ObjectIdManager()
    : mBeginId{IdType{0}}
    , mEndId{IdType{0}}
    , mCurrentId{IdType{0}}
    , mIdMap{}
    , mQueryMutex{}
{
    if (!std::is_integral<IdType>::value)
    {
        ROS_ERROR_STREAM("IdType is not integral");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

template<typename KeyType, typename IdType>
void ObjectIdManager<KeyType, IdType>::Configure(
    const IdType &beginId,
    const IdType &endId)
{
    if (endId < beginId)
    {
        ROS_WARN_STREAM("invalid beginId: " << beginId << ", endId: " << endId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mBeginId = beginId;
    mEndId = endId;
    mCurrentId = mBeginId;
}

template<typename KeyType, typename IdType>
void ObjectIdManager<KeyType, IdType>::Reset()
{
    mBeginId = IdType{0};
    mEndId = IdType{0};
    mCurrentId = IdType{0};
    mIdMap.clear();
}

template<typename KeyType, typename IdType>
IdType ObjectIdManager<KeyType, IdType>::QueryId(const KeyType &key)
{
    std::lock_guard<std::mutex> guard(mQueryMutex);
    const auto foundIdPair{mIdMap.find(key)};
    IdType outputId{0};
    if (mIdMap.end() != foundIdPair)
    {
        outputId = foundIdPair->second;
    }
    else
    {
        outputId = this->EvaluateNewId();
        mIdMap.emplace(key, outputId);
    }

    return outputId;
}

template<typename KeyType, typename IdType>
bool ObjectIdManager<KeyType, IdType>::IsInitialized() const
{
    return mEndId > mBeginId;
}

// protected func.

// private func.

template<typename KeyType, typename IdType>
IdType ObjectIdManager<KeyType, IdType>::EvaluateNewId()
{
    bool isExistedId{true};

    while (isExistedId)
    {
        if (mCurrentId < mEndId)
        {
            ++mCurrentId;
        }
        else
        {
            ROS_ERROR_STREAM(
                "mCurrentId: " << mCurrentId << '\n' <<
                "mEndId: " << mEndId);
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
        isExistedId = std::any_of(
            mIdMap.cbegin(),
            mIdMap.cend(),
            [this](const typename IdMap::value_type &keyIdPair)
            {return keyIdPair.second == mCurrentId ? true : false;});
    }

    return mCurrentId;
}

// explicit instantiation

} // namespace utils {

#endif  // #ifndef _UTILS_OBJECT_ID_MANAGER_H_
