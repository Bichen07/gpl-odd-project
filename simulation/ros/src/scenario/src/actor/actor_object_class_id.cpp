#include <actor_object_class_id.h>
#include <cctype>
#include <algorithm>
#include <stdexcept>
#include <ros/console.h>

namespace actor {

ObjectClassId ToObjectClassId(const std::string &key)
{
    std::string lowercaseKey{key};
    std::transform(
        key.cbegin(),
        key.cend(),
        lowercaseKey.begin(),
        [](const char &input)
        {return std::tolower(input);});
    static const std::map<std::string, ObjectClassId> objectClassIdMap =
    {
        {ToObjectClassLabel(ObjectClass::Car),                 ObjectClass::Car},
        {ToObjectClassLabel(ObjectClass::Truck),               ObjectClass::Truck},
        {ToObjectClassLabel(ObjectClass::Bus),                 ObjectClass::Bus},
        {ToObjectClassLabel(ObjectClass::Trailer),             ObjectClass::Trailer},
        {ToObjectClassLabel(ObjectClass::ConstructionVehicle), ObjectClass::ConstructionVehicle},
        {ToObjectClassLabel(ObjectClass::Person),              ObjectClass::Person},
        {ToObjectClassLabel(ObjectClass::Motorbike),           ObjectClass::Motorbike},
        {ToObjectClassLabel(ObjectClass::Bicycle),             ObjectClass::Bicycle},
        {ToObjectClassLabel(ObjectClass::TrafficCone),         ObjectClass::TrafficCone},
        {ToObjectClassLabel(ObjectClass::Barrier),             ObjectClass::Barrier},
    };

    const auto foundPair{objectClassIdMap.find(lowercaseKey)};
    if (objectClassIdMap.end() == foundPair)
    {
        ROS_ERROR_STREAM(
            "invalid key: " << key << '\n' <<
            "return ObjectClass::Null instead");
        return ObjectClass::Null;
    }

    return foundPair->second;
}

std::string ToObjectClassLabel(const ObjectClassId &objectClassId)
{
    static const std::map<ObjectClassId, const char *> objectClassLabelMap =
    {
        {ObjectClass::Car,                 "car"},
        {ObjectClass::Truck,               "truck"},
        {ObjectClass::Bus,                 "bus"},
        {ObjectClass::Trailer,             "trailer"},
        {ObjectClass::ConstructionVehicle, "construction_vehicle"},
        {ObjectClass::Person,              "person"},
        {ObjectClass::Motorbike,           "motorbike"},
        {ObjectClass::Bicycle,             "bicycle"},
        {ObjectClass::TrafficCone,         "traffic_cone"},
        {ObjectClass::Barrier,             "barrier"},
    };

    const auto foundPair{objectClassLabelMap.find(objectClassId)};
    if (objectClassLabelMap.end() == foundPair)
    {
        ROS_ERROR_STREAM("invalid " << objectClassId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    return foundPair->second;
}

} // namespace actor {
