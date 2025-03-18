#pragma once

#include <vector>

#include <ros/ros.h>
#include <tf2/impl/utils.h>
#include <tf2/LinearMath/Quaternion.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/PoseArray.h>
#include <visualization_msgs/MarkerArray.h>
#include <itri_msgs/Waypoint.h>
#include <itri_msgs/WaypointArray.h>
#include <itri_msgs/RRTPlanningResponse.h>
#include <itri_msgs/DetectedObject.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <rrt_planning/RRTStar.hpp>
#include <rrt_planning/Car.hpp>
#include <rrt_planning/State/Pose2D.hpp>

namespace RosUtils {

double quaternionToTheta(const geometry_msgs::Quaternion & q) {
    tf2::Quaternion quat(q.x, q.y, q.z, q.w);
    return tf2::impl::getYaw(quat);
}

Pose2D transformToPose(const geometry_msgs::Transform & transform) {
    Pose2D pose = {
            .x=transform.translation.x,
            .y=transform.translation.y,
            .theta=quaternionToTheta(transform.rotation)
    };
    return pose;
}

Pose2D rosToPose(const geometry_msgs::Pose & msg) {
    Pose2D pose {.x=msg.position.x, .y=msg.position.y, .theta=quaternionToTheta(msg.orientation)};

    return pose;
}

Pose2D msgToPose(const geometry_msgs::Pose & msg) {
    Pose2D pose {.x=msg.position.x, .y=msg.position.y, .theta=msg.orientation.z};

    return pose;
}

std::vector<std::vector<Pose2D>> ObjectArrayToPolys(
    const itri_msgs::DetectedObjectArray & objectArray)
{
    std::vector<std::vector<Pose2D>> objsPoly;
    std::vector<Pose2D> objPoly;
    Pose2D element;

    for (auto const& object : objectArray.objects)
    {
        objPoly.clear();
        for (auto const& point : object.convex_hull.polygon.points)
        {
            element.x = point.x;
            element.y = point.y;

            objPoly.push_back(element);
        }

        objsPoly.push_back(objPoly);
    }
    return objsPoly;
}

geometry_msgs::Pose poseToRos(const Pose2D & pose) {
    geometry_msgs::Pose p;
    p.position.x = pose.x;
    p.position.y = pose.y;
    tf2::Quaternion quat;
    quat.setEuler(0., 0., pose.theta);
    p.orientation.x = quat.x();
    p.orientation.y = quat.y();
    p.orientation.z = quat.z();
    p.orientation.w = quat.w();

    return p;
}

geometry_msgs::Transform poseToTransform(const Pose2D & pose) {
    geometry_msgs::Transform t;
    t.translation.x = pose.x;
    t.translation.y = pose.y;

    tf2::Quaternion quat;
    quat.setEuler(0., 0., pose.theta);
    t.rotation.x = quat.x();
    t.rotation.y = quat.y();
    t.rotation.z = quat.z();
    t.rotation.w = quat.w();

    return t;
}

itri_msgs::WaypointArray vectorToWaypoints(
    const std::vector<Pose2D> & path,
    unsigned int direction)
{
    itri_msgs::WaypointArray waypointArray;
    itri_msgs::Waypoint waypoint;
    for (const Pose2D & pose : path)
    {
        waypoint.pose.pose.position.x = pose.x;
        waypoint.pose.pose.position.y = pose.y;
        waypointArray.waypoints.push_back(waypoint);
    }

    if (direction == itri_msgs::WaypointArray::FORWARD)
        waypointArray.direction = itri_msgs::WaypointArray::FORWARD;
    else if ((direction == itri_msgs::WaypointArray::BACKWARD))
        waypointArray.direction = itri_msgs::WaypointArray::BACKWARD;

    return waypointArray;
}

std::vector<std::vector<Pose2D>> RRTPathCombination(
    std::vector<std::vector<Pose2D>> & forwardVector,
    std::vector<std::vector<Pose2D>> & backwardVector,
    const std::vector<Pose2D> & path,
    itri_msgs::RRTPlanningResponse & response)
{
    std::vector<std::vector<Pose2D>> directionVector;
    bool startingForward = false;
    int restOfForwardSize = forwardVector.size();
    int restOfBackwardSize = backwardVector.size();

    if (restOfForwardSize + restOfBackwardSize == 0)
        return directionVector;

    if (forwardVector.size() >= 1 && path[0].x == forwardVector[0][0].x)
        startingForward = true;
    else if (backwardVector.size() >= 1 && path[0].x == backwardVector[0][0].x)
        startingForward = false;

    if(startingForward)
    {
        for (auto i = 0u; i < forwardVector.size(); i++)
        {
            if (restOfForwardSize > 0)
            {
                std::cout << "forwardVector[i].size(): " <<forwardVector[i].size()<< '\n';

                directionVector.push_back(forwardVector[i]);
                response.waypointArrays.push_back(vectorToWaypoints(
                    forwardVector[i], itri_msgs::WaypointArray::FORWARD));
                restOfForwardSize--;
            }
            if (restOfBackwardSize > 0)
            {
                std::cout << "backwardVector[i].size(): " <<backwardVector[i].size()<< '\n';

                directionVector.push_back(backwardVector[i]);
                response.waypointArrays.push_back(vectorToWaypoints(
                    backwardVector[i], itri_msgs::WaypointArray::FORWARD));
                restOfBackwardSize--;
            }
        }
    }
    else
    {
        for (auto i = 0u; i < backwardVector.size(); i++)
        {
            if (restOfBackwardSize > 0)
            {
                std::cout << "backwardVector[i].size(): " <<backwardVector[i].size()<< '\n';

                directionVector.push_back(backwardVector[i]);
                response.waypointArrays.push_back(vectorToWaypoints(
                    backwardVector[i], itri_msgs::WaypointArray::FORWARD));
                restOfBackwardSize--;
            }
            if (restOfForwardSize > 0)
            {
                std::cout << "forwardVector[i].size(): " <<forwardVector[i].size()<< '\n';

                directionVector.push_back(forwardVector[i]);
                response.waypointArrays.push_back(vectorToWaypoints(
                    forwardVector[i], itri_msgs::WaypointArray::FORWARD));
                restOfForwardSize--;
            }
        }
    }
    return directionVector;
}

visualization_msgs::Marker treeToRos(
    const std::vector<std::vector<Pose2D>> & tree,
    const std::vector<double> & weights = std::vector<double>(.7)) {
    visualization_msgs::Marker marker;

    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();
    marker.ns = "tree";
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.orientation.w = 1.;
    marker.pose.position.z = -0.1;
    marker.id = 1;
    marker.lifetime = ros::Duration(1.0);

    marker.type = visualization_msgs::Marker::LINE_LIST;

    marker.scale.x = 0.05;
    marker.color.r = 1.;
    marker.color.a = 1.;
    marker.color.g = .5;

    for (size_t pathIndex = 0; pathIndex < tree.size(); pathIndex++) {
        const std::vector<Pose2D> & path = tree[pathIndex];

        for (size_t i = 0; i + 1 < path.size(); i++) {
            geometry_msgs::Point p0, p1;
            p0.x = path[i].x;
            p0.y = path[i].y;
            p1.x = path[i+1].x;
            p1.y = path[i+1].y;

            if (weights.size() > 0) {
                std_msgs::ColorRGBA color;
                color.r = (1 - weights[pathIndex]);
                color.g = weights[pathIndex];
                color.a = 0.5;
                marker.colors.push_back(color);
                marker.colors.push_back(color);
            }

            marker.points.push_back(p0);
            marker.points.push_back(p1);
        }
    }

    return marker;
}

visualization_msgs::Marker treeBackwardToRos(
    const std::vector<std::vector<Pose2D>> & tree,
    const std::vector<double> & weights = std::vector<double>(.7)) {
    visualization_msgs::Marker marker;

    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();
    marker.ns = "tree";
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.orientation.w = 1.;
    marker.pose.position.z = -0.1;
    marker.id = 1;
    marker.lifetime = ros::Duration(1.0);

    marker.type = visualization_msgs::Marker::LINE_LIST;

    marker.scale.x = 0.05;
    marker.color.b = 1.;
    marker.color.g = .5;
    marker.color.a = 1.;

    for (size_t pathIndex = 0; pathIndex < tree.size(); pathIndex++) {
        const std::vector<Pose2D> & path = tree[pathIndex];

        for (size_t i = 0; i + 1 < path.size(); i++) {
            geometry_msgs::Point p0, p1;
            p0.x = path[i].x;
            p0.y = path[i].y;
            p1.x = path[i+1].x;
            p1.y = path[i+1].y;

            if (weights.size() > 0) {
                std_msgs::ColorRGBA color;
                color.r = (1 - weights[pathIndex]);
                color.g = weights[pathIndex];
                color.a = 0.5;
                marker.colors.push_back(color);
                marker.colors.push_back(color);
            }

            marker.points.push_back(p0);
            marker.points.push_back(p1);
        }
    }

    return marker;
}

visualization_msgs::Marker pathToRos(const std::vector<Pose2D> & path,
    float r, float g, float b, float a, float z)
{
    visualization_msgs::Marker marker;

    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();
    marker.ns = "path";
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.orientation.w = 1.;
    marker.id = 0;
    marker.lifetime = ros::Duration(1.0);

    marker.type = visualization_msgs::Marker::LINE_STRIP;

    // marker.scale.x = 0.05;
    marker.scale.x = 0.2;
    marker.pose.position.z = z;

    marker.color.r = r;
    marker.color.g = g;
    marker.color.b = b;
    marker.color.a = a;

    for (auto pose = path.begin(); pose < path.end(); pose++) {
        geometry_msgs::Point p;
        p.x = (*pose).x;
        p.y = (*pose).y;
        marker.points.push_back(p);
    }

    return marker;
}


visualization_msgs::Marker originalPathToRos(const std::vector<Pose2D> & path) {
    visualization_msgs::Marker marker;

    marker.header.frame_id = "map";
    marker.header.stamp = ros::Time::now();
    marker.ns = "path";
    marker.action = visualization_msgs::Marker::ADD;
    marker.pose.orientation.w = 1.;
    marker.id = 1;

    marker.type = visualization_msgs::Marker::LINE_STRIP;

    marker.scale.x = 0.05;
    marker.pose.position.z = 0.1;
    marker.color.b = 1.;
    marker.color.a = 1.;

    for (auto pose = path.begin(); pose < path.end(); pose++) {
        geometry_msgs::Point p;
        p.x = (*pose).x;
        p.y = (*pose).y;
        marker.points.push_back(p);
    }

    return marker;
}

geometry_msgs::PoseArray poseArrayToRos(const std::vector<Pose2D> & poses) {
    geometry_msgs::PoseArray array;
    array.header.frame_id = "map";
    array.header.stamp = ros::Time::now();
    for (const Pose2D & pose : poses) {
        array.poses.push_back(RosUtils::poseToRos(pose));
    }
    return array;
}

geometry_msgs::PoseArray endToRos(const RRTStar<Pose2D>::Node* end) {
    geometry_msgs::PoseArray array;
    array.header.frame_id = "map";
    array.header.stamp = ros::Time::now();
    std::vector<Pose2D> roughPath;
    Pose2D tempPose;
    while (end->parent != NULL) {
        tempPose.x = end->state.x;
        tempPose.y = end->state.y;
        tempPose.theta = end->state.theta;
        roughPath.push_back(tempPose);
        end = end->parent;
    }
    tempPose.x = end->state.x;
    tempPose.y = end->state.y;
    tempPose.theta = end->state.theta;
    roughPath.push_back(tempPose);

    std::reverse(roughPath.begin(), roughPath.end());

    for (const Pose2D & pose : roughPath) {
        array.poses.push_back(RosUtils::poseToRos(pose));
    }
    return array;
}

visualization_msgs::MarkerArray modelToRos(const std::vector<Pose2D> & path) {
    visualization_msgs::MarkerArray rectArray;
    int i = 0;
    for (auto pose = path.begin(); pose < path.end(); pose+=2) {
        visualization_msgs::Marker rectangles;
        rectangles.header.frame_id = "map";
        rectangles.header.stamp = ros::Time::now();
        rectangles.ns = "Car Shape";
        rectangles.action = visualization_msgs::Marker::ADD;
        rectangles.id = i;

        rectangles.type = visualization_msgs::Marker::LINE_LIST;

        rectangles.scale.x = 0.1;
        // rectangles.scale.y = 2.0;
        // rectangles.scale.z = 0.00;

        rectangles.color.b = 1.;
        rectangles.color.a = 0.3;

        geometry_msgs::Point center, polygon1, polygon2, polygon3, polygon4;
        center.x = (*pose).x + 1.5 * cos((*pose).theta);
        center.y = (*pose).y + 1.5 * sin((*pose).theta);
        // (*pose).theta = (*pose).theta;

        polygon1.x = center.x + 2 * cos((*pose).theta) + 1 * sin((*pose).theta);
        polygon1.y = center.y + 2 * sin((*pose).theta) - 1 * cos((*pose).theta);

        polygon2.x = center.x + -2 * cos((*pose).theta) + 1 * sin((*pose).theta);
        polygon2.y = center.y + -2 * sin((*pose).theta) + -1 * cos((*pose).theta);

        polygon3.x = center.x + 2 * cos((*pose).theta) + -1 * sin((*pose).theta);
        polygon3.y = center.y + 2 * sin((*pose).theta) + 1 * cos((*pose).theta);

        polygon4.x = center.x + -2 * cos((*pose).theta) + -1 * sin((*pose).theta);
        polygon4.y = center.y + -2 * sin((*pose).theta) + 1 * cos((*pose).theta);

        std::vector<geometry_msgs::Point> polygon;
        polygon.push_back(polygon1);
        polygon.push_back(polygon2);
        polygon.push_back(polygon4);
        polygon.push_back(polygon3);

        auto point1 = polygon.back();
        for (auto const& point2 : polygon)
        {
            rectangles.points.push_back(point1);
            rectangles.points.push_back(point2);
            point1 = point2;
        }

        rectArray.markers.push_back(rectangles);
        i++;
    }
    return rectArray;
}

visualization_msgs::MarkerArray modelToRos(const std::vector<Pose2D> & path, const std::shared_ptr<Car> & mCar, double r, double g, double b)
{
    visualization_msgs::MarkerArray rectArray;
    int i = 0;
    double carLength = mCar->GetCarLength();
    double carWidth = mCar->GetCarWidth();
    double carRearLength = mCar->GetCarRearLength();
    for (auto pose = path.begin(); pose < path.end(); pose+=2) {
        visualization_msgs::Marker rectangles;
        rectangles.header.frame_id = "map";
        rectangles.header.stamp = ros::Time::now();
        rectangles.ns = "Car Shape";
        rectangles.action = visualization_msgs::Marker::ADD;
        rectangles.id = i;

        rectangles.type = visualization_msgs::Marker::LINE_LIST;

        rectangles.scale.x = 0.1;
        // rectangles.scale.y = 2.0;
        // rectangles.scale.z = 0.00;

        rectangles.color.r = r;
        rectangles.color.g = g;
        rectangles.color.b = b;
        rectangles.color.a = 1.;

        geometry_msgs::Point center, polygon1, polygon2, polygon3, polygon4;
        center.x = (*pose).x + (carLength/2 - carRearLength) * cos((*pose).theta);
        center.y = (*pose).y + (carLength/2 - carRearLength) * sin((*pose).theta);
        // (*pose).theta = (*pose).theta;

        polygon1.x = center.x + (carLength/2) * cos((*pose).theta) + (carWidth/2) * sin((*pose).theta);
        polygon1.y = center.y + (carLength/2) * sin((*pose).theta) - (carWidth/2) * cos((*pose).theta);

        polygon2.x = center.x + -(carLength/2) * cos((*pose).theta) + (carWidth/2) * sin((*pose).theta);
        polygon2.y = center.y + -(carLength/2) * sin((*pose).theta) + -(carWidth/2) * cos((*pose).theta);

        polygon3.x = center.x + (carLength/2) * cos((*pose).theta) + -(carWidth/2) * sin((*pose).theta);
        polygon3.y = center.y + (carLength/2) * sin((*pose).theta) + (carWidth/2) * cos((*pose).theta);

        polygon4.x = center.x + -(carLength/2) * cos((*pose).theta) + -(carWidth/2) * sin((*pose).theta);
        polygon4.y = center.y + -(carLength/2) * sin((*pose).theta) + (carWidth/2) * cos((*pose).theta);

        std::vector<geometry_msgs::Point> polygon;
        polygon.push_back(polygon1);
        polygon.push_back(polygon2);
        polygon.push_back(polygon4);
        polygon.push_back(polygon3);

        auto point1 = polygon.back();
        for (auto const& point2 : polygon)
        {
            rectangles.points.push_back(point1);
            rectangles.points.push_back(point2);
            point1 = point2;
        }

        rectArray.markers.push_back(rectangles);
        i++;
    }
    return rectArray;
}
};
