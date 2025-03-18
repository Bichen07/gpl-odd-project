#ifndef _RSS_INTERSECTION_MANAGER_H_
#define _RSS_INTERSECTION_MANAGER_H_

#include <vector>
#include <geometry_transform_3d.h>
#include <geometry_vector_3d.h>
#include <geometry_intersection_evaluator.h>
#include <rss_intersection.h>

namespace rss {

class IntersectionManager final
{

public:

    IntersectionManager();
    IntersectionManager(const IntersectionManager &) = delete;
    IntersectionManager &operator=(const IntersectionManager &) = delete;
    virtual ~IntersectionManager() = default;

    const std::vector<int32_t> &GetIds() const;
    const std::vector<Intersection::Ptr> &GetIntersections() const;

    void Configure(const std::string &fileName);
    const Intersection::Ptr QueryIntersection(const int32_t id) const;
    bool HasOverlapping(
        const geometry::Transform3d &targetTransform,
        const geometry::Vector3d &targetSize) const;

protected:

private:

    std::vector<Intersection::Ptr> mIntersections;
    std::vector<int32_t> mValidIds;
    geometry::IntersectionEvaluator mIntersectionEvaluator;
};

} // namespace rss {

#endif // #ifndef _RSS_INTERSECTION_MANAGER_H_
