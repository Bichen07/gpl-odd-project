Header header

# image info
string image_topic
sensor_msgs/Image full_image

# semantic map info
int32 id
string[] sign

float32 x_enlarge_factor
float32 y_enlarge_factor
float32 x_offset_factor
float32 y_offset_factor

# traffic_sign_projection info
int32 distance
sensor_msgs/Image roi_image
sensor_msgs/Image tone_map_roi_image

geometry_msgs/Polygon traffic_sign_map_points
geometry_msgs/Polygon traffic_sign_points
sensor_msgs/RegionOfInterest traffic_sign_roi

geometry_msgs/Polygon all_traffic_sign_points
sensor_msgs/RegionOfInterest[] all_traffic_sign_roi

# traffic_sign_detection info
itri_msgs/ImageObj sign_box

# traffic_sign_status info
bool has_sign
