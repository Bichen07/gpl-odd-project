#ifndef _MAP_PATH_PLANNER_H_
#define _MAP_PATH_PLANNER_H_

#include <map>
#include <vector>
#include <string>
#include <utility>
#include <boost/config.hpp>
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/property_map/property_map.hpp>

namespace map {

class PathPlanner final
{

public:

    PathPlanner();
    PathPlanner(const PathPlanner &) = delete;
    PathPlanner &operator=(const PathPlanner &) = delete;
    virtual ~PathPlanner() = default;

    void Configure(const std::string &lanesInfoFileName);
    void Compute(
        const int32_t beginLaneId,
        const int32_t endLaneId,
        std::vector<int32_t> &connectedLaneIds);

protected:

private:

    using ConnectedLaneIdMap = std::map<int32_t, std::vector<int32_t>>;
    using Graph = boost::adjacency_list<
        boost::listS, // OutEdgeList
        boost::vecS,  // VertexList
        boost::directedS, // Directed
        boost::no_property, // VertexProperties
        boost::property<boost::edge_weight_t, int> // EdgeProperty
        >;
    using Edge = std::pair<int32_t, int32_t>;
    using VertexDescriptor = boost::graph_traits<Graph>::vertex_descriptor;

    void ParseLanesInfo(
        const std::string &lanesInfoFileName,
        ConnectedLaneIdMap &outputConnectedLaneIdMap);
    void ConstructGraph(const ConnectedLaneIdMap &connectedLaneIdMap);
    std::size_t ComputeEdgeSize(const ConnectedLaneIdMap &connectedLaneIdMap) const;
    bool IsConnectedLaneIds(const std::vector<int32_t> &laneIds) const;

    void ExecuteSampleCode();

    ConnectedLaneIdMap mConnectedLaneIdMap;
    Graph mGraph;
    std::size_t mEdgeSize;
};

} // namespace map {

#endif // #ifndef _MAP_PATH_PLANNER_H_
