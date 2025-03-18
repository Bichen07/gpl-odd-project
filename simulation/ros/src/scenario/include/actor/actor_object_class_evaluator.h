#ifndef _ACTOR_OBJECT_CLASS_EVALUATOR_H_
#define _ACTOR_OBJECT_CLASS_EVALUATOR_H_

#include <map>
#include <utility>
#include <string>
#include <itri_msgs/DetectedObject.h>
#include <itri_msgs/DetectedObjectArray.h>
#include <geometry_vector_2d.h>
#include <actor_object_class_id.h>

namespace actor {

class ObjectClassEvaluator final
{

public:

    ObjectClassEvaluator();
    ObjectClassEvaluator(const ObjectClassEvaluator &) = delete;
    ObjectClassEvaluator &operator=(const ObjectClassEvaluator &) = delete;
    virtual ~ObjectClassEvaluator() = default;

    void Execute(itri_msgs::DetectedObjectArray &detectedObjectArray);
    std::string Execute(const itri_msgs::DetectedObject &detedctedObject);

protected:

private:

    using ObjectClassAreaPair = std::pair<ObjectClassId, double>;

    std::string EstimateBySize(const itri_msgs::DetectedObject &detectedObject) const;
    bool IsValidLabel(const std::string &label) const;

    std::map<ObjectClassId, std::string> mObjectClassLabelMap;
    std::map<ObjectClassId, geometry::Vector2d> mObjectClassRefSizeMap;
    std::vector<ObjectClassAreaPair> mObjectClassAreaPairs;
};

} // namespace actor {

#endif // #ifndef _ACTOR_OBJECT_CLASS_EVALUATOR_H_
