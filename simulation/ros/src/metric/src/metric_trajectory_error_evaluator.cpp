#include <metric_trajectory_error_evaluator.h>
#include <ros/console.h>

namespace metric {

// public func.

TrajectoryErrorEvaluator::TrajectoryErrorEvaluator()
{
}

math::real_t TrajectoryErrorEvaluator::Compute(
    const Trajectory &traj1st,
    const Trajectory &traj2nd) const
{
    math::MatrixNd_t errorMat(traj1st.size(), traj2nd.size());
    ROS_DEBUG_STREAM_COND(
        false,
        "errorMatrix size: " << errorMat.rows() <<
        ", " << errorMat.cols());

    for (int32_t rowIdx{0}; rowIdx < errorMat.rows(); ++rowIdx)
    {
        for (int32_t colIdx{0}; colIdx < errorMat.cols(); ++colIdx)
        {
            const math::Vector2d_t point1st(
                traj1st.at(rowIdx).x(), traj1st.at(rowIdx).y());
            const math::Vector2d_t point2nd(
                traj2nd.at(colIdx).x(), traj2nd.at(colIdx).y());
            errorMat(rowIdx, colIdx) = (point1st - point2nd).norm();
        }
    }

    return this->ComputeMinError(errorMat);
}

// protected func.

// private func.

math::real_t TrajectoryErrorEvaluator::ComputeMinError(
    const math::MatrixNd_t &errorMat) const
{
    math::real_t rowDirAccumulatedError{0.0};
    for (int32_t rowIdx{0}; rowIdx < errorMat.rows(); ++rowIdx)
    {
        rowDirAccumulatedError += errorMat.row(rowIdx).minCoeff();
    }

    const math::real_t rowDirError =
        rowDirAccumulatedError / static_cast<math::real_t>(errorMat.rows());

    math::real_t colDirAccumulatedError{0.0};
    for (int32_t colIdx{0}; colIdx < errorMat.cols(); ++colIdx)
    {
        colDirAccumulatedError += errorMat.col(colIdx).minCoeff();
    }

    const math::real_t colDirError =
        colDirAccumulatedError / static_cast<math::real_t>(errorMat.cols());

    ROS_DEBUG_STREAM_COND(
        true,
        "rowDirError: " << rowDirError << ", colDirError: " << colDirError);

    return rowDirError < colDirError ? rowDirError : colDirError;
}

} // namespace metric {
