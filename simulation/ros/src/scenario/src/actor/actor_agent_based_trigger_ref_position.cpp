#include <actor_agent_based_trigger_ref_position.h>
#include <typeinfo>
#include <ros/console.h>

namespace actor {

// public func.

AgentBasedTriggerRefPosition::AgentBasedTriggerRefPosition()
    : motion::TriggerRefPosition()
    , mAgent{nullptr}
{
}

AgentBasedTriggerRefPosition::AgentBasedTriggerRefPosition(const Agent::Ptr &agent)
    : motion::TriggerRefPosition()
    , mAgent{agent}
{
}

motion::TriggerRefPosition::TypeId AgentBasedTriggerRefPosition::GetTypeId() const
{
    return motion::TriggerRefPosition::Type::AgentBased;
}

geometry::Vector3d AgentBasedTriggerRefPosition::Evaluate()
{
    return mAgent->GetState().position;
}

void AgentBasedTriggerRefPosition::Configure(const boost::any &config)
{
    try
    {
        mAgent = boost::any_cast<actor::Agent::Ptr>(config);
    }
    catch (const boost::bad_any_cast &ex)
    {
        ROS_ERROR_STREAM(
            ex.what() << '\n' <<
            "config type: " << config.type().name() << '\n' <<
            "actor::Agent:Ptr: " << typeid(actor::Agent::Ptr).name());
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

// protected func.

// private func.

} // namespace actor {
