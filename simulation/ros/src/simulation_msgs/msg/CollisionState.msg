uint8 COLLISION_SIDE_UNKNOWN=0
uint8 COLLISION_SIDE_FRONT=1
uint8 COLLISION_SIDE_LEFT=2
uint8 COLLISION_SIDE_REAR=3
uint8 COLLISION_SIDE_RIGHT=4
uint8 collision_side

uint8 TRAJS_SOURCE_UNKNOWN = 0
uint8 TRAJS_SOURCE_SIMULATION = 1
uint8 TRAJS_SOURCE_ACCIDENTRECORDER = 2
uint8 trajs_source
geometry_msgs/Vector3 size
geometry_msgs/Pose2D pose   # Global Frame
geometry_msgs/Pose2D twist  # Global Frame
geometry_msgs/Pose2D[] trajs  # Global Frame
float32 s
float32 d
float32 s_vel
float32 d_vel

int32 nearest_waypoint_idx_on_nearby_forward_route
int32 nearest_waypoint_idx_on_nearby_opposite_route
int32 nearest_waypoint_idx_on_current_waypoints

float32 lat_dist_to_opposite_lane
float32 forward_included_angle  # with nearest forward waypoint, range [0, PI]
float32 opposite_included_angle

float32 LONGITUDINAL_SPEED_THRESHOLD=0.2
float32 LATERAL_SPEED_THRESHOLD=0.2
bool no_longitudinal_speed_on_frenet
bool no_lateral_speed_on_frenet
bool is_stop
bool vel_reversing
bool heading_reversing
bool in_opposite_lane     # left most, max(d)
bool is_crossing_lane
bool is_crossing_road_bound
bool is_outside_the_road  # right most, min(d)
