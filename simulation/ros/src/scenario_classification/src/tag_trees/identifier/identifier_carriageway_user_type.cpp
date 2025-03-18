#include <boost/python.hpp>

#include <string>
#include <ros/serialization.h>
#include <scenario_classification/ClassificationObject.h>
#include <scenario_classification/TagCarriagewayUserType.h>
#include "utils.cpp"
#include "parameters.h"

class IdentifierCarriagewayUserType
{
public:
	IdentifierCarriagewayUserType() {}
	std::string IdentifyTag(const std::string& str_msg)
	{
		scenario_classification::ClassificationObject obj = FromPython<
            scenario_classification::ClassificationObject>(str_msg);
		scenario_classification::TagCarriagewayUserType userType = _IdentifyTag(obj);
		return ToPython(userType);
	}

private:
    scenario_classification::TagCarriagewayUserType _IdentifyTag(
        scenario_classification::ClassificationObject & msg)
    {
        scenario_classification::TagCarriagewayUserType userType;
        if (msg.label == "bicycle")
        {
            userType.primary_category = 6;
            userType.secondary_category = 22;
        }
        else if (msg.label == "person")
        {
            userType.primary_category = 6;
            userType.secondary_category = 21;
        }
        else if (msg.label == "motorbike")
        {
            userType.primary_category = 1;
            userType.secondary_category = 3;
        }
        else if (msg.label == "car")
        {
            userType.primary_category = 2;
            userType.secondary_category = 5;
        }
        else if (msg.label == "bus")
        {
            userType.primary_category = 2;
            userType.secondary_category = 7;
        }
        else if (msg.label == "truck")
        {
            userType.primary_category = 3;
            userType.secondary_category = 8;
        }
        else if (msg.label == "traffic_cone")
        {
            userType.primary_category = 0;
            userType.secondary_category = 23;
        }
        else if (msg.label == "construction_vehicle")
        {
            userType.primary_category = 3;
            userType.secondary_category = 10;
        }
        else if (msg.label == "trailer")
        {
            userType.primary_category = 3;
            userType.secondary_category = 10;
        }
        else
        {
            userType.primary_category = 0;
            userType.secondary_category = 0;
        }
        return userType;
    }
};

BOOST_PYTHON_MODULE(_identifier_carriageway_user_type_cpp)
{
    boost::python::class_<IdentifierCarriagewayUserType>("IdentifierCarriagewayUserType", boost::python::init<>())
        .def("IdentifyTag", &IdentifierCarriagewayUserType::IdentifyTag);
}