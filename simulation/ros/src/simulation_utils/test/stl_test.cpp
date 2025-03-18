#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <sstream>
#include <iomanip>
#include <math_utils.h>

class StlTest : public testing::Test
{

protected:

    StlTest()
    {
    }

    virtual ~StlTest()
    {
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(StlTest, MapErase)
{
    std::map<int32_t, std::string> testMap =
    {
        {int32_t{1}, "1"},
        {int32_t{2}, "2"},
        {int32_t{3}, "3"},
        {int32_t{4}, "2"},
        {int32_t{6}, "1"},
    };

    const std::string targetValue("2");
    for (auto testPair{testMap.begin()};
         testPair != testMap.end();
         ++testPair)
    {
        if (targetValue == testPair->second)
        {
            testMap.erase(testPair);
        }
    }

    EXPECT_EQ(testMap.size(), std::size_t{3ul});

    for (auto element{testMap.cbegin()};
         element != testMap.cend();
         ++element)
    {
        EXPECT_NE(element->second, targetValue);
        std::cout << "element->first: " << element->first <<
            ", element->second: " << element->second << std::endl;
    }
}

TEST_F(StlTest, StringstringClear)
{
    std::stringstream stringstream;
    stringstream << "test string";
    EXPECT_EQ(stringstream.str(), "test string");
    stringstream = std::stringstream();
    EXPECT_EQ(stringstream.str(), "");
}

TEST_F(StlTest, LowerBound)
{
    std::vector<double> refSequence
    {
        double{10.0},
        double{20.0},
        double{30.0},
        double{40.0},
        double{50.0},
    };

    std::vector<double> testSequence
    {
        double{0.0},
        double{10.0},
        double{15.0},
        double{20.0},
        double{25.0},
        double{30.0},
        double{35.0},
        double{40.0},
        double{45.0},
        double{50.0},
        double{55.0},
    };

    for (auto testNum{testSequence.cbegin()};
         testNum != testSequence.cend();
         ++testNum)
    {
        const auto lowerBound{
            std::lower_bound(
                refSequence.cbegin(),
                refSequence.cend(),
                *testNum)};
        const auto lowerBound2nd{
            std::lower_bound(
                refSequence.cbegin(),
                refSequence.cend(),
                *testNum,
                [](const double first, const double second)
                {return first < second;})};

        auto lowerBound3rd{refSequence.cend()};
        for (auto refNum{refSequence.cbegin()};
             refNum != refSequence.cend();
             ++refNum)
        {
            if (math::IsGreaterThanOrApprox(*refNum, *testNum, double{1.0e-5}))
            {
                lowerBound3rd = refNum;
                break;
            }
        }

        EXPECT_DOUBLE_EQ(*lowerBound, *lowerBound3rd);
        EXPECT_EQ(lowerBound, lowerBound3rd);

        //std::cout << std::boolalpha <<
        //    "testNum: " << *testNum << '\n' <<
        //    "lowerBound1st: " << *lowerBound <<
        //    ", is equal to end: " <<
        //    bool{lowerBound == refSequence.cend()} << '\n' <<
        //    "lowerBound2nd: " << *lowerBound2nd <<
        //    ", is equal to end: " <<
        //    bool{lowerBound2nd == refSequence.cend()} << '\n' <<
        //    "lowerBound3rd: " << *lowerBound3rd <<
        //    ", is equal to end: " <<
        //    bool{lowerBound3rd == refSequence.cend()} << '\n' <<
        //    std::endl;
    }
}

TEST_F(StlTest, UpperBound)
{
    std::vector<double> refSequence
    {
        double{10.0},
        double{20.0},
        double{30.0},
        double{40.0},
        double{50.0},
    };

    std::vector<double> testSequence
    {
        double{0.0},
        double{10.0},
        double{15.0},
        double{20.0},
        double{25.0},
        double{30.0},
        double{35.0},
        double{40.0},
        double{45.0},
        double{50.0},
        double{55.0},
    };

    for (auto testNum{testSequence.cbegin()};
         testNum != testSequence.cend();
         ++testNum)
    {
        const auto upperBound{
            std::upper_bound(
                refSequence.cbegin(),
                refSequence.cend(),
                *testNum)};
        const auto upperBound2nd{
            std::upper_bound(
                refSequence.cbegin(),
                refSequence.cend(),
                *testNum,
                [](const double first, const double second)
                {return first < second;})};
        EXPECT_EQ(upperBound, upperBound2nd);
        //std::cout << std::boolalpha <<
        //    "testNum: " << *testNum << '\n' <<
        //    "upperBound1st: " << *upperBound <<
        //    ", is equal to end: " <<
        //    bool{upperBound == refSequence.cend()} << '\n' <<
        //    "upperBound2nd: " << *upperBound2nd <<
        //    ", is equal to end: " <<
        //    bool{upperBound2nd == refSequence.cend()} <<
        //    std::endl;
    }
}
