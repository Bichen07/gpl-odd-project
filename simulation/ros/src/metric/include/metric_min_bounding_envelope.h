#ifndef _METRIC_MIN_BOUNDING_ENVELOPE_H_
#define _METRIC_MIN_BOUNDING_ENVELOPE_H_

#include <vector>
#include <math_type.h>

namespace metric {

class MinBoundingEnvelope final
{

public:

    MinBoundingEnvelope();
    MinBoundingEnvelope(const MinBoundingEnvelope &) = delete;
    MinBoundingEnvelope &operator=(const MinBoundingEnvelope &) = delete;
    virtual ~MinBoundingEnvelope() = default;

    const std::vector<math::Vector3d_t> &GetRealPath() const;
    const std::vector<math::Vector3d_t> &GetSimPath() const;

    void Configure(const std::string &fileName);

protected:

private:

    std::vector<math::Vector3d_t> mRealPath;
    std::vector<math::Vector3d_t> mSimPath;
};

} // namespace metric {

#endif // #ifndef _METRIC_MIN_BOUNDING_ENVELOPE_H_
