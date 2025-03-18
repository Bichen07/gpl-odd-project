#include "math_generate_random_vector.h"
#include <chrono>
#include <random>
#include "console_log.h"

namespace math {

// public func.

GenerateRandomVector::GenerateRandomVector()
    :lower_bounds_(new math::VectorNd_t),
    upper_bounds_(new math::VectorNd_t)
{
}

GenerateRandomVector::GenerateRandomVector(
        const math::VectorNd_t &lower_bounds,
        const math::VectorNd_t &upper_bounds
        )
    :lower_bounds_(new math::VectorNd_t(lower_bounds)),
    upper_bounds_(new math::VectorNd_t(upper_bounds))
{
}

GenerateRandomVector::GenerateRandomVector(const GenerateRandomVector &other)
    :lower_bounds_(new math::VectorNd_t(other.lower_bounds())),
    upper_bounds_(new math::VectorNd_t(other.upper_bounds()))
{
}

GenerateRandomVector &GenerateRandomVector::operator=(const GenerateRandomVector &other)
{
    if (&other == this)
    {
        return *this;
    }

    *lower_bounds_ = other.lower_bounds();
    *upper_bounds_ = other.upper_bounds();

    return *this;
}

VectorNd_t GenerateRandomVector::operator()() const
{
    const VectorNd_t zero_means = VectorNd_t::Zero(this->lower_bounds().size());
    return (*this)(zero_means);
//    if (lower_bounds_->size() != upper_bounds_->size())
//    {
//        console::log(WARN) << "unequal size between lower_bounds and upper_bounds" << NEWLINE
//            << "lower bound size " << lower_bounds_->size() << NEWLINE
//            << "upper bound size " << upper_bounds_->size() << NEWLINE
//            << std::endl;
//        return VectorNd_t();
//    }
//
//    if (VectorNd_t::Index{0} == lower_bounds_->size())
//    {
//        console::log(WARN) << "empty lower_bounds and upper_bounds" << std::endl;
//        return VectorNd_t();
//    }
//
//    std::default_random_engine generator(std::chrono::system_clock::now().time_since_epoch().count());
//    VectorNd_t output(lower_bounds_->size());
//    for (VectorNd_t::Index idx = VectorNd_t::Index{0}; idx < output.size(); ++idx)
//    {
//        if ((*lower_bounds_)(idx) > (*upper_bounds_)(idx))
//        {
//            console::log(WARN) << "invalid lower_bound and upper_bound at idx " << idx << NEWLINE
//                << "lower_bound " << (*lower_bounds_)(idx) << NEWLINE
//                << "upper_bound " << (*upper_bounds_)(idx) << NEWLINE
//                << std::endl;
//            return output;
//        }
//
//        std::uniform_real_distribution<math::VectorNd_t::RealScalar> real_distribution(
//                (*lower_bounds_)(idx),
//                (*upper_bounds_)(idx)
//                );
//        output(idx) = real_distribution(generator);
//    }
//
//    return output;
}

GenerateRandomVector::~GenerateRandomVector()
{
}

VectorNd_t GenerateRandomVector::operator()(const VectorNd_t &means) const
{
    if (lower_bounds_->size() != upper_bounds_->size())
    {
        console::log(WARN) << "unequal size between lower_bounds and upper_bounds" << NEWLINE
            << "lower bound size " << lower_bounds_->size() << NEWLINE
            << "upper bound size " << upper_bounds_->size() << NEWLINE
            << std::endl;
        return VectorNd_t();
    }

    if (means.size() != lower_bounds_->size())
    {
        console::log(WARN) << "unequal size between means and lower_bounds" << NEWLINE
            << "means size " << means.size() << NEWLINE
            << "lower bound size " << lower_bounds_->size() << NEWLINE
            << std::endl;
        return VectorNd_t();
    }

    if (VectorNd_t::Index{0} == lower_bounds_->size())
    {
        console::log(WARN) << "empty lower_bounds and upper_bounds" << std::endl;
        return VectorNd_t();
    }

    std::default_random_engine generator(std::chrono::system_clock::now().time_since_epoch().count());
    VectorNd_t output(lower_bounds_->size());
    for (VectorNd_t::Index idx = VectorNd_t::Index{0}; idx < output.size(); ++idx)
    {
        if ((*lower_bounds_)(idx) > (*upper_bounds_)(idx))
        {
            console::log(WARN) << "invalid lower_bound and upper_bound at idx " << idx << NEWLINE
                << "lower_bound " << (*lower_bounds_)(idx) << NEWLINE
                << "upper_bound " << (*upper_bounds_)(idx) << NEWLINE
                << std::endl;
            return output;
        }

        std::uniform_real_distribution<math::VectorNd_t::RealScalar> real_distribution(
                means(idx) + (*lower_bounds_)(idx),
                means(idx) + (*upper_bounds_)(idx)
                );
        output(idx) = real_distribution(generator);
    }

    return output;
}

VectorNd_t GenerateRandomVector::lower_bounds() const
{
    return *lower_bounds_;
}

VectorNd_t GenerateRandomVector::upper_bounds() const
{
    return *upper_bounds_;
}

void GenerateRandomVector::set_lower_bounds(const VectorNd_t &lower_bounds)
{
    *lower_bounds_ = lower_bounds;
}

void GenerateRandomVector::set_upper_bounds(const VectorNd_t &upper_bounds)
{
    *upper_bounds_ = upper_bounds;
}

// protected func.

// private func.

} // namespace math {
