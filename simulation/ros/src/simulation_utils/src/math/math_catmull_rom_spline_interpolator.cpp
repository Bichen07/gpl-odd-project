#include "math_catmull_rom_spline_interpolator.h"
#include "math_type.h"
#include "math_utils.h"

namespace math {

// public func.

CatmullRomSplineInterpolator::CatmullRomSplineInterpolator()
{
}

CatmullRomSplineInterpolator::~CatmullRomSplineInterpolator()
{
}

Vector3dColl_t CatmullRomSplineInterpolator::Compute(
        const Vector3d_t &point_1st,
        const Vector3d_t &point_2nd,
        const Vector3d_t &point_3rd,
        const Vector3d_t &point_4th,
        const int32_t size,
        const real_t tension
        ) const
{
    //const real_t unit_ratio = real_t{1.0} / boost::numeric_cast<real_t>(size);
    const real_t unit_ratio = real_t{1.0} / static_cast<real_t>(size);

    Vector3dColl_t output;
    output.reserve(size);

    for (int32_t idx = 0; idx < size; ++idx)
    {
        //const real_t ratio = boost::numeric_cast<real_t>(idx) * unit_ratio;
        const real_t ratio = static_cast<real_t>(idx) * unit_ratio;
        //const Vector3d_t interpolated_point
        const RowVectorNd_t interpolated_point
            = this->ComputeCoefMat(ratio)
            * this->ComputeBasisMat(tension)
            * this->ComputeControlVectorMat(point_1st, point_2nd, point_3rd, point_4th);
        
        output.push_back(interpolated_point.transpose());
    }

    return output;
}

// protected func.

// private func.

MatrixNd_t CatmullRomSplineInterpolator::ComputeCoefMat(const real_t ratio) const
{
    MatrixNd_t coef_mat = MatrixNd_t::Zero(1, 4);
    coef_mat(0) = math::Cube(ratio);
    coef_mat(1) = math::Square(ratio);
    coef_mat(2) = ratio;
    coef_mat(3) = real_t{1.0};

    //console::log(DBG) << "coef mat" << NEWLINE
    //    << coef_mat << NEWLINE
    //    << std::endl;

    return coef_mat;
}

MatrixNd_t CatmullRomSplineInterpolator::ComputeBasisMat(const real_t tension) const
{
    const Matrix_t<4, 4> basis_mat(
            (
             Matrix_t<4, 4>()
                 << -tension, real_t{2.0} - tension, tension - real_t{2.0}, tension,
                    real_t{2.0} * tension, tension - real_t{3.0}, real_t{3.0} - real_t{2.0} * tension, -tension,
                    -tension, real_t{0.0}, tension, real_t{0.0},
                    real_t{0.0}, real_t{1.0}, real_t{0.0}, real_t{0.0}
            ).finished()
            );

    //console::log(DBG) << "basis mat" << NEWLINE
    //    << basis_mat << NEWLINE
    //    << std::endl;

    return basis_mat;
}

MatrixNd_t CatmullRomSplineInterpolator::ComputeControlVectorMat(
        const Vector3d_t &point_1st,
        const Vector3d_t &point_2nd,
        const Vector3d_t &point_3rd,
        const Vector3d_t &point_4th
        ) const
{
    MatrixNd_t control_vector_mat = MatrixNd_t::Zero(4, 3);
    control_vector_mat.row(0) = point_1st.transpose();
    control_vector_mat.row(1) = point_2nd.transpose();
    control_vector_mat.row(2) = point_3rd.transpose();
    control_vector_mat.row(3) = point_4th.transpose();

    //console::log(DBG) << "control vector mat" << NEWLINE
    //    << control_vector_mat << NEWLINE
    //    << "point_1st: " << point_1st.transpose() << NEWLINE
    //    << "point_2nd: " << point_2nd.transpose() << NEWLINE
    //    << "point_3rd: " << point_3rd.transpose() << NEWLINE
    //    << "point_4th: " << point_4th.transpose() << NEWLINE
    //    << std::endl;

    return control_vector_mat;
}

} // namespace math {
