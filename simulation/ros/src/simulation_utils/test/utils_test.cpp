#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <ros/console.h>
#include <math_utils.h>
#include <utils_time_stamped_data.h>

class UtilsTest : public testing::Test
{

protected:

    UtilsTest()
    {
    }

    virtual ~UtilsTest()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(UtilsTest, TimeStampedData)
{
    using TimeStampedVector3d = utils::TimeStampedData<math::Vector3d_t>;

    const TimeStampedVector3d refTimeStampedVector =
    {
        ros::Time(10ul, 20ul),
        math::Vector3d_t::Random()
    };

    ROS_INFO_STREAM("refTimeStampedVector: " << refTimeStampedVector);

    const TimeStampedVector3d copiedTimeStampedVector(
        refTimeStampedVector);
    EXPECT_EQ(
        refTimeStampedVector.stamp.sec,
        copiedTimeStampedVector.stamp.sec);
    EXPECT_EQ(
        refTimeStampedVector.stamp.nsec,
        copiedTimeStampedVector.stamp.nsec);
    EXPECT_TRUE(
        math::IsApprox(
            refTimeStampedVector.data,
            copiedTimeStampedVector.data,
            math::real_t{1.0e-6}));
    const TimeStampedVector3d assignedTimeStampedVector = refTimeStampedVector;
    EXPECT_EQ(
        refTimeStampedVector.stamp.sec,
        assignedTimeStampedVector.stamp.sec);
    EXPECT_EQ(
        refTimeStampedVector.stamp.nsec,
        assignedTimeStampedVector.stamp.nsec);
    EXPECT_TRUE(
        math::IsApprox(
            refTimeStampedVector.data,
            assignedTimeStampedVector.data,
            math::real_t{1.0e-6}));
}
