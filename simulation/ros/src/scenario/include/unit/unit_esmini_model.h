#ifndef _UNIT_ESMINI_MODEL_H_
#define _UNIT_ESMINI_MODEL_H_

#include <actor_agent_speed_manager.h>
#include <actor_obstacle.h>
#include <actor_vehicle.h>
#include <ctrl_waypoint_follower.h>
#include <itri_msgs/Waypoint.h>
#include <math_frenet_transformer.h>
#include <math_moving_average_filter.h>
#include <measure_frenet_distance_evaluator.h>
#include <motion_esmini_config.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Float32.h>
#include <std_msgs/String.h>
#include <unit_model.h>
#include <limits>
#include <unordered_map>
#include <unordered_set>
#include "rss_msgs/ProperResponse.h"
#include <scenario/AgentState.h>
#include <scenario/AgentStates.h>

namespace unit
{

    class EsminiModel final : public Model
    {
        using YawRateFilter   = math::MovingAverageFilter<math::real_t>;
        using MovingAvgFilter = math::MovingAverageFilter<math::real_t>;

    public:
        typedef std::shared_ptr<EsminiModel> Ptr;

        EsminiModel();
        EsminiModel(const EsminiModel &)            = delete;
        EsminiModel &operator=(const EsminiModel &) = delete;
        virtual ~EsminiModel();

        virtual std::string GetId() const override;
        virtual void        Configure(const ModelConfig &config) override;
        virtual void        Update() override;
        virtual void        AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes) override;
        virtual void        RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

    protected:
    private:
        static constexpr const char *AgentIdPrefix()
        {
            return "esmini_";
        }

        virtual void ConfigureMotions() override;

        void ScenarioEndsCallback(const std_msgs::Header &msg);
        void ScenarioStableCallback(const std_msgs::Bool msg);
        void EsminiRecordFilepathCallback(const std_msgs::String msg);
        void ProperResponseCallback(const rss_msgs::ProperResponse msg);
        void IsReferenceModelTurnCallback(const std_msgs::Bool msg);

        void InitEsmini();
        void EndEsmini();
        void UpdateAgents();
        void UpdateEgo();
        void UpdateReferenceModelCarState();
        void Prepare();
        void CheckEndCondition();
        void fillInAgentState(SE_ScenarioObjectState esminiState, scenario::AgentState &outputAgentState);

        std::vector<actor::Pedestrian::Ptr>          mPedestrians;
        std::vector<actor::Vehicle::Ptr>             mMovingVehicles;
        motion::EsminiConfig                         mMotionConfig;
        utils::ObjectManager<ctrl::WaypointFollower> mWaypointFollowerManager;
        measure::FrenetDistanceEvaluator             mFrenetDistanceEvaluator;
        ros::Publisher                               mEgoSpeedCmdPublisher;

        ros::Publisher mEndScenarioPublisher;
        ros::Publisher mCollisionProfilePublisher;
        ros::Publisher mStartEsminiPublisher;
        ros::Publisher mEsminiEventPublisher;

        ros::Subscriber mScenarioStableSubscriber;
        bool            mScenarioStable;

        ros::Subscriber mTtcSubscriber;
        float           mTtc = 10000;
        void            TtcCallback(const std_msgs::Float32 msg);

        ros::Subscriber mProperResponseSubscriber;

        ros::Subscriber mIsReferenceModelTurnSubscriber;
        bool            mIsReferenceModelTurn;

        const int mYawRateFilterWindowSize      = 10;
        const int mAccelerationFilterWindowSize = 10;

        std::unordered_map<std::string, MovingAvgFilter> mYawRateFilters;
        std::unordered_map<std::string, MovingAvgFilter> mAccelerationFilters;

        MovingAvgFilter mEgoPosXFilter;
        MovingAvgFilter mEgoPosYFilter;
        MovingAvgFilter mEgoYawFilter;
        MovingAvgFilter mEgoSpeedFilter;
        bool            mIsEsminiBegin;
        bool            mHeadless;
        bool            mIsScenarioEnd;
        std::string     mEsminiRecordFilepath;
        ros::Subscriber mEsminiRecordFilepathSubscriber;
        ros::Publisher  mCanStartObservationSamplingPublisher;
        ros::Publisher  mEsminiSimulationTimePublisher;
        ros::Publisher  mEsminiEgoStuckPublisher;

        ros::Publisher mAgentStatesPublisher;

        bool mSimWithExternalEgo;

        bool            mEgoInitialSpeedRequired;
        double          mEgoExternalSpeedKph;
        double          mEgoInitialSpeedKph;
        bool            mEgoInitialSpeedStable;
        MovingAvgFilter mEgoSpeedStableFilter;

        ros::Publisher mCarStatePublisher;

        bool mPublishedCanStartObservationSampling = false;

        std::unordered_map<std::string, scenario::AgentState> mAgentStates;
        std::unordered_map<std::string, scenario::AgentState> mLastAgentStates;
    };

}  // namespace unit

#endif  // #ifndef _UNIT_CONSTANT_VELOCITY_MODEL_H_
