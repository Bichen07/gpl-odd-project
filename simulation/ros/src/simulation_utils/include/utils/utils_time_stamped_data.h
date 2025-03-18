#ifndef _UTILS_TIME_STAMPED_DATA_H_
#define _UTILS_TIME_STAMPED_DATA_H_

#include <iostream>
#include <ros/time.h>

namespace utils {

template<typename DataType>
struct TimeStampedData final
{
    ros::Time stamp;
    DataType data;

    TimeStampedData();
    TimeStampedData(
        const ros::Time &inputStamp,
        const DataType &inputData)
        : stamp{inputStamp}
        , data{inputData}
    {
    }
    TimeStampedData(const TimeStampedData &other) = default;
    TimeStampedData &operator=(const TimeStampedData &other) = default;
    ~TimeStampedData() = default;
};

template<typename charT, typename traits, typename DataType>
std::basic_ostream<charT, traits> &operator<<(
    std::basic_ostream<charT, traits> &ostream,
    const TimeStampedData<DataType> &timeStampedData)
{
    ostream << "stamp: " << timeStampedData.stamp << '\n' <<
        "data: " << timeStampedData.data;
    return ostream;
}

} // namespace utils {

#endif // #ifndef _UTILS_TIME_STAMPED_DATA_H_
