#include <gtest/gtest.h>
#include <vector>
#include <string>
#include "boost/algorithm/string/join.hpp"
#include <ros/init.h>

int main(int argc, char **argv)
{
    static const std::vector<std::string> modules =
    {
        "GeometryTest*",
        "MathTest*",
        "StlTest*",
        "UtilsTest*"
    };
    ros::init(argc, argv, "simulation_utils");
    testing::InitGoogleTest(&argc, argv);

    const std::string testModuleName = boost::algorithm::join(modules, ":");
    testing::GTEST_FLAG(filter) = testModuleName.c_str();

    return RUN_ALL_TESTS();
}
