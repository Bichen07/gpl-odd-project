#include <rss_rss_object_data_convertor.h>
#include <limits>
#include <stdexcept>
#include "scenario/AgentState.h"
#include <ros/console.h>

namespace rss
{

    // public func.

    RssObjectDataConvertor::RssObjectDataConvertor() : mConfiguration{}, mObjectIdManager{}, mGetRssDynamicsFuncMap{}, mObjectIdMap{}
    {
        mObjectIdManager.Configure(ad::rss::world::ObjectId(1), std::numeric_limits<ad::rss::world::ObjectId>::max());

        mGetRssDynamicsFuncMap = GetRssDynamicsFuncMap{
            {ad::rss::world::ObjectType::OtherVehicle, std::bind(&Configuration::GetOtherVehicleRssDynamics, &mConfiguration)},
            {ad::rss::world::ObjectType::Pedestrian, std::bind(&Configuration::GetPedestrianRssDynamics, &mConfiguration)},
            {ad::rss::world::ObjectType::ArtificialObject, std::bind(&Configuration::GetArtificialObjectRssDynamics, &mConfiguration)},
        };
    }

    void RssObjectDataConvertor::ToEgoVehicleObjectData(const rss_msgs::EgoVehicleData     &egoVehicleData,
                                                        const ad::map::match::Object       &matchObject,
                                                        const ad::physics::Speed           &speed,
                                                        const ad::physics::AngularVelocity &yawRate,
                                                        const ad::physics::Angle           &steeringAngle,
                                                        ad::rss::map::RssObjectData        &outputEgoVehicleObjectData)
    {
        outputEgoVehicleObjectData.id            = mObjectIdManager.QueryId("ego_vehicle");
        outputEgoVehicleObjectData.type          = ad::rss::world::ObjectType::EgoVehicle;
        outputEgoVehicleObjectData.matchObject   = matchObject;
        outputEgoVehicleObjectData.speed         = speed;
        outputEgoVehicleObjectData.yawRate       = yawRate;
        outputEgoVehicleObjectData.steeringAngle = steeringAngle;
        outputEgoVehicleObjectData.rssDynamics   = mConfiguration.GetEgoVehicleRssDynamics();
    }

    void RssObjectDataConvertor::ToOtherObjectData(const scenario::AgentState         &objectData,
                                                   const ad::map::match::Object       &matchObject,
                                                   const ad::physics::Speed           &speed,
                                                   const ad::physics::AngularVelocity &yawRate,
                                                   const ad::physics::Angle           &steeringAngle,
                                                   ad::rss::map::RssObjectData        &outputRssObjectData)
    {
        outputRssObjectData.id = ad::rss::world::ObjectId(mObjectIdManager.QueryId(std::string(objectData.name)));

        // ROS_ERROR_STREAM("object_class_id: " << objectData.object_class_id);
        if (std::string(objectData.name).find("Pedestrian") != std::string::npos)
        {
            outputRssObjectData.type = ad::rss::world::ObjectType::Pedestrian;
        }
        else
        {
            outputRssObjectData.type = ad::rss::world::ObjectType::OtherVehicle;
        }
        outputRssObjectData.matchObject   = matchObject;
        outputRssObjectData.speed         = speed;
        outputRssObjectData.yawRate       = yawRate;
        outputRssObjectData.steeringAngle = steeringAngle;
        outputRssObjectData.rssDynamics   = this->GetRssDynamics(outputRssObjectData.type);
    }

    void RssObjectDataConvertor::ToOtherObjectData(const rss_msgs::ObjectData         &objectData,
                                                   const ad::map::match::Object       &matchObject,
                                                   const ad::physics::Speed           &speed,
                                                   const ad::physics::AngularVelocity &yawRate,
                                                   const ad::physics::Angle           &steeringAngle,
                                                   ad::rss::map::RssObjectData        &outputRssObjectData)
    {
        outputRssObjectData.id = ad::rss::world::ObjectId(mObjectIdManager.QueryId(std::to_string(objectData.detected_object_id)));

        // ROS_ERROR_STREAM("object_class_id: " << objectData.object_class_id);
        outputRssObjectData.type          = this->ToObjectType(actor::ToObjectClassId(objectData.object_class_id));
        outputRssObjectData.matchObject   = matchObject;
        outputRssObjectData.speed         = speed;
        outputRssObjectData.yawRate       = yawRate;
        outputRssObjectData.steeringAngle = steeringAngle;
        outputRssObjectData.rssDynamics   = this->GetRssDynamics(outputRssObjectData.type);

        const auto foundPair{mObjectIdMap.find(objectData.detected_object_id)};
        if (mObjectIdMap.end() == foundPair)
        {
            const bool isSuccessfulInserting{mObjectIdMap.emplace(objectData.detected_object_id, outputRssObjectData.id).second};
            if (!isSuccessfulInserting)
            {
                ROS_WARN_STREAM("duplicated detected_object_id: " << objectData.detected_object_id);
            }
        }
    }

    bool RssObjectDataConvertor::QueryDetectedObjectId(const ad::rss::world::ObjectId &rssObjectId, uint32_t &outputDetectedObjectId) const
    {
        const auto foundPair{std::find_if(mObjectIdMap.cbegin(),
                                          mObjectIdMap.cend(),
                                          [&rssObjectId](const ObjectIdMap::value_type &objectIdPair)
                                          { return objectIdPair.second == rssObjectId; })};
        if (mObjectIdMap.cend() == foundPair)
        {
            return false;
        }

        outputDetectedObjectId = foundPair->first;

        return true;
    }

    bool RssObjectDataConvertor::QueryRssObjectId(const uint32_t detectedObjectId, ad::rss::world::ObjectId &outputRssObjectId) const
    {
        const auto foundPair{mObjectIdMap.find(detectedObjectId)};
        if (mObjectIdMap.end() == foundPair)
        {
            return false;
        }

        outputRssObjectId = foundPair->second;

        return true;
    }

    // protected func.

    // private func.

    ad::rss::world::ObjectType RssObjectDataConvertor::ToObjectType(const actor::ObjectClassId &objectClassId) const
    {
        static const std::map<actor::ObjectClassId, ad::rss::world::ObjectType> rssObjectTypeMap = {
            {actor::ObjectClass::Car, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Truck, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Bus, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Trailer, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::ConstructionVehicle, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Motorbike, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Bicycle, ad::rss::world::ObjectType::OtherVehicle},
            {actor::ObjectClass::Person, ad::rss::world::ObjectType::Pedestrian},
            {actor::ObjectClass::TrafficCone, ad::rss::world::ObjectType::ArtificialObject},
            {actor::ObjectClass::Null, ad::rss::world::ObjectType::ArtificialObject},
        };

        const auto foundPair{rssObjectTypeMap.find(objectClassId)};
        if (rssObjectTypeMap.end() == foundPair)
        {
            ROS_ERROR_STREAM("invalid " << objectClassId);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        return foundPair->second;
    }

    const ad::rss::world::RssDynamics &RssObjectDataConvertor::GetRssDynamics(const ad::rss::world::ObjectType &objectType) const
    {
        const auto foundPair{mGetRssDynamicsFuncMap.find(objectType)};
        if (mGetRssDynamicsFuncMap.end() == foundPair)
        {
            ROS_ERROR_STREAM("invalid " << objectType);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        return foundPair->second();
    }

}  // namespace rss
