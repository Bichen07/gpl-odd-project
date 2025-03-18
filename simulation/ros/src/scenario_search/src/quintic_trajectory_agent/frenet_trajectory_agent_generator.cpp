#include <stdlib.h>
#include <iostream>
#include <math.h>
#include <time.h>
#include <Eigen/Dense>
#include <frenet_trajectory_agent_generator.h>
#include <math_utils.h>
#include <math_frenet_coord.h>
#include <motion_state.h>
#include <utils_converter.h>
#include <geometry_type.h>
#include <geometry_msgs/Twist.h>
#include <itri_msgs/CarState.h>
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include <simulation_msgs/SimulationAgentStateControl.h>
#include <simulation_msgs/CollisionProfile.h>
#include <simulation_msgs/AgentPose2DArray.h>
#include <quintic_agents_formula.hpp>

#define TIME_STEP 0.01
#define AGENT_LOOK_AHEAD_SEC 0.5

namespace scen_srch{

bool PointInRectangle(math::Vector2d_t point, geometry::Rect2d rect)
{
    // Check if the point lies in the same side for 4 vector
    auto xp = point.x();
    auto yp = point.y();

    std::vector<math::Vector2d_t> rectPoint;  // Clockwise
    rectPoint.push_back(rect.topLeft);
    rectPoint.push_back(rect.topRight);
    rectPoint.push_back(rect.bottomRight);
    rectPoint.push_back(rect.bottomLeft);

    bool inside = true;
    for (uint i = 0; i < 4; i++)
    {
        auto lastIdx = (i>0)?(i-1):(3);
        auto x1 = rectPoint[lastIdx].x();
        auto y1 = rectPoint[lastIdx].y();
        auto x2 = rectPoint[i].x();
        auto y2 = rectPoint[i].y();

        bool isOutside = ((yp - y1) * (x2 -x1) - (xp - x1) * (y2 - y1)) > 0;

        if (((yp - y1) * (x2 -x1) - (xp - x1) * (y2 - y1)) > 0)
        {
            return false;
        }
        // should < 0 if in right side; = 0 if on line.
    }

    return true;
}

// public func.

FrenetTrajectoryAgentGenerator::FrenetTrajectoryAgentGenerator()
{
    geometry_msgs::Vector3 defaultSize;
    defaultSize.x = 3.6;
    defaultSize.y = 1.8;
    defaultSize.z = 1.7;
    FrenetTrajectoryAgentGenerator("agent_scensrch", defaultSize);
}

time_t AgentNameAsRandomSeed(std::string name)
{
    srand(time(NULL));
    time_t co = 0;
    for(int i = 0; i < name.length(); i++)
    {
        co += abs(time_t(name[i] * int(rand() * 10000)));
    }
    return co;
}


FrenetTrajectoryAgentGenerator::FrenetTrajectoryAgentGenerator(
    std::string agentName, geometry_msgs::Vector3 agentSize)
    : mAgentName(agentName)
    , mAgentSize(agentSize)
    , mNodeHandle()
    , mGlobalPathSubscriber()
    , mCollisionSubscriber()
    , mGenerateAgentByWaypointService()
    , mFrenetTransformer()
    , mGlobalPathAcquired(false)
    , mEgoVehicleObserver()
    , mCollisionTime(ros::Time())
    , mMaxTrajMarker(0)
    , mAgentCount(0)
{
    mGlobalPathSubscriber = mNodeHandle.subscribe(
        "/global_path", 1,
        &FrenetTrajectoryAgentGenerator::CallbackGlobalPath,
        this);

    mCollisionSubscriber = mNodeHandle.subscribe(
        "simulation/collision_profile", 1,
        &FrenetTrajectoryAgentGenerator::CallbackCollisionPath,
        this);

    mAgentTrajPublisher = mNodeHandle.advertise
        <visualization_msgs::MarkerArray>("viz_traj", 1);

    mAgentStatePublisher = mNodeHandle.advertise
        <simulation_msgs::SimulationAgentStateControl>(
            "simulation/agent/state_control", 1);

    mCreateAgentService =
        mNodeHandle.serviceClient<simulation_srvs::SimulationCreateAgent>(
            "simulation/agent/create_service");

    mDeleteAgentService =
        mNodeHandle.serviceClient<simulation_srvs::SimulationDeleteAgent>(
            "simulation/agent/delete_service");

    mCreateAgentRequest.request.agentId = mAgentName;
    mCreateAgentRequest.request.size = mAgentSize;

    mDeleteAgentRequest.request.agentId = mAgentName;

    auto randomSeed = time(NULL) + AgentNameAsRandomSeed(mAgentName);
    ROS_INFO_STREAM("Random Seed: " << randomSeed);
    srand(randomSeed);
}

FrenetTrajectoryAgentGenerator::~FrenetTrajectoryAgentGenerator()
{
    mDeleteAgentRequest.request.agentId = mCurrentAgentId;
    ROS_INFO_STREAM(
        "Agent " << mCurrentAgentId <<
        " of group " << mAgentName << "deleted.");
    mDeleteAgentService.call(mDeleteAgentRequest);
    visualization_msgs::Marker msg;
    msg.action = 3;
    msg.ns = "AgentTraj/" + mAgentName;
    visualization_msgs::MarkerArray msgs;
    msgs.markers.push_back(msg);
    mAgentTrajPublisher.publish(msgs);
    ros::Duration(1.).sleep();
    mAgentTrajPublisher.publish(msgs);
    ros::Duration(1.).sleep();
    mAgentTrajPublisher.publish(msgs);
    ros::Duration(1.).sleep();
}

void FrenetTrajectoryAgentGenerator::Configure(
    const std::vector<math::Vector3d_t> &waypoint3ds)
{
    mRefWaypoint3ds = waypoint3ds;
    mRefWaypoint2ds.resize(mRefWaypoint3ds.size());
    std::transform(
        mRefWaypoint3ds.begin(),
        mRefWaypoint3ds.end(),
        mRefWaypoint2ds.begin(),
        [](const math::Vector3d_t &waypoint3d)
        {return math::Vector2d_t(waypoint3d.x(), waypoint3d.y());});
    mFrenetTransformer.Configure(
        mRefWaypoint2ds,
        utils::FileLineNumPairInstance());
    ROS_INFO("[RandomFrenetTrajGenerator] Configure Done.");
}

void FrenetTrajectoryAgentGenerator::MainLoop(
    const bool automaticallyGenerateAgentWithRandomRequest)
{

    while (ros::ok())
    {
        ros::Duration(0.1).sleep();
        ros::spinOnce();
        if (mGlobalPathAcquired)
            break;
    }

    ROS_INFO("Got Global Path.");

    auto startAfterFrenetS = mGlobalPath.waypoints[30].s;
    uint globalPathLenght = uint(mGlobalPath.waypoints.size());
    auto endAfterFrenetS = mGlobalPath.waypoints[globalPathLenght-151].s;

    if (automaticallyGenerateAgentWithRandomRequest)
    {
        ROS_INFO("Automatically Generates Agents.");
        for (uint iAgentsGenerated = 0; ros::ok(); iAgentsGenerated += 1)
        {

            // Get Ego Information
            geometry_msgs::Pose egoPose = utils::ConvertToGeometryMsgsPose(
                mEgoVehicleObserver.GetTransform3d());
            math::FrenetCoord fPoint = mFrenetTransformer.ConvertToFrenetCoord(
                math::Vector2d_t(egoPose.position.x, egoPose.position.y));

            if (fPoint.s() < startAfterFrenetS ||
                fPoint.s() > endAfterFrenetS)
            {
                iAgentsGenerated -= 1;
                ros::Duration(0.1).sleep();
                ros::spinOnce();
                continue;
            }

            std::vector<itri_msgs::CarState> agentProfile;
            scenario_search::GenerateAgentByWaypoint::Request request;

            auto randomAgentParam = Rand();

            if (randomAgentParam < 0.75)  // Generate preset agents.
                request = quintic_agent::Random();
            else if (randomAgentParam < 0.8)
                request = quintic_agent::Acc();
            else if (randomAgentParam < 0.9)
                request = quintic_agent::Overtake();
            else
                request = quintic_agent::UTurn();

            for(uint i = 0; i < request.waypoints.points.size(); i++)
                request.waypoints.points[i].position.x += fPoint.s();

            uint retryTimes = -1;

            while (true)
            {
                egoPose = utils::ConvertToGeometryMsgsPose(
                    mEgoVehicleObserver.GetTransform3d());
                fPoint = mFrenetTransformer.ConvertToFrenetCoord(
                    math::Vector2d_t(egoPose.position.x, egoPose.position.y));
                agentProfile = GenerateQuinticAgent(request, egoPose, fPoint);

                if (AgentInDangerArea(agentProfile[0].pose.pose))
                {
                    ros::spinOnce();
                    retryTimes += 1;
                    if (retryTimes % 500)
                    {
                        ROS_WARN_STREAM("[Quintic Agent Generate] Generate Failed.");
                        ros::Duration(2.).sleep();
                        retryTimes = 0;
                    }
                    ros::Duration(0.01).sleep();
                }
                else
                {
                    break;
                }
            }

            PublishTrajectory(agentProfile);


            bool donePeacefully = RunGeneratedAgentWrapper(
                agentProfile, request.delay_time, request.trigger_distance);

        }
    }
    else
    {
        ROS_INFO("Wait for agent generation requests.");
        mGenerateAgentByWaypointService = mNodeHandle.advertiseService(
            "scenario_search/generate_agent_by_waypoint",
            &FrenetTrajectoryAgentGenerator::RunGenerateAgentByWaypointService,
            this);
        ros::spin();
    }
}

void FrenetTrajectoryAgentGenerator::CleanAgentsWithSameName()
{
    simulation_msgs::AgentPose2DArray::ConstPtr agentList =
        ros::topic::waitForMessage<simulation_msgs::AgentPose2DArray>(
            "simulation/agent_pose2d", mNodeHandle);
    for (auto agent: agentList->id_list)
    {
        if (agent.find(mAgentName) == 0)
        {
            mDeleteAgentRequest.request.agentId = agent;
            mDeleteAgentService.call(mDeleteAgentRequest);
        }
    }
}

// protected func.


// private func.

std::vector<itri_msgs::CarState> FrenetTrajectoryAgentGenerator::GenerateQuinticAgent(
    scenario_search::GenerateAgentByWaypoint::Request request,
    geometry_msgs::Pose egoPose, math::FrenetCoord fPoint)
{

    std::vector<itri_msgs::CarState> agentProfile;

    uint nWps = request.waypoints.points.size();
    math::real_t segmentTimeHorizon = request.time_horizon / (nWps-1.);
    math::real_t trajSteps = request.time_horizon / TIME_STEP;
    math::real_t segSteps = trajSteps / (nWps-1.);

    // Calculate heading of given frenet point.
    // We want the heading to be parallel with waypoint on global_path
    request.waypoints.points[0].position.x = std::max(
        request.waypoints.points[0].position.x, 10.0);

    math::FrenetCoord agentPosition(
        request.waypoints.points[0].position.x, request.waypoints.points[0].position.y);

    int32_t wayPointIdx = mFrenetTransformer.ComputeWaypointIdx(agentPosition);
    math::real_t waypointHeading = mGlobalPath.waypoints[wayPointIdx].heading;

    math::Vector2d_t agentPositionCartesian(
        mFrenetTransformer.ConvertToCartesianCoord(agentPosition));

    math::Vector2d_t agentVelocityCartesian(
        mFrenetVelocityTransformer.ConvertToCartesianCoord(math::FrenetCoord(
            request.waypoints.points[0].velocity.x,
            request.waypoints.points[0].velocity.y),
            waypointHeading));

    math::Vector2d_t agentAccelerationCartesian(
        mFrenetVelocityTransformer.ConvertToCartesianCoord(math::FrenetCoord(
            request.waypoints.points[0].acceleration.x,
            request.waypoints.points[0].acceleration.y),
            waypointHeading));

    for (uint iSeg = 1; iSeg < nWps; iSeg++)
    {

        request.waypoints.points[iSeg].position.x = std::max(
        request.waypoints.points[iSeg].position.x, 15.0);

        math::FrenetCoord agentPosition(
            request.waypoints.points[iSeg].position.x,
            request.waypoints.points[iSeg].position.y);
        wayPointIdx = mFrenetTransformer.ComputeWaypointIdx(agentPosition);
        waypointHeading = mGlobalPath.waypoints[wayPointIdx].heading;

        math::Vector2d_t agentPosition2Cartestian(
        mFrenetTransformer.ConvertToCartesianCoord(math::FrenetCoord(
            request.waypoints.points[iSeg].position.x,
            request.waypoints.points[iSeg].position.y)));

        math::Vector2d_t agentVelocity2Cartestian(
            mFrenetVelocityTransformer.ConvertToCartesianCoord(math::FrenetCoord(
                request.waypoints.points[iSeg].velocity.x,
                request.waypoints.points[iSeg].velocity.y),
                waypointHeading));

        math::Vector2d_t agentAcceleration2Cartestian(
            mFrenetVelocityTransformer.ConvertToCartesianCoord(math::FrenetCoord(
                request.waypoints.points[iSeg].acceleration.x,
                request.waypoints.points[iSeg].acceleration.y),
                waypointHeading));

        Eigen::Matrix<math::real_t, 6, 1> xBoundaries;
        Eigen::Matrix<math::real_t, 6, 1> yBoundaries;

        xBoundaries <<
            agentPositionCartesian.x(), agentPosition2Cartestian.x(),
            agentVelocityCartesian.x(), agentVelocity2Cartestian.x(),
            agentAccelerationCartesian.x(), agentAcceleration2Cartestian.x();

        yBoundaries <<
            agentPositionCartesian.y(), agentPosition2Cartestian.y(),
            agentVelocityCartesian.y(), agentVelocity2Cartestian.y(),
            agentAccelerationCartesian.y(), agentAcceleration2Cartestian.y();

        math::real_t T = segmentTimeHorizon;
        Eigen::Matrix<math::real_t, 6, 6> coeffs;
        coeffs <<
                          0.0,                 0.0,                  0.0,            0.0,     0.0,     1.0,
                   pow(T, 5.),          pow(T, 4.),           pow(T, 3.),     pow(T, 2.),       T,     1.0,
                          0.0,                 0.0,                  0.0,            0.0,     1.0,     0.0,
             5.0 * pow(T, 4.),    4.0 * pow(T, 3.),     3.0 * pow(T, 2.),        2.0 * T,     1.0,     0.0,
                          0.0,                 0.0,                  0.0,            2.0,     0.0,     0.0,
            20.0 * pow(T, 3.),   12.0 * pow(T, 2.),              6.0 * T,            2.0,     0.0,     0.0;
        Eigen::Matrix<math::real_t, 6, 6> coeffsInverse = coeffs.inverse();

        Eigen::Matrix<math::real_t, 6, 1> xSolve = coeffsInverse * xBoundaries;
        Eigen::Matrix<math::real_t, 6, 1> ySolve = coeffsInverse * yBoundaries;

        for (uint iStep = 0; iStep < segSteps; iStep++)
        {
            Eigen::Matrix<math::real_t, 6, 1> tPower(6);
            math::real_t timeStamp(math::real_t(iStep) * TIME_STEP);
            tPower << pow(timeStamp, 5.), pow(timeStamp, 4.), pow(timeStamp, 3.),
                      pow(timeStamp, 2.), pow(timeStamp, 1.), pow(timeStamp, 0.);
            math::real_t xi(xSolve.dot(tPower));
            math::real_t yi(ySolve.dot(tPower));

            itri_msgs::CarState state;
            state.pose.pose.position.x = xi;
            state.pose.pose.position.y = yi;
            if (!agentProfile.empty()) // Not using first point when applying traj on agent.
            {
                geometry_msgs::Pose lastPose = agentProfile.back().pose.pose;
                geometry_msgs::Pose currPose = state.pose.pose;
                float dx = currPose.position.x - lastPose.position.x;
                float dy = currPose.position.y - lastPose.position.y;
                float currHeading = atan2(dy, dx);
                float lastHeading = agentProfile.back().pose.pose.orientation.z;
                state.pose.pose.orientation.z = currHeading;
                state.twist.twist.linear.x = dx / TIME_STEP;
                state.twist.twist.linear.y = dy / TIME_STEP;
                state.twist.twist.angular.z =
                    (currHeading - lastHeading) / TIME_STEP;
            }
            agentProfile.push_back(state);
        }

        agentPositionCartesian = agentPosition2Cartestian;
        agentVelocityCartesian = agentVelocity2Cartestian;
        agentAccelerationCartesian = agentAcceleration2Cartestian;

    }

    return agentProfile;
}

void FrenetTrajectoryAgentGenerator::PublishTrajectory(
    std::vector<itri_msgs::CarState> & carStates)
{
    visualization_msgs::MarkerArray msgs;
    visualization_msgs::Marker msg;

    msg.header.frame_id = "map";
    msg.ns = "AgentTraj/" + mAgentName;
    msg.type = 2;

    for (uint i = 0; i < carStates.size(); i++)
    {
        itri_msgs::CarState state = carStates[i];
        msg.id = i;
        msg.action = 0;
        msg.pose.position.x = state.pose.pose.position.x;
        msg.pose.position.y = state.pose.pose.position.y;
        msg.pose.orientation.z = state.pose.pose.orientation.z;
        msg.scale.x = msg.scale.y = msg.scale.z = 0.5;

        if (i < 100)
            msg.color.r = 0.8 - 0.2 * (float(i) / 100.);
        else
            msg.color.r = 0.8;
        msg.color.g = 0.6;
        msg.color.b = 0.8;
        msg.color.a = 1.0;
        msgs.markers.push_back(msg);
    }

    // Clean previous trajectories
    mMaxTrajMarker = std::max(mMaxTrajMarker, uint(carStates.size()));

    msg.action = 2;
    for (uint i = carStates.size(); i < mMaxTrajMarker - 1; i++)
    {
        msg.id = i;
        msgs.markers.push_back(msg);
    }

    mAgentTrajPublisher.publish(msgs);
}

bool FrenetTrajectoryAgentGenerator::AgentFailed(itri_msgs::CarState & state)
{
    motion::State egoState = mEgoVehicleObserver.GetState();
    math::FrenetCoord egoFrenetPoint = mFrenetTransformer.ConvertToFrenetCoord(
        math::Vector2d_t(egoState.position.x(), egoState.position.y()));
    math::FrenetCoord agentFrenetPoint(mFrenetTransformer.ConvertToFrenetCoord(
        math::Vector2d_t(state.pose.pose.position.x, state.pose.pose.position.y)));

    math::real_t distance = pow(
        pow(egoState.position.x()-state.pose.pose.position.x, 2) +
        pow(egoState.position.y()-state.pose.pose.position.y, 2) ,
        0.5);

    if (distance > 50.)
    {
        // ROS_DEBUG("Agent reset: too far.");
        return true;
    }

    if (ros::Time::now() - mCollisionTime < ros::Duration(0.02))
    {
        // ROS_DEBUG("Agent reset: collision.");
        simulation_msgs::SimulationAgentStateControl stateControl;
        while (mCollisionTime != ros::Time() && ros::ok())
        {
            mAgentStatePublisher.publish(stateControl);
            mCollisionTime = ros::Time();
            ros::Duration(0.2).sleep();
        }
        return true;
    }

    return false;
}

bool FrenetTrajectoryAgentGenerator::CheckIntersection(
    std::vector<itri_msgs::CarState> agentProfile, uint currentIdx,
    math::real_t lookAheadSec)
{
    math::Vector3d_t egoSize(mEgoVehicleObserver.GetSize());
    geometry::Rect2d egoBox(
        mEgoVehicleObserver.CompouteWorldBoundingRect3dWithSpareSpaceForAgent(
            math::Vector3d_t(
                mAgentSize.x, mAgentSize.y, mAgentSize.z)));

    uint lookAheadIdxMax = std::min(
        uint(agentProfile.size()-1), currentIdx + uint(lookAheadSec / TIME_STEP));

    for (uint iPoint = currentIdx; iPoint <= lookAheadIdxMax; iPoint++)
    {
        math::Vector2d_t waypoint(
            agentProfile[iPoint].pose.pose.position.x,
            agentProfile[iPoint].pose.pose.position.y);
        if(PointInRectangle(waypoint, egoBox))
            return true;
    }
    return false;
}

bool FrenetTrajectoryAgentGenerator::AgentInDangerArea(
    const geometry_msgs::Pose agent)
{
    auto egoLinearVelocity(
        mEgoVehicleObserver.GetState().linearVelocity);
    math::Vector3d_t egoSize(mEgoVehicleObserver.GetSize());
    geometry::Rect2d egoBox(
        mEgoVehicleObserver.CompouteWorldBoundingRect3dWithSpareSpaceForAgent(
            math::Vector3d_t(
                mAgentSize.x + egoLinearVelocity.x() * 5.,
                mAgentSize.y,
                mAgentSize.z)));
    math::Vector2d_t agentPoint(agent.position.x, agent.position.y);
    return PointInRectangle(agentPoint, egoBox);
}

bool FrenetTrajectoryAgentGenerator::RunGeneratedAgentWrapper(
    std::vector<itri_msgs::CarState> agentProfile,  // orientation: z
    const math::real_t delayTime,
    const math::real_t triggerDistance)
{
    mAgentCount++;
    mCurrentAgentId = mAgentName + "." + std::to_string(mAgentCount);
    mCreateAgentRequest.request.agentId = mCurrentAgentId;
    mDeleteAgentRequest.request.agentId = mCurrentAgentId;
    mCreateAgentRequest.request.pose = agentProfile.front().pose.pose;

    mCreateAgentService.call(mCreateAgentRequest);
    RunGeneratedAgent(agentProfile, delayTime, triggerDistance);
    mDeleteAgentService.call(mDeleteAgentRequest);
}

bool FrenetTrajectoryAgentGenerator::RunGeneratedAgent(
    std::vector<itri_msgs::CarState> agentProfile,
    const math::real_t delayTime,
    const math::real_t triggerDistance)
{

    // Publish Agent
    ros::Rate nodeRate(1.0f / TIME_STEP);
    uint stopCounter = 0;
    auto agentLookAheadSec = AGENT_LOOK_AHEAD_SEC;
    for (uint step = 1; step < agentProfile.size(); step++)
    {
        simulation_msgs::SimulationAgentStateControl agentStateControlMsg;
        agentStateControlMsg.agentIds.push_back(mCurrentAgentId);

        agentStateControlMsg.onlyPose = false;
        agentStateControlMsg.onlyPoint = false;
        agentStateControlMsg.dt = TIME_STEP;

        // Stop agent and even go reverse if stucked with ego
        if(CheckIntersection(agentProfile, step, agentLookAheadSec))
        {
            geometry_msgs::Twist twist;
            auto tmpProfile = agentProfile[step];
            tmpProfile.twist.twist = twist;
            agentStateControlMsg.carStates.push_back(tmpProfile);
            agentStateControlMsg.carStates[0].twist.twist = twist;
            stopCounter += 1;
            step -= 1;
            if (stopCounter > 1500)
            {
                return false;
            }
            step = std::max(step, uint(1));
        }
        else
        {
            if (stopCounter)
            {
                stopCounter = 0;
                ros::Duration(2.).sleep();
            }
            agentLookAheadSec = AGENT_LOOK_AHEAD_SEC;
            agentStateControlMsg.carStates.push_back(agentProfile[step]);
        }

        // Check delay time and trigger distance condition
        uint notTriggeredCounter = 0;
        if (step == 1)
        {
            auto zeroTwistControlMsg = agentStateControlMsg;
            geometry_msgs::TwistStamped emptyTwist;
            zeroTwistControlMsg.carStates[0].twist = emptyTwist;
            mAgentStatePublisher.publish(zeroTwistControlMsg);

            if (abs(triggerDistance) > 5.0)
            {
                geometry_msgs::Pose egoCurrentPose;
                math::FrenetCoord egoCurrentFrenetPoint, agentInitFrenetPoint;
                math::real_t distance = 9999999, lastDistance = 9999999;
                bool triggerDistanceIsMet = false, triggerDistanceIsCrossed = false;

                // Wait for ego reaching trigger distance;
                while(!(triggerDistanceIsMet || triggerDistanceIsCrossed) && ros::ok())
                {
                    egoCurrentPose = utils::ConvertToGeometryMsgsPose(
                        mEgoVehicleObserver.GetTransform3d());
                    egoCurrentFrenetPoint = mFrenetTransformer.ConvertToFrenetCoord(
                        math::Vector2d_t(
                            egoCurrentPose.position.x, egoCurrentPose.position.y));
                    agentInitFrenetPoint = mFrenetTransformer.ConvertToFrenetCoord(
                        math::Vector2d_t(
                            agentStateControlMsg.carStates[0].pose.pose.position.x,
                            agentStateControlMsg.carStates[0].pose.pose.position.y));
                    distance = agentInitFrenetPoint.s() - egoCurrentFrenetPoint.s();

                    triggerDistanceIsMet = abs(distance-triggerDistance) < 0.01;
                    triggerDistanceIsCrossed =
                        (distance-triggerDistance)*(lastDistance-triggerDistance) < 0.;

                    if (abs(distance-triggerDistance) > 100.)
                        return false;

                    ROS_DEBUG_STREAM_THROTTLE(5.,
                        "ego: "<< egoCurrentFrenetPoint.s() <<
                        ", agent: "  << agentInitFrenetPoint.s() <<
                        ", dist: "<<distance);

                    lastDistance = distance;
                    mAgentStatePublisher.publish(zeroTwistControlMsg);
                    ros::spinOnce();
                    nodeRate.sleep();

                    if (notTriggeredCounter++ > 2500)
                    {
                        return false;
                    }
                    ROS_DEBUG_STREAM("notTriggeredCounter for "<<
                        mCurrentAgentId << ": " << notTriggeredCounter);
                }
                ROS_DEBUG("Triggered.");
            }

            if (delayTime)
            {
                mAgentStatePublisher.publish(zeroTwistControlMsg);
                ROS_DEBUG_STREAM("Wait for delay time "<<delayTime<<" seconds");
                ros::Duration(delayTime).sleep();
            }
        }

        mAgentStatePublisher.publish(agentStateControlMsg);
        nodeRate.sleep();


        ros::spinOnce();

        if (AgentFailed(agentProfile[step]))
            return false;

        if (!ros::ok())
            return false;

    }

    return true;
}

void FrenetTrajectoryAgentGenerator::CallbackGlobalPath(const itri_msgs::Path & msg)
{
    ros::Duration(1.0).sleep();
    std::vector<math::Vector3d_t> refWaypoint3ds;
    for(int i = 0; i < msg.waypoints.size(); i++)
    {
        math::Vector3d_t point(
            msg.waypoints[i].point.x,
            msg.waypoints[i].point.y,
            msg.waypoints[i].point.z);

        refWaypoint3ds.push_back(point);
    }

    Configure(refWaypoint3ds);
    mGlobalPath = msg;
    mGlobalPathAcquired = true;
}

void FrenetTrajectoryAgentGenerator::CallbackCollisionPath(
    const simulation_msgs::CollisionProfile &msg)
{
    mCollisionTime = ros::Time::now();
}

bool FrenetTrajectoryAgentGenerator::RunGenerateAgentByWaypointService(
    scenario_search::GenerateAgentByWaypoint::Request &request,
    scenario_search::GenerateAgentByWaypoint::Response &response)
{
    auto startTime = ros::Time::now();
    geometry_msgs::Pose egoPose = utils::ConvertToGeometryMsgsPose(
        mEgoVehicleObserver.GetTransform3d());
    math::FrenetCoord fPoint = mFrenetTransformer.ConvertToFrenetCoord(
        math::Vector2d_t(egoPose.position.x, egoPose.position.y));
    auto agentProfile = GenerateQuinticAgent(request, egoPose, fPoint);
    math::real_t delayTime = request.delay_time;
    math::real_t triggerDistance = request.trigger_distance;
    bool donePeacefully = RunGeneratedAgentWrapper(agentProfile, delayTime, triggerDistance);
    response.duration = ros::Time::now() - startTime;
    response.reason = (donePeacefully)?("Success"):("Accident");
    response.score = 0;
}

} // namespace scen_srch{
