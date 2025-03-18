#ifndef _ACTOR_OBJECT_CLASS_ID_H_
#define _ACTOR_OBJECT_CLASS_ID_H_

#include <map>
#include <string>
#include <iostream>

namespace actor {

typedef enum class ObjectClass: int32_t
{
    Car = 0,
    Truck,               // = 1
    Bus,                 // = 2
    Trailer,             // = 3
    ConstructionVehicle, // = 4
    Person,              // = 5
    Motorbike,           // = 6
    Bicycle,             // = 7
    TrafficCone,         // = 8
    Barrier,             // = 9
    Num,                 // = 10
    Null = Num,
} ObjectClassId;

ObjectClassId ToObjectClassId(const std::string &key);
std::string ToObjectClassLabel(const ObjectClassId &objectClassId);

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const ObjectClassId &objectClassId)
{
    static const std::map<ObjectClassId, const char *> objectClassIdMap =
    {
        {ObjectClass::Car,                 "ObjectClass::Car"},
        {ObjectClass::Truck,               "ObjectClass::Truck"},
        {ObjectClass::Bus,                 "ObjectClass::Bus"},
        {ObjectClass::Trailer,             "ObjectClass::Trailer"},
        {ObjectClass::ConstructionVehicle, "ObjectClass::ConstructionVehicle"},
        {ObjectClass::Person,              "ObjectClass::Person"},
        {ObjectClass::Motorbike,           "ObjectClass::Motorbike"},
        {ObjectClass::Bicycle,             "ObjectClass::Bicycle"},
        {ObjectClass::TrafficCone,         "ObjectClass::TrafficCone"},
        {ObjectClass::Barrier,             "ObjectClass::Barrier"},
        {ObjectClass::Null,                "ObjectClass::Null"},
    };

    ostream << objectClassIdMap.find(objectClassId)->second;
    return ostream;
}

} // namespace actor {

#endif // #ifndef _ACTOR_OBJECT_CLASS_ID_H_
