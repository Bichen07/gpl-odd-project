#pragma once

#include <vector>

/** The Reeds-Shepp path cost types */
enum class CostType {CONNECT_FORWARD = 0, CONNECT_BACKWARD = 1};

template <class State>
class Steer {
public:
    virtual bool steer(const State * start, const State * end) = 0;
    virtual std::vector<State> sample(double resolution) = 0;
    virtual double cost(CostType type, double preLength) = 0;
    virtual double backwardCost() = 0;
    virtual int cusp() = 0;
    virtual double firstLength() = 0;
    virtual double lastLength() = 0;
    virtual double* segLength() = 0;
    virtual double totalLength() = 0;
    virtual double curve() = 0;
    virtual double distance() = 0;
    virtual State interpolateDistance(double t) = 0;
    virtual double lowerBoundCost(const State * sate, const State * end) const = 0;
};
