#include <chrono>
#include <vector>
#include <numeric>
#include <simulation_adv/Trigger.h>
#include <ros/console.h>
#include <ros/node_handle.h>
#include <ros/ros.h>
#include <ros/init.h>
#include <ros/rate.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "trigger_time_test_node");
    ros::NodeHandle nh;
    ros::ServiceClient client = nh.serviceClient<simulation_adv::Trigger>("/simulation/control/trigger");

    ros::Rate nodeRate(static_cast<int>(100));

    std::vector<double> v;
    uint32_t co = 0;

    using std::chrono::high_resolution_clock;
    using std::chrono::duration_cast;
    using std::chrono::duration;
    using std::chrono::milliseconds;

    while (ros::ok())
    {
        co ++;
        auto t1 = high_resolution_clock::now();
        simulation_adv::Trigger trigger;
        client.call(trigger);

        if (co > 6000 && co <= 12000)
        {
            auto t2 = high_resolution_clock::now();
            duration<double, std::milli> ms_double = t2 - t1;

            v.push_back(ms_double.count());
            if (co > 10000 && co % 100 == 0)
            {
                double sum = std::accumulate(v.begin(), v.end(), 0.);
                double mean = sum / v.size();
                double sq_sum = std::inner_product(v.begin(), v.end(), v.begin(), 0.0);
                double stdev = std::sqrt(sq_sum / v.size() - mean * mean);
                double max = *std::max_element(v.begin(), v.end());
                ROS_INFO_STREAM("iter # " << co <<
                    " | time: " << ms_double.count() << " ms" <<
                    ", mean: " << mean << " ms, stdev: " << stdev <<
                    ", max: " << max);
            }
        }
        if (co == 12000)
            break;

        nodeRate.sleep();

    }

    return 0;
}
