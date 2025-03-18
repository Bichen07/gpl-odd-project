#include "math_ease_in_out_generator.h"
#include <stdexcept>
#include <algorithm>
#include "boost/numeric/conversion/cast.hpp"
//#include "console_log.h"
#include "math_utils.h"

namespace math {

// public func.

EaseInOutGenerator::EaseInOutGenerator()
    :compute_weight_func_map_(new ComputeWeightFuncMap_t)
{
    *compute_weight_func_map_ = ComputeWeightFuncMap_t
    {
        {
            Method::Quadratic,
            std::bind(&EaseInOutGenerator::ComputeQuadraticInOutWeight, this, std::placeholders::_1, std::placeholders::_2)
        },
        {
            Method::Sinusoidal,
            std::bind(&EaseInOutGenerator::ComputeSinusoidalInOutWeight, this, std::placeholders::_1, std::placeholders::_2)
        },
    };
}

EaseInOutGenerator::~EaseInOutGenerator()
{
}

std::vector<real_t> EaseInOutGenerator::ComputeQuadraticInOutWeight(
        const int32_t size,
        const bool_t is_including_end /* = FALSE */
        ) const
{
    if (size < default_min_size())
    {
        //console::log(ERR) << "invalid size: " << size << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return std::vector<real_t>();
    }

    std::vector<real_t> output_weight_coll;
    output_weight_coll.reserve(size);

    if (is_including_end)
    {
        const int32_t internal_size = size - int32_t{1};
        const real_t internal_size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(internal_size));
        for (int32_t idx = 0; idx < internal_size; ++idx)
        {
            real_t current_ratio = boost::numeric_cast<real_t>(idx) * internal_size_reciprocal * real_t{2.0};
            if (current_ratio < real_t{1.0})
            {
                output_weight_coll.push_back(
                        real_t{0.5} * current_ratio * current_ratio
                        );
                continue;
            }

            current_ratio -= real_t{1.0};
            output_weight_coll.push_back(
                    -real_t{0.5} * (current_ratio * (current_ratio - real_t{2.0}) - real_t{1.0})
                    );
        }

        output_weight_coll.push_back(real_t{1.0});
    }
    else
    {
        const real_t size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(size));
        for (int32_t idx = 0; idx < size; ++idx)
        {
            real_t current_ratio = boost::numeric_cast<real_t>(idx) * size_reciprocal * real_t{2.0};
            if (current_ratio < real_t{1.0})
            {
                output_weight_coll.push_back(
                        real_t{0.5} * current_ratio * current_ratio
                        );
                continue;
            }

            current_ratio -= real_t{1.0};

            output_weight_coll.push_back(
                    -real_t{0.5} * (current_ratio * (current_ratio - real_t{2.0}) - real_t{1.0})
                    );
        }
    }

    return output_weight_coll;

//#if 1
//
//#else
//    std::vector<real_t> output_weight_coll;
//    output_weight_coll.reserve(size);
//    const real_t size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(size));
//    for (int32_t idx = 0; idx < size; ++idx)
//    {
//        real_t current_ratio = boost::numeric_cast<real_t>(idx) * size_reciprocal * real_t{2.0};
//        if (current_ratio < real_t{1.0})
//        {
//            output_weight_coll.push_back(
//                    real_t{0.5} * current_ratio * current_ratio
//                    );
//            continue;
//        }
//
//        current_ratio -= real_t{1.0};
//
//        output_weight_coll.push_back(
//                -real_t{0.5} * (current_ratio * (current_ratio - real_t{2.0}) - real_t{1.0})
//                );
//    }
//
//    return output_weight_coll;
//#endif
}

std::vector<real_t> EaseInOutGenerator::ComputeSinusoidalInOutWeight(
        const int32_t size,
        const bool_t is_including_end /* = FALSE */
        ) const
{
    if (size < default_min_size())
    {
        //console::log(ERR) << "invalid size: " << size << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
        return std::vector<real_t>();
    }

    std::vector<real_t> output_weight_coll;
    output_weight_coll.reserve(size);

    if (is_including_end)
    {
        const int32_t internal_size = size - int32_t{1};
        const real_t internal_size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(internal_size));
        for (int32_t idx = 0; idx < internal_size; ++idx)
        {
            real_t cos_value = math::Pi<real_t>() * boost::numeric_cast<real_t>(idx) * internal_size_reciprocal;
            output_weight_coll.push_back(real_t{-0.5} * (cos(cos_value) - real_t{1.0}));
        }

        output_weight_coll.push_back(real_t{1.0});
    }
    else
    {
        const real_t size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(size));
        for (int32_t idx = 0; idx < size; ++idx)
        {
            real_t cos_value = math::Pi<real_t>() * boost::numeric_cast<real_t>(idx) * size_reciprocal;
            output_weight_coll.push_back(real_t{-0.5} * (cos(cos_value) - real_t{1.0}));
        }
    }

    return output_weight_coll;
//#if 1
//
//    const int32_t internal_size = size - int32_t{1};
//    const real_t internal_size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(internal_size));
//    for (int32_t idx = 0; idx < internal_size; ++idx)
//    {
//        real_t cos_value = math::Pi<real_t>() * boost::numeric_cast<real_t>(idx) * internal_size_reciprocal;
//        output_weight_coll.push_back(real_t{-0.5} * (cos(cos_value) - real_t{1.0}));
//    }
//
//    output_weight_coll.push_back(real_t{1.0});
//
//    return output_weight_coll;
//#else
//    std::vector<real_t> output_weight_coll;
//    output_weight_coll.reserve(size);
//    const real_t size_reciprocal = math::Reciprocal(boost::numeric_cast<real_t>(size));
//    for (int32_t idx = 0; idx < size; ++idx)
//    {
//        real_t cos_value = math::Pi<real_t>() * boost::numeric_cast<real_t>(idx) * size_reciprocal;
//        output_weight_coll.push_back(real_t{-0.5} * (cos(cos_value) - real_t{1.0}));
//    }
//
//    return output_weight_coll;
//#endif
}

std::vector<real_t> EaseInOutGenerator::ComputeWeight(
        const MethodId_t &method_id,
        const int32_t size,
        const real_t begin,
        const real_t end,
        const bool_t is_including_end
        ) const
{
    auto found_func = compute_weight_func_map_->find(method_id);
    if (compute_weight_func_map_->end() == found_func)
    {
        //console::log(ERR) << "invalid " << method_id << std::endl;
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    const std::vector<real_t> ease_in_out_weight_coll = found_func->second(size, is_including_end);

    std::vector<real_t> output_weight_coll(size, math::real_t{0.0});
    std::transform(
            ease_in_out_weight_coll.begin(),
            ease_in_out_weight_coll.end(),
            output_weight_coll.begin(),
            [&begin, &end](const real_t ease_in_out_weight)
            {return math::Lerp(begin, end, ease_in_out_weight);}
            );

    return output_weight_coll;
}

// protected func.

// private func.

} // namespace math {
