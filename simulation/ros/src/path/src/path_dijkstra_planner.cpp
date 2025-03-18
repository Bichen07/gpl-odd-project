#include <path_dijkstra_planner.h>
#include <fstream>
#include <iterator>
#include <stdexcept>
#include <boost/graph/dijkstra_shortest_paths.hpp>
#include <ros/console.h>
#include <jsoncpp/json/json.h>

namespace path {

// public func.

DijkstraPlanner::DijkstraPlanner()
    : mConnectedLaneIdMap{}
    , mGraph{}
    , mEdgeSize{0ul}
{
}

void DijkstraPlanner::Configure(const std::string &lanesInfoFileName)
{
    this->ParseLanesInfo(
        lanesInfoFileName,
        mConnectedLaneIdMap);
    this->ConstructGraph(mConnectedLaneIdMap);
}

void DijkstraPlanner::Compute(
    const int32_t beginLaneId,
    const int32_t endLaneId,
    std::vector<int32_t> &outputConnectedLaneIds)
{
    VertexDescriptor sourceVertex = boost::vertex(beginLaneId, mGraph);
    std::vector<VertexDescriptor> predecessors(num_vertices(mGraph));
    std::vector<int32_t> distances(num_vertices(mGraph));
    dijkstra_shortest_paths(
        mGraph,
        sourceVertex,
        predecessor_map(boost::make_iterator_property_map(predecessors.begin(), boost::get(boost::vertex_index, mGraph))).
        distance_map(boost::make_iterator_property_map(distances.begin(), boost::get(boost::vertex_index, mGraph))));
    outputConnectedLaneIds.clear();
    outputConnectedLaneIds.reserve(predecessors.size());
    int32_t currentVertex{endLaneId};
    outputConnectedLaneIds.push_back(currentVertex);
    while (currentVertex != beginLaneId)
    {
        currentVertex = predecessors[currentVertex];
        outputConnectedLaneIds.push_back(currentVertex);
    }

    std::reverse(
        outputConnectedLaneIds.begin(),
        outputConnectedLaneIds.end());

    if (beginLaneId != outputConnectedLaneIds.front())
    {
        ROS_ERROR_STREAM(
            "wrong begin lane id: " << outputConnectedLaneIds.front() << ", " <<
            "the correct one is " << beginLaneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (endLaneId != outputConnectedLaneIds.back())
    {
        ROS_ERROR_STREAM(
            "wrong end lane id: " << outputConnectedLaneIds.back() << ", " <<
            "the correct one is " << endLaneId);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    if (!this->IsConnectedLaneIds(outputConnectedLaneIds))
    {
        ROS_ERROR_STREAM("not connected lane ids");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }
}

void DijkstraPlanner::Compute(
    const int32_t beginLaneId,
    const std::vector<int32_t> &viaLaneIds,
    const int32_t endLaneId,
    std::vector<int32_t> &outputConnectedLaneIds)
{
    std::vector<int32_t> subConnectedLaneIds;
    int32_t subBeginLaneId{beginLaneId};
    for (auto viaLaneId{viaLaneIds.cbegin()};
         viaLaneId != viaLaneIds.cend();
         ++viaLaneId)
    {
        this->Compute(
            subBeginLaneId,
            *viaLaneId,
            subConnectedLaneIds);
        subBeginLaneId = *viaLaneId;
        outputConnectedLaneIds.insert(
            outputConnectedLaneIds.cend(),
            subConnectedLaneIds.cbegin(),
            subConnectedLaneIds.cend() - 1);
    }

    this->Compute(
        subBeginLaneId,
        endLaneId,
        subConnectedLaneIds);
    outputConnectedLaneIds.insert(
        outputConnectedLaneIds.cend(),
        subConnectedLaneIds.cbegin(),
        subConnectedLaneIds.cend());
}

// protected func.

// private func.

void DijkstraPlanner::ParseLanesInfo(
    const std::string &lanesInfoFileName,
    ConnectedLaneIdMap &outputConnectedLaneIdMap)
{
    std::ifstream lanesInfoFileStream;
    lanesInfoFileStream.open(lanesInfoFileName, std::ifstream::in);
    if (!lanesInfoFileStream.good())
    {
        ROS_ERROR_STREAM("fail to open " << lanesInfoFileName);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    Json::Reader jsonReader;
    Json::Value lanesInfoJsonValue;
    jsonReader.parse(lanesInfoFileStream, lanesInfoJsonValue);
    lanesInfoFileStream.close();

    for (const auto &laneInfoValue: lanesInfoJsonValue["lanes"])
    {
        std::vector<int32_t> outputConnectedLaneIds(laneInfoValue["next_clane"].size());
        auto connectedLaneId{outputConnectedLaneIds.begin()};
        for (const auto &nextLaneId: laneInfoValue["next_clane"])
        {
            *connectedLaneId = nextLaneId.asInt();
            ++connectedLaneId;
        }

        outputConnectedLaneIdMap.insert(
            std::make_pair(laneInfoValue["id"].asInt(), outputConnectedLaneIds));
    }
}

void DijkstraPlanner::ConstructGraph(const ConnectedLaneIdMap &connectedLaneIdMap)
{
    mEdgeSize = this->ComputeEdgeSize(connectedLaneIdMap);
    std::vector<Edge> edges(mEdgeSize);
    auto edge{edges.begin()};
    for (auto laneIdPair{connectedLaneIdMap.cbegin()};
         laneIdPair != connectedLaneIdMap.cend();
         ++laneIdPair)
    {
        for (auto connectedLaneId{laneIdPair->second.cbegin()};
             connectedLaneId != laneIdPair->second.cend();
             ++connectedLaneId)
        {
            *edge = Edge(laneIdPair->first, *connectedLaneId);
            ++edge;
        }
    }

    std::vector<int32_t> edgeWeights(mEdgeSize, int32_t{1});
    mGraph = Graph(
        edges.data(),
        edges.data() + mEdgeSize,
        edgeWeights.data(),
        connectedLaneIdMap.size());
}

std::size_t DijkstraPlanner::ComputeEdgeSize(const ConnectedLaneIdMap &connectedLaneIdMap) const
{
    std::size_t edgeSize{0ul};
    for (auto laneIdPair{connectedLaneIdMap.cbegin()};
         laneIdPair != connectedLaneIdMap.cend();
         ++laneIdPair)
    {
        edgeSize += laneIdPair->second.size();
    }

    return edgeSize;
}

bool DijkstraPlanner::IsConnectedLaneIds(const std::vector<int32_t> &laneIds) const
{
    if (mConnectedLaneIdMap.empty())
    {
        ROS_ERROR_STREAM("mConnectedLaneIdMap is empty");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    auto laneId{laneIds.cbegin() + 1};
    for (; laneId != laneIds.cend(); ++laneId)
    {
        const auto foundConnectedLaneId{mConnectedLaneIdMap.find(*(laneId - 1))};
        if (mConnectedLaneIdMap.end() == foundConnectedLaneId)
        {
            ROS_ERROR_STREAM("invalid laneId: " << *(laneId - 1));
            throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        }

        const bool isConnectedLaneId{
            std::any_of(
                foundConnectedLaneId->second.cbegin(),
                foundConnectedLaneId->second.cend(),
                [&laneId](const int32_t nextLaneId)
                {return nextLaneId == *laneId;})};
        if (!isConnectedLaneId)
        {
            return isConnectedLaneId;
        }
    }

    return true;
}

void DijkstraPlanner::ExecuteSampleCode()
{
    typedef boost::adjacency_list<
        boost::listS, // OutEdgeList
        boost::vecS,  // VertexList
        boost::directedS, // Directed
        boost::no_property, // VertexProperties
        boost::property<boost::edge_weight_t, int> // EdgeProperty
            > graph_t;
    typedef boost::graph_traits<graph_t>::vertex_descriptor vertex_descriptor;
    typedef std::pair<int, int> Edge;

    const int num_nodes = 5;
    enum nodes { A, B, C, D, E };
    char name[] = "ABCDE";
    Edge edge_array[] =
    {
        Edge(A, C),
        Edge(B, B),
        Edge(B, D),
        Edge(B, E),
        Edge(C, B),
        Edge(C, D),
        Edge(D, E),
        Edge(E, A),
        Edge(E, B)
    };
    int weights[] = {1, 2, 1, 2, 7, 3, 1, 1, 1};
    int num_arcs = sizeof(edge_array) / sizeof(Edge);
    graph_t g(edge_array, edge_array + num_arcs, weights, num_nodes);
    boost::property_map<graph_t, boost::edge_weight_t>::type weightmap = get(boost::edge_weight, g);
    std::vector<vertex_descriptor> p(num_vertices(g));
    std::vector<int> d(num_vertices(g));
    int32_t source{C};
    //vertex_descriptor s = boost::vertex(A, g);
    vertex_descriptor s = boost::vertex(source, g);

    dijkstra_shortest_paths(
        g,
        s,
        predecessor_map(boost::make_iterator_property_map(p.begin(), boost::get(boost::vertex_index, g))).
        distance_map(boost::make_iterator_property_map(d.begin(), boost::get(boost::vertex_index, g))));

    std::cout << "distances and parents:" << std::endl;
    boost::graph_traits<graph_t>::vertex_iterator vi, vend;
    for (boost::tie(vi, vend) = vertices(g); vi != vend; ++vi)
    {
        std::cout << "distance(" << name[*vi] << ") = " << d[*vi] << ", ";
        std::cout << "parent(" << name[*vi] << ") = " << name[p[*vi]] << std::endl;
    }
    std::cout << std::endl;

    int32_t currentVertex = static_cast<int32_t>(E);
    while (currentVertex != source)
    {
        currentVertex = p[currentVertex];
        std::cout << "currentVertex: " << name[currentVertex] << std::endl;
    }

    //std::ofstream dot_file("figs/dijkstra-eg.dot");

    //dot_file << "digraph D {\n"
//    std::cout << "digraph D {\n"
//        << "  rankdir=LR\n"
//        << "  size=\"4,3\"\n"
//        << "  ratio=\"fill\"\n"
//        << "  edge[style=\"bold\"]\n" << "  node[shape=\"circle\"]\n";
//
//    boost::graph_traits<graph_t>::edge_iterator ei, ei_end;
//    for (boost::tie(ei, ei_end) = edges(g); ei != ei_end; ++ei)
//    {
//        boost::graph_traits<graph_t>::edge_descriptor e = *ei;
//        boost::graph_traits<graph_t>::vertex_descriptor
//            u = source(e, g), v = target(e, g);
//        //dot_file << name[u] << " -> " << name[v]
//        std::cout << name[u] << " -> " << name[v]
//            << "[label=\"" << get(weightmap, e) << "\"";
//        if (p[v] == u)
//        {
//            //dot_file << ", color=\"black\"";
//            std::cout << ", color=\"black\"";
//        }
//        else
//        {
//            //dot_file << ", color=\"grey\"";
//            std::cout << ", color=\"grey\"";
//        }
//        //dot_file << "]";
//        std::cout << "]";
//    }
    //dot_file << "}";
    std::cout << "}";
}

} // namespace path {
