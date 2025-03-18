#ifndef _MATH_EASE_IN_OUT_GENERATOR_H_
#define _MATH_EASE_IN_OUT_GENERATOR_H_

#include "math_def.h"
#include <memory>
#include <functional>
#include <vector>
#include <map>
#include "math_type.h"

namespace math {

class EaseInOutGenerator final
{
    static constexpr int32_t default_min_size()
    {return int32_t{3};}

public:

    typedef enum class Method: int32_t
    {
        Quadratic = 0, // = 0
        Sinusoidal,    // = 1
        Num,           // = 2
        Null = Num,
    } MethodId_t;

    EaseInOutGenerator();
    EaseInOutGenerator(const EaseInOutGenerator &) = delete;
    EaseInOutGenerator &operator=(const EaseInOutGenerator &) = delete;
    virtual ~EaseInOutGenerator();
    /**
     * \brief Compute quadratic weight 0.0 -> 1.0
     * \param[in] size
     * \param[in] is_including_end
     * \retval begin value = 0.0, end value = 1.0, if is_including_end == TRUE,
     *         begin value = 0.0, end value < 1.0, if is_including_end == FALSE
     */
    std::vector<real_t> ComputeQuadraticInOutWeight(
            const int32_t size,
            const bool_t is_including_end = FALSE
            ) const;
    /**
     * \brief Compute sinusoidal weight 0.0 -> 1.0, begin value = 0.0, end value = 1.0
     * \param[in] size
     * \param[in] is_including_end
     * \reval begin value = 0.0, end value = 1.0, if is_including_end == TRUE,
     *        begin value = 0.0, end value < 1.0, if is_including_end == FALSE
     */
    std::vector<real_t> ComputeSinusoidalInOutWeight(
            const int32_t size,
            const bool_t is_including_end = FALSE
            ) const;
    /**
     * \brief Compute ease-in ease-out weight between begin and end,
     * begin value = begin, end value = end
     */
    std::vector<real_t> ComputeWeight(
            const MethodId_t &method_id,
            const int32_t size,
            const real_t begin,
            const real_t end,
            const bool_t is_including_end = FALSE
            ) const;

    template<typename charT, typename traits>
    friend std::basic_ostream<charT, traits> &operator<<(
            std::basic_ostream<charT, traits> &ostream,
            const MethodId_t &method_id
            );

protected:

private:

    using ComputeWeightFunc_t = std::function<std::vector<real_t> (const int32_t size, const bool_t is_including_end)>;
    using ComputeWeightFuncMap_t = std::map<MethodId_t, ComputeWeightFunc_t>;

    std::unique_ptr<ComputeWeightFuncMap_t> compute_weight_func_map_;
};

template<typename charT, typename traits>
std::basic_ostream<charT, traits> &operator<<(
        std::basic_ostream<charT, traits> &ostream,
        const EaseInOutGenerator::MethodId_t &method_id
        )
{
    static const std::map<EaseInOutGenerator::MethodId_t, std::string> kMethoIdMap =
    {
        {EaseInOutGenerator::Method::Quadratic,  STRINGIFY(Method::Quadratic)},
        {EaseInOutGenerator::Method::Sinusoidal, STRINGIFY(Method::Sinusoidal)},
        {EaseInOutGenerator::Method::Null,       STRINGIFY(Method::Null)},
    };

    ostream << kMethoIdMap.find(method_id)->second;

    return ostream;
}

} // namespace math {

#endif // #ifndef _MATH_EASE_IN_OUT_GENERATOR_H_
