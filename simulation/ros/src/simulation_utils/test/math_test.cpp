#include <iterator>
#include <numeric>
#include <stdexcept>
#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <ros/console.h>
#include <utils_empty_container_exception.h>
#include <math_type.h>
#include <math_coord.h>
#include <math_utils.h>
#include <math_frenet_transformer.h>
#include <math_moving_average_filter.h>

class MathTest : public testing::Test
{

protected:

    MathTest()
    {
    }

    virtual ~MathTest()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(MathTest, MovingAverageFilterZeorBuffer)
{
    math::MovingAverageFilter<double> filter;
    EXPECT_THROW(filter.Push(double{10.0}), std::logic_error);

    const std::size_t bufferSize{10ul};
    filter.Configure(std::size_t{10});
    EXPECT_EQ(bufferSize, filter.GetBufferSize());
}

TEST_F(MathTest, MovingAverageFilterCopyValidation)
{
    const std::size_t filterSize{10ul};
    math::MovingAverageFilter<double> filter(filterSize);

    const std::size_t testSequenceSize{20ul};
    for (std::size_t idx{0ul}; idx < testSequenceSize; ++idx)
    {
        filter.Push(static_cast<double>(idx));
        math::MovingAverageFilter<double> constructedFilter(filter);

        EXPECT_EQ(
            filter.GetBufferSize(),
            constructedFilter.GetBufferSize());
        EXPECT_EQ(
            filter.GetElementSize(),
            constructedFilter.GetElementSize());

        math::MovingAverageFilter<double> assignedFilter = filter;
        EXPECT_EQ(
            filter.GetBufferSize(),
            assignedFilter.GetBufferSize());
        EXPECT_EQ(
            filter.GetElementSize(),
            assignedFilter.GetElementSize());

        auto filterElement{filter.GetDeque().cbegin()};
        auto constructedElement{constructedFilter.GetDeque().cbegin()};
        auto assignedElement{assignedFilter.GetDeque().cbegin()};
        for (; filterElement != filter.GetDeque().cend();
             ++filterElement, ++constructedElement, ++assignedElement)
        {
            EXPECT_DOUBLE_EQ(*filterElement, *constructedElement);
            EXPECT_DOUBLE_EQ(*filterElement, *assignedElement);
        }
    }
}

TEST_F(MathTest, MovingAverageFilterDoubleValue)
{
    const std::size_t filterSize{10ul};
    math::MovingAverageFilter<double> filter(filterSize);

    const std::size_t testSequenceSize{20ul};
    for (std::size_t idx{0ul}; idx < testSequenceSize; ++idx)
    {
        filter.Push(static_cast<double>(idx));
        const double refSum = std::accumulate(
            filter.GetDeque().cbegin(),
            filter.GetDeque().cend(),
            double{0.0});
        EXPECT_DOUBLE_EQ(refSum, filter.ComputeSum());

        const double refAverage =
            refSum / static_cast<double>(filter.GetElementSize());
        EXPECT_DOUBLE_EQ(refAverage, filter.ComputeAverage());
        static constexpr bool canShowElements{false};
        if (canShowElements)
        {
            ROS_INFO_STREAM(
                "idx: " << idx <<
                ", size: " << filter.GetElementSize() <<
                ", sum: " << filter.ComputeSum() <<
                ", ref sum: " << refSum <<
                ", average: " << filter.ComputeAverage() <<
                ", ref avg: " << refAverage);
            std::copy(
                filter.GetDeque().cbegin(),
                filter.GetDeque().cend(),
                std::ostream_iterator<double>(std::cout, ", "));
            std::cout << std::endl;
        }
    }
}

TEST_F(MathTest, MovingAverageFilterVector3d)
{
    const std::size_t filterSize{10ul};
    math::MovingAverageFilter<math::Vector3d_t> filter(filterSize);

    static constexpr math::real_t epsilon{1.0e-6};
    const std::size_t testSequenceSize{20ul};
    for (auto idx{0ul}; idx < testSequenceSize; ++idx)
    {
        filter.Push(math::Vector3d_t::Random());
        const math::Vector3d_t refSum = std::accumulate(
            filter.GetDeque().cbegin(),
            filter.GetDeque().cend(),
            math::Vector3d_t());
        EXPECT_TRUE(math::IsApprox(refSum, filter.ComputeSum(), epsilon));

        const math::Vector3d_t refAverage =
            refSum / static_cast<double>(filter.GetElementSize());
        EXPECT_TRUE(math::IsApprox(refAverage, filter.ComputeAverage(), epsilon));
    }
}

TEST_F(MathTest, MovingAverageFilterVector6d)
{
    const std::size_t filterSize{10ul};
    math::MovingAverageFilter<math::Vector6d_t> filter(filterSize);

    static constexpr math::real_t epsilon(1.0e-6);
    const std::size_t testSequenceSize{20ul};
    for (auto idx{0ul}; idx < testSequenceSize; ++idx)
    {
        filter.Push(math::Vector6d_t::Random());
        const math::Vector6d_t refSum = std::accumulate(
            filter.GetDeque().cbegin(),
            filter.GetDeque().cend(),
            math::Vector6d_t());
        EXPECT_TRUE(math::IsApprox(refSum, filter.ComputeSum(), epsilon));

        const math::Vector6d_t refAverage =
            refSum / static_cast<double>(filter.GetElementSize());
        EXPECT_TRUE(math::IsApprox(refAverage, filter.ComputeAverage(), epsilon));
    }
}

TEST_F(MathTest, Corod)
{
    EXPECT_EQ(ToCoord("local"), Coord::Local);
    EXPECT_EQ(ToCoord("Local"), Coord::Local);
    EXPECT_EQ(ToCoord("world"), Coord::World);
    EXPECT_EQ(ToCoord("World"), Coord::World);
    EXPECT_EQ(ToCoord("null"), Coord::Null);
    EXPECT_EQ(ToCoord("Null"), Coord::Null);
    EXPECT_EQ(ToCoordLabel(Coord::Local), std::string("local"));
    EXPECT_EQ(ToCoordLabel(Coord::World), std::string("world"));
}

TEST_F(MathTest, FrenetCoordExceedingGivenPath)
{
    const std::size_t segmentNum{10ul};
    const math::Vector2d_t incrementVector(1.0, 1.0);
    std::vector<math::Vector2d_t> points{segmentNum};
    auto point{points.begin() + 1};
    for (; point != points.end(); ++point)
    {
        *point = *(point - 1) + incrementVector;
    }

    math::FrenetTransformer frenetTransformer;
    EXPECT_THROW(
        frenetTransformer.Configure(
            std::vector<math::Vector2d_t>(),
            utils::FileLineNumPairInstance()),
        utils::EmptyContainerException);

    frenetTransformer.Configure(
        points,
        utils::FileLineNumPairInstance());

    const std::vector<math::Vector2d_t> cartesianCoords =
    {
        math::Vector2d_t(-1.0, -1.0),
        math::Vector2d_t(-2.0, 0.0),
        math::Vector2d_t(points.back() + incrementVector),
        math::Vector2d_t(9.0, 11.0),
    };

    std::vector<math::FrenetCoord> frenetCoords(cartesianCoords.size());
    auto cartesianCoord{cartesianCoords.cbegin()};
    auto frenetCoord{frenetCoords.begin()};
    for (; cartesianCoord != cartesianCoords.cend();
         ++cartesianCoord, ++frenetCoord)
    {
        const auto idx{
            std::distance(cartesianCoords.cbegin(), cartesianCoord)};
        *frenetCoord = frenetTransformer.ConvertToFrenetCoord(*cartesianCoord);
        const auto convertedCartesianCoord{
            frenetTransformer.ConvertToCartesianCoord(*frenetCoord)};
        static const math::real_t epsilon{1.0e-10};
        EXPECT_TRUE(
            math::IsApprox(
                *cartesianCoord,
                convertedCartesianCoord,
                epsilon)) <<
            "ref: " << cartesianCoord->transpose() << '\n' <<
            "test: " << convertedCartesianCoord.transpose() << std::endl;
    }
}
