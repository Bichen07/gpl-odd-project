#include <unit_model.h>
#include <stdexcept>
#include <ros/console.h>
#include <utils_converter.h>
#include <utils_json.h>
#include <path/DijkstraPlanning.h>
#include <actor_vehicle.h>
#include <actor_obstacle.h>
#include <actor_pedestrian.h>
#include <actor_config_reader.h>
#include <actor_utils.h>

namespace unit
{

    // public func.

    std::string Model::GetId() const
    {
        ROS_ERROR_STREAM("no implementation");
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    void Model::Configure(const ModelConfig &config)
    {
        if (config.nodeFrequency < double{10.0})
        {
            ROS_ERROR_STREAM("invalid nodeFrequency: " << config.nodeFrequency);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        const bool hasAgentConfigs{utils::IsMemberKey(config.configJsonValue, "moving_agent_configs")};
        if (!mIsValidProcedure && hasAgentConfigs)
        {
            ROS_ERROR_STREAM("invalid procedure of configuration");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
        mConfigJsonValue         = config.configJsonValue;
        mAgentModelJsonValue     = config.agentModelJsonValue;
        mEgoVehicleObserver      = config.egoVehicleObserver;
        mAgentManager            = config.agentManager;
        mNavigationPath          = config.navigationPath;
        mMapVisualizer           = config.mapVisualizer;
        mMeasureVisualizer       = config.measureVisualizer;
        mAuxiliaryVisualizer     = config.auxiliaryVisualizer;
        mDetectedObjectPublisher = config.detectedObjectPublisher;
        mVisualizer              = config.visualizer;
        mConfigFileDir           = config.configFileDir;

        mTimeStep = double{1.0} / config.nodeFrequency;
        if (mTimeStep < math::real_t{1.0e-6})
        {
            ROS_ERROR_STREAM("invalid mTimeStep: " << mTimeStep);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Model::AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes)
    {
        ROS_ERROR_STREAM("no implementation");
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    void Model::RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas)
    {
        ROS_ERROR_STREAM("no implementation");
        throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
    }

    void Model::ConfigureIsoPerformanceEvaluation(const std::shared_ptr<iso::AgentManager> &isoAgentManager)
    {
        mIsoAgentManager = isoAgentManager;
    }

    bool Model::CanAccessAgentAttributes() const
    {
        return mCanAccessAgentAttributes;
    }

    // protected func.

    Model::Model()
        : mConfigJsonValue{},
          mAgentModelJsonValue{},
          mEgoVehicleObserver{nullptr},
          mAgentManager{nullptr},
          mIsoAgentManager{nullptr},
          mNavigationPath{nullptr},
          mMapVisualizer{nullptr},
          mMeasureVisualizer{nullptr},
          mAuxiliaryVisualizer{nullptr},
          mDetectedObjectPublisher{nullptr},
          mVisualizer{nullptr},
          mPoseApproximationEvaluatorManager{},
          mConfigFileDir{},
          mTimeStep{0.0},
          mCanAccessAgentAttributes{false},
          mDoneConfigureMotions{false},
          mCanUpdate{false},
          mNodeHandle{},
          mEgoVehicleSpeedCommandSubscriber{},
          mEgoVehicleGlobalPathSubscriber{},
          mDijkstraPlanningService{},
          mIsEgoVehicleSpeedCommandReady{false},
          mEgoVehicleGlobalPath{},
          mIsValidProcedure{false}
    {
        mDijkstraPlanningService = mNodeHandle.serviceClient<path::DijkstraPlanning>("path/dijkstra_planning");
    }

    void Model::RegisterIsoAgents(const std::vector<std::string> &isoAgentIds, const std::vector<std::shared_ptr<actor::Vehicle>> &movingVehicles)
    {
        if (isoAgentIds.size() != movingVehicles.size())
        {
            ROS_ERROR_STREAM("diff. sizes b/t mMovingVehicle & isoAgentIds" << '\n'
                                                                            << "mMovingVehicles: " << movingVehicles.size() << '\n'
                                                                            << "isoAgentIds: " << isoAgentIds.size());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        auto isoAgentId{isoAgentIds.cbegin()};
        auto vehicle{movingVehicles.begin()};
        for (; vehicle != movingVehicles.end(); ++isoAgentId, ++vehicle)
        {
            mIsoAgentManager->Register(*isoAgentId, *vehicle);
        }
    }

    template <typename AgentType, typename ConfigType>
    void Model::Configure(const ModelConfig &config, const std::string &agentIdPrefix, std::vector<std::shared_ptr<AgentType>> &agents)
    {
        mIsValidProcedure = true;
        Model::Configure(config);

        static constexpr const char *agentConfigKey{"moving_agent_configs"};
        if (!utils::IsMemberKey(mConfigJsonValue, agentConfigKey))
        {
            return;
        }
        std::vector<ConfigType> agentConfigs;
        actor::ParseAgentConfigs(mConfigJsonValue[agentConfigKey], mAgentModelJsonValue, &agentConfigs);
        agents.resize(agentConfigs.size());
        auto agent{agents.begin()};
        auto agentConfig{agentConfigs.cbegin()};
        for (; agent != agents.end(); ++agent, ++agentConfig)
        {
            const auto agentIdx = std::distance(agents.begin(), agent);
            const auto agentId  = agentIdPrefix + std::string("agent_") + std::to_string(agentIdx);
            *agent              = std::make_shared<AgentType>(agentId, *agentConfig);
            mAgentManager->Append(*agent);
        }
    }
    template <>
    void Model::Configure<actor::Vehicle, actor::VehicleConfig>(const ModelConfig                &config,
                                                                const std::string                &agentIdPrefix,
                                                                std::vector<actor::Vehicle::Ptr> &agents)
    {
        mIsValidProcedure = true;
        Model::Configure(config);

        static constexpr const char *agentConfigKey{"moving_agent_configs"};
        if (!utils::IsMemberKey(mConfigJsonValue, agentConfigKey))
        {
            return;
        }
        std::vector<actor::VehicleConfig> agentConfigs;
        actor::ParseAgentConfigs(mConfigJsonValue[agentConfigKey], mAgentModelJsonValue, &agentConfigs);

        agents.resize(0);
        for (int i = 0; i < agentConfigs.size(); i++)
        {
            const auto &agentConfig = agentConfigs[i];
            if (!(agentConfig.objectClassId == actor::ObjectClassId::Car || agentConfig.objectClassId == actor::ObjectClassId::Bus ||
                  agentConfig.objectClassId == actor::ObjectClassId::Truck || agentConfig.objectClassId == actor::ObjectClassId::Bicycle ||
                  agentConfig.objectClassId == actor::ObjectClassId::Motorbike ||
                  agentConfig.objectClassId == actor::ObjectClassId::ConstructionVehicle ||
                  agentConfig.objectClassId == actor::ObjectClassId::Trailer))
            {
                continue;
            }
            // const auto agentId = agentIdPrefix + std::string("vehicle_") + std::to_string(i);
            const auto agentId = utils::GetStringJsonValue(mConfigJsonValue["moving_agent_configs"][i]["name"]);
            const auto agent   = std::make_shared<actor::Vehicle>(agentId, agentConfig);
            agents.emplace_back(agent);
            mAgentManager->Append(agent);
        }
    }
    template <>
    void Model::Configure<actor::Pedestrian, actor::PedestrianConfig>(const ModelConfig                   &config,
                                                                      const std::string                   &agentIdPrefix,
                                                                      std::vector<actor::Pedestrian::Ptr> &agents)
    {
        mIsValidProcedure = true;
        Model::Configure(config);

        static constexpr const char *agentConfigKey{"moving_agent_configs"};
        if (!utils::IsMemberKey(mConfigJsonValue, agentConfigKey))
        {
            return;
        }
        std::vector<actor::PedestrianConfig> agentConfigs;
        actor::ParseAgentConfigs(mConfigJsonValue[agentConfigKey], mAgentModelJsonValue, &agentConfigs);

        agents.resize(0);
        for (int i = 0; i < agentConfigs.size(); i++)
        {
            const auto &agentConfig = agentConfigs[i];
            if (agentConfig.objectClassId != actor::ObjectClassId::Person)
            {
                continue;
            }
            const auto agentId = agentIdPrefix + std::string("pedestrian_") + std::to_string(i);
            const auto agent   = std::make_shared<actor::Pedestrian>(agentId, agentConfig);
            agents.emplace_back(agent);
            mAgentManager->Append(agent);
        }
    };
    template void Model::Configure<actor::Obstacle, actor::ObstacleConfig>(const ModelConfig &,
                                                                           const std::string &,
                                                                           std::vector<actor::Obstacle::Ptr> &);

    void Model::ConfigureMotions()
    {
        utils::VerifyMemberKey(mConfigJsonValue, "motion_configs");
    }

    template <typename AgentType>
    void Model::ConfigureMotions(std::vector<std::shared_ptr<AgentType>> &agents)
    {
        Model::ConfigureMotions();

        auto agent{agents.begin()};
        for (; agent != agents.end(); ++agent)
        {
            mPoseApproximationEvaluatorManager.Register((*agent)->GetAttribute().id,
                                                        std::make_shared<PoseApproximationEvaluator>(PoseApproximationEvaluator::DefaultEpsilon()));
        }
    }
    template void Model::ConfigureMotions<actor::Vehicle>(std::vector<actor::Vehicle::Ptr> &agents);
    template void Model::ConfigureMotions<actor::Pedestrian>(std::vector<actor::Pedestrian::Ptr> &agents);
    template void Model::ConfigureMotions<actor::Obstacle>(std::vector<actor::Obstacle::Ptr> &agents);

    template <typename AgentType>
    void Model::AccessAgentAttributes(std::vector<scenario::AgentAttribute> *agentAttributes, std::vector<std::shared_ptr<AgentType>> agents) const
    {
        if (nullptr == agentAttributes)
        {
            ROS_ERROR_STREAM("agentAttributes is nullptr");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
        agentAttributes->resize(agents.size());
        std::transform(agents.cbegin(),
                       agents.cend(),
                       agentAttributes->begin(),
                       [](const std::shared_ptr<AgentType> &agent) { return actor::ConvertToAgentAttributeMsg(agent->GetAttribute()); });
    }
    template void Model::AccessAgentAttributes<actor::Vehicle>(std::vector<scenario::AgentAttribute> *agentAttributes,
                                                               std::vector<actor::Vehicle::Ptr>       agents) const;
    template void Model::AccessAgentAttributes<actor::Pedestrian>(std::vector<scenario::AgentAttribute> *agentAttributes,
                                                                  std::vector<actor::Pedestrian::Ptr>    agents) const;
    template void Model::AccessAgentAttributes<actor::Obstacle>(std::vector<scenario::AgentAttribute> *agentAttributes,
                                                                std::vector<actor::Obstacle::Ptr>      agents) const;

    template <typename AgentType>
    void Model::RunCarlaUpdate(std::vector<carla::ActorUpdateData> *actorUpdateDatas, std::vector<std::shared_ptr<AgentType>> agents)
    {
        if (nullptr == actorUpdateDatas)
        {
            ROS_ERROR_STREAM("actorUpdateDatas is nullptr");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        actorUpdateDatas->resize(agents.size());
        auto agent{agents.cbegin()};
        auto actorUpdateData{actorUpdateDatas->begin()};
        for (; agent != agents.cend(); ++agent, ++actorUpdateData)
        {
            actorUpdateData->id   = (*agent)->GetAttribute().id;
            actorUpdateData->pose = (*agent)->GetTransform3d();
            auto poseApproximationEvaluator{mPoseApproximationEvaluatorManager.QueryObject((*agent)->GetAttribute().id)};
            actorUpdateData->isStationary = poseApproximationEvaluator->Compute((*agent)->GetTransform3d());
        }
    }
    template void Model::RunCarlaUpdate<actor::Vehicle>(std::vector<carla::ActorUpdateData> *actorUpdateDatas,
                                                        std::vector<actor::Vehicle::Ptr>     agents);
    template void Model::RunCarlaUpdate<actor::Pedestrian>(std::vector<carla::ActorUpdateData> *actorUpdateDatas,
                                                           std::vector<actor::Pedestrian::Ptr>  agents);
    template void Model::RunCarlaUpdate<actor::Obstacle>(std::vector<carla::ActorUpdateData> *actorUpdateDatas,
                                                         std::vector<actor::Obstacle::Ptr>    agents);

    template <typename AgentType>
    void Model::AppendVelocityMarkers(const std::vector<std::shared_ptr<AgentType>> &movingAgents)
    {
        static constexpr math::real_t speedTextScale{0.0};
        for (auto movingAgent{movingAgents.cbegin()}; movingAgent != movingAgents.cend(); ++movingAgent)
        {
            measure::VelocityMarker velocityMarker{.id             = (*movingAgent)->GetAttribute().id + "_velocity",
                                                   .velocity       = (*movingAgent)->GetState().linearVelocity,
                                                   .beginPosition  = (*movingAgent)->GetState().position,
                                                   .lifeTime       = ros::Duration(),
                                                   .color          = (*movingAgent)->GetAttribute().color,
                                                   .speedTextScale = speedTextScale};
            mMeasureVisualizer->AppendVelocityMarker(velocityMarker);
        }
    }
    template void Model::AppendVelocityMarkers(const std::vector<actor::Vehicle::Ptr> &);
    template void Model::AppendVelocityMarkers(const std::vector<actor::Pedestrian::Ptr> &);

    void Model::ExecuteDijkstraPlanning(const map::WaypointId         &beginWaypointId,
                                        const map::WaypointId         &endWaypointId,
                                        std::vector<math::Vector3d_t> &outputPlannedWaypoints)
    {
        this->ExecuteDijkstraPlanning(beginWaypointId, std::vector<int32_t>(), endWaypointId, outputPlannedWaypoints);
    }

    void Model::ExecuteDijkstraPlanning(const map::WaypointId         &beginWaypointId,
                                        const std::vector<int32_t>    &viaLaneIds,
                                        const map::WaypointId         &endWaypointId,
                                        std::vector<math::Vector3d_t> &outputPlannedWaypoints)
    {
        path::DijkstraPlanning dijkstraPlanning;
        dijkstraPlanning.request.begin_waypoint_id.lane  = beginWaypointId.lane;
        dijkstraPlanning.request.begin_waypoint_id.point = beginWaypointId.point;
        dijkstraPlanning.request.via_lane_ids            = viaLaneIds;
        dijkstraPlanning.request.end_waypoint_id.lane    = endWaypointId.lane;
        dijkstraPlanning.request.end_waypoint_id.point   = endWaypointId.point;
        ROS_DEBUG_STREAM_COND(false, "dijkstraPlanning.request" << '\n' << dijkstraPlanning.request);
        if (!mDijkstraPlanningService.call(dijkstraPlanning))
        {
            ROS_ERROR_STREAM("fail to call dijkstra planning service"
                             << '\n'
                             << "request" << '\n'
                             << dijkstraPlanning.request << '\n'
                             << "response waypoint size: " << dijkstraPlanning.response.planned_waypoints.size());
        }
        else
        {
            static constexpr bool canShowPlannedLandIds{false};
            if (canShowPlannedLandIds)
            {
                ROS_DEBUG_STREAM_COND(true, "planned_lane_ids, size: " << dijkstraPlanning.response.planned_lane_ids.size());
                std::copy(dijkstraPlanning.response.planned_lane_ids.cbegin(),
                          dijkstraPlanning.response.planned_lane_ids.cend(),
                          std::ostream_iterator<int32_t>(std::cout, ", "));
                std::cout << std::endl;
            }
        }

        outputPlannedWaypoints.resize(dijkstraPlanning.response.planned_waypoints.size());
        std::transform(dijkstraPlanning.response.planned_waypoints.cbegin(),
                       dijkstraPlanning.response.planned_waypoints.cend(),
                       outputPlannedWaypoints.begin(),
                       [](const geometry_msgs::Point &input) { return utils::ConvertToVector3d(input); });
    }

    void Model::EgoVehicleSpeedCommandCallback(const itri_msgs::speed_cmd &msg)
    {
        ROS_WARN_STREAM("no implementation");
    }

    void Model::EgoVehicleWaypointsCallback(const itri_msgs::WaypointArray &msg)
    {
        ROS_WARN_STREAM("no implementation");
    }

    void Model::EgoVehicleGlobalPathCallback(const itri_msgs::Path &msg)
    {
        mEgoVehicleGlobalPath.resize(msg.waypoints.size());
        auto pathWaypoint{msg.waypoints.cbegin()};
        auto egoVehicleWaypoint{mEgoVehicleGlobalPath.begin()};
        for (; pathWaypoint != msg.waypoints.cend(); ++pathWaypoint, ++egoVehicleWaypoint)
        {
            *egoVehicleWaypoint = pathWaypoint->pose.pose.position;
        }
    }

    // private func.

}  // namespace unit
