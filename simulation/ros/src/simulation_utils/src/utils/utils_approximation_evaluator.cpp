#include <utils_approximation_evaluator.h>
#include <math_utils.h>

namespace utils {

// public func.

template<typename ObjectType>
ApproximationEvaluator<ObjectType>::ApproximationEvaluator()
    : mEpsilon{DefaultEpsilon()}
    , mPreviousObject{}
{
}

template<typename ObjectType>
ApproximationEvaluator<ObjectType>::ApproximationEvaluator(const math::real_t epsilon)
    : mEpsilon{epsilon}
    , mPreviousObject{}
{
}

template<typename ObjectType>
ApproximationEvaluator<ObjectType>::ApproximationEvaluator(
    const ApproximationEvaluator<ObjectType> &other)
    : mEpsilon{other.GetEpsilon()}
    , mPreviousObject{other.GetPreviousObject()}
{
}

template<typename ObjectType>
ApproximationEvaluator<ObjectType> &ApproximationEvaluator<ObjectType>::operator=(
    const ApproximationEvaluator<ObjectType> &other)
{
    if (&other == this)
    {
        return *this;
    }

    mEpsilon = other.GetEpsilon();
    mPreviousObject = other.GetPreviousObject();

    return *this;
}

template<typename ObjectType>
ApproximationEvaluator<ObjectType>::~ApproximationEvaluator()
{
}

template<typename ObjectType>
math::real_t ApproximationEvaluator<ObjectType>::GetEpsilon() const
{
    return mEpsilon;
}

template<typename ObjectType>
const ObjectType &ApproximationEvaluator<ObjectType>::GetPreviousObject() const
{
    return mPreviousObject;
}

template<typename ObjectType>
bool ApproximationEvaluator<ObjectType>::Compute(const ObjectType &updatedObject)
{
    const bool isApprox = math::IsApprox(
        mPreviousObject,
        updatedObject,
        mEpsilon);

    mPreviousObject = updatedObject;

    return isApprox;
}

template<typename ObjectType>
void ApproximationEvaluator<ObjectType>::Configure(const math::real_t epsilon)
{
    mEpsilon = epsilon;
}

// protected func.

// private func.

// explicit instantiation

template class ApproximationEvaluator<math::HomoXfm3d_t>;

} // namespace utils {
