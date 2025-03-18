#include <utils_visualization_msgs.h>
#include <stdexcept>
#include <ros/console.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Vector3.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>

namespace utils {

void GenerateVisualizationSphereMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::SPHERE;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(pose);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;
    markerMsgs->color = colorMsgs;
}

void GenerateVisualizationSphereMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &color,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.frame_id = "map";
    outputMsg.ns = ns;
    outputMsg.header.stamp = stamp;
    outputMsg.action = visualization_msgs::Marker::ADD;

    outputMsg.id = id;
    outputMsg.type = visualization_msgs::Marker::SPHERE;
    outputMsg.pose = pose;
    outputMsg.scale = scale;
    outputMsg.lifetime = lifeTime;
    outputMsg.color = color;
}

void GenerateVisualizationCubeMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::CUBE;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(pose);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;
    markerMsgs->color = colorMsgs;
}

void GenerateVisualizationCubeMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker &msg)
{
    msg.header.frame_id = "map";
    msg.ns = ns;
    msg.header.stamp = stamp;
    msg.action = visualization_msgs::Marker::ADD;

    msg.id = id;
    msg.type = visualization_msgs::Marker::CUBE;
    msg.pose = pose;
    msg.scale = scale;
    msg.lifetime = lifeTime;
    msg.color = colorMsgs;
}

void GenerateVisualizationLineStripMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const std::vector<math::Vector3d_t> &points,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (points.empty())
    {
        return;
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::LINE_STRIP;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        math::Quaternion_t::Identity(),
        math::Vector3d_t::Zero());
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;

    markerMsgs->colors.resize(points.size(), colorMsgs);
    markerMsgs->points.resize(points.size());
    std::transform(
        points.begin(),
        points.end(),
        markerMsgs->points.begin(),
        [](const math::Vector3d_t &inputPoint)
        {return utils::ConvertToGeometryMsgsPoint(inputPoint);});

}

void GenerateVisualizationLineStripMsg(
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const std::vector<geometry_msgs::Point> &points,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker &outputMsg)
{
    outputMsg.header.frame_id = "map";
    outputMsg.ns = ns;
    outputMsg.header.stamp = stamp;
    outputMsg.action = visualization_msgs::Marker::ADD;
    outputMsg.id = id;
    outputMsg.type = visualization_msgs::Marker::LINE_STRIP;
    //markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
    //    math::Quaternion_t::Identity(),
    //    math::Vector3d_t::Zero());
    outputMsg.pose = utils::GetIdentityGeometryMsgsPose();
    outputMsg.scale = scale;
    outputMsg.lifetime = lifeTime;
    outputMsg.colors.resize(points.size(), colorMsgs);
    outputMsg.points = points;
    //outputMsgs.points.resize(points.size());
    //std::transform(
    //    points.begin(),
    //    points.end(),
    //    markerMsgs->points.begin(),
    //    [](const math::Vector3d_t &inputPoint)
    //    {return utils::ConvertToGeometryMsgsPoint(inputPoint);});

}

void GenerateVisualizationClosedLineStripMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const std::vector<math::Vector3d_t> &corners,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (corners.empty())
    {
        return;
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::LINE_STRIP;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(
        math::Quaternion_t::Identity(),
        math::Vector3d_t::Zero());
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;

    markerMsgs->colors.resize(corners.size() + 1ul, colorMsgs);
    markerMsgs->points.resize(corners.size() + 1ul);
    std::transform(
        corners.cbegin(),
        corners.cend(),
        markerMsgs->points.begin(),
        [](const math::Vector3d_t &corner)
        {return utils::ConvertToGeometryMsgsPoint(corner);});
    markerMsgs->points.back() = utils::ConvertToGeometryMsgsPoint(corners.front());
}

void GenerateVisualizationArrowMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::ARROW;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(pose);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;
    markerMsgs->color = colorMsgs;
}

void GenerateVisualizationTextMsgs(
    const std::string &text,
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const math::HomoXfm3d_t &pose,
    const math::Vector3d_t &scale,
    const ros::Duration &lifeTime,
    const std_msgs::ColorRGBA &colorMsgs,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::ADD;

    markerMsgs->text = text;
    markerMsgs->id = id;
    markerMsgs->type = visualization_msgs::Marker::TEXT_VIEW_FACING;
    markerMsgs->pose = utils::ConvertToGeometryMsgsPose(pose);
    markerMsgs->scale = utils::ConvertToGeometryMsgsVector3(scale);
    markerMsgs->lifetime = lifeTime;
    markerMsgs->color = colorMsgs;
}

void GenerateVisualizationTextMsg(
    const std::string &text,
    const int32_t id,
    const std::string &ns,
    const ros::Time &stamp,
    const geometry_msgs::Pose &pose,
    const geometry_msgs::Vector3 &scale,
    const ros::Duration &lifetime,
    const std_msgs::ColorRGBA &colorMsg,
    visualization_msgs::Marker &markerMsg)
{
    markerMsg.header.frame_id = "/map";
    markerMsg.header.stamp = stamp;
    markerMsg.ns = ns;
    markerMsg.action = visualization_msgs::Marker::ADD;

    markerMsg.text = text;
    markerMsg.id = id;
    markerMsg.type = visualization_msgs::Marker::TEXT_VIEW_FACING;
    markerMsg.pose = pose;
    markerMsg.scale = scale;
    markerMsg.lifetime = lifetime;
    markerMsg.color = colorMsg;
}

void DeleteVisualizationMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    markerMsgs->header.frame_id = "map";
    markerMsgs->ns = ns;
    markerMsgs->header.stamp = stamp;
    markerMsgs->action = visualization_msgs::Marker::DELETE;

    markerMsgs->id = id;
    markerMsgs->lifetime = ros::Duration();
}

void GenerateVisualizationPointMarkerMsgs(
    const int32_t id,
    const char *ns,
    const ros::Time &stamp,
    const PointMarker &pointMarker,
    visualization_msgs::Marker *markerMsgs)
{
    if (nullptr == markerMsgs)
    {
        ROS_ERROR_STREAM("markerMsgs is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (PointMarkerType::Sphere == pointMarker.type)
    {
        utils::GenerateVisualizationSphereMsgs(
            id,
            ns,
            stamp,
            pointMarker.pose,
            pointMarker.scale,
            pointMarker.lifeTime,
            pointMarker.color,
            markerMsgs);
    }
    else if (PointMarkerType::Cube == pointMarker.type)
    {
        utils::GenerateVisualizationCubeMsgs(
            id,
            ns,
            stamp,
            pointMarker.pose,
            pointMarker.scale,
            pointMarker.lifeTime,
            pointMarker.color,
            markerMsgs);
    }
    else
    {
        ROS_ERROR_STREAM("invalid PointMarkerType: " << pointMarker.type);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

} // namespace utils {
