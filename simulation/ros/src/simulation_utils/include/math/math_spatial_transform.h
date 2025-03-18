#ifndef _MATH_SPATIAL_TRANSFORM_H_
#define _MATH_SPATIAL_TRANSFORM_H_

#include "math_def.h"
#include "Eigen/Dense"
#include "math_col_vector_3d.h"

namespace math {

template<typename Scalar> class ColVector3d;

template<typename Scalar>
class SpatialTransform final
{

public:

    typedef Scalar RealScalar;
    typedef Eigen::Matrix<Scalar, 6, 6> Result_t;
    typedef Eigen::Matrix<Scalar, 4, 4> HomoXfm3d_t;
    typedef Eigen::Matrix<Scalar, 3, 3> SubMat_t;
    typedef SubMat_t RotMat3d_t;
    typedef ColVector3d<Scalar> Xlt3d_t;

    explicit SpatialTransform(
            const RotMat3d_t &rotmat_a_to_b,
            const Xlt3d_t &xlt_a_to_b_in_coord_a
            );
    explicit SpatialTransform(const HomoXfm3d_t &xfm_a_to_b);
    SpatialTransform(const SpatialTransform &other);
    SpatialTransform &operator=(const SpatialTransform &other);
    virtual ~SpatialTransform();
    /**
     * \brief
     * \return
     */
    RotMat3d_t rotmat() const;
    /**
     * \brief
     * \return
     */
    Xlt3d_t xlt() const;
    /**
     * return X,
     * transformation from A to B motion space
     */
    Result_t xfm() const;
    /**
     * Return X* = X^{-T}, inverse then transpose,
     * transformation from A to B force space,
     * to avoid singularity when Xlt -> zero,
     * use RotMat & Xlt to compute Dual instead of xfm().inverse().transpose()
     */
    Result_t dual() const;
    /**
     * return X^{-1}, inverse,
     * transformation from B to A motion space
     * to avoid singularity when Xlt -> zero
     * use RotMat & Xlt to compute inverse instead of xfm().inverse()
     */
    Result_t inverse() const;
    /**
     * return {X^{-1}}^{-T}, inverse -> inverse ->transpose, equal to X^{T},
     * transformation from B to A force space,
     */
    Result_t inverse_dual() const;

protected:

private:

    static RotMat3d_t EvalCrossMat(const Xlt3d_t &vector3d);

    RotMat3d_t rotmat_;
    Xlt3d_t xlt_;
    RotMat3d_t xlt_cross_mat_;
    Result_t xfm_;
};

} // namespace math {

namespace math {

// public func.

template<typename Scalar>
SpatialTransform<Scalar>::SpatialTransform(
        const typename SpatialTransform<Scalar>::RotMat3d_t &rotmat_a_to_b,
        const typename SpatialTransform<Scalar>::Xlt3d_t &xlt_a_to_b_in_coord_a
        )
    :rotmat_(rotmat_a_to_b),
    xlt_(xlt_a_to_b_in_coord_a),
    xlt_cross_mat_(RotMat3d_t::Zero()),
    xfm_(Result_t::Zero())
{
    xlt_cross_mat_ = this->EvalCrossMat(xlt_);

    xfm_.topLeftCorner(3, 3) = rotmat_;
    xfm_.bottomRightCorner(3, 3) = rotmat_;
    xfm_.bottomLeftCorner(3, 3) = -rotmat_ * xlt_cross_mat_;
}

template<typename Scalar>
SpatialTransform<Scalar>::SpatialTransform(
        const typename SpatialTransform<Scalar>::HomoXfm3d_t &xfm_a_to_b
        )
    :rotmat_(RotMat3d_t::Zero()),
    xlt_(Xlt3d_t::Zero()),
    xlt_cross_mat_(RotMat3d_t::Zero()),
    xfm_(Result_t::Zero())
{
    rotmat_ = xfm_a_to_b.topLeftCorner(3, 3);
    xlt_ = -rotmat_.transpose() * xfm_a_to_b.col(3).head(3);
    xlt_cross_mat_ = this->EvalCrossMat(xlt_);

    xfm_.topLeftCorner(3, 3) = rotmat_;
    xfm_.bottomRightCorner(3, 3) = rotmat_;
    xfm_.bottomLeftCorner(3, 3) = -rotmat_ * xlt_cross_mat_;
}

template<typename Scalar>
SpatialTransform<Scalar>::SpatialTransform(const SpatialTransform<Scalar> &other)
    :rotmat_(other.rotmat()),
    xlt_(other.xlt()),
    xlt_cross_mat_(this->EvalCrossMat(xlt_)),
    xfm_(other.xfm())
{
}

template<typename Scalar>
SpatialTransform<Scalar> &SpatialTransform<Scalar>::operator=(
        const SpatialTransform<Scalar> &other
        )
{
    if (&other == this)
    {
        return *this;
    }

    rotmat_ = other.rotmat();
    xlt_ = other.xlt();
    xlt_cross_mat_ = this->EvalCrossMat(xlt_);
    xfm_ = other.xfm();

    return *this;
}

template<typename Scalar>
SpatialTransform<Scalar>::~SpatialTransform()
{
}

template<typename Scalar>
typename SpatialTransform<Scalar>::RotMat3d_t SpatialTransform<Scalar>::rotmat() const
{
    return rotmat_;
}

template<typename Scalar>
typename SpatialTransform<Scalar>::Xlt3d_t SpatialTransform<Scalar>::xlt() const
{
    return xlt_;
}

template<typename Scalar>
typename SpatialTransform<Scalar>::Result_t SpatialTransform<Scalar>::xfm() const
{
    return xfm_;
}

template<typename Scalar>
typename SpatialTransform<Scalar>::Result_t SpatialTransform<Scalar>::dual() const
{
    Result_t dual_mat(Result_t::Zero());

    dual_mat.topLeftCorner(3, 3) = rotmat_;
    dual_mat.bottomRightCorner(3, 3) = rotmat_;
    dual_mat.topRightCorner(3, 3) = -rotmat_ * xlt_cross_mat_;

    return dual_mat;
}

template<typename Scalar>
typename SpatialTransform<Scalar>::Result_t SpatialTransform<Scalar>::inverse() const
{
    Result_t inverse_mat(Result_t::Zero());

    inverse_mat.topLeftCorner(3, 3) = rotmat_.transpose();
    inverse_mat.bottomRightCorner(3, 3) = rotmat_.transpose();
    inverse_mat.bottomLeftCorner(3, 3) = xlt_cross_mat_ * rotmat_.transpose();

    return inverse_mat;
}

template<typename Scalar>
typename SpatialTransform<Scalar>::Result_t SpatialTransform<Scalar>::inverse_dual() const
{
    Result_t inverse_dual_mat(Result_t::Zero());

    inverse_dual_mat.topLeftCorner(3, 3) = rotmat_.transpose();
    inverse_dual_mat.bottomRightCorner(3, 3) = rotmat_.transpose();
    inverse_dual_mat.topRightCorner(3, 3) = xlt_cross_mat_ * rotmat_.transpose();

    return inverse_dual_mat;
}

// protected func.

// private func.

template<typename Scalar>
typename SpatialTransform<Scalar>::SubMat_t SpatialTransform<Scalar>::EvalCrossMat(
        const typename SpatialTransform<Scalar>::Xlt3d_t &vector3d
        )
{
    const Scalar coord_x = vector3d[0];
    const Scalar coord_y = vector3d[1];
    const Scalar coord_z = vector3d[2];
    const Scalar kZero = Scalar{0.0};

    SubMat_t cross_mat(SubMat_t::Zero());
    cross_mat <<    kZero, -coord_z,  coord_y,
                  coord_z,    kZero, -coord_x,
                 -coord_y,  coord_x,    kZero;

    return cross_mat;
}

} // namespace math {

#endif // #ifndef _MATH_SPATIAL_TRANSFORM_H_
