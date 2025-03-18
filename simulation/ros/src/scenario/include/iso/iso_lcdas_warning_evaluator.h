#ifndef _ISO_LCDAS_WARNING_EVALUATOR_H_
#define _ISO_LCDAS_WARNING_EVALUATOR_H_

#include <memory>
#include <ros/ros.h>
#include <scenario/IsoAccCurveCapabilityEvaluation.h>
#include <scenario/IsoVehicleAttribute.h>
#include <scenario/IsoVehicleState.h>
#include <actor_ego_vehicle_observer.h>
#include <iso_type.h>
#include <iso_acc_time_gap_evaluator.h>
#include <iso_vehicle_attribute.h>
#include <iso_vehicle_state.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <std_msgs/Int8.h>
#include <map_navigation_path.h>
#include <queue>

namespace iso {
namespace lcdas {

class LcdasWarningEvaluator final
{

public:

    LcdasWarningEvaluator();
    LcdasWarningEvaluator(const LcdasWarningEvaluator &) = delete;
    LcdasWarningEvaluator &operator=(const LcdasWarningEvaluator &) = delete;
    virtual ~LcdasWarningEvaluator();


    void Configure(
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver);
    void Configure(
        const std::string testCase,
        const std::shared_ptr<actor::EgoVehicleObserver> &egoVehicleObserver);

    void Evaluate();

protected:

private:

    void LcdasWarninsMsgCallback(const std_msgs::Int8 &msg);
    void DetectedObjectsCallback(const itri_msgs::DetectedObjectArray &msg);

    int EncodeToBinary(void);

    VehicleState ExtractVehicleState(
        const std::string &id,
        const std::vector<scenario::IsoVehicleState> &msg) const;

    ros::NodeHandle mNodeHandle;
    ros::Subscriber mWarningMsgSubscriber;
    ros::Publisher mDummyWarningMsgPublisher;
    ros::Publisher mPerformancePublisher;
    ros::Subscriber mDetectedObjectsSubscriber;
    std::shared_ptr<actor::EgoVehicleObserver> mEgoVehicleObserver;
    std::string mTestCase;
    bool mAgentInSection[3];
};

} // namespace lcdas {
} // namespace iso {

#endif // #ifndef _ISO_LCDAS_WARNING_EVALUATOR_H_
