#ifndef _RSS_VERIFIER_H_
#define _RSS_VERIFIER_H_

#include <mutex>
#include <map>
#include <ros/ros.h>
#include <ad/map/match/Object.hpp>
#include <ad/rss/core/RssCheck.hpp>
#include <ad/rss/map/RssSceneCreation.hpp>
#include <ad/rss/world/ObjectId.hpp>
#include <ad/rss/world/RssDynamics.hpp>
#include <ad/physics/Speed.hpp>
#include <ad/physics/AngularVelocity.hpp>
#include <ad/physics/Angle.hpp>
#include <ad/map/route/FullRoute.hpp>
#include <utils_object_id_manager.h>
#include <logger_txt_writer.h>
#include <scenario_msgs/LineStripMarkerArray.h>
#include <scenario_msgs/AgentDataArray.h>
#include <scenario/AgentStates.h>
#include <rss_msgs/EgoVehicleData.h>
#include <rss_msgs/ObjectData.h>
#include <rss_msgs/ObjectDataArray.h>
#include <rss_msgs/LandmarkArray.h>
#include <rss_type.h>
#include <rss_object_input_param.h>
#include <rss_check_result.h>
#include <rss_configuration.h>
#include <rss_inspector.h>
#include <rss_logger.h>
#include <rss_rss_object_data_convertor.h>
#include <rss_scene_mode_evaluator.h>
#include <rss_unstructured_safety_corrector.h>

namespace rss
{

    class Verifier
    {
        static constexpr int32_t DefaultQueueSize()
        {
            return int32_t{1};
        }

    public:
        Verifier();
        Verifier(const Verifier &)            = delete;
        Verifier &operator=(const Verifier &) = delete;
        virtual ~Verifier()                   = default;

        const rss_msgs::LandmarkArray &GetLandmarkArray() const;

        void Configure();
        void Run(const rss_msgs::EgoVehicleData &egoVehicleData,
                 const scenario::AgentStates    &agentStates,
                 CheckResult                    &outputCheckResult,
                 ad::rss::state::ProperResponse &outputProperResponse);
        void Run(const rss_msgs::EgoVehicleData          &egoVehicleData,
                 const std::vector<rss_msgs::ObjectData> &objectDatas,
                 CheckResult                             &outputCheckResult,
                 ad::rss::state::ProperResponse          &outputProperResponse);

    protected:
    private:
        using ObjectIdManager = utils::ObjectIdManager<std::string, ad::rss::world::ObjectId>;

        void InitializeMap(const std::string &openDriveFileName);
        void InitializedIntesections(const std::string &intersectionFileName);
        bool InitializeEgoVehicle(const ad::map::point::ENUPoint     &position,
                                  const ad::map::point::ENUHeading   &heading,
                                  const ad::physics::Dimension3D     &dimenstion,
                                  const ad::physics::Speed           &speed,
                                  const ad::physics::AngularVelocity &yawRate,
                                  const ad::physics::Angle           &steeringAngle,
                                  const ad::map::point::ENUPoint     &target);
        void InitializeObjectENU(const ad::map::point::ENUPoint   &position,
                                 const ad::map::point::ENUHeading &heading,
                                 const ad::physics::Dimension3D   &dimension,
                                 ad::map::match::Object           &outputObject);
        void GenerateLandmarkArrayMsg();

        ad::physics::Speed           mEgoSpeed;
        ad::physics::AngularVelocity mEgoYawRate;
        ad::physics::Angle           mEgoSteeringAngle;
        ad::map::match::Object       mEgoMatchObject;
        ad::map::route::FullRoute    mEgoRoute;
        ad::rss::core::RssCheck      mRssCheck;
        ad::rss::world::TimeIndex    mTimeIndex;
        RssObjectDataConvertor       mRssObjectDataConvertor;
        SceneModeEvaluator           mSceneModeEvaluator;
        Configuration                mConfiguration;
        Inspector                    mInspector;
        UnstructuredSafetyCorrector  mUnstructuredSafetyCorrector;
        Logger                       mLogger;
        rss_msgs::LandmarkArray      mLandmarkArray;
        bool                         mCanShowWarningMessage;
        bool                         mCanRunUnsafeLogging;
        bool                         mCanRunQuantitativeAnalysisLogging;

        logger::TxtWriter mLongitudinalDistanceLogger;
        logger::TxtWriter mLateralDistanceLogger;
        logger::TxtWriter mLongSafeDistanceLogger;
        logger::TxtWriter mRelativeLongSpeedLogger;
        logger::TxtWriter mRelativeLatSpeedLogger;
        logger::TxtWriter mSafetyStatusLogger;

        const ad::physics::Duration cResponseTimeEgoVehicle{1};
        const ad::physics::Duration cResponseTimeOtherVehicles{2};

        const ad::physics::Acceleration cMaximumLongitudinalAcceleration{3.5};
        const ad::physics::Acceleration cMinimumLongitudinalBrakingDeceleleration{-4};
        const ad::physics::Acceleration cMaximumLongitudinalBrakingDeceleleration{-8};
        const ad::physics::Acceleration cMinimumLongitudinalBrakingDecelelerationCorrect{-3};

        const ad::physics::Acceleration cMaximumLateralAcceleration{0.2};
        const ad::physics::Acceleration cMinimumLateralBrakingDeceleleration{-0.8};
    };

}  // namespace rss

#endif  // #ifndef _RSS_VERIFIER_H_
