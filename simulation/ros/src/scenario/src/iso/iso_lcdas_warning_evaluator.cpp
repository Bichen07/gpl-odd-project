#include <iso_lcdas_warning_evaluator.h>
#include <iso_utils.h>
#include <utils_converter.h>

namespace iso{
namespace lcdas{

// public func.

LcdasWarningEvaluator::LcdasWarningEvaluator()
    : mNodeHandle{}
    , mEgoVehicleObserver{nullptr}
    , mAgentInSection{false}
    , mTestCase{""}
{
    // mWarningMsgSubscriber = mNodeHandle.subscribe(
    //     "standard_test/iso/lcdas/state", 1,
    //     &LcdasWarningEvaluator::LcdasWarninsMsgCallback, this);
    mDummyWarningMsgPublisher = mNodeHandle.advertise<
        std_msgs::Int8>("standard_test/iso/lcdas/state", 1);
    mDetectedObjectsSubscriber = mNodeHandle.subscribe(
        "detected_objects", 
        1, 
        &LcdasWarningEvaluator::DetectedObjectsCallback, 
        this);
    // mPerformancePublisher = mNodeHandle.advertise<
    // std_msgs::Bool>("standard_test/iso/lcdas/performance", 1)
}


LcdasWarningEvaluator::~LcdasWarningEvaluator()
{
}

void LcdasWarningEvaluator::Configure(
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver)
{
    if (nullptr == egoVehicleObserver)
    {
        ROS_ERROR_STREAM("egoVehicleObserver is nullptr");
        throw std::invalid_argument(std::string(__FILE__":") + std::to_string(__LINE__));
    }

    mEgoVehicleObserver = egoVehicleObserver;
}

void LcdasWarningEvaluator::Configure(
    const std::string testCase,
    const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver)
{
    mTestCase = testCase;
    Configure(egoVehicleObserver);
}

void LcdasWarningEvaluator::Evaluate()
{
    /*
        For demo purpose, 
        this evaluator simply find section(s) with agent inside
        and publish through mDummyWarningMsgPublisher.

        If this module is going to used as a standard checking module,
        disable the dummy publisher, 
        subscribe "simulation/behavior/lcdas",
        and compare the msg with EncodeToBinary().
    */

    // std_msgs::Bool isPass;
    // isPass.data = true;
    // mPerformancePublisher.publish(isPass);
}


// private func.

int LcdasWarningEvaluator::EncodeToBinary(void)
{
    return mAgentInSection[0] + \
           mAgentInSection[1] * 2 + \
           mAgentInSection[2] * 4;
}

void LcdasWarningEvaluator::LcdasWarninsMsgCallback(const std_msgs::Int8 &msg)
{
    if (msg.data == EncodeToBinary())
    {
        // success
    }
    else
    {
        // failed
    }
}

void LcdasWarningEvaluator::DetectedObjectsCallback(const itri_msgs::DetectedObjectArray &msg)
{
    // math::Vector3d_t egoPoint = mEgoVehicleObserver->GetState().position();
    math::Vector3d_t egoSize = mEgoVehicleObserver->GetSize();
    auto egoLength = 4.8;  // egoSize.x(); 
    auto egoWidth = 2.17;  // egoSize.y();

    for (size_t i = 0; i < 3; i++)
    {
        mAgentInSection[i] = false;
    }
    
    for (size_t i = 0; i < msg.objects.size(); i++)
    {
        math::Vector3d_t point = utils::ConvertToVector3d(msg.objects[i].pose);

        math::real_t lateralOffset = 3.;
        math::real_t rearLongitudinalOffset = 3.5;
        math::real_t frontLongitudinalOffset = 0.;

        auto agentLength = msg.objects[i].dimensions.x;
        auto agentWidth = msg.objects[i].dimensions.y * 0.8;  // Slightly adjust for demo video
        if (mTestCase == "overtaking_subject")
        {
            rearLongitudinalOffset = 30.;
        }
        else if (mTestCase == "overtaking_target")
        {
            math::real_t visualAdjust = 1.5;
            frontLongitudinalOffset = egoLength / 2. + visualAdjust;
        }
        else if (mTestCase == "lateral_moving")
        {
            lateralOffset = 6.;
        }

        bool lateralInRange =
            (-egoWidth / 2. - lateralOffset - agentWidth / 2. < point.y()) &&
            (egoWidth / 2. + lateralOffset + agentWidth / 2. > point.y());
        bool longitudinalInRange = 
            (-rearLongitudinalOffset - egoLength / 2. - agentLength / 2. < point.x()) && 
            (point.x() < agentLength / 2.+ frontLongitudinalOffset);

        if (lateralInRange && longitudinalInRange)
        {
            if (point.y() < -egoWidth / 2. + agentWidth / 2.)
            {
                mAgentInSection[0] = true;
            }
            else if (egoWidth / 2. - agentWidth / 2. < point.y())
            {
                mAgentInSection[2] = true;
            }
            else
            {
                mAgentInSection[1] = true;
            }

            if (mAgentInSection[0] && mAgentInSection[1] && mAgentInSection[2])
            {
                break;
            }
        }
    }

    std_msgs::Int8 detectedState;
    detectedState.data = EncodeToBinary();
    mDummyWarningMsgPublisher.publish(detectedState);

}

VehicleState LcdasWarningEvaluator::ExtractVehicleState(
    const std::string &id,
    const std::vector<scenario::IsoVehicleState> &msgs) const
{
    VehicleState outputState;
    for (const auto &msg: msgs)
    {
        if (msg.id == id)
        {
            outputState = iso::ConvertToVehicleState(msg);
            break;
        }
    }

    return outputState;
}


} // namespace lcdas{
} // namespace iso{
