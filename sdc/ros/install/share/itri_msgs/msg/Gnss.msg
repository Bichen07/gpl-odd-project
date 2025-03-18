uint8 INVALID=0
uint8 GPS=1
uint8 DGPS=2
uint8 RTK_FIXED=4
uint8 RTK_FLOAT=5

Header header
geometry_msgs/Pose pose
uint8 gps_state
bool heading_info
bool gpgga_is_exit
