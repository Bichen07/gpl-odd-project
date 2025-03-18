#ifndef HC_REEDS_SHEPP_H
#define HC_REEDS_SHEPP_H

#include <ros/ros.h>
#include <steering_functions/hc_cc_state_space/cc00_reeds_shepp_state_space.hpp>
#include <steering_functions/hc_cc_state_space/hcpmpm_reeds_shepp_state_space.hpp>
#include <steering_functions/hc_cc_state_space/hc00_reeds_shepp_state_space.hpp>
#include <steering_functions/hc_cc_state_space/hcpm0_reeds_shepp_state_space.hpp>
#include <steering_functions/hc_cc_state_space/hc0pm_reeds_shepp_state_space.hpp>
#include <steering_functions/hc_cc_state_space/ccpmpm_dubins_state_space.hpp>
#include <steering_functions/hc_cc_state_space/cc00_dubins_state_space.hpp>
#include <steering_functions/steering_functions.hpp>

#include <rrt_planning/Steer/Steer.hpp>
#include <rrt_planning/State/Pose2D.hpp>

#define DISCRETIZATION 0.1               // [m]

using namespace std;
// using namespace e503;

class PathClass
{
public:
    // path properties
    string id_;
    string path_type_;
    double discretization_;
    State_With_Covariance state_start_;
    State state_goal_;
    double kappa_max_;
    double sigma_max_;
    vector<State_With_Covariance> path_;

    // filter parameters
    Motion_Noise motion_noise_;
    Measurement_Noise measurement_noise_;
    Controller controller_;

    // constructor
    PathClass() {};
    PathClass(const string& path_type, const State_With_Covariance& state_start, const State& state_goal,
            const double kappa_max, const double sigma_max, const double resolution);
};

class ccReedsSheppStateSpace{
public:
    class ccReedsSheppPath{
    public:
        ccReedsSheppPath() {};
        double length() const { return totalLength_; }
        double backwardLength() const { return backwardLength_; }
        double cusp() const { return cusp_; }
        double curve() const { return curve_; }
        double totalLength = 0;
        vector<Control> controls;

        double length_[5];
        double totalLength_;
        double backwardLength_;
        double firstLength_;
        double lastLength_;
        double curve_;
        int cusp_;
    };

private:
    Motion_Noise motion_noise_ = {
        .alpha1 = 0.1,
        .alpha2 = 0.0,
        .alpha3 = 0.0,
        .alpha4 = 0.1};

    Measurement_Noise measurement_noise_ = {
        .std_x = 0.1,
        .std_y = 0.1,
        .std_theta = 0.01};

    Controller controller_ = {
        .k1 = 1.0,
        .k2 = 1.0,
        .k3 = 1.0};

    double kappa_max_ = 0.2;
    double sigma_max_ = 0.1;
    double discretization_ = 0.1;

public:
    double rho_;
    ccReedsSheppStateSpace(double turningRadius) :
        rho_(turningRadius),
        state_space(kappa_max_, sigma_max_, discretization_)
        {
            state_space.set_filter_parameters(motion_noise_, measurement_noise_, controller_);
        }

    // CCpmpm_Reeds_Shepp_State_Space state_space;
    CC00_Reeds_Shepp_State_Space state_space;
    // HCpmpm_Reeds_Shepp_State_Space state_space;
    // HC00_Reeds_Shepp_State_Space state_space;
    // HC0pm_Reeds_Shepp_State_Space state_space;
    // CC00_Dubins_State_Space state_space;
    // CCpmpm_Dubins_State_Space state_space;


    double discretization() const { return discretization_; }
};

class ccReedsSheppSteer : public Steer<Pose2D>{
private:
    ccReedsSheppStateSpace space;
    ccReedsSheppStateSpace::ccReedsSheppPath path;

public:
    Pose2D start;
    Pose2D end;
    State_With_Covariance start_wout_curv;
    State goal_wout_curv;

    ccReedsSheppSteer(double turningRadius_) : space(turningRadius_) {};

    bool steer(const Pose2D * start, const Pose2D * end);

    vector<Pose2D> sample(double resolution);

    double cost(CostType type, double preLength);
    double backwardCost();
    int cusp();
    double firstLength();
    double lastLength();
    double distance();
    double* segLength();
    double segmentCost();
    double totalLength();
    double curve();
    Pose2D interpolateDistance(double t);
    double lowerBoundCost(const Pose2D * state, const Pose2D * end) const;
};
#endif
