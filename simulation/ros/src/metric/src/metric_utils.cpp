#include <metric_utils.h>

namespace metric {

void ExtractTrajectories(
    const Trajectory &wholeTrajectory,
    const std::vector<Indexes> &indexesSet,
    Trajectories &outputTrajectories)
{
    outputTrajectories.resize(indexesSet.size());
    auto indexes{indexesSet.cbegin()};
    auto outputTrajectory{outputTrajectories.begin()};
    for (; indexes != indexesSet.cend(); ++indexes, ++outputTrajectory)
    {
        outputTrajectory->resize(indexes->size());
        auto idx{indexes->cbegin()};
        auto point{outputTrajectory->begin()};
        for (; idx != indexes->cend(); ++idx, ++point)
        {
            *point = wholeTrajectory.at(*idx);
        }
    }
}

} // namespace metric {
