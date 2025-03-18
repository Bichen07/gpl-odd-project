#ifndef _UNIT_ROUTE_MOVING_MODEL_H_
#define _UNIT_ROUTE_MOVING_MODEL_H_

#include <actor_agent_speed_manager.h>
#include <actor_obstacle.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <itri_msgs/Waypoint.h>
#include <math_frenet_transformer.h>
#include <math_moving_average_filter.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_route_moving_config.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int32.h>
#include <std_msgs/String.h>
#include <unit_model.h>
#include <unordered_map>
#include <unordered_set>

namespace unit
{

    class RouteMovingModel final : public Model
    {
        using YawRateFilter   = math::MovingAverageFilter<math::real_t>;
        using MovingAvgFilter = math::MovingAverageFilter<math::real_t>;

    public:
        typedef std::shared_ptr<RouteMovingModel> Ptr;

        RouteMovingModel();
        RouteMovingModel(const RouteMovingModel &)            = delete;
        RouteMovingModel &operator=(const RouteMovingModel &) = delete;
        virtual ~RouteMovingModel();

        virtual std::string GetId() const override;
        virtual void        Configure(const ModelConfig &config) override;
        virtual void        Update() override;
        virtual void        AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes) override;
        virtual void        RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

    protected:
    private:
        static constexpr const char *AgentIdPrefix()
        {
            return "route_moving_";
        }

        virtual void ConfigureMotions() override;
        virtual void EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg) override;

        void ScenarioEndsCallback(const std_msgs::Header &msg);
        void ScenarioCountCallback(const std_msgs::Int32 msg);
        void ScenarioStableCallback(const std_msgs::Bool msg);
        void EsminiBeginCallback(const std_msgs::Bool msg);
        void EsminiRecordFilepathCallback(const std_msgs::String msg);
        void EndScenarioCallback(const std_msgs::Bool msg);

        void InitEsmini();
        void UpdateAgent();
        void UpdateEgo();
        void Prepare();
        void CheckEndCondition();

        std::vector<actor::Vehicle::Ptr>             mMovingVehicles;
        std::vector<motion::RouteMovingConfig>       mMotionConfigs;
        utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
        measure::FrenetDistanceEvaluator             mFrenetDistanceEvaluator;
        pcl::KdTreeFLANN<pcl::PointXYZ>              mGlobalPathKdtree;
        std::unordered_map<int, itri_msgs::Waypoint> mKdtreeWaypointMap;
        ros::Publisher                               mEgoSpeedCmdPublisher;
        ros::Publisher                               mEgoStuckPublisher;
        std::shared_ptr<itri_msgs::Waypoint>         mEgoNearestWaypoint = nullptr;

        ros::Subscriber mScenarioCountSubscriber;
        ros::Subscriber mEndScenarioSubscriber;
        ros::Publisher  mEndScenarioPublisher;
        ros::Publisher  mCollisionProfilePublisher;
        ros::Publisher  mStartEsminiPublisher;

        math::Vector3d_t mAgentInitialVelocity;
        ros::Subscriber  mScenarioStableSubscriber;
        bool             mScenarioStable;

        MovingAvgFilter mYawRateFilter;
        MovingAvgFilter mEgoPosXFilter;
        MovingAvgFilter mEgoPosYFilter;
        MovingAvgFilter mEgoYawFilter;
        MovingAvgFilter mEgoSpeedFilter;
        bool            mEgoStable;
        bool            mIsEsminiBegin;
        bool            mHeadless;
        bool            mIsScenarioEnd;
        ros::Subscriber mEsminiBeginSubscriber;
        std::string     mEsminiRecordFilepath;
        ros::Subscriber mEsminiRecordFilepathSubscriber;
        float           mLastSimulationTime;
        ros::Publisher  mCanStartObservationSamplingPublisher;
        ros::Publisher  mEsminiSimulationTimePublisher;

        std::vector<math::Vector3d_t> mRefWaypoint3ds;
        std::vector<math::Vector2d_t> mRefWaypoint2ds;
    };

}  // namespace unit

#endif  // #ifndef _UNIT_CONSTANT_VELOCITY_MODEL_H_
