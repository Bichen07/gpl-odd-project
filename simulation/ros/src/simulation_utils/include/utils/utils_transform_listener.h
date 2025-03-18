#ifndef _UTLIS_TRANSFORM_LISTERER_H_
#define _UTLIS_TRANSFORM_LISTERER_H_

#include <string>
#include <utility>
#include <map>
#include <tf/tf.h>
#include <tf/transform_listener.h>

namespace utils {

class TransformListener final
{

public:

    using SourceTargetFramePair = std::pair<std::string, std::string>;
    using TransformMap = std::map<SourceTargetFramePair, tf::Transform>;

    TransformListener();
    TransformListener(const TransformListener &) = delete;
    TransformListener &operator=(const TransformListener &) = delete;
    virtual ~TransformListener() = default;

    void Configure(const TransformMap &initTransformMap);
    void AppendInitTransform(
        const SourceTargetFramePair &sourceTargetFramePair,
        const tf::Transform &initTransform);
    void Run(
        const std::string &targetFrame,
        const std::string &sourceFrame,
        const ros::Time &stamp,
        tf::StampedTransform *transform);

protected:

private:

    bool IsValidFramePair(const SourceTargetFramePair &sourceTargetFramePair) const;

    tf::TransformListener mTransformListener;
    TransformMap mInitTransformMap;
};

} // namespace utils {

#endif // #ifndef _UTLIS_TRANSFORM_LISTERER_H_
