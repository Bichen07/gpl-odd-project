#include <vector>
#include <limits>

class DistanceTransform {
private:
    std::vector<int> parabolaIdxs;
    std::vector<double> parabolaBoundaries;
    static constexpr double inf = std::numeric_limits<double>::infinity();

public:
    DistanceTransform(int maxSize);

    void DistanceSquared1D(const std::vector<double> & input, std::vector<double> & output);

    void DistanceSquared2D(std::vector<double> & input, int width, int height, int boundaryValue=99999);

    void Distance2D(std::vector<double> & input, int width, int height, int boundaryValue=99999);
};
