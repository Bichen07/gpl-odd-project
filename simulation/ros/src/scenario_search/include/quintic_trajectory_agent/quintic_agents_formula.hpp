#ifndef _QUINTICAGENTS_FORMULA_H_
#define _QUINTICAGENTS_FORMULA_H_

#include <scenario_search/GenerateAgentByWaypoint.h>
#include <math_utils.h>

#define MAX_VELOCITY 22.0
#define MAX_ACCELERATION 1.6
#define MAX_DECELERATION -4.9
#define N_VIA_POINTS 19  // For quintic agent

math::real_t Rand(void)
{
    return math::real_t(rand() % 32767 / 32766.);
}

math::real_t RandRange(math::real_t low, math::real_t high)
{
    return math::real_t(Rand() * (high-low) + low);
}


namespace quintic_agent{


// Random Agents

scenario_search::GenerateAgentByWaypoint::Request Random(uint nPoints)
{
    scenario_search::GenerateAgentByWaypoint::Request request;
    scenario_search::QuinticWaypointArray waypoints;
    for (uint iWp = 0; iWp < nPoints; iWp++)
    {
        scenario_search::QuinticWaypoint wp;
        wp.position.x = RandRange(6., 40.) * (Rand()<0.5?1.:-1.);
        wp.position.y = RandRange(-8., 8.);
        wp.velocity.x = RandRange(-MAX_VELOCITY, MAX_VELOCITY);
        wp.velocity.y = 0.1 * pow(
            pow(MAX_VELOCITY, 2) - pow(wp.velocity.x, 2), 0.5) * (Rand()<0.5?1.:-1.);
        wp.acceleration.x = RandRange(-MAX_ACCELERATION, MAX_ACCELERATION);
        wp.acceleration.y = 0.01 * pow(
            pow(MAX_ACCELERATION, 2) - pow(wp.acceleration.x, 2), 0.5) * 
            (Rand()<0.5?1.:-1.);
        waypoints.points.push_back(wp);
    }
    request.waypoints = waypoints;
    request.time_horizon = 12.;
    return request;
}

scenario_search::GenerateAgentByWaypoint::Request Random()
{
    return Random(2);
}


// Acc Agents

scenario_search::GenerateAgentByWaypoint::Request Acc(
    uint nPoints, math::real_t lateralOffset)
{
    scenario_search::GenerateAgentByWaypoint::Request request;
    scenario_search::QuinticWaypointArray waypoints;
    for (uint iWp = 0; iWp < N_VIA_POINTS; iWp++)
    {
        scenario_search::QuinticWaypoint wp;
        wp.position.x = 24 + iWp * 5.;
        wp.position.y = lateralOffset;
        wp.velocity.x = 2.5;
        wp.velocity.y = 0.0;
        wp.acceleration.x = 0.0;
        wp.acceleration.y = 0.0;
        waypoints.points.push_back(wp);
    }
    request.waypoints = waypoints;
    request.time_horizon = 28.;
    request.delay_time = 0.0;
    request.trigger_distance = 22.0;
    return request;
}

scenario_search::GenerateAgentByWaypoint::Request Acc(uint nPoints)
{
    return Acc(nPoints, math::real_t(0.0));
}

scenario_search::GenerateAgentByWaypoint::Request Acc(math::real_t lateralOffset)
{
    return Acc(19, lateralOffset);
}

scenario_search::GenerateAgentByWaypoint::Request Acc()
{
    return Acc(19, math::real_t(0.0));
}


// Overtake Agents

scenario_search::GenerateAgentByWaypoint::Request Overtake()
{
    scenario_search::GenerateAgentByWaypoint::Request request;
    scenario_search::QuinticWaypointArray waypoints;

    float opposite = (Rand() < 0.5)?(1.):(-1.);

    scenario_search::QuinticWaypoint wp;
    wp.position.x = -28.;
    wp.position.y = 0. * opposite;
    wp.velocity.x = 24.;
    waypoints.points.push_back(wp);

    wp.position.x = 30.;
    wp.position.y = 2.8 * opposite;
    wp.velocity.x = 28.;
    waypoints.points.push_back(wp);

    wp.position.x = 68.;
    wp.position.y = 0.2 * opposite;
    wp.velocity.x = 3.;
    waypoints.points.push_back(wp);

    wp.position.x = 84.;
    wp.position.y = -0.4 * opposite;
    wp.velocity.x = 3.;
    waypoints.points.push_back(wp);

    wp.position.x = 100.;
    wp.position.y = 0.0 * opposite;
    wp.velocity.x = 3.;
    waypoints.points.push_back(wp);

    request.waypoints = waypoints;
    request.time_horizon = RandRange(14, 20);  // 16.
    request.delay_time = RandRange(0., 2.);  // 0.0;
    request.trigger_distance = -40.0 + RandRange(-10., 10.);
    return request;
}


// U-Turn Agent

scenario_search::GenerateAgentByWaypoint::Request UTurn()
{
    scenario_search::GenerateAgentByWaypoint::Request request;
    scenario_search::QuinticWaypointArray waypoints;

    scenario_search::QuinticWaypoint wp;
    wp.position.x = 40.;
    wp.position.y = -0.5;
    wp.velocity.x = 4.;
    waypoints.points.push_back(wp);

    wp.position.x = 55.;
    wp.position.y = -0.7;
    wp.velocity.x = 0.;
    wp.velocity.y = 0.;
    waypoints.points.push_back(wp);

    wp.position.x = 59.;
    wp.position.y = 2.0;
    wp.velocity.x = 0.;
    wp.velocity.y = 1.5;
    waypoints.points.push_back(wp);

    wp.position.x = 40.;
    wp.position.y = 4.8;
    wp.velocity.x = -4.;
    wp.velocity.y = 0.;
    waypoints.points.push_back(wp);    

    request.waypoints = waypoints;
    request.time_horizon = RandRange(14, 20);  // 15.
    request.delay_time = RandRange(0., 2.);  // 0.0;
    request.trigger_distance = 22.0 - RandRange(0., 2.);
    return request;
}

}

#endif // #ifndef _QUINTICAGENTS_FORMULA_H_