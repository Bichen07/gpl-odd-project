#ifndef _CARLA_ACTOR_UPDATE_DATA_H_
#define _CARLA_ACTOR_UPDATE_DATA_H_

#include <string>
#include <math_type.h>

namespace carla {

struct ActorUpdateData final
{
    std::string id;
    math::HomoXfm3d_t pose;
    bool isStationary;

    ActorUpdateData()
        : id{}
        , pose{math::HomoXfm3d_t::Identity()}
        , isStationary{false}
    {
    }
    ActorUpdateData(
        const std::string &inputId,
        const math::HomoXfm3d_t &inputPose,
        const bool inputIsStationary)
        : id{inputId}
        , pose{inputPose}
        , isStationary{inputIsStationary}
    {
    }
    ActorUpdateData(const ActorUpdateData &) = default;
    ActorUpdateData &operator=(const ActorUpdateData &) = default;
    ~ActorUpdateData() = default;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const ActorUpdateData &actorUpdateData)
{
    ostream << "id: " << actorUpdateData.id << '\n' <<
        "pose: " << actorUpdateData.pose << '\n' <<
        "isStationary: " << actorUpdateData.isStationary;
    return ostream;
}

} // namespace carla {

#endif // #ifndef _CARLA_ACTOR_UPDATE_DATA_H_
