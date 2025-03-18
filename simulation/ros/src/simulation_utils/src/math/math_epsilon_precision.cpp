#include "math_epsilon_precision.h"
#include "boost/numeric/conversion/cast.hpp"

namespace math {

// public func.

template<typename Scalar>
EpsilonPrecision<Scalar>::EpsilonPrecision(const Scalar &target_epsilon)
    :epsilon_(target_epsilon),
    precision_digits_(0)
{
    precision_digits_ = this->ComputePrecisionDigits(epsilon_);
}

template<typename Scalar>
EpsilonPrecision<Scalar>::EpsilonPrecision(const EpsilonPrecision<Scalar> &other)
    :epsilon_(other.epsilon()),
    precision_digits_(other.precision_digits())
{
}

template<typename Scalar>
EpsilonPrecision<Scalar> &EpsilonPrecision<Scalar>::operator=(const EpsilonPrecision<Scalar> &other)
{
    if (&other == this)
    {
        return *this;
    }

    epsilon_ = other.epsilon();
    precision_digits_ = other.precision_digits();

    return *this;
}

template<typename Scalar>
EpsilonPrecision<Scalar>::~EpsilonPrecision()
{
}

template<typename Scalar>
Scalar EpsilonPrecision<Scalar>::epsilon() const
{
    return epsilon_;
}

template<typename Scalar>
int32_t EpsilonPrecision<Scalar>::precision_digits() const
{
    return precision_digits_;
}

template<typename Scalar>
void EpsilonPrecision<Scalar>::reset_epsilon(const Scalar &epsilon)
{
    epsilon_ = epsilon;
    precision_digits_ = this->ComputePrecisionDigits(epsilon_);
}

// protected func.

// private func.

template<typename Scalar>
int32_t EpsilonPrecision<Scalar>::ComputePrecisionDigits(const Scalar &epsilon) const
{
    return boost::numeric_cast<int32_t>(-log10(epsilon_)) + 1;
}

// explicit instantiation

template class EpsilonPrecision<float64_t>;
template class EpsilonPrecision<float32_t>;

} // namespace math {
