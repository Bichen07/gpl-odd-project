#ifndef _ACTOR_AGENT_BASED_TRIGGER_REF_POSITION_H_
#define _ACTOR_AGENT_BASED_TRIGGER_REF_POSITION_H_

#include <motion_trigger_ref_position.h>
#include <actor_agent.h>

namespace actor {

class AgentBasedTriggerRefPosition final : public motion::TriggerRefPosition
{

public:

    typedef std::shared_ptr<AgentBasedTriggerRefPosition> Ptr;

    AgentBasedTriggerRefPosition();
    explicit AgentBasedTriggerRefPosition(const Agent::Ptr &agent);
    AgentBasedTriggerRefPosition(const AgentBasedTriggerRefPosition &) = delete;
    AgentBasedTriggerRefPosition &operator=(const AgentBasedTriggerRefPosition &) = delete;
    virtual ~AgentBasedTriggerRefPosition() = default;

    virtual motion::TriggerRefPosition::TypeId GetTypeId() const override;
    virtual geometry::Vector3d Evaluate() override;

    virtual void Configure(const boost::any &config);

protected:

private:

    Agent::Ptr mAgent;
};

} // namespace actor {

#endif // #ifndef _ACTOR_AGENT_BASED_TRIGGER_REF_POSITION_H_
