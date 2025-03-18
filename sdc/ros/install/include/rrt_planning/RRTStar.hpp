#ifndef RRT_STAR_HPP
#define RRT_STAR_HPP

#include <list>
#include <ros/ros.h>
#include <functional>

#include <rrt_planning/Steer/Steer.hpp>
#include <rrt_planning/Occupancy/Occupancy.hpp>

enum class RRTType
{
    Start_side = 0,
    Goal_side = 1
};

template <class State>
class RRTStar {
public:
    struct Node {
        State state;
        Node * parent;
        std::vector<Node *> children;
        double cost;
        double segmentCost; // the cost from parent to node
        double curve = 0;
        double segmentCurve = 0;
        double firstLength = 0;
        double lastLength = 0;
    };

private:
    Steer<State> * steer;
    Steer<State> * CCsteer;
    const Occupancy<State> * occupancy;
    std::function<State(void)> sampleState;
    State start;
    State goal;

    double searchRadius;

    // nodes is a list so pointers don't get invalidated
    // as it changes size.
    std::list<Node> nodes;

    Node * InitNode(const State & state, Node * parent, double cost, double segmentCost, 
            double curve, double segmentCurve, double firstLength, double lastLength);
    Node * GrowTree(const RRTType & type, const State & rand);
    void Rewire(const RRTType & type, Node * randNode);
    void UpdateCosts(Node * node);

    Node * ccGrowTree(const State & rand);
    void ccRewire(Node * randNode);

public:
    RRTStar() {};
    /**
     * Initialize the RRTStar algorithm.
     *
     * @param steer Determines feasible paths between states in free space.
     * @param occupancy Determines whether a state is in free space.
     * @param stateSampler Samples states in free space.
     */
    RRTStar(
        Steer<State> * steer_,
        Steer<State> * CCsteer_,
        const Occupancy<State> * occupancy_,
        std::function<State(void)> sampleState_,
        const State & start,
        const State & goal,
        double searchRadius_);

    /**
     * Perform one iteration of the RRTStar algorithm
     *
     * This generates a single random sample and attempts
     * to add it to the tree of paths.
     *
     * @returns True iff the random sample is added to the tree
     */
    Node* iterate();
    Node* iterate(const State &);
    Node* iterate_backward(const State &);
    Node* iterate(const Node*);

    Node* cciterate(const State &);

    const Node & root() const {return nodes.front();};

    const std::list<Node> & GetNodes() const {return nodes;};

    /**
     * Sample the path at approximately the given resolution.
     */
    std::vector<State> SamplePath(const Node *, double) const;
    std::vector<State> SampleNode(std::vector<State> roughPath, double resolution) const;
    std::vector<State> SampleCCNode(std::vector<State> roughPath, double resolution) const;
    std::vector<State> SampleDivision(std::vector<State> roughPath, double resolution) const;
    std::vector<std::vector<State>> SampleTree(double) const;
    std::vector<State> ExtractPath(const RRTType & type, Node* end);
    std::vector<State> RRTGreedy(std::vector<State> const &, double, int);
    std::vector<State> ExtractForwardWaypoint(std::vector<State> const &);
    std::vector<State> RRTBackwardPath(std::vector<State> path);
    std::vector<State> ExtractBackwardWaypoint(std::vector<State> const &);
    std::vector<std::vector<State>> ExtractForwardPath(std::vector<State>);
    std::vector<std::vector<State>> ExtractBackwardPath(std::vector<State>);
    std::vector<std::vector<State>> RRTPathCombination(
        std::vector<std::vector<State>> forwardVector,
        std::vector<std::vector<State>> backwardVector,
        std::vector<State> path,
        std::vector<int> & directionVector);

    std::vector<State> SampleCusp(std::vector<State> path) const;
};

#endif // RRT_STAR_HPP
