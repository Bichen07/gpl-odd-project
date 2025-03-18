#ifndef _RSS_CONVERTER_H_
#define _RSS_CONVERTER_H_

#include <ad/map/point/ENUPoint.hpp>
#include <ad/physics/Dimension3D.hpp>
#include <ad/physics/Distance2DList.hpp>
#include <ad/rss/situation/SituationType.hpp>
#include <ad/rss/state/LongitudinalRssState.hpp>
#include <ad/rss/state/LateralRssState.hpp>
#include <ad/rss/state/RssState.hpp>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Vector3.h>
#include <itri_msgs/DetectedObject.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <math_type.h>
#include <geometry_vector_3d.h>
#include <rss_msgs/EgoVehicleData.h>
#include <rss_msgs/LateralState.h>
#include <rss_msgs/LongitudinalState.h>
#include <rss_msgs/ObjectData.h>
#include <rss_msgs/ObjectDataArray.h>
#include <rss_msgs/RssState.h>
#include <rss_object_input_param.h>
#include <rss_ego_vehicle_input_param.h>

namespace rss {

ad::map::point::ENUPoint ToENUPoint(const geometry_msgs::Point &point);
ad::map::point::ENUPoint ToENUPoint(const math::Vector3d_t &vector3d);
ad::physics::Dimension3D ToDimension3d(const geometry_msgs::Vector3 &vector3);
ad::physics::Dimension3D ToDimension3d(const math::Vector3d_t &vector3d);
geometry_msgs::Point ToGeometryMsgsPoint(const ad::map::point::ENUPoint &enuPoint);
ObjectInputParam ToObjectInputParam(const rss_msgs::ObjectData &msg);
EgoVehicleInputParam ToEgoVehicleInputParam(const rss_msgs::EgoVehicleData &msg);
void ToObjectDataMsg(
    const itri_msgs::DetectedObject &detectedObject,
    rss_msgs::ObjectData &outputObjectData);
void ToObjectDataArrayMsg(
    const itri_msgs::DetectedObjectArray &detectedObjectArray,
    rss_msgs::ObjectDataArray &outputObjectDataArray);
void ToGeometryVector2ds(
    const ad::physics::Distance2DList &distance2dList,
    std::vector<geometry::Vector2d> &outputVector2ds);
void ToRssStateMsg(
    const ad::rss::state::RssState &rssState,
    rss_msgs::RssState &outputMsg);
void ToLongitudinalStateMsg(
    const ad::rss::state::LongitudinalRssState &state,
    rss_msgs::LongitudinalState &outputMsg);
void ToLateralStateMsg(
    const ad::rss::state::LateralRssState &state,
    rss_msgs::LateralState &outputMsg);

} // namespace rss {

#endif // #ifndef _RSS_CONVERTER_H_
