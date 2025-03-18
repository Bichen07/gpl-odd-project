#include <boost/python.hpp>

#include <chrono>
#include <string>
#include <ros/serialization.h>
#include <scenario_classification/ClassificationObject.h>
#include <scenario_classification/TagLongitudinalActivity.h>
#include <itri_msgs/CarState.h>
#include "utils.cpp"
#include "parameters.h"
#include "utils_converter.h"
#include "math_utils.h"

using namespace scenario_classification;

class IdentifierLongitudinalActivity
{
public:
	IdentifierLongitudinalActivity() = default;

	std::string IdentifyTag(const std::string &str_msg)
	{
		ClassificationObject obj = FromPython<ClassificationObject>(str_msg);
		TagLongitudinalActivity longitudinalActivity = _IdentifyTag(obj);
		return ToPython(longitudinalActivity);
	}

private:
    TagLongitudinalActivity _IdentifyTag(ClassificationObject &obj)
    {
        TagLongitudinalActivity tag;

        if (obj.label == "ego") {
            auto velocity_x = obj.velocities.back().twist.linear.x;
            auto acceleration_x =
                obj.relative_accelerations.back().twist.linear.x;
            if (abs(velocity_x) < SPEED_DIFFERENCE_TOLERANCE)
            {
                tag.primary_category =
                    TagLongitudinalActivity::PRIMARY_STANDING_STILL;
            }
            else if (abs(velocity_x) > SPEED_DIFFERENCE_TOLERANCE
                    && velocity_x < 0)
            {
                tag.primary_category =
                    TagLongitudinalActivity::PRIMARY_REVERSING;
            }
            else
            {
                tag.primary_category =
                    TagLongitudinalActivity::PRIMARY_DRIVING_FORWARD;

                if (acceleration_x > ACCELERATION_DIFFERENCE_TOLERANCE)
                {
                    tag.secondary_category =
                        TagLongitudinalActivity::SECONDARY_ACCELERATING;
                }
                else if (acceleration_x < -ACCELERATION_DIFFERENCE_TOLERANCE)
                {
                    tag.secondary_category =
                        TagLongitudinalActivity::SECONDARY_BRAKING;
                }
                else
                {
                    tag.secondary_category =
                        TagLongitudinalActivity::SECONDARY_CRUISING;
                }
            }
            return tag;
        }

        float headingAngle = utils::ConvertToVector3d(
                obj.relative_poses[0].pose.orientation).z();
        while (headingAngle > math::Pi<float>())
        {
            headingAngle -= 2 * math::Pi<float>();
        }
        while (headingAngle < -math::Pi<float>())
        {
            headingAngle += 2 * math::Pi<float>();
        }

        float relativePositionY = obj.relative_poses.back().pose.position.y;
        if (abs(relativePositionY) > 2 * obj.size.y
                || (abs(headingAngle) > MAX_RELEVANT_SAME_DIRECTION_ANGLE
                    && abs(headingAngle) < MIN_RELEVANT_ON_COMING_ANGLE))
        {
            tag.primary_category = TagLongitudinalActivity::PRIMARY_IRRELEVANT;
            return tag;
        }

        float localVelocityX = obj.local_velocities.back().twist.linear.x;
        float localVelocityY = obj.local_velocities.back().twist.linear.y;
        float relativeVelocityX =
            obj.relative_velocities.back().twist.linear.x;

        if (abs(localVelocityX) < SPEED_DIFFERENCE_TOLERANCE
                && abs(localVelocityY) < SPEED_DIFFERENCE_TOLERANCE)
        {
            tag.primary_category =
                TagLongitudinalActivity::PRIMARY_STANDING_STILL;
        }
        else if (abs(localVelocityX) > SPEED_DIFFERENCE_TOLERANCE
                && localVelocityX < 0)
        {
            tag.primary_category = TagLongitudinalActivity::PRIMARY_REVERSING;
        }
        else
        {
            tag.primary_category =
                TagLongitudinalActivity::PRIMARY_DRIVING_FORWARD;

            if (abs(relativeVelocityX) < SPEED_DIFFERENCE_TOLERANCE)
            {
                tag.secondary_category =
                    TagLongitudinalActivity::SECONDARY_CRUISING;
            }
            else if (relativeVelocityX > 0)
            {
                tag.secondary_category =
                    TagLongitudinalActivity::SECONDARY_ACCELERATING;
            }
            else
            {
                tag.secondary_category =
                    TagLongitudinalActivity::SECONDARY_BRAKING;
            }
        }

        return tag;
    }
};

BOOST_PYTHON_MODULE(_identifier_longitudinal_activity_cpp)
{
    boost::python::class_<IdentifierLongitudinalActivity>(
        "IdentifierLongitudinalActivity", boost::python::init<>())
        .def("IdentifyTag", &IdentifierLongitudinalActivity::IdentifyTag);
}
