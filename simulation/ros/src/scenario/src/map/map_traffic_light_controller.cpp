#include <map_traffic_light_controller.h>
#include <utils_default_color.h>

namespace map {

// public func.

TrafficLightController::TrafficLightController()
    : mPreviousStateId{TrafficLightState::Null}
    , mPreviousSeconds{0.0}
    , mIsFlashingOn{false}
{
}

void TrafficLightController::ComputeUpdatedSignal(
    const TrafficLightStateId &stateId,
    std_msgs::ColorRGBA &redLight,
    std_msgs::ColorRGBA &yellowLight,
    std_msgs::ColorRGBA &greenLight)
{
    if (this->IsFlashingState(stateId))
    {
        static const double flashingPeriod{1.0};
        if (stateId == mPreviousStateId)
        {
            const auto currentSeconds = ros::Time::now().toSec();
            const auto timePeriod = currentSeconds - mPreviousSeconds;
            if (timePeriod > flashingPeriod)
            {
                mIsFlashingOn = !mIsFlashingOn;
                mPreviousSeconds = currentSeconds;
            }

            if (mIsFlashingOn)
            {
                redLight =
                    TrafficLightState::FlashingRed == stateId ?
                    utils::Red() : utils::Gray();
                yellowLight =
                    TrafficLightState::FlashingYellow == stateId ?
                    utils::Yellow() : utils::Gray();
                greenLight = utils::Gray();
            }
            else
            {
                redLight = utils::Gray();
                yellowLight = utils::Gray();
                greenLight = utils::Gray();
            }
        }
        else
        {
            redLight =
                TrafficLightState::FlashingRed == stateId ?
                utils::Red() : utils::Gray();
            yellowLight =
                TrafficLightState::FlashingYellow == stateId ?
                utils::Yellow() : utils::Gray();
            greenLight = utils::Gray();
            mIsFlashingOn = true;
        }

        mPreviousStateId = stateId;
        return;
    }

    redLight = TrafficLightState::Red == stateId ? utils::Red() : utils::Gray();
    yellowLight = TrafficLightState::Yellow == stateId ? utils::Yellow() : utils::Gray();
    greenLight = TrafficLightState::Green == stateId ? utils::Green() : utils::Gray();
    mIsFlashingOn = false;
    mPreviousStateId = stateId;
}

// protected func.

// private func.

bool TrafficLightController::IsFlashingState(const TrafficLightStateId &stateId) const
{
    return TrafficLightState::FlashingRed == stateId ||
           TrafficLightState::FlashingYellow == stateId;
}

} // namespace map {
