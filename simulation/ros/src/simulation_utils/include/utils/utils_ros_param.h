#ifndef _UTILS_ROS_PARAM_H_
#define _UTILS_ROS_PARAM_H_

#include <string>
#include <stdexcept>
#include <ros/node_handle.h>
#include <ros/console.h>
#include <ros/param.h>
#include <utils_invalid_key_exception.h>

namespace utils {

template<typename DataType>
DataType GetRosParam(const ros::NodeHandle &nodeHandle, const std::string &key)
{
    if (!nodeHandle.hasParam(key))
    {
        ROS_ERROR_STREAM("no param " << key);
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    DataType outputParam;
    nodeHandle.getParam(key, outputParam);

    return outputParam;
}

template<typename DataType>
DataType GetRosParam(const std::string &key)
{
    DataType outputParam;
    if (!ros::param::get(key, outputParam))
    {
        ROS_ERROR_STREAM("no param " << key);
        throw utils::InvalidKeyException(key);
    }

    return outputParam;
}

} // namespace utils {

#endif // #ifndef _UTILS_ROS_PARAM_H_
