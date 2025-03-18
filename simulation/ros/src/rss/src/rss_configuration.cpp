#include <rss_configuration.h>
#include <boost/numeric/conversion/cast.hpp>
#include <ros/param.h>
#include <ros/console.h>
#include <utils_ros_param.h>

namespace rss
{

    // public func.

    Configuration::Configuration() : mEgoVehicleRssDynamics{}, mOtherVehicleRssDynamics{}, mPedestrianRssDynamics{}, mOpenDriveMapDict{}
    {
        this->ParseRssDynamics(std::string("rss/ego_vehicle_dynamics/"), mEgoVehicleRssDynamics);
        this->ParseRssDynamics(std::string("rss/other_vehicle_dynamics/"), mOtherVehicleRssDynamics);
        this->ParseRssDynamics(std::string("rss/pedestrian_dynamics/"), mPedestrianRssDynamics);
        this->ParseOpenDriveMapDict(std::string("rss/"), mOpenDriveMapDict);

        ROS_DEBUG_STREAM_COND(false, "ego-vehicle rss-dynamics" << '\n' << mEgoVehicleRssDynamics);
        ROS_DEBUG_STREAM_COND(false, "other vehicle rss-dynamics" << '\n' << mOtherVehicleRssDynamics);
        ROS_DEBUG_STREAM_COND(false, "pedestrian rss-dynamics" << '\n' << mPedestrianRssDynamics);
    }

    const ad::rss::world::RssDynamics &Configuration::GetEgoVehicleRssDynamics() const
    {
        return mEgoVehicleRssDynamics;
    }

    const ad::rss::world::RssDynamics &Configuration::GetOtherVehicleRssDynamics() const
    {
        return mOtherVehicleRssDynamics;
    }

    const ad::rss::world::RssDynamics &Configuration::GetPedestrianRssDynamics() const
    {
        return mPedestrianRssDynamics;
    }

    const ad::rss::world::RssDynamics &Configuration::GetArtificialObjectRssDynamics() const
    {
        return mOtherVehicleRssDynamics;
    }

    const std::string Configuration::QueryOpenDriveMapFile(const MapId &mapId) const
    {
        const auto foundMap{mOpenDriveMapDict.find(mapId)};
        if (mOpenDriveMapDict.end() == foundMap)
        {
            ROS_ERROR_STREAM("invalid mapId: " << mapId);
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }

        return foundMap->second;
    }

    // protected func.

    // private func.

    void Configuration::ParseRssDynamics(const std::string &objectPrefix, ad::rss::world::RssDynamics &output) const
    {
        this->ParseAlphaLon(objectPrefix, output.alphaLon);
        this->ParseAlphaLat(objectPrefix, output.alphaLat);
        this->ParseLateralFluctuationMargin(objectPrefix, output.lateralFluctuationMargin);
        this->ParseResponseTime(objectPrefix, output.responseTime);
        this->ParseMaxSpeedOnAcceleration(objectPrefix, output.maxSpeedOnAcceleration);
        this->ParseUnstructedSettings(objectPrefix, output.unstructuredSettings);
    }

    void Configuration::ParseAlphaLon(const std::string &objectPrefix, ad::rss::world::LongitudinalRssAccelerationValues &output) const
    {
        try
        {
            output.accelMax        = utils::GetRosParam<double>(objectPrefix + std::string("alphaLon/accelMax"));
            output.brakeMax        = utils::GetRosParam<double>(objectPrefix + std::string("alphaLon/brakeMax"));
            output.brakeMin        = utils::GetRosParam<double>(objectPrefix + std::string("alphaLon/brakeMin"));
            output.brakeMinCorrect = utils::GetRosParam<double>(objectPrefix + std::string("alphaLon/brakeMinCorrect"));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseAlphaLat(const std::string &objectPrefix, ad::rss::world::LateralRssAccelerationValues &output) const
    {
        try
        {
            output.accelMax = utils::GetRosParam<double>(objectPrefix + std::string("alphaLat/accelMax"));
            output.brakeMin = utils::GetRosParam<double>(objectPrefix + std::string("alphaLat/brakeMin"));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseLateralFluctuationMargin(const std::string &objectPrefix, ad::physics::Distance &output) const
    {
        try
        {
            output = utils::GetRosParam<double>(objectPrefix + std::string("lateralFluctuationMargin"));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseResponseTime(const std::string &objectPrefix, ad::physics::Duration &output) const
    {
        try
        {
            output = utils::GetRosParam<double>(objectPrefix + std::string("responseTime"));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseMaxSpeedOnAcceleration(const std::string &objectPrefix, ad::physics::Speed &output) const
    {
        try
        {
            output = utils::GetRosParam<double>(objectPrefix + std::string("maxSpeedOnAcceleration"));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseUnstructedSettings(const std::string &objectPrefix, ad::rss::world::UnstructuredSettings &output) const
    {
        const std::string prefix{objectPrefix + "unstructuredSettings/"};
        try
        {
            output.pedestrianTurningRadius          = utils::GetRosParam<double>(prefix + std::string("pedestrianTurningRadius"));
            output.driveAwayMaxAngle                = utils::GetRosParam<double>(prefix + std::string("driveAwayMaxAngle"));
            output.vehicleYawRateChange             = utils::GetRosParam<double>(prefix + std::string("vehicleYawRateChange"));
            output.vehicleMinRadius                 = utils::GetRosParam<double>(prefix + std::string("vehicleMinRadius"));
            output.vehicleTrajectoryCalculationStep = utils::GetRosParam<double>(prefix + std::string("vehicleTrajectoryCalculationStep"));
            output.vehicleFrontIntermediateYawRateChangeRatioSteps =
                boost::numeric_cast<uint32_t>(utils::GetRosParam<int32_t>(prefix + std::string("vehicleFrontIntermediateYawRateChangeRatioSteps")));
            output.vehicleBackIntermediateYawRateChangeRatioSteps =
                boost::numeric_cast<uint32_t>(utils::GetRosParam<int32_t>(prefix + std::string("vehicleBackIntermediateYawRateChangeRatioSteps")));
            output.vehicleBrakeIntermediateAccelerationSteps =
                boost::numeric_cast<uint32_t>(utils::GetRosParam<int32_t>(prefix + std::string("vehicleBrakeIntermediateAccelerationSteps")));
            output.vehicleContinueForwardIntermediateAccelerationSteps = boost::numeric_cast<uint32_t>(
                utils::GetRosParam<int32_t>(prefix + std::string("vehicleContinueForwardIntermediateAccelerationSteps")));
            output.vehicleContinueForwardIntermediateYawRateChangeRatioSteps = boost::numeric_cast<uint32_t>(
                utils::GetRosParam<int32_t>(prefix + std::string("vehicleContinueForwardIntermediateYawRateChangeRatioSteps")));
            output.pedestrianContinueForwardIntermediateHeadingChangeRatioSteps = boost::numeric_cast<uint32_t>(
                utils::GetRosParam<int32_t>(prefix + std::string("pedestrianContinueForwardIntermediateHeadingChangeRatioSteps")));
            output.pedestrianContinueForwardIntermediateAccelerationSteps = boost::numeric_cast<uint32_t>(
                utils::GetRosParam<int32_t>(prefix + std::string("pedestrianContinueForwardIntermediateAccelerationSteps")));
            output.pedestrianBrakeIntermediateAccelerationSteps =
                boost::numeric_cast<uint32_t>(utils::GetRosParam<int32_t>(prefix + std::string("pedestrianBrakeIntermediateAccelerationSteps")));
            output.pedestrianFrontIntermediateHeadingChangeRatioSteps = boost::numeric_cast<uint32_t>(
                utils::GetRosParam<int32_t>(prefix + std::string("pedestrianFrontIntermediateHeadingChangeRatioSteps")));
            output.pedestrianBackIntermediateHeadingChangeRatioSteps =
                boost::numeric_cast<uint32_t>(utils::GetRosParam<int32_t>(prefix + std::string("pedestrianBackIntermediateHeadingChangeRatioSteps")));
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

    void Configuration::ParseOpenDriveMapDict(const std::string &objectPrefix, OpenDriveMapDict &outputOpenDriveMapDict) const
    {
        try
        {
            outputOpenDriveMapDict = utils::GetRosParam<OpenDriveMapDict>(objectPrefix + "open_drive_map");
        }
        catch (const utils::InvalidKeyException &ex)
        {
            ROS_ERROR_STREAM(ex.what());
            throw std::invalid_argument(std::string(__FILE__ ":") + std::to_string(__LINE__));
        }
    }

}  // namespace rss
