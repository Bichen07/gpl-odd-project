#ifndef _UNIT_STATIONARY_OBJECT_MODEL_H_
#define _UNIT_STATIONARY_OBJECT_MODEL_H_

#include <unit_model.h>
#include <motion_stationary_object_config.h>
#include <actor_obstacle.h>

namespace unit {

class StationaryObjectModel final : public Model
{

public:

    typedef std::shared_ptr<StationaryObjectModel> Ptr;

    StationaryObjectModel();
    StationaryObjectModel(const StationaryObjectModel &) = delete;
    StationaryObjectModel &operator=(const StationaryObjectModel &) = delete;
    virtual ~StationaryObjectModel() = default;

    virtual std::string GetId() const override;
    virtual void Configure(const ModelConfig &config) override;
    virtual void Update() override;
    virtual void AccessAgentAttributes(
        std::vector<scenario::AgentAttribute> *agentAttributes) override;
    virtual void RunCarlaUpdate(
        std::vector<carla::ActorUpdateData> *actorUpdateDatas) override;

protected:

private:

    static constexpr const char *AgentIdPrefix()
    {return "stationary_object_";}

    void ConfigureMotions();

    std::vector<std::shared_ptr<actor::Obstacle>> mObjects;
    std::vector<motion::StationaryObjectConfig> mMotionConfigs;
};

} // namespace unit {

#endif // #ifndef _UNIT_STATIONARY_OBJECT_MODEL_H_
