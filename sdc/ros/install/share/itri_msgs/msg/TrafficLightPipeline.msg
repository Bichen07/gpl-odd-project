Header header

# image info
string image_topic
sensor_msgs/Image tone_map_full_image
sensor_msgs/Image lights_full_image

# semantic map info
int32 id
string[] light_status
string[] light_rules

float32 x_enlarge_factor
float32 y_enlarge_factor
float32 x_offset_factor
float32 y_offset_factor

# traffic_light_projection info
int32 distance
sensor_msgs/Image tone_map_roi_image
sensor_msgs/Image lights_roi_image
geometry_msgs/Polygon traffic_light_map_points

geometry_msgs/Polygon traffic_light_points
sensor_msgs/RegionOfInterest traffic_light_roi
geometry_msgs/Polygon all_traffic_light_points
sensor_msgs/RegionOfInterest[] all_traffic_light_roi

# traffic_light_detection info
itri_msgs/ImageObj tone_map_detect_light_box
itri_msgs/ImageObj tone_map_detect_light_status
itri_msgs/ImageObj lights_detect_light_status

# traffic_light_merge info
bool merged_result_light_box
bool merged_result_red
bool merged_result_yellow
bool merged_result_green
bool merged_result_left
bool merged_result_straight
bool merged_result_right

# traffic_light_queue info
bool red
bool yellow
bool green
bool left
bool straight
bool right
bool flashred
bool flashyellow
