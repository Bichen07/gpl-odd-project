#include <scenario_simulator_manager.h>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <ros/package.h>
#include <ros/console.h>
#include <jsoncpp/json/json.h>
#include <math_utils.h>
#include <ctrl_type.h>
#include <utils_converter.h>
#include <utils_default_color.h>
#include <utils_json.h>
#include <utils_ros_param.h>
#include <utils_text_marker.h>
#include <carla_actor_update_data.h>
#include <motion_utils.h>
#include <scenario_simulator_config.h>
#include <scenario_action.h>
#include <scenario_adas.h>
#include <scenario_expway68.h>
#include <scenario_hct.h>
#include <scenario_itri.h>
#include <scenario_shuinan.h>
#include <scenario_esmini.h>
#include <itri_msgs/Path.h>
#include <scenario_drts.h>

namespace scenario
{

    // public func.

    SimulatorManager::SimulatorManager()
        : mNodeHandle{},
          mAgentAttributeAccessService{},
          mCarlaActorUpdateService{},
          mScenarioUpdateService{},
          mScenarioIds{},
          mSimulatorFactory{},
          mSimulator{nullptr},
          mAgentManager{std::make_shared<actor::AgentManager>()},
          mEgoVehicleObserver{std::make_shared<actor::EgoVehicleObserver>()},
          mEgoVehicleSimulator{},
          mCollisionDetector{},
          mMeasureVisualizer{std::make_shared<measure::Visualizer>()},
          mNavigationPath{nullptr},
          mMapVisualizer{std::make_shared<map::Visualizer>()},
          mAuxiliaryVisualizer{std::make_shared<utils::AuxiliaryVisualizer>()},
          mDetectedObjectIdManager{std::make_shared<DetectedObjectIdManager>()},
          mDetectedObjectPublisher{std::make_shared<DetectedObjectPublisher>()},
          mVisualizer{std::make_shared<Visualizer>()},
          mVisualizationMsgsManager{std::make_shared<VisualizationMsgsManager>()},
          mUseSimTime{false},
          mUseCarla{false},
          mAgentMotionUpdateMutex{},
          mDetectedObjectPublishingMutex{},
          mVisualizationPublishingMutex{},
          mReconfiguringMutex{},
          mScenarioReconfigureActionServer(mNodeHandle,
                                           "scenario_reconfigure_action",
                                           boost::bind(&SimulatorManager::ScenarioReconfigureActionCallback, this, _1),
                                           false)
    {
        mAgentAttributeAccessService = mNodeHandle.advertiseService("agent_attribute_access", &SimulatorManager::AccessAgentAttributes, this);
        mCarlaActorUpdateService     = mNodeHandle.advertiseService("carla_actor_update", &SimulatorManager::UpdateCarlaActors, this);
        mScenarioUpdateService       = mNodeHandle.advertiseService("scenario/update", &SimulatorManager::UpdateScenario, this);

        scenario::RegisterActionScenarios(mSimulatorFactory);
        scenario::RegisterAdasScenarios(mSimulatorFactory);
        scenario::RegisterExpway68Scenarios(mSimulatorFactory);
        scenario::RegisterHctScenarios(mSimulatorFactory);
        scenario::RegisterItriScenarios(mSimulatorFactory);
        scenario::RegisterShuinanScenarios(mSimulatorFactory);
        scenario::RegisterDrtsScenarios(mSimulatorFactory);
        scenario::RegisterEsminiScenarios(mSimulatorFactory);

        scenario::AppendActionScenarioIds(mScenarioIds);
        scenario::AppendAdasScenarioIds(mScenarioIds);
        scenario::AppendExpway68ScenarioIds(mScenarioIds);
        scenario::AppendHctScenarioIds(mScenarioIds);
        scenario::AppendItriScenarioIds(mScenarioIds);
        scenario::AppendShuinanScenarioIds(mScenarioIds);
        scenario::AppendDrtsScenarioIds(mScenarioIds);
        scenario::AppendEsminiScenarioIds(mScenarioIds);

        if (mNodeHandle.hasParam("use_sim_time"))
        {
            mNodeHandle.getParam("use_sim_time", mUseSimTime);
        }

        if (mNodeHandle.hasParam("simulation/using_carla"))
        {
            mNodeHandle.getParam("simulation/using_carla", mUseCarla);
        }
        mScenarioReconfigureActionServer.start();
    }

    void SimulatorManager::Configure(const double nodeFrequency, const int32_t detectedObjectIdOffset)
    {
        mNodeFrequency          = nodeFrequency;
        mDetectedObjectIdOffset = detectedObjectIdOffset;
        const std::string configFile{utils::GetRosParam<std::string>(mNodeHandle, "scenario/config/file")};
        const std::string scenarioConfigurationDirectory{utils::GetRosParam<std::string>(mNodeHandle, "scenario/config/dir")};
        const std::string scenarioConfigFile{configFile};
        Configure(scenarioConfigFile, mNodeFrequency, mDetectedObjectIdOffset);
    }

    void SimulatorManager::Configure(const std::string scenarioConfigFile, const double nodeFrequency, const int32_t detectedObjectIdOffset)
    {
        ROS_INFO_STREAM("Loading scenario config from " << scenarioConfigFile);
        mDetectedObjectIdManager->Configure(detectedObjectIdOffset);
        mMeasureVisualizer->Configure(mVisualizationMsgsManager);
        mMapVisualizer->Configure(mVisualizationMsgsManager);
        mVisualizer->Configure(mVisualizationMsgsManager, mDetectedObjectIdManager);

        const std::string scenarioConfigurationDirectory{utils::GetRosParam<std::string>(mNodeHandle, "scenario/config/dir")};
        const std::string agentSizeFile{utils::GetRosParam<std::string>(mNodeHandle, "scenario/config/agent/size")};

        // Read specific model size

        const std::string agentSizeConfigFile{scenarioConfigurationDirectory + agentSizeFile};
        std::ifstream     agentSizeConfigFileStream;
        agentSizeConfigFileStream.open(agentSizeConfigFile);
        if (agentSizeConfigFileStream.fail())
        {
            ROS_ERROR_STREAM("fail to open " << agentSizeConfigFile);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        Json::Value  agentModelJsonValue;
        Json::Reader agentModelJsonReader;
        agentModelJsonReader.parse(agentSizeConfigFileStream, agentModelJsonValue);
        agentSizeConfigFileStream.close();

        // Read scenario configuration

        std::ifstream scenarioConfigFileStream;
        scenarioConfigFileStream.open(scenarioConfigFile);
        if (scenarioConfigFileStream.fail())
        {
            ROS_ERROR_STREAM("fail to open " << scenarioConfigFile);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        Json::Value  configJsonValue;
        Json::Reader jsonReader;
        jsonReader.parse(scenarioConfigFileStream, configJsonValue);
        scenarioConfigFileStream.close();

        const math::Vector3d_t egoVehicleSize(configJsonValue["ego_vehicle"]["size"]["x"].asDouble(),
                                              configJsonValue["ego_vehicle"]["size"]["y"].asDouble(),
                                              configJsonValue["ego_vehicle"]["size"]["z"].asDouble());
        mEgoVehicleObserver->Configure(egoVehicleSize,
                                       configJsonValue["ego_vehicle"]["compensated_second"].asDouble(),
                                       configJsonValue["ego_vehicle"]["static_longitudinal_compensated_distance"].asDouble());

        mCollisionDetector.Configure(mEgoVehicleObserver, mAgentManager);

        mEgoVehicleSimulator.Configure(mEgoVehicleObserver);

        const std::string scenarioId{utils::GetRosParam<std::string>(mNodeHandle, "scenario/id")};
        this->VerifyScenarioId(scenarioId);
        ROS_INFO_STREAM("scenario_id: " << scenarioId);

        const std::string simulatorId{configJsonValue[scenarioId].asString()};
        ROS_INFO_STREAM("simulatorId: " << simulatorId);

        if (simulatorId.empty())
        {
            ROS_WARN_STREAM("empty simulatorId with scenarioId: " << scenarioId);
            return;
        }

        mNavigationPath = std::make_shared<map::NavigationPath>();

        const map::NavigationPathConfig navigationPathConfig(configJsonValue[simulatorId]["map"].asString(),
                                                             configJsonValue[simulatorId]["route"].asString());
        mNavigationPath->Configure(navigationPathConfig);

        SimulatorConfig simulatorConfig;
        simulatorConfig.nodeFrequency           = nodeFrequency;
        simulatorConfig.configJsonValue         = configJsonValue[simulatorId];
        simulatorConfig.agentModelJsonValue     = agentModelJsonValue;
        simulatorConfig.egoVehicleObserver      = mEgoVehicleObserver;
        simulatorConfig.agentManager            = mAgentManager;
        simulatorConfig.navigationPath          = mNavigationPath;
        simulatorConfig.mapVisualizer           = mMapVisualizer;
        simulatorConfig.measureVisualizer       = mMeasureVisualizer;
        simulatorConfig.auxiliaryVisualizer     = mAuxiliaryVisualizer;
        simulatorConfig.detectedObjectPublisher = mDetectedObjectPublisher;
        simulatorConfig.visualizer              = mVisualizer;

        simulatorConfig.configFileDir = scenarioConfigurationDirectory;

        mSimulator.reset(mSimulatorFactory.CreateRawPtr(simulatorId));
        if (!mSimulator)
        {
            ROS_ERROR_STREAM("mSimulator is nullptr" << '\n' << "Failed to create mSimulator with simulatorId: " << simulatorId);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
        mSimulator->Configure(simulatorConfig);

        const std::string egoInitPoseConfigFile{utils::GetRosParam<std::string>(mNodeHandle, "simulation/ego_vehicle/config/init_pose/file")};
        const std::string simulationConfigurationDirectory{utils::GetRosParam<std::string>(mNodeHandle, "simulation/config/dir")};
        const std::string simulatedEgoConfigFile{utils::GetRosParam<std::string>(mNodeHandle, "simulation/ego_vehicle/config/file")};

        ROS_DEBUG_STREAM_COND(false,
                              "egoInitPoseConfigFile: " << egoInitPoseConfigFile << '\n'
                                                        << "simulationConfigurationDirectory: " << simulationConfigurationDirectory << '\n'
                                                        << "simulatedEgoConfigFile: " << simulatedEgoConfigFile);

        math::HomoXfm3d_t egoVehicleInitPose;
        this->ConfigureEgoVehicleInitPose(scenarioId,
                                          mNavigationPath->GetNavigationPathConfig().map,
                                          scenarioConfigurationDirectory + egoInitPoseConfigFile,
                                          simulationConfigurationDirectory + simulatedEgoConfigFile,
                                          egoVehicleInitPose);
        mDetectedObjectPublisher->Configure(mDetectedObjectIdManager, egoVehicleInitPose);
    }

    void SimulatorManager::Update()
    {
        std::lock_guard<std::mutex> agentMotionUpdateGuard(mAgentMotionUpdateMutex);
        std::lock_guard<std::mutex> detectedObjectPublishingGuard(mDetectedObjectPublishingMutex);
        std::lock_guard<std::mutex> visualizationPublishingGuard(mVisualizationPublishingMutex);
        std::lock_guard<std::mutex> reconfiguringGuard(mReconfiguringMutex);

        mCollisionDetector.ClearDetectedCollision();
        mDetectedObjectPublisher->Clear();
        if (mSimulator && !mUseCarla)
        {
            mSimulator->Update();
        }

        this->UpdateEgoVehicle();
        mCollisionDetector.Update();
    }

    void SimulatorManager::Reset()
    {
        mSimulator.reset();
        mAgentManager->Reset();
        mDetectedObjectIdManager->Reset();
        mVisualizationMsgsManager->Reset();
    }

    void SimulatorManager::PublishVisualization()
    {
        std::lock_guard<std::mutex> agentMotionUpdateGuard(mAgentMotionUpdateMutex);
        std::lock_guard<std::mutex> visualizationPublishingGuard(mVisualizationPublishingMutex);

        mVisualizer->AppendCollidedAgentIds(mCollisionDetector.CollidedAgentIdList());
        mVisualizer->SetEgoVehicleCollisionState(mCollisionDetector.HasEgoVehicleCollision());
        mVisualizer->SetEgoVehicleRect(mEgoVehicleObserver->GetWorldBoundingRect3d(), mEgoVehicleObserver->GetState());

        mVisualizer->Publish();
        mMeasureVisualizer->Publish();
        mAuxiliaryVisualizer->Publish();
        mMapVisualizer->Publish();
    }

    void SimulatorManager::PublishDetectedObjects(const DetectedObjectCoord &coord)
    {
        std::lock_guard<std::mutex> agentMotionUpdateGuard(mAgentMotionUpdateMutex);
        std::lock_guard<std::mutex> detectedObjectPublishingGuard(mDetectedObjectPublishingMutex);
        mDetectedObjectPublisher->Publish(coord);
    }

    void SimulatorManager::ExtractDetectedAgentData(std::vector<DetectedAgentData> *detectedAgentDatas) const
    {
        mDetectedObjectPublisher->ExtractDetectedAgentData(detectedAgentDatas);
    }

    // protected func.

    // private func.

    void SimulatorManager::UpdateEgoVehicle()
    {
        mEgoVehicleSimulator.Update();

        if (mNodeHandle.hasParam("scenario/can_show_ego_vehicle_speed"))
        {
            bool canShowEgoVehicleVel{false};
            mNodeHandle.getParam("scenario/can_show_ego_vehicle_speed", canShowEgoVehicleVel);
            if (canShowEgoVehicleVel)
            {
                int32_t precisionDigit{0};
                mNodeHandle.getParam("scenario/ego_vehicle_speed/precision_digit", precisionDigit);
                double textLongitudinalOffset{0.0};
                mNodeHandle.getParam("scenario/ego_vehicle_speed/text_longitudinal_offset", textLongitudinalOffset);
                double textLateralOffset{0.0};
                mNodeHandle.getParam("scenario/ego_vehicle_speed/text_lateral_offset", textLateralOffset);
                double textHeightOffset{0.0};
                mNodeHandle.getParam("scenario/ego_vehicle_speed/text_height_offset", textHeightOffset);
                double textScale{1.0};
                mNodeHandle.getParam("scenario/ego_vehicle_speed/text_scale", textScale);
                ROS_DEBUG_STREAM_COND(false,
                                      "precision_digit: " << precisionDigit << '\n'
                                                          << "text_longitudinal_offset: " << textLongitudinalOffset << '\n'
                                                          << "text_lateral_offset: " << textLateralOffset << '\n'
                                                          << "text_height_offset: " << textHeightOffset << '\n'
                                                          << "text_scale: " << textScale);

                std::stringstream velSstream;
                velSstream << std::setprecision(precisionDigit) << std::fixed
                           << motion::ConvertToKph(mEgoVehicleObserver->GetState().linearVelocity.norm()) << "kph";
                const math::Vector3d_t  textOffsetVector(textLongitudinalOffset, textLateralOffset, textHeightOffset);
                const math::Vector3d_t  textPos{mEgoVehicleObserver->GetTransform3d().linear() * textOffsetVector +
                                               mEgoVehicleObserver->GetTransform3d().translation()};
                const math::HomoXfm3d_t textXfm(mEgoVehicleObserver->GetTransform3d().linear(), textPos);

                mAuxiliaryVisualizer->AppendTextMarker(utils::TextMarker{.id       = "ego_vehicle_vel_text",
                                                                         .text     = velSstream.str(),
                                                                         .pose     = geometry::Transform3d(textXfm),
                                                                         .scale    = geometry::Vector3d(textScale, textScale, textScale),
                                                                         .lifetime = ros::Duration(),
                                                                         .color    = utils::Yellow()});
            }
        }
    }

    void SimulatorManager::VerifyScenarioId(const std::string &scenarioId) const
    {
        const bool isValidScenarioId =
            std::any_of(mScenarioIds.cbegin(), mScenarioIds.cend(), [&scenarioId](const std::string &validId) { return scenarioId == validId; });

        if (!isValidScenarioId)
        {
            ROS_ERROR_STREAM("invalid scenarioId: " << scenarioId);
            std::cout << "valid scenarioIds are ";
            std::copy(mScenarioIds.cbegin(), mScenarioIds.cend(), std::ostream_iterator<std::string>(std::cout, ", "));
            std::cout << std::endl;
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void SimulatorManager::ConfigureEgoVehicleInitPose(const std::string &scenarioId,
                                                       const std::string &mapId,
                                                       const std::string &egoInitPoseConfigFile,
                                                       const std::string &simulatedEgoConfigFile,
                                                       math::HomoXfm3d_t &outputEgoVehicleInitPose)
    {
        std::ifstream egoInitPoseConfigFileStream(egoInitPoseConfigFile);
        if (!egoInitPoseConfigFileStream.good())
        {
            ROS_ERROR_STREAM("file stream is not good, file name: " << egoInitPoseConfigFile);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        if (!this->IsSimulationNodeActive())
        {
            Json::Value  egoInitPoseConfigJsonValue;
            Json::Reader jsonReader;
            jsonReader.parse(egoInitPoseConfigFileStream, egoInitPoseConfigJsonValue);
            egoInitPoseConfigFileStream.close();

            std::ifstream simulatedEgoConfigFileStream(simulatedEgoConfigFile, std::ifstream::in);
            if (!simulatedEgoConfigFileStream.good())
            {
                ROS_ERROR_STREAM("file stream is not good, file name: " << simulatedEgoConfigFile);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }

            ROS_INFO_STREAM("simulatedEgoCnofigFile: " << simulatedEgoConfigFile);

            Json::Value simulatedEgoConfigJsonValue;
            jsonReader.parse(simulatedEgoConfigFileStream, simulatedEgoConfigJsonValue);
            simulatedEgoConfigFileStream.close();
            const auto poseJsonValue = egoInitPoseConfigJsonValue[scenarioId][mapId];

            simulatedEgoConfigJsonValue["position"]["x"] = 0.0;
            // utils::GetDoubleJsonValue(poseJsonValue["position"]["x"]);
            simulatedEgoConfigJsonValue["position"]["y"] = 0.0;
            // utils::GetDoubleJsonValue(poseJsonValue["position"]["y"]);
            simulatedEgoConfigJsonValue["orientation"] = 0.0;
            // utils::GetDoubleJsonValue(poseJsonValue["orientation"]);

            Json::StreamWriterBuilder builder;
            builder["commentStyle"] = "None";
            builder["indentation"]  = "   ";

            std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
            std::ofstream                       outputSimulatedEgoConfigFileStream(simulatedEgoConfigFile, std::ofstream::out);
            if (!outputSimulatedEgoConfigFileStream.good())
            {
                ROS_ERROR_STREAM("file stream is not good, file name: " << simulatedEgoConfigFile);
                throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
            }
            writer->write(simulatedEgoConfigJsonValue, &outputSimulatedEgoConfigFileStream);

            ROS_INFO_STREAM("write to file: " << simulatedEgoConfigFile);
            outputSimulatedEgoConfigFileStream.close();

            outputEgoVehicleInitPose =
                math::HomoXfm3d_t(math::ToRotMatXyz(math::Vector3d_t(math::real_t{0.0}, math::real_t{0.0}, utils::GetDoubleJsonValue(0.0))),
                                  math::Vector3d_t(utils::GetDoubleJsonValue(0.0), utils::GetDoubleJsonValue(0.0), utils::GetDoubleJsonValue(1.0)));
        }
    }

    bool SimulatorManager::UpdateCarlaActors(CarlaActorUpdate::Request &request, CarlaActorUpdate::Response &response)
    {
        if (!mSimulator)
        {
            return false;
        }

        std::vector<carla::ActorUpdateData> actorUpdateDatas;
        mSimulator->RunCarlaUpdate(&actorUpdateDatas);
        response.poses.resize(actorUpdateDatas.size());
        auto actorUpdateData{actorUpdateDatas.cbegin()};
        auto actorPose{response.poses.begin()};
        for (; actorUpdateData != actorUpdateDatas.cend(); ++actorUpdateData, ++actorPose)
        {
            actorPose->id           = actorUpdateData->id;
            actorPose->pose         = utils::ConvertToGeometryMsgsPose(actorUpdateData->pose);
            actorPose->isStationary = actorUpdateData->isStationary;
        }

        return true;
    }

    bool SimulatorManager::AccessAgentAttributes(AgentAttributeAccess::Request &request, AgentAttributeAccess::Response &response)
    {
        if (!mSimulator)
        {
            return false;
        }

        if (!mSimulator->CanAccessAgentAttributes())
        {
            return false;
        }

        mSimulator->AccessAgentAttributes(&response.attributes);

        return true;
    }

    bool SimulatorManager::UpdateScenario(ScenarioUpdate::Request &request, ScenarioUpdate::Response &response)
    {
        this->Update();
    }

    bool SimulatorManager::IsSimulationNodeActive() const
    {
        std::vector<std::string> activeNodes;
        ros::master::getNodes(activeNodes);
        const bool isSimulationNodeActive = activeNodes.cend() != std::find(activeNodes.cbegin(), activeNodes.cend(), "/simulation");

        return isSimulationNodeActive;
    }

    void SimulatorManager::ScenarioReconfigureActionCallback(const scenario::ScenarioReconfigureGoalConstPtr &goal)
    {
        scenario::ScenarioReconfigureFeedback feedback;
        scenario::ScenarioReconfigureResult   result;
        std::lock_guard<std::mutex>           reconfiguringGuard(mReconfiguringMutex);
        this->Reset();
        this->Configure(goal->motion_config_file_path, mNodeFrequency, mDetectedObjectIdOffset);
        mScenarioReconfigureActionServer.setSucceeded(result);
    }

}  // namespace scenario

