#ifndef OCCUPANCY_GRID_2D_HPP
#define OCCUPANCY_GRID_2D_HPP

#include <string>
#include <random>
#include <png.h>

#include <nav_msgs/OccupancyGrid.h>
#include <rrt_planning/ros_utils.hpp>
#include <rrt_planning/State/Pose2D.hpp>
#include <rrt_planning/Occupancy/Occupancy.hpp>
#include <rrt_planning/Steer/Steer.hpp>
#include <itri_msgs/WaypointArray.h>
#include <itri_msgs/Waypoint.h>
#include <itri_msgs/ParkingSpace.h>

template <class State>
class OccupancyGrid2D : public Occupancy<State> {
private:
    double bufferedRadius;
    double noBufferedRadius;
    double collisionCheckingResolution;
    double resolution;
    int collisionCircleNum;

    State origin;

    std::vector<double> map;
    std::vector<double> dt; // distance transform
    size_t width;
    size_t height;
    size_t originalWidth;
    size_t originalHeight;

    std::default_random_engine generator;
    std::uniform_real_distribution<double> colDistribution;
    std::uniform_real_distribution<double> rowDistribution;
    std::uniform_real_distribution<double> thetaDistribution;

    double intToProbability(uint8_t i) const;
    bool InitializeMap(size_t width, size_t height, double resolution_, State origin_);
    void computeDistanceTransform();

public:
    OccupancyGrid2D();
    size_t getWidth() {return width;};
    size_t getHeight() {return height;};
    double getResolution() {return resolution;};
    const Pose2D & getOrigin() {return origin;};

    double entropy() const;

    void SetObjectRadius(double objectRadius, double searchBuffer);
    void SetCollisionCircleNum(int initCircleNum);
    void SetCarContext(const std::shared_ptr<Car> & car);
    double distanceTransform(const State * state) const;

    double OccupancyProbability(const State * state) const;
    double OccupancyProbability(int cell) const;
    double OccupancyProbability(size_t row, size_t col) const;

    inline bool isFree(const State * state) const {
        return OccupancyProbability(state) < freeThreshold(); }
    inline bool isOccupied(const State * state) const {
        return OccupancyProbability(state) > occupiedThreshold(); }
    inline bool isUnknown(const State * state) const {
        return (not isFree(state)) and (not isOccupied(state)); }
    inline bool isFree(size_t row, size_t col) const {
        return OccupancyProbability(row, col) < freeThreshold(); }
    inline bool isFree(int cell) const {
        return OccupancyProbability(cell) < freeThreshold(); }
    inline bool isOccupied(size_t row, size_t col) const {
        return OccupancyProbability(row, col) > occupiedThreshold(); }
    inline bool isOccupied(int cell) const {
        return OccupancyProbability(cell) > occupiedThreshold(); }
    inline bool isUnknown(size_t row, size_t col) const {
        return (not isFree(row, col)) and (not isOccupied(row, col)); }
    inline bool isUnknown(int cell) const {
        return (not isFree(cell)) and (not isOccupied(cell)); }

    int rowColToCell(size_t row, size_t col) const;
    void StateToRowCol(const Pose2D * state, size_t & row, size_t & col) const;
    void xyToRowCol(double x, double y, size_t & row, size_t & col) const;
    void RowColToXY(size_t row, size_t col, double & x, double & y) const;

    bool IsSteerFree(Steer<State> * steer) const;
    double freeThreshold() const {return 0.4;};
    double occupiedThreshold() const {return 0.6;};
    void RandomState(State * state);
    bool UpdateDistribution(State start, State goal, double expandLenghth);
    void RenewDistribution();

    template<typename T>
    bool SetMap(const std::vector<T> & dataVec, size_t width, size_t height, double resolution_, State origin_);

    bool SetMap(std::string mapPngFile, double resolution, State origin);
    bool SetMap(const int8_t * data, size_t width, size_t height, double resolution_, State origin_);
    bool SetMap(const uint8_t * data, size_t width, size_t height, double resolution_, State origin_);
    bool SetObjToMap(std::vector<int8_t> & mapData,
        const std::vector<std::vector<Pose2D>> & objsPoly);
    bool ClearObjToMap(std::vector<int8_t> & mapData,
        const std::vector<std::vector<Pose2D>> & objsPoly);
    nav_msgs::OccupancyGrid FreeSpaceToMap(
        const std::vector<Pose2D> & freeSpace,
        const Pose2D & start, int mapWidth,
        int mapHeight, float mapResolution);
    nav_msgs::OccupancyGrid SetSpaceScopeToMap(
        const Pose2D & start, const Pose2D & goal,
        int direction,
        std::vector<std::vector<Pose2D>> & objsPoly,
        float scopeSize, float mapResolution);
    std::pair<Pose2D, Pose2D> SetNewStartEnd(
        const Pose2D & start, const Pose2D & end);

    std::shared_ptr<Car> mCar;
};

#endif // OCCUPANCY_GRID_2D_HPP
