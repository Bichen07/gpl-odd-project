#!/usr/bin/env python
from scenario_classification.msg import TagCarriagewayUserType
from scenario_classification.msg import ClassificationObject

class IdentifierCarriagewayUserType:
    def __init__(self):
        pass

    def IdentifyTag(self, msg):
        """
        Args:
            msg: scenario_classification/ClassificationObject
        Returns:
            scenario_classification/TagCarriagewayUserType
        """
        userType = TagCarriagewayUserType()
        if msg.label == "bicycle":
            userType.primary_category = 6
            userType.secondary_category = 22
        elif msg.label == "person":
            userType.primary_category = 6
            userType.secondary_category = 21
        elif msg.label == "motorbike":
            userType.primary_category = 1
            userType.secondary_category = 3
        elif msg.label == "car":
            userType.primary_category = 2
            userType.secondary_category = 5
        elif msg.label == "bus":
            userType.primary_category = 2
            userType.secondary_category = 7
        elif msg.label == "truck":
            userType.primary_category = 3
            userType.secondary_category = 8
        elif msg.label == "traffic_cone":
            userType.primary_category = 0
            userType.secondary_category = 23
        elif msg.label == "construction_vehicle":
            userType.primary_category = 3
            userType.secondary_category = 10
        elif msg.label == "trailer":
            userType.primary_category = 3
            userType.secondary_category = 10
        else:
            userType.primary_category = 0
            userType.secondary_category = 0

        return userType