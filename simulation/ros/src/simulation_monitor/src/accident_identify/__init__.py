#!/usr/bin/env python

from accident_type.nlia_forward_accident import NLIAForwardAccident
implemented_accidents = [
    NLIAForwardAccident(), ]

from simulation_monitor.srv import IdentifyAccident, IdentifyAccidentResponse
from accident_identify_node import get_accident_match

def identify_accident(collision_profile):
    identification = IdentifyAccident()
    identification.request.collision_profile = collision_profile
    identification.response = get_accident_match(
        identification.request)
    return identification.response.results