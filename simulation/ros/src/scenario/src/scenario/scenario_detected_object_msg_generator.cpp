#include <scenario_detected_object_msg_generator.h>
#include <stdexcept>
#include <ros/console.h>
#include <math_utils.h>
#include <utils_converter.h>
#include <utils_geometry_msgs.h>

namespace scenario {

// public func.

DetectedObjectMsgGenerator::DetectedObjectMsgGenerator()
    : mBaseLinkId{"/base_link"}
    , mTransformListener{}
    , mDetectedObjectIdManager{nullptr}
    , mRosTimeFunc{std::bind(&DetectedObjectMsgGenerator::GetRosTime, this)}
    , mUseSimTime{false}
{
    bool useSimTime{false};
    std::string ns = ros::this_node::getNamespace();
    ns = (ns == "/") ? ("") : (ns);
    mBaseLinkId = (ns=="")?("base_link"):(ns + "/base_link");
    
    if (ros::param::get("/use_sim_time", mUseSimTime))
    {
        if (mUseSimTime)
        {
            mRosTimeFunc = std::bind(
                &DetectedObjectMsgGenerator::GetRosTimeNow,
                this);
        }
    }
}

void DetectedObjectMsgGenerator::Configure(
    const DetectedObjectIdManager::Ptr &detectedObjectIdManager,
    const math::HomoXfm3d_t &initBaseLinkToMapXfm)
{
    mDetectedObjectIdManager = detectedObjectIdManager;
    math::Quaternion_t orientation(
        initBaseLinkToMapXfm.linear());
    mTransformListener.AppendInitTransform(
        std::make_pair("base_link", "map"),
        tf::Transform(
            tf::Quaternion(
                orientation.x(),
                orientation.y(),
                orientation.z(),
                orientation.w()),
            tf::Vector3(
                initBaseLinkToMapXfm.translation().x(),
                initBaseLinkToMapXfm.translation().y(),
                initBaseLinkToMapXfm.translation().z())));
}

void DetectedObjectMsgGenerator::ComputeMsg(
    const std::vector<actor::Agent::Ptr> &agents,
    const std::vector<sensor::LidarDetectedObject::Ptr> &lidarDetectedObjects,
    const ros::Time &stamp,
    const DetectedObjectCoord &coord,
    itri_msgs::DetectedObjectArray &outputMsg)
{
    outputMsg.objects.clear();
    outputMsg.objects.resize(
        agents.size() + lidarDetectedObjects.size());

    outputMsg.header.frame_id = this->EvaluateFrameId(coord);
    outputMsg.header.stamp = stamp;

    if (outputMsg.objects.empty())
    {
        return;
    }

    tf::StampedTransform baselinkToMapTransform;
    mTransformListener.Run(
        MapId(),
        mBaseLinkId,
        stamp,
        &baselinkToMapTransform);
    auto object{outputMsg.objects.begin()};

    if (!agents.empty())
    {
        auto agent{agents.cbegin()};
        while (agent != agents.cend())
        {
            const auto objectId{
                mDetectedObjectIdManager->QueryId(
                    (*agent)->GetAttribute().id)};
            this->ComputeDetectedObjectMsg(
                (*agent)->GetAttribute(),
                (*agent)->GetState(),
                stamp,
                coord,
                baselinkToMapTransform,
                objectId,
                *object);
            ++agent;
            ++object;
        }
    }

    if (!lidarDetectedObjects.empty())
    {
        auto lidarDetectedObject{lidarDetectedObjects.cbegin()};
        while (lidarDetectedObject != lidarDetectedObjects.cend())
        {
            const auto objectId{
                mDetectedObjectIdManager->QueryId(
                    (*lidarDetectedObject)->GetId())};
            ++lidarDetectedObject;
            ++object;
        }
    }
}

void DetectedObjectMsgGenerator::Compute(
    const std::vector<std::shared_ptr<actor::Agent>> &agents,
    const std::vector<std::shared_ptr<sensor::LidarDetectedObject>> &lidarDetectedObjects,
    const Coord &coord,
    itri_msgs::DetectedObjectArray &detectedObjectArray)
{
    detectedObjectArray.objects.clear();
    detectedObjectArray.objects.resize(
        agents.size() +
        lidarDetectedObjects.size());

    const ros::Time stamp{ros::Time::now()};
    if (Coord::Local == coord)
    {
        tf::StampedTransform baselinkToMapTransform;
        mTransformListener.Run(
            MapId(),
            mBaseLinkId,
            stamp,
            &baselinkToMapTransform);

        detectedObjectArray.header.frame_id = mBaseLinkId;
        detectedObjectArray.header.stamp = stamp;
        auto object = detectedObjectArray.objects.begin();

        if (!agents.empty())
        {
            auto agent{agents.cbegin()};
            while (agent != agents.cend())
            {
                const auto objectId{
                    mDetectedObjectIdManager->QueryId(
                        (*agent)->GetAttribute().id)};
                this->ComputeLocalCoordDetectedAgent(
                    (*agent)->GetAttribute(),
                    (*agent)->GetState(),
                    stamp,
                    baselinkToMapTransform,
                    objectId,
                    &(*object));
                ++agent;
                ++object;
            }
        }

        if (!lidarDetectedObjects.empty())
        {
            auto lidarDetectedObject{lidarDetectedObjects.cbegin()};
            while (lidarDetectedObject != lidarDetectedObjects.cend())
            {
                const auto objectId{
                    mDetectedObjectIdManager->QueryId(
                        (*lidarDetectedObject)->GetId())};
                this->ComputeLocalCoordLidarObject(
                    *(*lidarDetectedObject),
                    stamp,
                    baselinkToMapTransform,
                    objectId,
                    &(*object));
                ++lidarDetectedObject;
                ++object;
            }
        }
    }
    else if (Coord::World == coord)
    {
        detectedObjectArray.header.frame_id = MapId();
        detectedObjectArray.header.stamp = stamp;
        auto object = detectedObjectArray.objects.begin();

        if (!agents.empty())
        {
            auto agent{agents.cbegin()};
            while (agent != agents.cend())
            {
                const auto objectId{
                    mDetectedObjectIdManager->QueryId(
                        (*agent)->GetAttribute().id)};
                this->ComputeWorldCoordDetectedAgent(
                    (*agent)->GetAttribute(),
                    (*agent)->GetState(),
                    stamp,
                    objectId,
                    &(*object));
                ++agent;
                ++object;
            }
        }

        if (!lidarDetectedObjects.empty())
        {
            auto lidarDetectedObject{lidarDetectedObjects.cbegin()};
            while (lidarDetectedObject != lidarDetectedObjects.cend())
            {
                const auto objectId{
                    mDetectedObjectIdManager->QueryId(
                        (*lidarDetectedObject)->GetId())};
                this->ComputeWorldCoordLidarObject(
                    *(*lidarDetectedObject),
                    stamp,
                    objectId,
                    &(*object));
                ++lidarDetectedObject;
                ++object;
            }
        }
    }
    else
    {
        ROS_ERROR_STREAM("invalid coord: " << coord);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void DetectedObjectMsgGenerator::ComputeMsg(
    const std::vector<DetectedAgentData> &detectedAgentDatas,
    const ros::Time &stamp,
    const Coord &coord,
    const int32_t detectedObjectIdOffset,
    itri_msgs::DetectedObjectArray *msg)
{
    if (nullptr == msg)
    {
        ROS_ERROR_STREAM("msg is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    msg->objects.clear();
    msg->objects.resize(detectedAgentDatas.size());

    if (Coord::Local == coord)
    {
        tf::StampedTransform baselinkToMapTransform;
        mTransformListener.Run(
            MapId(),
            mBaseLinkId,
            stamp,
            &baselinkToMapTransform);

        msg->header.frame_id = mBaseLinkId;
        msg->header.stamp = stamp;
        auto object{msg->objects.begin()};
        int32_t objectIdx{detectedObjectIdOffset};
        for (auto detectedAgentData{detectedAgentDatas.cbegin()};
             detectedAgentData != detectedAgentDatas.cend();
             ++detectedAgentData, ++object, ++objectIdx)
        {
            this->ComputeLocalCoordDetectedAgent(
                detectedAgentData->attribute,
                detectedAgentData->state,
                stamp,
                baselinkToMapTransform,
                objectIdx,
                &(*object));
        }
    }
    else if (Coord::World == coord)
    {
        msg->header.frame_id = MapId();
        msg->header.stamp = stamp;
        auto object{msg->objects.begin()};
        int32_t objectIdx{detectedObjectIdOffset};
        for (auto detectedAgentData{detectedAgentDatas.cbegin()};
             detectedAgentData != detectedAgentDatas.cend();
             ++detectedAgentData, ++object, ++objectIdx)
        {
            this->ComputeWorldCoordDetectedAgent(
                detectedAgentData->attribute,
                detectedAgentData->state,
                stamp,
                objectIdx,
                &(*object));
        }
    }
    else
    {
        ROS_ERROR_STREAM("invalid coord: " << coord);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

// protected func.

// private func.

std::string DetectedObjectMsgGenerator::EvaluateFrameId(const DetectedObjectCoord &coord) const
{
    if (Coord::World == coord.pose || Coord::World == coord.velocity)
    {
        return std::string(MapId());
    }

    return mBaseLinkId;
}

std::string DetectedObjectMsgGenerator::EvaluateFrameId(const Coord &coord) const
{
    return Coord::World == coord ? std::string(MapId()) : mBaseLinkId;
}

void DetectedObjectMsgGenerator::ComputeDetectedObjectMsg(
    const actor::Attribute &attribute,
    const motion::State &state,
    const ros::Time &stamp,
    const DetectedObjectCoord &coord,
    const tf::StampedTransform &baselinkToMapTransform,
    const int32_t detectedObjectId,
    itri_msgs::DetectedObject &outputMsg) const
{
    outputMsg.pose = utils::ConvertToGeometryMsgsPose(
        state.orientation,
        state.position);
    outputMsg.velocity.linear = utils::ConvertToGeometryMsgsVector3(state.linearVelocity);
    outputMsg.velocity.angular = utils::ConvertToGeometryMsgsVector3(state.angularVelocity);

    outputMsg.header.frame_id = this->EvaluateFrameId(coord);
    outputMsg.header.stamp = stamp;

    outputMsg.id = detectedObjectId;
    outputMsg.dimensions = utils::ConvertToGeometryMsgsVector3(attribute.size);
    outputMsg.behavior_state = this->EvaluateBehaviorState(state.linearVelocity);

    outputMsg.convex_hull.header.frame_id = this->EvaluateFrameId(coord.pose);
    outputMsg.convex_hull.header.stamp = stamp;
    this->ComputeWorldCoordCubePolygon(
        geometry::Vector3d(state.position),
        geometry::Quaternion(state.orientation),
        attribute.size,
        outputMsg.convex_hull.polygon);
    outputMsg.label = actor::ToObjectClassLabel(attribute.objectClassId);

    if (Coord::Local == coord.pose)
    {
        tf::Pose worldPose(
            utils::ConvertToTfQuaternion(outputMsg.pose.orientation),
            utils::ConvertToTfVector3(outputMsg.pose.position));
        outputMsg.pose = utils::ConvertToGeometryMsgsPose(
            baselinkToMapTransform.inverse() * worldPose);

        for (auto corner{outputMsg.convex_hull.polygon.points.begin()};
             corner != outputMsg.convex_hull.polygon.points.cend();
             ++corner)
        {
            const tf::Point localCorner =
                baselinkToMapTransform.inverse() *
                utils::ConvertToTfPoint(*corner);
            *corner = utils::ConvertToGeometryMsgsPoint32(localCorner);
        }
    }

    if (Coord::Local == coord.velocity)
    {
        outputMsg.velocity.linear =
            utils::ConvertToGeometryMsgsVector3(
                baselinkToMapTransform.inverse().getBasis() *
                utils::ConvertToTfVector3(outputMsg.velocity.linear));
        outputMsg.velocity.angular =
            utils::ConvertToGeometryMsgsVector3(
                baselinkToMapTransform.inverse().getBasis() *
                utils::ConvertToTfVector3(outputMsg.velocity.angular));
    }
}

void DetectedObjectMsgGenerator::ComputeWorldCoordCubePolygon(
    const geometry::Vector3d &position,
    const geometry::Quaternion &orientation,
    const geometry::Vector3d &size,
    geometry_msgs::Polygon &outputPolygon) const
{
    const double offsetX = double{0.5} * size.x();
    const double offsetY = double{0.5} * size.y();
    const double offsetZ = double{0.5} * size.z();

    const std::vector<double> cornerOffsetXs(
        {+offsetX, -offsetX, -offsetX, +offsetX, +offsetX, -offsetX, -offsetX, +offsetX});
    const std::vector<double> cornerOffsetYs(
        {+offsetY, +offsetY, -offsetY, -offsetY, +offsetY, +offsetY, -offsetY, -offsetY});
    const std::vector<double> cornerOffsetZs(
        {+offsetZ, +offsetZ, +offsetZ, +offsetZ, -offsetZ, -offsetZ, -offsetZ, -offsetZ});

    tf::Transform cubeTransform(
        utils::ConvertToTfQuaternion(orientation),
        utils::ConvertToTfVector3(position));
    outputPolygon.points.resize(cornerOffsetXs.size());
    for (std::size_t idx{0ul}; idx < cornerOffsetXs.size(); ++idx)
    {
        const tf::Point localCorner(
            cornerOffsetXs[idx],
            cornerOffsetYs[idx],
            cornerOffsetZs[idx]);
        const auto worldCorner = cubeTransform * localCorner;
        outputPolygon.points[idx] = utils::ConvertToGeometryMsgsPoint32(worldCorner);
    }
}

void DetectedObjectMsgGenerator::ComputeLocalCoordDetectedAgent(
    const actor::Attribute &attribute,
    const motion::State &state,
    const ros::Time &stamp,
    const tf::StampedTransform &baselinkToMapTransform,
    const int32_t detectedObjectId,
    itri_msgs::DetectedObject *msg)
{
    tf::Pose worldPose;
    worldPose.setOrigin(
        utils::ConvertToTfVector3(state.position));
    worldPose.setRotation(
        utils::ConvertToTfQuaternion(state.orientation));
    tf::Pose localPose = baselinkToMapTransform.inverse() * worldPose;
    msg->pose = utils::ConvertToGeometryMsgsPose(localPose);
    msg->velocity.linear = utils::ConvertToGeometryMsgsVector3(state.linearVelocity);
    msg->velocity.angular = utils::ConvertToGeometryMsgsVector3(state.angularVelocity);

    msg->header.frame_id = mBaseLinkId;
    msg->header.stamp = stamp;

    msg->id = detectedObjectId;
    msg->dimensions = utils::ConvertToGeometryMsgsVector3(attribute.size);
    msg->behavior_state = this->EvaluateBehaviorState(state.linearVelocity);

    msg->convex_hull.header.frame_id = mBaseLinkId;
    msg->convex_hull.header.stamp = stamp;

    const geometry_msgs::Pose agentPoseMsg = utils::ConvertToGeometryMsgsPose(
        state.orientation,
        state.position);
    msg->convex_hull.polygon = utils::ComputeGeometryMsgsLocalCoordCubePolygon(
        agentPoseMsg,
        attribute.size,
        baselinkToMapTransform);
    msg->label = actor::ToObjectClassLabel(attribute.objectClassId);
}

void DetectedObjectMsgGenerator::ComputeWorldCoordDetectedAgent(
    const actor::Attribute &attribute,
    const motion::State &state,
    const ros::Time &stamp,
    const int32_t detectedObjectId,
    itri_msgs::DetectedObject *msg)
{
    msg->pose = utils::ConvertToGeometryMsgsPose(
        state.orientation,
        state.position);
    msg->velocity.linear = utils::ConvertToGeometryMsgsVector3(state.linearVelocity);
    msg->velocity.angular = utils::ConvertToGeometryMsgsVector3(state.angularVelocity);

    msg->header.frame_id = MapId();
    msg->header.stamp = stamp;

    msg->id = detectedObjectId;
    msg->dimensions = utils::ConvertToGeometryMsgsVector3(attribute.size);
    msg->behavior_state = this->EvaluateBehaviorState(state.linearVelocity);

    msg->convex_hull.header.frame_id = MapId();
    msg->convex_hull.header.stamp = stamp;

    const geometry_msgs::Pose agentPoseMsg = utils::ConvertToGeometryMsgsPose(
        state.orientation,
        state.position);
    msg->convex_hull.polygon = utils::ComputeGeometryMsgsWorldCoordCubePolygon(
        agentPoseMsg,
        attribute.size);
    msg->label = actor::ToObjectClassLabel(attribute.objectClassId);
}

void DetectedObjectMsgGenerator::ComputeLocalCoordLidarObject(
    const sensor::LidarDetectedObject &object,
    const ros::Time &stamp,
    const tf::StampedTransform &baselinkToMapTransform,
    const int32_t objectId,
    itri_msgs::DetectedObject *msg)
{
    tf::Pose worldPose;
    worldPose.setOrigin(
        utils::ConvertToTfVector3(object.GetState().position));
    worldPose.setRotation(
        utils::ConvertToTfQuaternion(object.GetState().orientation));
    tf::Pose localPose = baselinkToMapTransform.inverse() * worldPose;
    msg->pose = utils::ConvertToGeometryMsgsPose(localPose);
    msg->velocity.linear = utils::ConvertToGeometryMsgsVector3(object.GetState().linearVelocity);
    msg->velocity.angular = utils::ConvertToGeometryMsgsVector3(object.GetState().angularVelocity);

    msg->header.frame_id = mBaseLinkId;
    msg->header.stamp = stamp;

    msg->id = objectId;
    msg->dimensions = utils::ConvertToGeometryMsgsVector3(object.GetSize());
    msg->behavior_state = this->EvaluateBehaviorState(object.GetState().linearVelocity);

    msg->convex_hull.header.frame_id = mBaseLinkId;
    msg->convex_hull.header.stamp = stamp;

    const auto worldCorners = math::Concatenate(
        object.GetBoundingPolygonalColumn().GetTopPolygonCorners(),
        object.GetBoundingPolygonalColumn().GetBottomPolygonCorners());
    msg->convex_hull.polygon = utils::ComputeGeometryMsgsLocalCoordPolygonalColumn(
        worldCorners,
        baselinkToMapTransform);
}

void DetectedObjectMsgGenerator::ComputeWorldCoordLidarObject(
    const sensor::LidarDetectedObject &object,
    const ros::Time &stamp,
    const int32_t objectId,
    itri_msgs::DetectedObject *msg)
{
    msg->pose = utils::ConvertToGeometryMsgsPose(
        object.GetState().orientation,
        object.GetState().position);
    msg->velocity.linear = utils::ConvertToGeometryMsgsVector3(object.GetState().linearVelocity);
    msg->velocity.angular = utils::ConvertToGeometryMsgsVector3(object.GetState().angularVelocity);

    msg->header.frame_id = MapId();
    msg->header.stamp = stamp;

    msg->id = objectId;
    msg->dimensions = utils::ConvertToGeometryMsgsVector3(object.GetSize());
    msg->behavior_state = this->EvaluateBehaviorState(object.GetState().linearVelocity);

    msg->convex_hull.header.frame_id = MapId();
    msg->convex_hull.header.stamp = stamp;

    const auto worldCorners = math::Concatenate(
        object.GetBoundingPolygonalColumn().GetTopPolygonCorners(),
        object.GetBoundingPolygonalColumn().GetBottomPolygonCorners());
    msg->convex_hull.polygon =
        utils::ComputeGeometryMsgsWorldCoordPoygonalColumn(worldCorners);
}

uint32_t DetectedObjectMsgGenerator::EvaluateBehaviorState(const math::Vector3d_t &linearVelocity) const
{
    const bool isStationary = math::IsApproxZero(
        linearVelocity.norm(),
        math::real_t{1.0e-6});

    const DetectedObjectStateId agentState =
        isStationary ? DetectedObjectState::StoppingState : DetectedObjectState::ForwardState;

    return static_cast<typename std::underlying_type<DetectedObjectStateId>::type>(agentState);
}

ros::Time DetectedObjectMsgGenerator::GetRosTime() const
{
    return ros::Time();
}

ros::Time DetectedObjectMsgGenerator::GetRosTimeNow() const
{
    return ros::Time::now();
}

} // namespace scenario {
