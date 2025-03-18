#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <math_utils.h>
#include <geometry_vector_3d.h>

class GeometryTest : public testing::Test
{

protected:

    GeometryTest()
        : mEpsilon{1.0e-7}
    {
    }

    virtual ~GeometryTest()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }

    double mEpsilon;
};

TEST_F(GeometryTest, Vector3d)
{
    const math::Vector3d_t refVector{math::Vector3d_t::Random()};
    const geometry::Vector3d testVector1st{refVector};
    const geometry::Vector3d testVector2nd = refVector;

    auto isApprox = [this](const math::Vector3d_t &ref, const math::Vector3d_t &test)->bool
    {return math::IsApprox(ref, test, mEpsilon);};

    EXPECT_PRED2(
        isApprox,
        refVector,
        testVector1st);
    EXPECT_PRED2(
        isApprox,
        refVector,
        testVector1st);

    const auto firstTestGeometryMsgsVector3{testVector1st.ToVector3()};
    const auto secondTestGeometryMsgsVector3{testVector2nd.ToVector3()};
    EXPECT_PRED2(
        isApprox,
        geometry::Vector3d(firstTestGeometryMsgsVector3),
        geometry::Vector3d(secondTestGeometryMsgsVector3));

    const auto firstTestGeometryMsgsPoint32{testVector1st.ToPoint32()};
    const auto secondTestGeometryMsgsPoint32{testVector2nd.ToPoint32()};
    EXPECT_PRED2(
        isApprox,
        geometry::Vector3d(firstTestGeometryMsgsPoint32),
        geometry::Vector3d(secondTestGeometryMsgsPoint32));

    const auto firstTestGeometryMsgsPoint{testVector1st.ToPoint()};
    const auto secondTestGeometryMsgsPoint{testVector2nd.ToPoint()};
    EXPECT_PRED2(
        isApprox,
        geometry::Vector3d(firstTestGeometryMsgsPoint),
        geometry::Vector3d(secondTestGeometryMsgsPoint));
}
