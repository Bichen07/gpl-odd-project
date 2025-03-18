#include <rss_converter.h>
#include <scenario/AgentState.h>
#include <math_utils.h>
#include <actor_object_class_id.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>
#include "geometry_msgs/Transform.h"

namespace rss
{

    ad::map::point::ENUPoint ToENUPoint(const geometry_msgs::Point &point)
    {
        ad::map::point::ENUPoint enuPoint;
        enuPoint.x = ad::map::point::ENUCoordinate(point.x);
        enuPoint.y = ad::map::point::ENUCoordinate(point.y);
        // enuPoint.z = ad::map::point::ENUCoordinate(point.z);
        enuPoint.z = ad::map::point::ENUCoordinate(0.0);

        return enuPoint;
    }

    ad::map::point::ENUPoint ToENUPoint(const math::Vector3d_t &vector3d)
    {
        ad::map::point::ENUPoint enuPoint;
        enuPoint.x = ad::map::point::ENUCoordinate(vector3d.x());
        enuPoint.y = ad::map::point::ENUCoordinate(vector3d.y());
        enuPoint.z = ad::map::point::ENUCoordinate(vector3d.z());

        return enuPoint;
    }

    ad::physics::Dimension3D ToDimension3d(const geometry_msgs::Vector3 &vector3)
    {
        ad::physics::Dimension3D dimension3d;
        dimension3d.length = ad::physics::Distance(vector3.x);
        dimension3d.width  = ad::physics::Distance(vector3.y);
        dimension3d.height = ad::physics::Distance(vector3.z);

        return dimension3d;
    }

    ad::physics::Dimension3D ToDimension3d(const math::Vector3d_t &vector3d)
    {
        ad::physics::Dimension3D dimension3d;
        dimension3d.length = ad::physics::Distance(vector3d.x());
        dimension3d.width  = ad::physics::Distance(vector3d.y());
        dimension3d.height = ad::physics::Distance(vector3d.z());

        return dimension3d;
    }

    geometry_msgs::Point ToGeometryMsgsPoint(const ad::map::point::ENUPoint &enuPoint)
    {
        geometry_msgs::Point output;
        output.x = enuPoint.x;
        output.y = enuPoint.y;
        output.z = enuPoint.z;

        return output;
    }

    ObjectInputParam ToObjectInputParam(const scenario::AgentState &msg)
    {
        ObjectInputParam objectInputParam;
        // objectInputParam.detectedObjectId = detectedObjectId;
        // objectInputParam.linearVelocity      = utils::ConvertToVector3d(msg.twist.linear);
        // objectInputParam.angularVelocity     = utils::ConvertToVector3d(msg.twist.angular);
        // objectInputParam.linearAcceleration  = utils::ConvertToVector3d(msg.accel.linear);
        // objectInputParam.angularAcceleration = utils::ConvertToVector3d(msg.accel.angular);
        // objectInputParam.size                = utils::ConvertToVector3d(msg.size);
        objectInputParam.speed = msg.speed;
        // objectInputParam.yawRate             = msg.yaw_rate;
        // objectInputParam.steeringAngle       = msg.steering_angle;
        // objectInputParam.objectClassId       = actor::ToObjectClassId(msg.object_class_id);

        return objectInputParam;
    }

    ObjectInputParam ToObjectInputParam(const rss_msgs::ObjectData &msg)
    {
        ObjectInputParam objectInputParam;
        objectInputParam.detectedObjectId    = msg.detected_object_id;
        objectInputParam.transform           = utils::ConvertToHomoXfm3d(msg.pose);
        objectInputParam.linearVelocity      = utils::ConvertToVector3d(msg.twist.linear);
        objectInputParam.angularVelocity     = utils::ConvertToVector3d(msg.twist.angular);
        objectInputParam.linearAcceleration  = utils::ConvertToVector3d(msg.accel.linear);
        objectInputParam.angularAcceleration = utils::ConvertToVector3d(msg.accel.angular);
        objectInputParam.size                = utils::ConvertToVector3d(msg.size);
        objectInputParam.speed               = msg.speed;
        objectInputParam.yawRate             = msg.yaw_rate;
        objectInputParam.steeringAngle       = msg.steering_angle;
        objectInputParam.objectClassId       = actor::ToObjectClassId(msg.object_class_id);

        return objectInputParam;
    }

    EgoVehicleInputParam ToEgoVehicleInputParam(const rss_msgs::EgoVehicleData &msg)
    {
        EgoVehicleInputParam egoVehicleInputParam;
        egoVehicleInputParam.id                  = msg.id;
        egoVehicleInputParam.transform           = utils::ConvertToHomoXfm3d(msg.pose);
        egoVehicleInputParam.linearVelocity      = utils::ConvertToVector3d(msg.twist.linear);
        egoVehicleInputParam.angularVelocity     = utils::ConvertToVector3d(msg.twist.angular);
        egoVehicleInputParam.linearAcceleration  = utils::ConvertToVector3d(msg.accel.linear);
        egoVehicleInputParam.angularAcceleration = utils::ConvertToVector3d(msg.accel.angular);
        egoVehicleInputParam.size                = utils::ConvertToVector3d(msg.size);
        egoVehicleInputParam.target              = utils::ConvertToVector3d(msg.target);
        egoVehicleInputParam.speed               = msg.speed;
        egoVehicleInputParam.yawRate             = msg.yaw_rate;
        egoVehicleInputParam.steeringAngle       = msg.steering_angle;
        egoVehicleInputParam.speedCmd            = msg.speed_cmd_kph;
        egoVehicleInputParam.steerCmd            = msg.steer_cmd_angle;
        egoVehicleInputParam.accelerationCmd     = msg.acceleration_cmd;

        ROS_DEBUG_STREAM_COND(false,
                              "msg.acceleration_cmd: " << msg.acceleration_cmd << '\n'
                                                       << "egoVehicleInputParam.acceleartionCmd: " << egoVehicleInputParam.accelerationCmd);

        return egoVehicleInputParam;
    }

    void ToObjectDataMsg(const itri_msgs::DetectedObject &detectedObject, rss_msgs::ObjectData &outputObjectData)
    {
        outputObjectData.detected_object_id = detectedObject.id;
        outputObjectData.pose               = detectedObject.pose;
        outputObjectData.twist              = detectedObject.velocity;
        // outputObjectData.accel
        outputObjectData.size     = detectedObject.dimensions;
        outputObjectData.speed    = utils::ComputeNorm(outputObjectData.twist.linear);
        outputObjectData.yaw_rate = outputObjectData.twist.angular.z;

        const math::Vector3d_t rotationAngle =
            math::ToEulerAngleXyz(utils::ConvertToQuaternion(outputObjectData.pose.orientation).toRotationMatrix());
        const math::real_t gearRatio{19.6};
        outputObjectData.steering_angle = rotationAngle.z() / gearRatio;

        // ROS_ERROR_STREAM("detectedObject label: " << detectedObject.label);
        outputObjectData.object_class_id = detectedObject.label;
    }

    void ToObjectDataArrayMsg(const itri_msgs::DetectedObjectArray &detectedObjectArray, rss_msgs::ObjectDataArray &outputObjectDataArray)
    {
        outputObjectDataArray.datas.resize(detectedObjectArray.objects.size());
        auto detectedObject{detectedObjectArray.objects.cbegin()};
        auto objectDataMsg{outputObjectDataArray.datas.begin()};
        for (; detectedObject != detectedObjectArray.objects.cend(); ++detectedObject, ++objectDataMsg)
        {
            rss::ToObjectDataMsg(*detectedObject, *objectDataMsg);
        }
    }

    void ToGeometryVector2ds(const ad::physics::Distance2DList &distance2dList, std::vector<geometry::Vector2d> &outputVector2ds)
    {
        outputVector2ds.resize(distance2dList.size());
        std::transform(distance2dList.cbegin(),
                       distance2dList.cend(),
                       outputVector2ds.begin(),
                       [](const ad::physics::Distance2D &distance2d) { return geometry::Vector2d(distance2d.x, distance2d.y); });
    }

    void ToRssStateMsg(const ad::rss::state::RssState &rssState, rss_msgs::RssState &outputMsg)
    {
        rss::ToLongitudinalStateMsg(rssState.longitudinalState, outputMsg.longitudinal_state);
        rss::ToLateralStateMsg(rssState.lateralStateRight, outputMsg.right_lateral_state);
        rss::ToLateralStateMsg(rssState.lateralStateLeft, outputMsg.left_lateral_state);
    }

    void ToLongitudinalStateMsg(const ad::rss::state::LongitudinalRssState &state, rss_msgs::LongitudinalState &outputMsg)
    {
        outputMsg.is_safe          = state.isSafe;
        outputMsg.response         = static_cast<typename std::underlying_type<ad::rss::state::LongitudinalResponse>::type>(state.response);
        outputMsg.safe_distance    = state.rssStateInformation.safeDistance;
        outputMsg.current_distance = state.rssStateInformation.currentDistance;
    }

    void ToLateralStateMsg(const ad::rss::state::LateralRssState &state, rss_msgs::LateralState &outputMsg)
    {
        outputMsg.is_safe          = state.isSafe;
        outputMsg.response         = static_cast<typename std::underlying_type<ad::rss::state::LateralResponse>::type>(state.response);
        outputMsg.safe_distance    = state.rssStateInformation.safeDistance;
        outputMsg.current_distance = state.rssStateInformation.currentDistance;
    }

}  // namespace rss
