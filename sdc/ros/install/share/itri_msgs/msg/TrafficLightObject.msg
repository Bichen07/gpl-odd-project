bool dontCare
bool green
bool left
bool red
bool right
bool straight
bool yellow
bool flashyellow
bool flashred

bool blocked
geometry_msgs/Polygon traffic_light_map_points
sensor_msgs/RegionOfInterest roi
float32 score

int32 id
float32 distance
float32 remain_sec
string[] lights
sensor_msgs/RegionOfInterest[] lightsroi

uint8 DETECTOR=0
uint8 RSU=1
uint8 source
