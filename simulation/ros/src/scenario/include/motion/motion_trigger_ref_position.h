#ifndef _MOTION_TRIGGER_REF_POSITION_H_
#define _MOTION_TRIGGER_REF_POSITION_H_

#include <memory>
#include <map>
#include <iostream>
#include <boost/any.hpp>
#include <geometry_vector_3d.h>

namespace motion {

class TriggerRefPosition
{

public:

    typedef enum class Type: int32_t
    {
        PositionBased,
        AgentBased,
        Num,
        Null = Num,
    } TypeId;

    typedef std::shared_ptr<TriggerRefPosition> Ptr;

    TriggerRefPosition(const TriggerRefPosition &) = delete;
    TriggerRefPosition &operator=(const TriggerRefPosition &) = delete;
    virtual ~TriggerRefPosition() = default;

    virtual TriggerRefPosition::TypeId GetTypeId() const = 0;
    virtual geometry::Vector3d Evaluate() = 0;
    virtual void Configure(const boost::any &config);

protected:

    TriggerRefPosition() = default;

private:

};

TriggerRefPosition::TypeId ToTriggerRefPositionTypeId(const std::string &key);
std::string ToTriggerRefPositionTypeLabel(const TriggerRefPosition::TypeId &typeId);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const TriggerRefPosition::TypeId &typeId)
{
    static const std::map<TriggerRefPosition::TypeId, const char *> typeIdMap =
    {
        {TriggerRefPosition::Type::PositionBased, "TriggerRefPosition::Type::PositionBased"},
        {TriggerRefPosition::Type::AgentBased,    "TriggerRefPosition::Type::AgentBased"},
        {TriggerRefPosition::Type::Null,          "TriggerRefPosition::Type::Null"},
    };

    ostream << typeIdMap.find(typeId)->second;

    return ostream;
}

} // namespace motion {

#endif // #ifndef _MOTION_TRIGGER_REF_POSITION_H_
