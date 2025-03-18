#ifndef _RSS_RSS_OBJECT_DATA_CONVERTOR_H_
#define _RSS_RSS_OBJECT_DATA_CONVERTOR_H_

#include <map>
#include <functional>
#include <ad/rss/map/RssObjectData.hpp>
#include <utils_object_id_manager.h>
#include <rss_msgs/EgoVehicleData.h>
#include <rss_msgs/ObjectData.h>
#include <rss_configuration.h>
#include <rss_object_input_param.h>
#include <scenario/AgentState.h>

namespace rss
{

    class RssObjectDataConvertor final
    {
    public:
        RssObjectDataConvertor();
        RssObjectDataConvertor(const RssObjectDataConvertor &)            = delete;
        RssObjectDataConvertor &operator=(const RssObjectDataConvertor &) = delete;
        virtual ~RssObjectDataConvertor()                                 = default;

        void ToEgoVehicleObjectData(const rss_msgs::EgoVehicleData     &egoVehicleData,
                                    const ad::map::match::Object       &matchObject,
                                    const ad::physics::Speed           &speed,
                                    const ad::physics::AngularVelocity &yawRate,
                                    const ad::physics::Angle           &steeringAngle,
                                    ad::rss::map::RssObjectData        &outputEgoVehicleObjectData);
        void ToOtherObjectData(const scenario::AgentState         &objectData,
                               const ad::map::match::Object       &matchObject,
                               const ad::physics::Speed           &speed,
                               const ad::physics::AngularVelocity &yawRate,
                               const ad::physics::Angle           &steeringAngle,
                               ad::rss::map::RssObjectData        &outputRssObjectData);
        void ToOtherObjectData(const rss_msgs::ObjectData         &objectData,
                               const ad::map::match::Object       &matchObject,
                               const ad::physics::Speed           &speed,
                               const ad::physics::AngularVelocity &yawRate,
                               const ad::physics::Angle           &steeringAngle,
                               ad::rss::map::RssObjectData        &outputRssObjectData);
        bool QueryDetectedObjectId(const ad::rss::world::ObjectId &rssObjectId, uint32_t &outputDetectedObjectId) const;
        bool QueryRssObjectId(const uint32_t detectedObjectId, ad::rss::world::ObjectId &outputRssObjectId) const;

    protected:
    private:
        using GetRssDynamicsFunc    = std::function<const ad::rss::world::RssDynamics &()>;
        using GetRssDynamicsFuncMap = std::map<ad::rss::world::ObjectType, GetRssDynamicsFunc>;
        using ObjectIdManager       = utils::ObjectIdManager<std::string, ad::rss::world::ObjectId>;
        using ObjectIdMap           = std::map<uint32_t, ad::rss::world::ObjectId>;

        ad::rss::world::ObjectType         ToObjectType(const actor::ObjectClassId &objectClassId) const;
        const ad::rss::world::RssDynamics &GetRssDynamics(const ad::rss::world::ObjectType &objectType) const;

        Configuration         mConfiguration;
        ObjectIdManager       mObjectIdManager;
        GetRssDynamicsFuncMap mGetRssDynamicsFuncMap;
        ObjectIdMap           mObjectIdMap;
    };

}  // namespace rss

#endif  // #ifndef _RSS_RSS_OBJECT_DATA_CONVERTOR_H_
