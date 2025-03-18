#ifndef __PARAMETERS_H__
#define __PARAMETERS_H__

/*
Parameters for tag identifiers.
For C++ implementation, just include this file directly.
For Python implementation, the configs is read-in as a text file in
	constructor of TreeOfTagsRunner, so please follow the format strickly.
*/
// General Configuration
constexpr auto IS_SIMULATION = true; // turn off clasification radius and moving threshold
constexpr auto ENABLE_TAG_TREES_MATCHING = true;
constexpr auto EGO_CLASSIFICATION_RADIUS = 30.0f;
constexpr auto VELOCITY_ON_EGO_FRAME = true;  // This varies from branch to branch, needs to be manual checked
constexpr auto TRACKED_PERIOD_HORIZON = 20;  // Only record this amount of history data
constexpr auto SPEED_DIFFERENCE_TOLERANCE = 0.1f;  // Assume velocity is 0 if lower than this threshold
constexpr auto ACCELERATION_DIFFERENCE_TOLERANCE = 0.1f;  // Assume acceleration is 0 if lower than this threshold
constexpr auto MAX_RELEVANT_SAME_DIRECTION_ANGLE = 0.785f;  // 45 degrees
constexpr auto MIN_RELEVANT_ON_COMING_ANGLE = 2.356f;       // 135 degrees
constexpr auto ASSUME_MOVING_SPEED = 1.5f;
constexpr auto MOVING_SPEED_SAMPLING_WIDTH = 10;

// Lead Vehicle
constexpr auto PSYCHOLOGICALLY_STAGGERED_RATIO = 2.0f;  // Lateral allowed range multiplier of ego width to recognized as a leader
constexpr auto ASSUME_CENTER_RATIO = 0.6f;  // Lateral allowed range multiplier of ego width to consider not cutting-in or out
constexpr auto ASSUME_APPEAR_OR_DISAPPEAR = 2.5f;  // Relative long. speed to consider appearing or disappearing
constexpr auto ASSUME_CUT_IN_RATIO = 8.0f;

// Initial State
constexpr auto LATERAL_ASSUME_SAME_LANE_RATIO = 1.2f;  // assume same lane for lateral_position tag
constexpr auto LONGITUDINAL_ASSUME_SIDE_RATIO = 1.2f;  // assume at side for longitudinal_position tag

// Lateral Activity
constexpr auto MIN_TURNING_YAW_RATE = 0.261;    // 15 degrees per second
constexpr auto MAX_POSSIBLE_YAW_RATE = 6.28;    // 360 degrees per second
constexpr auto MIN_SWERVING_SPEED = 11.111f;    // 40 kph
constexpr auto YAWRATE_SAMPLING_WIDTH = 5;
constexpr auto EGO_MIN_STEER_ANGLE = 45.0f;     // degree

#endif
