from geometry_msgs.msg import Vector3, Twist, TwistStamped
from collections import OrderedDict

POSSIBLE_OUTCOMES = OrderedDict([
    ('lead_vehicle', [
        "unknown",
        "irrelevant",
        "following",
        "appearing:cutting_in",
        "appearing:gap_closing",
        "disappearing:cutting_out",
        "disappearing:gap_opening",
    ]),
    ('longitudinal_activity', [
        "unknown",
        "irrelevant",
        "standing_still",
        "reversing",
        "driving_forward:cruising",
        "driving_forward:accelerating",
        "driving_forward:braking",
    ]),
    ('lateral_activity', [
        "unknown",
        "irrelevant",
        "going_straight",
        "turning:left",
        "turning:right",
        "swerving:left",
        "swerving:right",
        "changing_lane:left",
        "changing_lane:right",
    ]),
    ('initial_state_irrelevant', [
        "unknown",
        "true",
        "false"
    ]),
    ('initial_state_direction', [
        "unknown",
        "same_as_ego",
        "on_coming",
        "crossing",
    ]),
    ('initial_state_dynamics', [
        "unknown",
        "standing_still",
        "moving",
    ]),
    ('initial_state_lateral', [
        "unknown",
        "same_lane",
        "left_of_ego",
        "right_of_ego",
    ]),
    ('initial_state_longitudinal', [
        "unknown",
        "in_front_of_ego",
        "rear_of_ego",
        "side_of_ego",
    ]),
])

def get_speed_square(msg):
	if isinstance(msg, TwistStamped):
		linear_twist = msg.twist.linear
	elif isinstance(msg, Twist):
		linear_twist = msg.linear
	elif isinstance(msg, Vector3):
		linear_twist = msg
	else:
		raise TypeError(type(msg))
	vx, vy, vz = linear_twist.x, linear_twist.y, linear_twist.z
	return (vx**2 + vy**2 + vz**2)

def get_speed(msg):
	return get_speed_square(msg)**0.5
