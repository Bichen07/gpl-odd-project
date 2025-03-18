#ifndef _MAP_TRAFFIC_LIGHT_H_
#define _MAP_TRAFFIC_LIGHT_H_

#include <vector>
#include <math_type.h>

namespace map {

class TrafficLight final
{

public:

    TrafficLight();
    explicit TrafficLight(
        const int32_t inputId,
        const std::vector<math::Vector3d_t> &inputCorner3ds);
    TrafficLight(const TrafficLight &other);
    TrafficLight &operator=(const TrafficLight &other);
    virtual ~TrafficLight() = default;

    int32_t GetId() const;
    const std::vector<math::Vector3d_t> &GetCorner3ds() const;
    const math::HomoXfm3d_t &GetPose() const;

    void Configure(
        const int32_t id,
        const std::vector<math::Vector3d_t> &inputCorner3ds);

protected:

private:

    void ComputeLocalXyAxes(
        const std::vector<math::Vector3d_t> &inputCorner3ds,
        math::Vector3d_t &outputNormalX,
        math::Vector3d_t &outputNormalY) const;

    int32_t mId;
    std::vector<math::Vector3d_t> mCorner3ds;
    math::HomoXfm3d_t mPose;
};

} // namespace map {

#endif // #ifndef _MAP_TRAFFIC_LIGHT_H_
