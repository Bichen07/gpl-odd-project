#ifndef _METRIC_MIN_BOUDNING_ENVELOPE_NODE_H_
#define _METRIC_MIN_BOUDNING_ENVELOPE_NODE_H_

#include <ros/ros.h>
#include <utils_auxiliary_visualizer.h>
#include <metric_lcss_matched_sub_trajectory_evaluator.h>
#include <metric_lcss_unmatched_sub_trajectory_evaluator.h>
#include <metric_longest_common_subsequence.h>
#include <metric_min_bounding_envelope.h>
#include <metric_trajectory_error_evaluator.h>

namespace metric {

class MinBoundingEnvelopeNode final
{

public:

    MinBoundingEnvelopeNode();
    MinBoundingEnvelopeNode(const MinBoundingEnvelopeNode &) = delete;
    MinBoundingEnvelopeNode &operator=(const MinBoundingEnvelopeNode &) = delete;
    virtual ~MinBoundingEnvelopeNode() = default;

    void Configure();
    void RunMainLoop();
    void PublishVisualization();

protected:

private:

    ros::NodeHandle mNodeHandle;
    ros::Publisher mRealPathMarkerPublisher;
    ros::Publisher mSimPathMarkerPublisher;
    MinBoundingEnvelope mMinBoundingEnvelope;
    LongestCommonSubsequence mLcss;
    LongestCommonSubsequence mUnmatchedSubLcss;
    LcssMatchedSubTrajectoryEvaluator mLcssMatchedSubTrajectoryEvaluator;
    LcssUnmatchedSubTrajectoryEvaluator mLcssUnmatchedSubTrajectoryEvaluator;
    TrajectoryErrorEvaluator mTrajectoryErrorEvaluator;
    std::pair<Trajectories, Trajectories> mMatchedSubTrajectories;
    utils::AuxiliaryVisualizer mAuxiliaryVisualizer;
};

} // namespace metric {

#endif // #ifndef _METRIC_MIN_BOUDNING_ENVELOPE_NODE_H_
