#include <rss_verifier.h>
#include <fstream>
#include <streambuf>
#include <limits>
#include <stdexcept>
#include <ros/console.h>
#include <ad/map/access/Operation.hpp>
#include <ad/map/intersection/IntersectionType.hpp>
#include <ad/map/landmark/LandmarkOperation.hpp>
#include <ad/map/lane/LaneOperation.hpp>
#include <ad/map/match/AdMapMatching.hpp>
#include <ad/map/point/HeadingOperation.hpp>
#include <ad/map/route/Planning.hpp>
#include <ad/rss/world/WorldModelValidInputRange.hpp>
#include <ad/rss/state/ProperResponse.hpp>
#include <ad/rss/situation/SituationSnapshot.hpp>
#include <ad/rss/state/RssStateSnapshot.hpp>
#include "ad/rss/state/AccelerationRestriction.hpp"
#include "rss_object_input_param.h"
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_ros_param.h>
#include <rss_converter.h>
#include <rss_generator.h>
#include <rss_logger.h>
#include <rss_motion.h>
#include <rss_utils.h>

namespace rss
{

    // public func.

    Verifier::Verifier()
        : mEgoSpeed{0.0},
          mEgoYawRate{0.0},
          mEgoSteeringAngle{0.0},
          mEgoMatchObject{},
          mEgoRoute{},
          mRssCheck{},
          mTimeIndex{0u},
          mRssObjectDataConvertor{},
          mSceneModeEvaluator{},
          mConfiguration{},
          mInspector{},
          mUnstructuredSafetyCorrector{},
          mLogger{},
          mLandmarkArray{},
          mCanShowWarningMessage{false},
          mCanRunUnsafeLogging{false},
          mCanRunQuantitativeAnalysisLogging{false}
    {
        mInspector.Configure(mConfiguration.GetEgoVehicleRssDynamics(), mConfiguration.GetOtherVehicleRssDynamics());

        ros::param::get("rss/can_show_verifier_warning_message", mCanShowWarningMessage);
        ros::param::get("rss/can_run_unsafe_logging", mCanRunUnsafeLogging);
        ros::param::get("rss/can_run_quantitative_analysis_logging", mCanRunQuantitativeAnalysisLogging);
        if (mCanRunUnsafeLogging)
        {
            static constexpr const char *unsafeLoggingFileKey{"rss/unsafe_logging_file"};
            std::string                  unsafeLoggingFile;
            if (!ros::param::get(unsafeLoggingFileKey, unsafeLoggingFile))
            {
                ROS_ERROR_STREAM("invalid key: " << unsafeLoggingFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }
            mLogger.Configure(unsafeLoggingFile);
        }

        if (mCanRunQuantitativeAnalysisLogging)
        {
            static constexpr const char *longitudinalDistanceFileKey{"rss/longitudinal_distance_file"};
            std::string                  longitudinalDistanceFile;
            if (!ros::param::get(longitudinalDistanceFileKey, longitudinalDistanceFile))
            {
                ROS_ERROR_STREAM("invalid key: " << longitudinalDistanceFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            static constexpr const char *lateralDistanceFileKey{"rss/lateral_distance_file"};
            std::string                  lateralDistanceFile;
            if (!ros::param::get(lateralDistanceFileKey, lateralDistanceFile))
            {
                ROS_ERROR_STREAM("invalid key: " << lateralDistanceFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            static constexpr const char *longSafeDistanceFileKey{"rss/long_safe_distance_file"};
            std::string                  longSafeDistanceFile;
            if (!ros::param::get(longSafeDistanceFileKey, longSafeDistanceFile))
            {
                ROS_ERROR_STREAM("invalid key: " << longSafeDistanceFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            static constexpr const char *relativeLongSpeedFileKey{"rss/relative_long_speed_file"};
            std::string                  relativeLongSpeedFile;
            if (!ros::param::get(relativeLongSpeedFileKey, relativeLongSpeedFile))
            {
                ROS_ERROR_STREAM("invalid key: " << relativeLongSpeedFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            static constexpr const char *relativeLatSpeedFileKey{"rss/relative_lat_speed_file"};
            std::string                  relativeLatSpeedFile;
            if (!ros::param::get(relativeLatSpeedFileKey, relativeLatSpeedFile))
            {
                ROS_ERROR_STREAM("invalid key: " << relativeLatSpeedFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            static constexpr const char *safetyStatusFileKey{"rss/safety_status_file"};
            std::string                  safetyStatusFile;
            if (!ros::param::get(safetyStatusFileKey, safetyStatusFile))
            {
                ROS_ERROR_STREAM("invalid key: " << safetyStatusFileKey);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            mLongitudinalDistanceLogger.Configure(longitudinalDistanceFile);
            mLateralDistanceLogger.Configure(lateralDistanceFile);
            mLongSafeDistanceLogger.Configure(longSafeDistanceFile);
            mRelativeLongSpeedLogger.Configure(relativeLongSpeedFile);
            mRelativeLatSpeedLogger.Configure(relativeLatSpeedFile);
            mSafetyStatusLogger.Configure(safetyStatusFile);
        }
    }

    const rss_msgs::LandmarkArray &Verifier::GetLandmarkArray() const
    {
        return mLandmarkArray;
    }

    void Verifier::Configure()
    {
        const std::string mapId{utils::GetRosParam<std::string>("route_mission_handler/route")};

        const std::string mapFile{mConfiguration.QueryOpenDriveMapFile(mapId)};
        if (mapFile.empty())
        {
            ROS_ERROR_STREAM("mapFile is empty");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        const std::string mapFileDir{utils::GetRosParam<std::string>("rss/map_file_dir") + "/"};

        ROS_INFO_STREAM("RSS Map File: " << mapFileDir + mapFile);

        this->InitializeMap(mapFileDir + mapFile);
        this->GenerateLandmarkArrayMsg();
    }

    void Verifier::Run(const rss_msgs::EgoVehicleData &egoVehicleData,
                       const scenario::AgentStates    &agentStates,
                       CheckResult                    &outputCheckResult,
                       ad::rss::state::ProperResponse &outputProperResponse)
    {
        ++mTimeIndex;
        ad::rss::map::RssSceneCreation sceneCreation(mTimeIndex, mConfiguration.GetEgoVehicleRssDynamics());

        const math::Vector3d_t egoLinearVelocity{utils::ConvertToVector3d(egoVehicleData.twist.linear)};
        const bool             isValid = this->InitializeEgoVehicle(rss::ToENUPoint(egoVehicleData.pose.position),
                                                        ad::map::point::createENUHeading(rss::ComputeHeadingRadian(egoLinearVelocity)),
                                                        // rss::ToDimension3d(egoVehicleData.size),
                                                        rss::ToDimension3d(math::Vector3d_t(5.17, 2.2, 1.17)),
                                                        ad::physics::Speed(egoVehicleData.speed),
                                                        ad::physics::AngularVelocity(egoVehicleData.yaw_rate),
                                                        ad::physics::Angle(egoVehicleData.steering_angle),
                                                        rss::ToENUPoint(egoVehicleData.target));
        if (!isValid)
        {
            ROS_WARN_STREAM("invalid ego-vehicle initialization");
            return;
        }

        const auto                       landmarkIds{ad::map::landmark::getLandmarks()};
        ad::map::landmark::LandmarkIdSet trafficSignalIdSet(landmarkIds.cbegin(), landmarkIds.cend());

        std::map<ad::rss::world::ObjectId, scenario::AgentState> objectInputParamMap;
        std::map<std::string, ad::rss::world::Object>            rssWorldObjectMap;

        unsigned long agentIndex = 0;
        for (const auto &objectData : agentStates.agents)
        {
            if (std::string(objectData.name) == "Ego")
            {
                continue;
            }
            // ROS_DEBUG_STREAM_COND(true,
            //                       "objectData" << '\n'
            //                                    << "yaw rate: " << objectData.yaw_rate << ", steering_angle: " << objectData.steering_angle);
            ad::map::match::Object otherMatchObject;
            otherMatchObject.enuPosition.centerPoint = rss::ToENUPoint(math::Vector3d_t(objectData.x, objectData.y, 0));
            otherMatchObject.enuPosition.heading     = ad::map::point::createENUHeading(objectData.h);
            otherMatchObject.enuPosition.dimension   = rss::ToDimension3d(math::Vector3d_t(objectData.length, objectData.width, 1.0));
            // ROS_DEBUG_STREAM_COND(true, "objectData" << '\n' << "size: " << otherMatchObject.enuPosition.dimension);

            this->InitializeObjectENU(otherMatchObject.enuPosition.centerPoint,
                                      otherMatchObject.enuPosition.heading,
                                      otherMatchObject.enuPosition.dimension,
                                      otherMatchObject);

            mEgoSpeed         = egoVehicleData.speed;
            mEgoYawRate       = egoVehicleData.yaw_rate;
            mEgoSteeringAngle = egoVehicleData.steering_angle;
            ad::rss::map::RssObjectData egoRssObjectData;
            mRssObjectDataConvertor
                .ToEgoVehicleObjectData(egoVehicleData, mEgoMatchObject, mEgoSpeed, mEgoYawRate, mEgoSteeringAngle, egoRssObjectData);

            // std::cout << std::endl;
            // std::cout << std::string(objectData.name) << std::endl;
            // std::cout << "egoPosition: " << egoRssObjectData.matchObject.enuPosition.centerPoint.x << ", "
            //           << egoRssObjectData.matchObject.enuPosition.centerPoint.y << std::endl;
            // std::cout << "egoHeading: " << egoRssObjectData.matchObject.enuPosition.heading << std::endl;

            const ad::physics::Speed           otherRssObjectSpeed = ad::physics::Speed(objectData.speed);
            const ad::physics::AngularVelocity otherRssObjectYawRate(objectData.yawRate);
            const ad::physics::Angle           otherRssObjectSteeringAngle(0);
            ad::rss::map::RssObjectData        otherRssObjectData;
            mRssObjectDataConvertor.ToOtherObjectData(objectData,
                                                      otherMatchObject,
                                                      otherRssObjectSpeed,
                                                      otherRssObjectYawRate,
                                                      otherRssObjectSteeringAngle,
                                                      otherRssObjectData);

            // std::cout << "otherPosition: " << otherRssObjectData.matchObject.enuPosition.centerPoint.x << ", "
            //           << otherRssObjectData.matchObject.enuPosition.centerPoint.y << std::endl;
            // std::cout << "otherHeading: " << otherRssObjectData.matchObject.enuPosition.heading << std::endl;

            if (otherRssObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.empty())
            {
                ROS_ERROR_STREAM(
                    "object occupied region is empty, size: " << otherRssObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.size());
                if (mCanShowWarningMessage)
                {
                    ROS_WARN_STREAM(
                        "object occupied region is empty, size: " << otherRssObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.size());
                }
                continue;
                // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            }

            try
            {
                const auto rssMode{mSceneModeEvaluator.Execute(egoRssObjectData, otherRssObjectData)};
                const bool canAppendScenes = sceneCreation.appendScenes(egoRssObjectData,
                                                                        mEgoRoute,
                                                                        otherRssObjectData,
                                                                        ad::rss::map::RssSceneCreation::RestrictSpeedLimitMode::IncreasedSpeedLimit10,
                                                                        trafficSignalIdSet,
                                                                        rssMode);
                if (!canAppendScenes)
                {
                    ROS_ERROR_STREAM("fail in appending scenes");
                    throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
                }
            }
            catch (std::out_of_range error)
            {
                // ROS_ERROR_STREAM("out_of_range_error: " << error.what());
                ROS_ERROR_STREAM("out_of_range_error");
                continue;
            }
            catch (std::invalid_argument error)
            {
                ROS_ERROR_STREAM("invalid_argument: " << error.what());
                continue;
            }

            // ad::rss::world::ObjectId otherRssObjectId{agentIndex};
            // if (!mRssObjectDataConvertor.QueryRssObjectId(agentIndex, otherRssObjectId))
            // {
            //     ROS_ERROR_STREAM("invalid detected_object_id: " << agentIndex);
            //     throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            // }

            if (!objectInputParamMap.emplace(otherRssObjectData.id, objectData).second)
            {
                ROS_ERROR_STREAM("invalid otherRssObjectId: " << otherRssObjectData.id);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            agentIndex += 1;
        }

        const auto worldModel{sceneCreation.getWorldModel()};
        withinValidInputRange(worldModel, true);

        // TODO: check worldModel.scenes here

        int i = 0;
        for (const auto &scene : worldModel.scenes)
        {
            outputCheckResult.egoVehicleState.speedLon = scene.egoVehicle.velocity.speedLonMax;
            outputCheckResult.egoVehicleState.speedLat = scene.egoVehicle.velocity.speedLatMax;

            auto &agentState    = objectInputParamMap[scene.object.objectId];
            agentState.speedLon = scene.object.velocity.speedLonMax;
            agentState.speedLat = scene.object.velocity.speedLatMax;
            // outputCheckResult.objectStates[i].speedLon = scene.egoVehicle.velocity.speedLonMax;
            // outputCheckResult.objectStates[i].speedLon = scene.egoVehicle.velocity.speedLonMax;
            // outputCheckResult.objectStates[i]. = scene.egoVehicle.velocity.speedLonMax;

            i++;

            // std::cout << "situation type: " << scene.situationType << std::endl;
            // std::cout << "ego center point" << std::endl;
            // std::cout << scene.egoVehicle.state.centerPoint << std::endl;
            // std::cout << "ego yaw" << std::endl;
            // std::cout << scene.egoVehicle.state.yaw << std::endl;
            // std::cout << "egoVehicle speedLonMax" << std::endl;
            // std::cout << scene.egoVehicle.velocity.speedLonMax << std::endl;
            // std::cout << "object speedLonMax" << std::endl;
            // std::cout << scene.object.velocity.speedLonMax << std::endl;
            // std::cout << "object speedLonMin" << std::endl;
            // std::cout << scene.object.velocity.speedLonMin << std::endl;
            // std::cout << "object speedLatMax" << std::endl;
            // std::cout << scene.object.velocity.speedLatMax << std::endl;
            // std::cout << "object speedLatMin" << std::endl;
            // std::cout << scene.object.velocity.speedLatMin << std::endl;
            // std::cout << "egoVehicle speedLonMin" << std::endl;
            // std::cout << scene.egoVehicle.velocity.speedLonMin << std::endl;
            // std::cout << "egoVehicle speedLatMax" << std::endl;
            // std::cout << scene.egoVehicle.velocity.speedLatMax << std::endl;
            // std::cout << "egoVehicle speedLatMin" << std::endl;
            // std::cout << scene.egoVehicle.velocity.speedLatMin << std::endl;
            // std::cout << "egoVehicle center point" << std::endl;
            // std::cout << scene.object.state.centerPoint << std::endl;
            // std::cout << "object yaw" << std::endl;
            // std::cout << scene.object.state.yaw << std::endl;
            // std::cout << "object speedLonMax" << std::endl;
            // std::cout << scene.object.velocity.speedLonMax << std::endl;
            // std::cout << "object speedLonMin" << std::endl;
            // std::cout << scene.object.velocity.speedLonMin << std::endl;
            // std::cout << "object speedLatMax" << std::endl;
            // std::cout << scene.object.velocity.speedLatMax << std::endl;
            // std::cout << "object speedLatMin" << std::endl;
            // std::cout << scene.object.velocity.speedLatMin << std::endl;
        }
        // outputCheckResult.egoVehicleState.speedLon = rssWorldObjectMap.at("Ego").velocity.speedLonMax;
        // outputCheckResult.egoVehicleState.speedLat = rssWorldObjectMap.at("Ego").velocity.speedLatMax;
        // std::cout << (rssWorldObjectMap["Ego"]) << std::endl;
        // std::cout << (rssWorldObjectMap["Opposite"]) << std::endl;

        ad::rss::situation::SituationSnapshot situationSnapshot;
        ad::rss::state::RssStateSnapshot      stateSnapshot;
        const bool canCalculateProperResponse = mRssCheck.calculateProperResponse(worldModel, situationSnapshot, stateSnapshot, outputProperResponse);
        if (!canCalculateProperResponse)
        {
            ROS_ERROR_STREAM("can not calculate proper response, return...");
            // throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            return;
        }

        // TODO: check situationSnapshot.situations here

        // mInspector.Check(
        //     situationSnapshot,
        //     stateSnapshot);

        const EgoVehicleInputParam egoVehicleInputParam{rss::ToEgoVehicleInputParam(egoVehicleData)};
        rss::EvaluateCheckResultForAS(situationSnapshot,
                                      stateSnapshot,
                                      egoVehicleInputParam,
                                      objectInputParamMap,
                                      rssWorldObjectMap,
                                      outputCheckResult);

        // auto outputObjectState{outputCheckResult.objectStates.begin()};
        // for (auto state = outputCheckResult.objectStates.begin(); state != outputCheckResult.objectStates.end(); state++)
        // {
        //     outputObjectState->speedLon = rssWorldObjectMap.at(outputObjectState->name).velocity.speedLonMax;
        //     outputObjectState->speedLat = rssWorldObjectMap.at(outputObjectState->name).velocity.speedLatMax;
        // }

        if (mUnstructuredSafetyCorrector.Execute(outputCheckResult))
        {
            // ROS_DEBUG_STREAM_COND(true, "correct unstructured safety");
        }

        // if (mCanRunUnsafeLogging)
        // {
        //     mLogger.Record(mTimeIndex, outputCheckResult, egoVehicleInputParam, objectInputParamMap);
        // }

        if (mCanRunQuantitativeAnalysisLogging && !outputCheckResult.objectStates.empty())
        {
            ROS_DEBUG_STREAM_COND(true, std::string(50, '='));
            ROS_DEBUG_STREAM_COND(true, "lateral response left: " << outputProperResponse.lateralResponseLeft);
            ROS_DEBUG_STREAM_COND(true, "lateral response right: " << outputProperResponse.lateralResponseRight);
            ROS_DEBUG_STREAM_COND(true, "longitudinalResponse: " << outputProperResponse.longitudinalResponse);
            ROS_DEBUG_STREAM_COND(true, "unstructuredSceneResponse: " << outputProperResponse.unstructuredSceneResponse);

            int i = 0;
            for (const auto &objectState : outputCheckResult.objectStates)
            {
                // if (i > 2)
                // {
                //     break;
                // }
                i++;
                const auto               objectInputParam{objectInputParamMap.begin()->second};
                const geometry::Vector3d objectPosition{objectState.transform.GetPosition()};
                const geometry::Vector3d egoPosition{egoVehicleInputParam.transform.GetPosition()};
                const geometry::Vector3d localPosVector = egoVehicleInputParam.transform.inverse() * objectPosition;

                const double longitudinalSafeDistance    = objectState.rssState.longitudinalState.rssStateInformation.safeDistance;
                const double currentLongitudinalDistance = objectState.rssState.longitudinalState.rssStateInformation.currentDistance;
                const double rightSafeDistance           = objectState.rssState.lateralStateRight.rssStateInformation.safeDistance;
                const double rightDistance               = objectState.rssState.lateralStateRight.rssStateInformation.currentDistance;
                const double leftSafeDistance            = objectState.rssState.lateralStateLeft.rssStateInformation.safeDistance;
                const double leftDistance                = objectState.rssState.lateralStateLeft.rssStateInformation.currentDistance;

                const geometry::Vector3d egoWorldLinearVelocity{egoVehicleInputParam.linearVelocity};
                // const geometry::Vector3d objectWorldLinearVelocity{objectInputParam.linearVelocity};
                // const geometry::Vector3d worldLinearVelDiff{objectWorldLinearVelocity - egoWorldLinearVelocity};
                // const geometry::Vector3d localLinearVelDiff = egoVehicleInputParam.transform.GetQuaternion().inverse() * worldLinearVelDiff;

                const double computedLongitudinalDistance = localPosVector.x() - 2.1 - 2.586;
                const double computedLateralDistance = std::fabs(localPosVector.y()) < ((2.297 + 1.8) * 0.5) ? 0.0 : std::fabs(localPosVector.y());

                ROS_DEBUG_STREAM_COND(true, std::string(50, '-'));
                // ROS_DEBUG_STREAM_COND(true, objectState.objectClassId);
                ROS_DEBUG_STREAM_COND(true, objectState.detectedObjectId);
                ROS_DEBUG_STREAM_COND(true, "currentLongitudinalDistance: " << currentLongitudinalDistance << "\n");
                ROS_DEBUG_STREAM_COND(true, "safeLongitudinalDistance: " << longitudinalSafeDistance << "\n");
                ROS_DEBUG_STREAM_COND(true, "currentrightDistance: " << rightDistance << "\n");
                ROS_DEBUG_STREAM_COND(true, "rightSafeDistance: " << rightSafeDistance << "\n");
                ROS_DEBUG_STREAM_COND(true, "currentleftDistance: " << leftDistance << "\n");
                ROS_DEBUG_STREAM_COND(true, "leftSafeDistance: " << leftSafeDistance << "\n");
                // ROS_DEBUG_STREAM_COND(true,
                //                       "\n\n"
                //                           << "\n"
                //                           << "currentLongitudinalDistance: " << currentLongitudinalDistance
                //                           << ", longitudinalSafeDistance: " << longitudinalSafeDistance << '\n'
                //                           << "computedLateralDistance: " << computedLateralDistance << '\n'
                //                           << "leftSafeDistance: " << leftSafeDistance << '\n'
                //                           << "leftDistance: " << leftDistance << "\n\n"
                //                           << "rightSafeDistance: " << rightSafeDistance << '\n'
                //                           << "rightDistance: " << rightDistance << "\n\n"
                //                           << "long speed diff: " << localLinearVelDiff.x() << ", lat speed diff: " << localLinearVelDiff.y()
                //                           << "\n\n");
                // ROS_DEBUG_STREAM_COND(true, "rssstate longitudinalstate response" << objectState.rssState.longitudinalState.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate lateralStateLeft response" << objectState.rssState.lateralStateLeft.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate lateralStateRight response" << objectState.rssState.lateralStateRight.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate unstructuredScene response" << objectState.rssState.unstructuredSceneState.response);
                // ROS_DEBUG_STREAM_COND(true, "objectworldlinearvelocity: " << objectWorldLinearVelocity);

                std::string safetyStatus;
                if (ad::rss::situation::SituationType::Unstructured == objectState.rssSituation.situationType)
                {
                    std::stringstream safetyStream;
                    safetyStream << objectState.unstructuredSafety.status;
                    safetyStatus = "unstructured, " + safetyStream.str();
                }
                else
                {
                    std::stringstream safetyStream;
                    safetyStream << objectState.structuredSafety.status;
                    safetyStatus = "structured, " + safetyStream.str();
                }
                if (currentLongitudinalDistance < 100.0)
                {
                    mLongitudinalDistanceLogger.Append(currentLongitudinalDistance);
                }
                else
                {
                    mLongitudinalDistanceLogger.Append(computedLongitudinalDistance);
                }
                mLateralDistanceLogger.Append(computedLateralDistance);
                mLongSafeDistanceLogger.Append(longitudinalSafeDistance);
                // mRelativeLongSpeedLogger.Append(localLinearVelDiff.x());
                // mRelativeLatSpeedLogger.Append(localLinearVelDiff.y());
                mSafetyStatusLogger.Append(safetyStatus);

                ROS_DEBUG_STREAM_COND(true, "safetyStatus: " << safetyStatus << "\n\n");
                ROS_DEBUG_STREAM_COND(true, std::string(50, '-'));
            }
            ROS_DEBUG_STREAM_COND(true, std::string(50, '='));
        }
    }

    void Verifier::Run(const rss_msgs::EgoVehicleData          &egoVehicleData,
                       const std::vector<rss_msgs::ObjectData> &objectDatas,
                       CheckResult                             &outputCheckResult,
                       ad::rss::state::ProperResponse          &outputProperResponse)
    {
        ++mTimeIndex;
        ad::rss::map::RssSceneCreation sceneCreation(mTimeIndex, mConfiguration.GetEgoVehicleRssDynamics());

        const math::Vector3d_t egoLinearVelocity{utils::ConvertToVector3d(egoVehicleData.twist.linear)};
        const bool             isValid = this->InitializeEgoVehicle(rss::ToENUPoint(egoVehicleData.pose.position),
                                                        ad::map::point::createENUHeading(rss::ComputeHeadingRadian(egoLinearVelocity)),
                                                        rss::ToDimension3d(egoVehicleData.size),
                                                        ad::physics::Speed(egoVehicleData.speed),
                                                        ad::physics::AngularVelocity(egoVehicleData.yaw_rate),
                                                        ad::physics::Angle(egoVehicleData.steering_angle),
                                                        rss::ToENUPoint(egoVehicleData.target));
        if (!isValid)
        {
            ROS_WARN_STREAM("invalid ego-vehicle initialization");
            return;
        }

        const auto                       landmarkIds{ad::map::landmark::getLandmarks()};
        ad::map::landmark::LandmarkIdSet trafficSignalIdSet(landmarkIds.cbegin(), landmarkIds.cend());
        // for (auto landmarkId{landmarkIds.cbegin()};
        //      landmarkId != landmarkIds.cend();
        //      ++landmarkId)
        //{
        //     ROS_DEBUG_STREAM("landmark id: " << *landmarkId);
        // }

        // ROS_DEBUG_STREAM_COND(true,
        //                       "egoVehicle data" << '\n'
        //                                         << "yaw_rate: " << egoVehicleData.yaw_rate << ", steering_angle: " <<
        //                                         egoVehicleData.steering_angle);

        ObjectInputParamMap objectInputParamMap;
        for (const auto &objectData : objectDatas)
        {
            ad::map::match::Object otherMatchObject;
            otherMatchObject.enuPosition.centerPoint   = rss::ToENUPoint(objectData.pose.position);
            const math::Vector3d_t agentLinearVelocity = utils::ConvertToVector3d(objectData.twist.linear);
            otherMatchObject.enuPosition.heading       = ad::map::point::createENUHeading(rss::ComputeHeadingRadian(agentLinearVelocity));
            otherMatchObject.enuPosition.dimension     = rss::ToDimension3d(objectData.size);
            this->InitializeObjectENU(otherMatchObject.enuPosition.centerPoint,
                                      otherMatchObject.enuPosition.heading,
                                      otherMatchObject.enuPosition.dimension,
                                      otherMatchObject);

            mEgoSpeed         = egoVehicleData.speed;
            mEgoYawRate       = egoVehicleData.yaw_rate;
            mEgoSteeringAngle = egoVehicleData.steering_angle;
            ad::rss::map::RssObjectData egoRssObjectData;
            mRssObjectDataConvertor
                .ToEgoVehicleObjectData(egoVehicleData, mEgoMatchObject, mEgoSpeed, mEgoYawRate, mEgoSteeringAngle, egoRssObjectData);

            const ad::physics::Speed           otherRssObjectSpeed = ad::physics::Speed(objectData.speed);
            const ad::physics::AngularVelocity otherRssObjectYawRate(objectData.yaw_rate);
            const ad::physics::Angle           otherRssObjectSteeringAngle(objectData.steering_angle);
            ad::rss::map::RssObjectData        otherRssObjectData;
            mRssObjectDataConvertor.ToOtherObjectData(objectData,
                                                      otherMatchObject,
                                                      otherRssObjectSpeed,
                                                      otherRssObjectYawRate,
                                                      otherRssObjectSteeringAngle,
                                                      otherRssObjectData);

            // ROS_ERROR_STREAM("RSS Object Type" << otherRssObjectData.type);

            if (otherRssObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.empty())
            {
                if (mCanShowWarningMessage)
                {
                    ROS_WARN_STREAM(
                        "object occupied region is empty, size: " << otherRssObjectData.matchObject.mapMatchedBoundingBox.laneOccupiedRegions.size());
                }
                continue;
                // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
            }

            try
            {
                const auto rssMode{mSceneModeEvaluator.Execute(egoRssObjectData, otherRssObjectData)};
                const bool canAppendScenes = sceneCreation.appendScenes(egoRssObjectData,
                                                                        mEgoRoute,
                                                                        otherRssObjectData,
                                                                        ad::rss::map::RssSceneCreation::RestrictSpeedLimitMode::IncreasedSpeedLimit10,
                                                                        trafficSignalIdSet,
                                                                        rssMode);
                if (!canAppendScenes)
                {
                    ROS_ERROR_STREAM("fail in appending scenes");
                    throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
                }
            }
            catch (std::out_of_range error)
            {
                ROS_ERROR_STREAM("out_of_range_error: " << error.what());
                continue;
            }
            catch (std::invalid_argument error)
            {
                ROS_ERROR_STREAM("invalid_argument: " << error.what());
                continue;
            }

            ad::rss::world::ObjectId otherRssObjectId{std::numeric_limits<uint64_t>::max()};
            if (!mRssObjectDataConvertor.QueryRssObjectId(objectData.detected_object_id, otherRssObjectId))
            {
                ROS_ERROR_STREAM("invalid detected_object_id: " << objectData.detected_object_id);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            if (!objectInputParamMap.emplace(otherRssObjectId, rss::ToObjectInputParam(objectData)).second)
            {
                ROS_ERROR_STREAM("invalid otherRssObjectId: " << otherRssObjectId);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }
        }

        const auto worldModel{sceneCreation.getWorldModel()};
        withinValidInputRange(worldModel, true);

        // TODO: check worldModel.scenes here

        ad::rss::situation::SituationSnapshot situationSnapshot;
        ad::rss::state::RssStateSnapshot      stateSnapshot;
        const bool canCalculateProperResponse = mRssCheck.calculateProperResponse(worldModel, situationSnapshot, stateSnapshot, outputProperResponse);
        if (!canCalculateProperResponse)
        {
            ROS_ERROR_STREAM("can not calculate proper response, return...");
            // throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            return;
        }

        // TODO: check situationSnapshot.situations here

        // mInspector.Check(
        //     situationSnapshot,
        //     stateSnapshot);

        const EgoVehicleInputParam egoVehicleInputParam{rss::ToEgoVehicleInputParam(egoVehicleData)};
        rss::EvaluateCheckResult(situationSnapshot, stateSnapshot, egoVehicleInputParam, objectInputParamMap, outputCheckResult);

        if (mUnstructuredSafetyCorrector.Execute(outputCheckResult))
        {
            // ROS_DEBUG_STREAM_COND(true, "correct unstructured safety");
        }

        if (mCanRunUnsafeLogging)
        {
            mLogger.Record(mTimeIndex, outputCheckResult, egoVehicleInputParam, objectInputParamMap);
        }

        if (mCanRunQuantitativeAnalysisLogging && !outputCheckResult.objectStates.empty())
        {
            ROS_DEBUG_STREAM_COND(true, std::string(50, '='));
            ROS_DEBUG_STREAM_COND(true, "lateral response left: " << outputProperResponse.lateralResponseLeft);
            ROS_DEBUG_STREAM_COND(true, "lateral response right: " << outputProperResponse.lateralResponseRight);
            ROS_DEBUG_STREAM_COND(true, "longitudinalResponse: " << outputProperResponse.longitudinalResponse);
            ROS_DEBUG_STREAM_COND(true, "unstructuredSceneResponse: " << outputProperResponse.unstructuredSceneResponse);

            int i = 0;
            for (const auto &objectState : outputCheckResult.objectStates)
            {
                // if (i > 2)
                // {
                //     break;
                // }
                i++;
                const auto               objectInputParam{objectInputParamMap.begin()->second};
                const geometry::Vector3d objectPosition{objectState.transform.GetPosition()};
                const geometry::Vector3d egoPosition{egoVehicleInputParam.transform.GetPosition()};
                const geometry::Vector3d localPosVector = egoVehicleInputParam.transform.inverse() * objectPosition;

                const double longitudinalSafeDistance    = objectState.rssState.longitudinalState.rssStateInformation.safeDistance;
                const double currentLongitudinalDistance = objectState.rssState.longitudinalState.rssStateInformation.currentDistance;
                const double rightSafeDistance           = objectState.rssState.lateralStateRight.rssStateInformation.safeDistance;
                const double rightDistance               = objectState.rssState.lateralStateRight.rssStateInformation.currentDistance;
                const double leftSafeDistance            = objectState.rssState.lateralStateLeft.rssStateInformation.safeDistance;
                const double leftDistance                = objectState.rssState.lateralStateLeft.rssStateInformation.currentDistance;

                const geometry::Vector3d egoWorldLinearVelocity{egoVehicleInputParam.linearVelocity};
                const geometry::Vector3d objectWorldLinearVelocity{objectInputParam.linearVelocity};
                const geometry::Vector3d worldLinearVelDiff{objectWorldLinearVelocity - egoWorldLinearVelocity};
                const geometry::Vector3d localLinearVelDiff = egoVehicleInputParam.transform.GetQuaternion().inverse() * worldLinearVelDiff;

                const double computedLongitudinalDistance = localPosVector.x() - 2.1 - 2.586;
                const double computedLateralDistance = std::fabs(localPosVector.y()) < ((2.297 + 1.8) * 0.5) ? 0.0 : std::fabs(localPosVector.y());

                ROS_DEBUG_STREAM_COND(true, std::string(50, '-'));
                // ROS_DEBUG_STREAM_COND(true, objectState.objectClassId);
                ROS_DEBUG_STREAM_COND(true, objectState.detectedObjectId);
                ROS_DEBUG_STREAM_COND(
                    true,
                    "long speed diff: " << localLinearVelDiff.x() << "\ncurrentLongitudinalDistance: " << currentLongitudinalDistance << "\n");
                // ROS_DEBUG_STREAM_COND(true,
                //                       "\n\n"
                //                           << "\n"
                //                           << "currentLongitudinalDistance: " << currentLongitudinalDistance
                //                           << ", longitudinalSafeDistance: " << longitudinalSafeDistance << '\n'
                //                           << "computedLateralDistance: " << computedLateralDistance << '\n'
                //                           << "leftSafeDistance: " << leftSafeDistance << '\n'
                //                           << "leftDistance: " << leftDistance << "\n\n"
                //                           << "rightSafeDistance: " << rightSafeDistance << '\n'
                //                           << "rightDistance: " << rightDistance << "\n\n"
                //                           << "long speed diff: " << localLinearVelDiff.x() << ", lat speed diff: " << localLinearVelDiff.y()
                //                           << "\n\n");
                // ROS_DEBUG_STREAM_COND(true, "rssstate longitudinalstate response" << objectState.rssState.longitudinalState.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate lateralStateLeft response" << objectState.rssState.lateralStateLeft.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate lateralStateRight response" << objectState.rssState.lateralStateRight.response);
                // ROS_DEBUG_STREAM_COND(true, "rssstate unstructuredScene response" << objectState.rssState.unstructuredSceneState.response);
                // ROS_DEBUG_STREAM_COND(true, "objectworldlinearvelocity: " << objectWorldLinearVelocity);

                std::string safetyStatus;
                if (ad::rss::situation::SituationType::Unstructured == objectState.rssSituation.situationType)
                {
                    std::stringstream safetyStream;
                    safetyStream << objectState.unstructuredSafety.status;
                    safetyStatus = "unstructured, " + safetyStream.str();
                }
                else
                {
                    std::stringstream safetyStream;
                    safetyStream << objectState.structuredSafety.status;
                    safetyStatus = "structured, " + safetyStream.str();
                }
                if (currentLongitudinalDistance < 100.0)
                {
                    mLongitudinalDistanceLogger.Append(currentLongitudinalDistance);
                }
                else
                {
                    mLongitudinalDistanceLogger.Append(computedLongitudinalDistance);
                }
                mLateralDistanceLogger.Append(computedLateralDistance);
                mLongSafeDistanceLogger.Append(longitudinalSafeDistance);
                mRelativeLongSpeedLogger.Append(localLinearVelDiff.x());
                mRelativeLatSpeedLogger.Append(localLinearVelDiff.y());
                mSafetyStatusLogger.Append(safetyStatus);

                ROS_DEBUG_STREAM_COND(true, "safetyStatus: " << safetyStatus << "\n\n");
                ROS_DEBUG_STREAM_COND(true, std::string(50, '-'));
            }
            ROS_DEBUG_STREAM_COND(true, std::string(50, '='));
        }
    }

    // protected func.

    // private func.

    void Verifier::InitializeMap(const std::string &openDriveFileName)
    {
        ad::map::access::cleanup();
        std::ifstream openDriveFileStream(openDriveFileName);
        if (!openDriveFileStream.good())
        {
            ROS_ERROR_STREAM(openDriveFileName << " is not good");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
        std::string openDriveContent((std::istreambuf_iterator<char>(openDriveFileStream)), std::istreambuf_iterator<char>());

        ad::map::access::initFromOpenDriveContent(openDriveContent, double{0.2}, ad::map::intersection::IntersectionType::TrafficLight);
    }

    bool Verifier::InitializeEgoVehicle(const ad::map::point::ENUPoint     &position,
                                        const ad::map::point::ENUHeading   &heading,
                                        const ad::physics::Dimension3D     &dimension,
                                        const ad::physics::Speed           &speed,
                                        const ad::physics::AngularVelocity &yawRate,
                                        const ad::physics::Angle           &steeringAngle,
                                        const ad::map::point::ENUPoint     &target)
    {
        mEgoMatchObject.enuPosition.centerPoint = position;
        mEgoMatchObject.enuPosition.heading     = heading;
        mEgoMatchObject.enuPosition.dimension   = dimension;

        this->InitializeObjectENU(mEgoMatchObject.enuPosition.centerPoint,
                                  mEgoMatchObject.enuPosition.heading,
                                  mEgoMatchObject.enuPosition.dimension,
                                  mEgoMatchObject);

        if (mEgoMatchObject.mapMatchedBoundingBox.laneOccupiedRegions.empty())
        {
            ROS_WARN_STREAM("lane occupied region of ego-vehicle is empty");
            return false;
        }

        mEgoSpeed         = speed;
        mEgoYawRate       = yawRate;
        mEgoSteeringAngle = steeringAngle;

        const std::size_t startPointIdx{static_cast<std::size_t>(ad::map::match::ObjectReferencePoints::Center)};
        const auto        confidenceList{mEgoMatchObject.mapMatchedBoundingBox.referencePointPositions[startPointIdx]};
        if (confidenceList.empty())
        {
            ROS_WARN_STREAM("confidence list of ego-vehicle is empty");
            return false;
        }

        const auto startPoint{mEgoMatchObject.mapMatchedBoundingBox.referencePointPositions[startPointIdx][0].lanePoint.paraPoint};
        const auto geoTarget = ad::map::point::toGeo(target);
        mEgoRoute            = ad::map::route::planning::planRoute(startPoint, geoTarget);

        return true;
    }

    void Verifier::InitializeObjectENU(const ad::map::point::ENUPoint   &position,
                                       const ad::map::point::ENUHeading &heading,
                                       const ad::physics::Dimension3D   &dimension,
                                       ad::map::match::Object           &outputObject)
    {
        outputObject.enuPosition.centerPoint = position;
        outputObject.enuPosition.heading     = heading;
        outputObject.enuPosition.dimension   = dimension;

        outputObject.enuPosition.enuReferencePoint = ad::map::access::getENUReferencePoint();

        ad::map::match::AdMapMatching mapMatching;
        outputObject.mapMatchedBoundingBox = mapMatching.getMapMatchedBoundingBox(outputObject.enuPosition, ad::physics::Distance(1.0));

        // ROS_INFO_STREAM("position: " << outputObject.enuPosition);
        // ROS_INFO_STREAM("mapMatchedBoundingBox: " << outputObject.mapMatchedBoundingBox);
        // ROS_INFO_STREAM("mapMatchObject: " << outputObject);

        if (outputObject.mapMatchedBoundingBox.referencePointPositions.size() < static_cast<uint64_t>(ad::map::match::ObjectReferencePoints::Center))
        {
            ROS_ERROR_STREAM("referencePointPositions size: " << outputObject.mapMatchedBoundingBox.referencePointPositions.size() << '\n'
                                                              << "ObjectReferencePoints::Center: "
                                                              << static_cast<uint64_t>(ad::map::match::ObjectReferencePoints::Center));
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        if (outputObject.mapMatchedBoundingBox.referencePointPositions[static_cast<uint64_t>(::ad::map::match::ObjectReferencePoints::Center)]
                .size() < 0u)
        {
            ROS_ERROR_STREAM(
                "referencePointPositions[center].size: "
                << outputObject.mapMatchedBoundingBox.referencePointPositions[static_cast<uint64_t>(::ad::map::match::ObjectReferencePoints::Center)]
                       .size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        if (outputObject.mapMatchedBoundingBox.laneOccupiedRegions.empty())
        {
            if (mCanShowWarningMessage)
            {
                ROS_WARN_STREAM(
                    "mapMatchedBoundingBox lane occupied region is empty, size: " << outputObject.mapMatchedBoundingBox.laneOccupiedRegions.size());
            }
            // throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }
    }

    void Verifier::GenerateLandmarkArrayMsg()
    {
        const auto landmarkIds{ad::map::landmark::getLandmarks()};
        mLandmarkArray.landmarks.resize(landmarkIds.size());
        auto landmarkMsg{mLandmarkArray.landmarks.begin()};
        for (auto landmarkId{landmarkIds.cbegin()}; landmarkId != landmarkIds.cend(); ++landmarkId, ++landmarkMsg)
        {
            const auto enuLandmark{ad::map::landmark::getENULandmark(*landmarkId)};
            landmarkMsg->id   = enuLandmark.id;
            landmarkMsg->type = static_cast<typename std::underlying_type<ad::map::landmark::LandmarkType>::type>(enuLandmark.type);
            enuLandmark.type;
            landmarkMsg->position = rss::ToGeometryMsgsPoint(enuLandmark.position);
            landmarkMsg->heading  = enuLandmark.heading;
            ROS_DEBUG_STREAM_COND(true, "landmark id: " << *landmarkId);
        }
    }

}  // namespace rss
