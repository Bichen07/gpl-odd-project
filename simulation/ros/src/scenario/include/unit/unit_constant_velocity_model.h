#ifndef _UNIT_CONSTANT_ACCELERATION_MODEL_H_
#define _UNIT_CONSTANT_ACCELERATION_MODEL_H_

#include "itri_msgs/Waypoint.h"
#include <actor_agent_speed_manager.h>
#include <actor_obstacle.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <math_frenet_transformer.h>
#include <math_moving_average_filter.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_constant_velocity_config.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int32.h>
#include <unit_model.h>
#include <unordered_map>
#include <unordered_set>

namespace unit {

class ConstantVelocityModel final : public Model
{
    using YawRateFilter = math::MovingAverageFilter<math::real_t>;

  public:
    typedef std::shared_ptr<ConstantVelocityModel> Ptr;

    ConstantVelocityModel();
    ConstantVelocityModel(const ConstantVelocityModel&) = delete;
    ConstantVelocityModel& operator=(const ConstantVelocityModel&) = delete;
    virtual ~ConstantVelocityModel() = default;

    virtual std::string GetId() const override;
    virtual void Configure(const ModelConfig& config) override;
    virtual void Update() override;
    virtual void AccessAgentAttributes(
      std::vector<scenario::AgentAttribute>* agentAttributes) override;
    virtual void RunCarlaUpdate(
      std::vector<carla::ActorUpdateData>* actorUpdateDatas) override;

    inline const std::vector<actor::Vehicle::Ptr>& GetMovingVehicles() const
    {
        return mMovingVehicles;
    }
    inline const math::FrenetTransformer& GetFrenetTransformer() const
    {
        return mFrenetTransformer;
    }
    inline const std::vector<motion::ConstantVelocityConfig> GetMotionConfigs()
      const
    {
        return mMotionConfigs;
    }
    inline const std::shared_ptr<itri_msgs::Waypoint>& GetEgoNearestWaypoint()
      const
    {
        return mEgoNearestWaypoint;
    }
    inline const bool GetDoneConfigureMotions() const
    {
        return mDoneConfigureMotions;
    }

  protected:
  private:
    static constexpr const char* AgentIdPrefix()
    {
        return "constant_velocity_";
    }

    virtual void ConfigureMotions() override;
    virtual void EgoVehicleGlobalPathCallback(
      const itri_msgs::Path& msg) override;

    void ScenarioEndsCallback(const std_msgs::Header& msg);
    void ScenarioCountCallback(const std_msgs::Int32 msg);
    void ScenarioStableCallback(const std_msgs::Bool msg);

    std::vector<actor::Vehicle::Ptr> mMovingVehicles;
    std::vector<motion::ConstantVelocityConfig> mMotionConfigs;
    utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
    math::FrenetTransformer mFrenetTransformer;
    measure::FrenetDistanceEvaluator mFrenetDistanceEvaluator;
    pcl::KdTreeFLANN<pcl::PointXYZ> mGlobalPathKdtree;
    std::unordered_map<int, itri_msgs::Waypoint> mKdtreeWaypointMap;
    ros::Publisher mEgoSpeedCmdPublisher;
    std::shared_ptr<itri_msgs::Waypoint> mEgoNearestWaypoint = nullptr;

    ros::Subscriber mScenarioCountSubscriber;
    ros::Publisher mEndScenarioPublisher;

    math::Vector3d_t mAgentInitialVelocity;
    ros::Subscriber mScenarioStableSubscriber;
    bool mScenarioStable = false;

    YawRateFilter mYawRateFilter;
};

} // namespace unit

#endif // #ifndef _UNIT_CONSTANT_VELOCITY_MODEL_H_
