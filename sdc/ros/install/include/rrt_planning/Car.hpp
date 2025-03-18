#ifndef CAR_HPP
#define CAR_HPP

#include <vector>
#include <rrt_planning/State/Pose2D.hpp>

class Car
{
public:
    Car(
        const double & length,
        const double & width,
        const double & wheelBase,
        const double & frontLength,
        const double & rearLength,
        const double & radiusOfGyration,
        const double & sideMirrorWidth);
    void RearCenterToCollisionCircles(const Pose2D &, std::vector<Pose2D> &);
    void CarStateToRearCenter(const Pose2D &, float, Pose2D &);
    void VehicleBlock(const Pose2D &, float, std::vector<std::vector<Pose2D>> &);
    double CollisionCircleRadius(const double &);
    double CollisionCircleRadius(int &, const double &);
    double GetCarLength();
    double GetCarWidth();
    double GetCarRearLength();
    double GetSmallestTurningRadius();

private:
    double mLength;
    double mWidth;
    double mWheelBase;
    double mFrontLength;
    double mRearLength;
    double mRadiusOfGyration;
    double mSideMirrorWidth;
};
#endif // CAR_HPP
