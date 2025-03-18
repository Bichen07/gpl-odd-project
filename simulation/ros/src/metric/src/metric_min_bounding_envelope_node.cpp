#include <metric_min_bounding_envelope_node.h>
#include <ros/console.h>
#include <utils_default_color.h>
#include <utils_ros_param.h>
#include <iostream>
#include <fstream>
#include <jsoncpp/json/json.h>

namespace metric {

// public func.

MinBoundingEnvelopeNode::MinBoundingEnvelopeNode()
    : mNodeHandle{}
    , mRealPathMarkerPublisher{}
    , mSimPathMarkerPublisher{}
    , mMinBoundingEnvelope{}
    , mLcss{}
    , mUnmatchedSubLcss{}
    , mLcssMatchedSubTrajectoryEvaluator{}
    , mLcssUnmatchedSubTrajectoryEvaluator{}
    , mTrajectoryErrorEvaluator{}
    , mMatchedSubTrajectories{}
    , mAuxiliaryVisualizer{}
{
}

void MinBoundingEnvelopeNode::Configure()
{
    const std::string targetFileName = utils::GetRosParam<std::string>(
        "metric/min_bounding_envelope_file_name");
    ROS_DEBUG_STREAM_COND(
        false,
        "targetFileName: " << targetFileName);
    mMinBoundingEnvelope.Configure(targetFileName);

    const double lcssDist = mLcss.ComputeDistance(
        mMinBoundingEnvelope.GetRealPath(),
        mMinBoundingEnvelope.GetSimPath(),
        math::real_t{0.4});

    ROS_DEBUG_STREAM_COND(
        true,
        "lcss distance: " << lcssDist);

    mLcssMatchedSubTrajectoryEvaluator.Compute(
        mMinBoundingEnvelope.GetRealPath(),
        mMinBoundingEnvelope.GetSimPath(),
        mLcss.GetMatchedTrajectoryIndexes());

    mLcssUnmatchedSubTrajectoryEvaluator.Compute(
        mMinBoundingEnvelope.GetRealPath(),
        mMinBoundingEnvelope.GetSimPath(),
        mLcss.GetMatchedTrajectoryIndexes());

    const bool isUnmatchedTrajectoriesEqualSize{
        mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().first.size() ==
        mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().second.size()};
    if (!isUnmatchedTrajectoriesEqualSize)
    {
        ROS_WARN_STREAM(
            "diff. sizes between unmatched trajectory size" << '\n' <<
            "the real one: " <<
            mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().first.size() << '\n' <<
            "the sim one: " <<
            mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().second.size());
        return;
    }

//    Json::Value rootValue = Json::objectValue;
//    rootValue["Matched Indice"] = Json::objectValue;
//    rootValue["Matched Indice"]["real"] = Json::arrayValue;
//    rootValue["Matched Indice"]["sim"] = Json::arrayValue;
//    for (auto & idx: mLcss.GetMatchedTrajectoryIndexes().first)
//    {
//        rootValue["Matched Indice"]["real"].append(idx);
//    }
//    for (auto & idx: mLcss.GetMatchedTrajectoryIndexes().second)
//    {
//        rootValue["Matched Indice"]["sim"].append(idx);
//    }
    
//    Json::StreamWriterBuilder builder;
//    builder["commentStyle"] = "None";
//    builder["indentation"] = "   ";
//    std::unique_ptr<Json::StreamWriter> writer(builder.newStreamWriter());
//    //std::ofstream outputFileStream("/project/mmsl_simulation/src/metric/data/matched_indice.json");
//    std::ofstream outputFileStream("/project/simulation/src/metric/data/matched_indice.json");
//    writer -> write(rootValue, &outputFileStream);

    const auto &unmatchedSubTrajectories1st{
        mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().first};
    const auto &unmatchedSubTrajectories2nd{
        mLcssUnmatchedSubTrajectoryEvaluator.GetUnmatchedSubTrajectories().second};
    auto unmatchedSubTrajectory1st{unmatchedSubTrajectories1st.cbegin()};
    auto unmatchedSubTrajectory2nd{unmatchedSubTrajectories2nd.cbegin()};
    for (; unmatchedSubTrajectory1st != unmatchedSubTrajectories1st.cend();
         ++unmatchedSubTrajectory1st, ++unmatchedSubTrajectory2nd)
    {
        const auto error{
            mTrajectoryErrorEvaluator.Compute(
                *unmatchedSubTrajectory1st,
                *unmatchedSubTrajectory2nd)};

        ROS_DEBUG_STREAM_COND(
            true,
            "error: " << error << '\n' <<
            "1st size: " << unmatchedSubTrajectory1st->size() << '\n' <<
            "2nd size: " << unmatchedSubTrajectory2nd->size());
    }
}

void MinBoundingEnvelopeNode::RunMainLoop()
{
    ros::Rate nodeRate(10.0);
    while (ros::ok())
    {
        this->PublishVisualization();
        ros::spinOnce();
        nodeRate.sleep();
    }
}

void MinBoundingEnvelopeNode::PublishVisualization()
{
    std_msgs::ColorRGBA realPathColor;
    realPathColor.r = 0.8f;
    realPathColor.g = 0.4f;
    realPathColor.b = 0.4f;
    realPathColor.a = 1.0f;
    std_msgs::ColorRGBA simPathColor;
    simPathColor.r = 0.4f;
    simPathColor.g = 0.8f;
    simPathColor.b = 0.4f;
    simPathColor.a = 1.0f;
    mAuxiliaryVisualizer.AppendLineStripMarker(
        utils::LineStripMarker{
        .id = "metric_real_path",
        .points = mMinBoundingEnvelope.GetRealPath(),
        .scale = .11,
        .lifeTime = ros::Duration(),
        .color = realPathColor});
        //.color = utils::Brown()});

    mAuxiliaryVisualizer.AppendLineStripMarker(
        utils::LineStripMarker{
            .id = "metric_sim_path",
            .points = mMinBoundingEnvelope.GetSimPath(),
            .scale = .11,
            .lifeTime = ros::Duration(),
            .color = simPathColor});
            //.color = utils::Purple()});

    const auto &matchedTrajectories1st{
        mLcssMatchedSubTrajectoryEvaluator.GetMatchedSubTrajectories().first};
    for (auto matchedTrajectory1st{matchedTrajectories1st.cbegin()};
         matchedTrajectory1st != matchedTrajectories1st.cend();
         ++matchedTrajectory1st)
    {
        const auto traj1stIdx{
            std::distance(
                matchedTrajectories1st.cbegin(),
                matchedTrajectory1st)};
        const std::string matchedTrajectory1stId{
            "metric_matched_trajectory_1st_" +
            std::to_string(traj1stIdx)};

        std::vector<math::Vector3d_t> offsetTrajectory(
            *matchedTrajectory1st);
        std::transform(
            matchedTrajectory1st->cbegin(),
            matchedTrajectory1st->cend(),
            offsetTrajectory.begin(),
            [](const math::Vector3d_t &input)
            {return input + math::Vector3d_t::UnitZ();});

        mAuxiliaryVisualizer.AppendLineStripMarker(
            utils::LineStripMarker{
                .id = matchedTrajectory1stId,
                //.points = *matchedTrajectory1st,
                .points = offsetTrajectory,
                .scale = 0.38,
                .lifeTime = ros::Duration(),
                .color = utils::DarkOrange()});
    }

    const auto &matchedTrajectories2nd{
        mLcssMatchedSubTrajectoryEvaluator.GetMatchedSubTrajectories().second};
    for (auto matchedTrajectory2nd{matchedTrajectories2nd.cbegin()};
         matchedTrajectory2nd != matchedTrajectories2nd.cend();
         ++matchedTrajectory2nd)
    {
        const auto traj2ndIdx{
            std::distance(
                matchedTrajectories2nd.cbegin(),
                matchedTrajectory2nd)};
        const std::string matchedTrajectory2ndId{
            "metric_matched_trajectory_2nd_" +
            std::to_string(traj2ndIdx)};

        std::vector<math::Vector3d_t> offsetTrajectory(
            *matchedTrajectory2nd);
        std::transform(
            matchedTrajectory2nd->cbegin(),
            matchedTrajectory2nd->cend(),
            offsetTrajectory.begin(),
            [](const math::Vector3d_t &input)
            {return input + math::Vector3d_t::UnitZ();});

        mAuxiliaryVisualizer.AppendLineStripMarker(
            utils::LineStripMarker{
                .id = matchedTrajectory2ndId,
                //.points = *matchedTrajectory2nd,
                .points = offsetTrajectory,
                .scale = 0.38,
                .lifeTime = ros::Duration(),
                .color = utils::DarkOrange()});
    }

    mAuxiliaryVisualizer.Publish();
}

// protected func.

// private func.

} // namespace metric {
