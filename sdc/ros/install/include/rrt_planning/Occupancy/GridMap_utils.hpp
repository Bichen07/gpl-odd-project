#include <rrt_planning/State/Pose2D.hpp>
#include <rrt_planning/Steer/Steer.hpp>
#include <boost/geometry.hpp>
#include <boost/geometry/geometries/point.hpp>
#include <boost/geometry/geometries/polygon.hpp>
#include <boost/foreach.hpp>
#include <itri_msgs/ParkingSpace.h>

static const float HALF = 0.5f;
static const float RESOLUTION_DEFAULT = 1.0f;
static const float THRESHOLD_SAFETY_FACTOR = 1.0f;

typedef boost::geometry::model::point<
    float, 2, boost::geometry::cs::cartesian> BoostPoint;
typedef boost::geometry::model::polygon<BoostPoint> BoostPolygon;

std::vector<Pose2D> GetFreeSpace(const BoostPolygon & parkingSpot, const BoostPolygon & lane);
Pose2D GetMapOrigin(const Pose2D & vehicle, float mapWidth, float mapHeight);
Pose2D GetMapOrigin(const Pose2D & vehicleStart, const Pose2D & vehicleGoal, float scopeSize);
std::vector<Pose2D> GetSupplement(const Pose2D & start, const Pose2D & end, float resolution);
BoostPolygon LaneToPoly(const itri_msgs::WaypointArray & lane, const float roadWidth);
BoostPolygon ParkingSpotToPoly(const itri_msgs::ParkingSpace & parkingSpot);
void CalculatePathCurvature(const itri_msgs::WaypointArray & path, std::vector<float> & curvature);
void PathOffset(
    const itri_msgs::WaypointArray & Oldpath,
    const float bias,
    const std::vector<float> curvature,
    std::vector<Pose2D> & newPath);
void PointOffset(const float distance, itri_msgs::Waypoint & point);

static inline float PrincipleAngleMinusPi(const float angle)
{
    return std::atan2(std::sin(angle), std::cos(angle));
}

static inline float SupplementaryAngle(const float angle)
{
    return PrincipleAngleMinusPi(M_PI - angle);
}

static inline float GetPrincipalAngle(const float & angle)
{
    float angleMod = std::fmod(angle, 2.0f * M_PI);
    if (std::signbit(angleMod))
        angleMod += 2.0f * M_PI;
    return angleMod;
}

static inline float Reciprocal(const float value)
{
    return 1.0f / value;
}

static inline float Sigmoid(const float x)
{
    return Reciprocal(1.0f + std::exp(-x));
}

static inline bool IsCurveUnderThreshold(
    const float curvature, const float offset)
{
    const float thershold = Reciprocal(
        std::abs(offset) + THRESHOLD_SAFETY_FACTOR);
    return std::signbit(curvature * offset) || std::abs(curvature) < thershold;
}

std::vector<Pose2D> GetFreeSpace(const BoostPolygon & parkingSpot, const BoostPolygon & lane)
{
    std::vector<Pose2D> freeSpace;
    std::vector<BoostPolygon> output;

    boost::geometry::union_(parkingSpot, lane, output);

    float area = 0.0;
    BOOST_FOREACH(BoostPolygon const & p, output)
    {
        area += boost::geometry::area(p);
    }
    std::cout << "area: " <<area<< '\n';
    std::cout << "output size: " <<output.size()<< '\n';
    if (area > 0.0)
    {
        for(size_t i = 0; i < output[0].outer().size(); i++)
        {
            freeSpace.push_back({boost::geometry::get<0>(output[0].outer()[i]),
                boost::geometry::get<1>(output[0].outer()[i]), 0.0});
        }
    }
    return freeSpace;
}

Pose2D GetMapOrigin(const Pose2D & vehicle, float mapWidth, float mapHeight)
{
    Pose2D origin;

    origin.x = vehicle.x + (mapHeight - 10.0f) * std::cos(GetPrincipalAngle(vehicle.theta)) +
        (mapWidth / 2.0f) * std::cos(GetPrincipalAngle(vehicle.theta - M_PI_2));
    origin.y =  vehicle.y + (mapHeight - 10.0f) * std::sin(GetPrincipalAngle(vehicle.theta)) +
        (mapWidth / 2.0f) * std::sin(GetPrincipalAngle(vehicle.theta - M_PI_2));
    origin.theta = GetPrincipalAngle(vehicle.theta + M_PI_2);
    origin.theta = origin.theta > M_PI?
        origin.theta - 2.0f * M_PI :
        origin.theta;

    return origin;
}

Pose2D GetMapOrigin(const Pose2D & vehicleStart, const Pose2D & vehicleGoal,
    float scopeSize)
{
    Pose2D origin;

    float vector = std::atan2(vehicleGoal.y - vehicleStart.y, vehicleGoal.x - vehicleStart.x);

    origin.x = vehicleStart.x +
        scopeSize * std::cos(GetPrincipalAngle(vector + M_PI_2)) +
        scopeSize * std::cos(GetPrincipalAngle(vector + M_PI));

    origin.y =  vehicleStart.y +
        scopeSize * std::sin(GetPrincipalAngle(vector + M_PI_2)) +
        scopeSize * std::sin(GetPrincipalAngle(vector + M_PI));

    origin.theta = GetPrincipalAngle(vector - M_PI_2);

    origin.theta = origin.theta > M_PI?
        origin.theta - 2.0f * M_PI : origin.theta;

    return origin;
}

std::vector<Pose2D> GetSupplement(const Pose2D & start, const Pose2D & end, float resolution)
{
    Pose2D tempPoint = start;
    std::vector<Pose2D> points;
    float length = std::sqrt(std::pow(end.x - start.x, 2) + std::pow(end.y - start.y, 2));
    float heading = GetPrincipalAngle(atan2(end.y - start.y, end.x - start.x));
    for (int i = 0; i < int(length / resolution); i++)
    {
        tempPoint.x = tempPoint.x + resolution * std::cos(heading);
        tempPoint.y = tempPoint.y + resolution * std::sin(heading);
        tempPoint.theta = heading;
        points.push_back(tempPoint);
    }
    return points;
}

BoostPolygon ParkingSpotToPoly(const itri_msgs::ParkingSpace & parkingSpot)
{
    BoostPolygon output;

    if (parkingSpot.array.waypoints.size() >= 4)
    {
        Pose2D point, center = {0.0, 0.0, 0.0};
        std::vector<std::pair<Pose2D, float>> polyOrder;

        for (auto i = 0u; i < parkingSpot.array.waypoints.size(); i++)
        {
            point = {parkingSpot.array.waypoints[i].pose.pose.position.x,
                parkingSpot.array.waypoints[i].pose.pose.position.y, 0.0};
            center.x += point.x;
            center.y += point.y;
            polyOrder.push_back({point, 0.0});
        }
        center.x /= parkingSpot.array.waypoints.size();
        center.y /= parkingSpot.array.waypoints.size();

        for (auto i = 0u; i < polyOrder.size(); i++)
        {
            polyOrder[i].second = GetPrincipalAngle(std::atan2(
                polyOrder[i].first.y - center.y, polyOrder[i].first.x - center.x));
        }

        std::sort(polyOrder.begin(), polyOrder.end(),
            [](const std::pair<Pose2D, float> &lhs,
            const std::pair<Pose2D, float> &rhs)
            {return lhs.second > rhs.second;});

        std::vector<Pose2D> supplement;
        for (auto i = 0u; i < polyOrder.size(); i++)
        {
            boost::geometry::append(output, BoostPoint{(float)(polyOrder[i].first.x), (float)(polyOrder[i].first.y)});

            if(i != polyOrder.size() - 1u)
                supplement = GetSupplement(polyOrder[i].first, polyOrder[i+1].first, 1.0);
            else
                supplement = GetSupplement(polyOrder[i].first, polyOrder[0].first, 1.0);

            if(supplement.size() > 0)
            {
                for (const Pose2D & pose : supplement)
                {
                    boost::geometry::append(output, BoostPoint{(float)(pose.x), (float)(pose.y)});
                }
            }
        }
        boost::geometry::correct(output);
    }
    return output;
}

BoostPolygon LaneToPoly(const itri_msgs::WaypointArray & lane, const float roadWidth)
{
    BoostPolygon output;
    itri_msgs::WaypointArray effectiveLane;
    int effectiveSize = std::min(int(lane.waypoints.size()), 40);

    for (int i = 0; i < effectiveSize; i++)
    {
        effectiveLane.waypoints.push_back(lane.waypoints[i]);
    }

    if (effectiveLane.waypoints.size() > 1)
    {
        std::vector<Pose2D> leftPoints;
        std::vector<Pose2D> rightPoints;
        std::vector<Pose2D> lanePoints;
        std::vector<Pose2D> supplement;
        std::vector<float> curvature;

        CalculatePathCurvature(effectiveLane, curvature);
        PathOffset(effectiveLane, - roadWidth / 2.0 - 1.0, curvature, rightPoints);
        PathOffset(effectiveLane, roadWidth / 2.0, curvature, leftPoints);
        std::reverse(rightPoints.begin(),rightPoints.end());

        lanePoints.insert(lanePoints.end(), leftPoints.begin(),leftPoints.end());
        supplement = GetSupplement(leftPoints.back(), rightPoints.front(), 1.0);
        if(supplement.size() > 0)
            lanePoints.insert(lanePoints.end(), supplement.begin(),supplement.end());
        lanePoints.insert(lanePoints.end(), rightPoints.begin(),rightPoints.end());
        supplement = GetSupplement(rightPoints.back(), leftPoints.front(), 1.0);
        if(supplement.size() > 0)
            lanePoints.insert(lanePoints.end(), supplement.begin(),supplement.end());

        for (const Pose2D & pose : lanePoints)
        {
            boost::geometry::append(output, BoostPoint{(float)(pose.x), (float)(pose.y)});
        }
        boost::geometry::correct(output);
    }
    return output;
}

void CalculatePathCurvature(const itri_msgs::WaypointArray & path, std::vector<float> & curvature)
{
    curvature.resize(path.waypoints.size(), 0.0f);

    for (size_t i = 1; i < curvature.size(); i ++)
    {
        const float angleHalf = HALF * SupplementaryAngle(
            path.waypoints[i].pose.pose.orientation.z -
            path.waypoints[i - 1].pose.pose.orientation.z);
        const float radius = HALF * RESOLUTION_DEFAULT * std::tan(angleHalf);
        curvature[i] = std::pow(radius, -1.0f);
    }
}

void PathOffset(
    const itri_msgs::WaypointArray & Oldpath,
    const float bias,
    const std::vector<float> curvature,
    std::vector<Pose2D> & newPath)
{
    newPath.clear();

    for (size_t j = 0; j < Oldpath.waypoints.size(); ++ j)
    {
        const float offset = bias;

        if (IsCurveUnderThreshold(curvature[j], offset))
        {
            itri_msgs::Waypoint point = Oldpath.waypoints[j];
            PointOffset(offset, point);
            Pose2D pointOutput =
                {point.pose.pose.position.x, point.pose.pose.position.y, 0.0};
            newPath.push_back(pointOutput);
        }
    }
}

void PointOffset(
    const float distance, itri_msgs::Waypoint & point)
{
    float dir = copysign(-1.0, distance);
    point.pose.pose.position.x +=
        std::abs(distance) * std::cos(point.pose.pose.orientation.z + dir * M_PI_2);
    point.pose.pose.position.y +=
        std::abs(distance) * std::sin(point.pose.pose.orientation.z + dir * M_PI_2);
}
