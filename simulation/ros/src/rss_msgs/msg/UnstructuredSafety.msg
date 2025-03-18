int32 status
int32 response
float64 begin_heading_angle
float64 end_heading_angle
geometry_msgs/Point[] brake_trajectory_set
geometry_msgs/Point[] continue_forward_trajectory_set

int32 STATUS_SAFE = 0
int32 STATUS_DANGEROUS = 2
int32 STATUS_NULL = 3

int32 RESPONSE_NONE = 0
int32 RESPONSE_CONTINUE_FORWARD = 1
int32 RESPONSE_DRIVE_AWAY = 2
int32 RESPONSE_BRAKE = 3
