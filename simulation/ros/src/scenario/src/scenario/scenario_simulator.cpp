#include <scenario_simulator.h>
#include <ros/console.h>
#include <ros/param.h>
#include <ctrl_type.h>
#include <utils_json.h>
#include <scenario_utils.h>
#include <numeric>

namespace scenario
{

    // public func.

    void Simulator::Configure(const SimulatorConfig &config)
    {
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

    void Simulator::Update()
    {
        if (mUnitModels.empty())
        {
            return;
        }

        std::for_each(mUnitModels.begin(), mUnitModels.end(), [](unit::Model::Ptr &unitModel) { unitModel->Update(); });
        mDetectedObjectPublisher->Clear();
        mDetectedObjectPublisher->AppendAgents(mAgentManager->GetAgents());
    }

    void Simulator::AccessAgentAttributes(std::vector<scenario::AgentAttribute> *outputAgentAttributes)
    {
        if (mUnitModels.empty())
        {
            ROS_WARN_STREAM("mUnitModels is empty");
            return;
        }

        if (nullptr == outputAgentAttributes)
        {
            ROS_ERROR_STREAM("outputAgentAttributes is empty");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        std::vector<std::vector<scenario::AgentAttribute>> unitModelAgentAttributeSet(mUnitModels.size());
        auto                                               agentAttributes{unitModelAgentAttributeSet.begin()};
        auto                                               unitModel{mUnitModels.begin()};
        for (; unitModel != mUnitModels.end(); ++agentAttributes, ++unitModel)
        {
            (*unitModel)->AccessAgentAttributes(&(*agentAttributes));
        }

        const std::size_t actorSize =
            std::accumulate(unitModelAgentAttributeSet.cbegin(),
                            unitModelAgentAttributeSet.cend(),
                            std::size_t{0ul},
                            [](const std::size_t &accumulatedSize, const std::vector<scenario::AgentAttribute> &agentAttributes)
                            { return accumulatedSize + agentAttributes.size(); });
        outputAgentAttributes->resize(actorSize);
        std::for_each(unitModelAgentAttributeSet.cbegin(),
                      unitModelAgentAttributeSet.cend(),
                      [&outputAgentAttributes](const std::vector<scenario::AgentAttribute> &agentAttributes)
                      { outputAgentAttributes->insert(outputAgentAttributes->cend(), agentAttributes.cbegin(), agentAttributes.cend()); });
    }

    void Simulator::RunCarlaUpdate(std::vector<carla::ActorUpdateData> *outputActorUpdateDatas)
    {
        if (mUnitModels.empty())
        {
            ROS_WARN_STREAM("mUnitModels is empty");
            return;
        }

        if (nullptr == outputActorUpdateDatas)
        {
            ROS_ERROR_STREAM("outputActorUpdateDatas is nullptr");
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        std::vector<std::vector<carla::ActorUpdateData>> unitModelActorUpdateDataSet(mUnitModels.size());
        auto                                             actorUpdateDatas{unitModelActorUpdateDataSet.begin()};
        auto                                             unitModel{mUnitModels.begin()};
        for (; unitModel != mUnitModels.end(); ++actorUpdateDatas, ++unitModel)
        {
            (*unitModel)->RunCarlaUpdate(&(*actorUpdateDatas));
        }

        const std::size_t actorSize =
            std::accumulate(unitModelActorUpdateDataSet.cbegin(),
                            unitModelActorUpdateDataSet.cend(),
                            std::size_t{0ul},
                            [](const std::size_t &accumulatedSize, const std::vector<carla::ActorUpdateData> &actorUpdateDatas)
                            { return accumulatedSize + actorUpdateDatas.size(); });

        outputActorUpdateDatas->resize(actorSize);
        std::for_each(unitModelActorUpdateDataSet.cbegin(),
                      unitModelActorUpdateDataSet.cend(),
                      [&outputActorUpdateDatas](const std::vector<carla::ActorUpdateData> &actorUpdateDatas)
                      { outputActorUpdateDatas->insert(outputActorUpdateDatas->cend(), actorUpdateDatas.cbegin(), actorUpdateDatas.cend()); });
    }

    bool Simulator::CanAccessAgentAttributes() const
    {
        return std::all_of(mUnitModels.cbegin(),
                           mUnitModels.cend(),
                           [](const unit::Model::Ptr &unitModel) { return unitModel->CanAccessAgentAttributes(); });
    }

    // protected func.

    Simulator::Simulator()
        : mNodeHandle{},
          mNavigationPathReadinessSubscriber{},
          mRssEgoVehicleDataPublisher{},
          mRssAgentDataArrayPublisher{},
          mConfigJsonValue{},
          mEgoVehicleObserver{nullptr},
          mAgentManager{nullptr},
          mNavigationPath{nullptr},
          mMapVisualizer{nullptr},
          mMeasureVisualizer{nullptr},
          mAuxiliaryVisualizer{nullptr},
          mDetectedObjectPublisher{nullptr},
          mVisualizer{nullptr},
          mConfigFileDir{},
          mTimeStep{0.0}

          ,
          mIsNavigationPathReady{false},
          mEgoVehicleWaypointEvaluator{},
          mTimeStepEvaluator{},
          mUnitModels{}
    {
        mNavigationPathReadinessSubscriber =
            mNodeHandle.subscribe("scenario/navigation_path_readiness", DefaultQueueSize(), &Simulator::NavigationPathReadinessCallback, this);
    }

    void Simulator::Configure(const SimulatorConfig &config, const std::vector<unit::Model::Ptr> &unitModels)
    {
        if (config.nodeFrequency < double{10.0})
        {
            ROS_ERROR_STREAM("invalid nodeFrequency: " << config.nodeFrequency);
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

        if (unitModels.empty())
        {
            return;
        }

        mUnitModels = unitModels;
        unit::ModelConfig unitModelConfig;
        this->ToUnitModelConfig(config, unitModelConfig);
        for (auto unitModel{mUnitModels.begin()}; unitModel != mUnitModels.end(); ++unitModel)
        {
            utils::VerifyMemberKey(config.configJsonValue, (*unitModel)->GetId().c_str());
            unitModelConfig.configJsonValue = config.configJsonValue[(*unitModel)->GetId()];
            (*unitModel)->Configure(unitModelConfig);
        }
    }

    void Simulator::RegisterUnitModel(const unit::Model::Ptr &unitModel)
    {
        mUnitModels.push_back(unitModel);
    }

    void Simulator::ToUnitModelConfig(const SimulatorConfig &simulatorConfig, unit::ModelConfig &outputUnitModelConfig) const
    {
        outputUnitModelConfig.nodeFrequency           = simulatorConfig.nodeFrequency;
        outputUnitModelConfig.configJsonValue         = simulatorConfig.configJsonValue;
        outputUnitModelConfig.agentModelJsonValue     = simulatorConfig.agentModelJsonValue;
        outputUnitModelConfig.egoVehicleObserver      = simulatorConfig.egoVehicleObserver;
        outputUnitModelConfig.agentManager            = simulatorConfig.agentManager;
        outputUnitModelConfig.navigationPath          = simulatorConfig.navigationPath;
        outputUnitModelConfig.mapVisualizer           = simulatorConfig.mapVisualizer;
        outputUnitModelConfig.measureVisualizer       = simulatorConfig.measureVisualizer;
        outputUnitModelConfig.auxiliaryVisualizer     = simulatorConfig.auxiliaryVisualizer;
        outputUnitModelConfig.detectedObjectPublisher = simulatorConfig.detectedObjectPublisher;
        outputUnitModelConfig.visualizer              = simulatorConfig.visualizer;
        outputUnitModelConfig.nodeFrequency           = simulatorConfig.nodeFrequency;
        outputUnitModelConfig.configFileDir           = simulatorConfig.configFileDir;
    }

    void Simulator::NavigationPathReadinessCallback(const std_msgs::Bool &msg)
    {
        if (!msg.data)
        {
            return;
        }

        mIsNavigationPathReady = true;

        mEgoVehicleWaypointEvaluator.Configure(mNavigationPath->GetForwardWaypoints());
    }

    // private func.

}  // namespace scenario

