std_msgs/Header header

uint32 id
string label
float32 score
std_msgs/ColorRGBA color
float64 trackedPeriod

geometry_msgs/Pose pose
geometry_msgs/Vector3 dimensions
geometry_msgs/Vector3 variance
geometry_msgs/Twist velocity
geometry_msgs/Twist abs_velocity

geometry_msgs/PolygonStamped convex_hull

bool pose_reliable
bool velocity_reliable

sensor_msgs/PointCloud2 pointcloud

string image_frame
int32 x
int32 y
int32 width
int32 height
float32 angle

string space_frame

# Behavior State of the Detected Object
# FORWARD_STATE			= 0
# STOPPING_STATE 		= 1
# BRANCH_LEFT_STATE		= 2
# BRANCH_RIGHT_STATE	= 3
# YIELDING_STATE		= 4
# ACCELERATING_STATE	= 5
# SLOWDOWN_STATE 		= 6

uint32 behavior_state

geometry_msgs/Point[] history_path
geometry_msgs/Point[] predicted_poses
geometry_msgs/Point[] predicted_variance

PredictedPath[] predicted_paths
geometry_msgs/Twist acceleration

Ars40xClusters radarFusionPoints
CameraObjectFrustum cameraObjectFrustum
int32 overlapObjectsNumber
geometry_msgs/PolygonStamped visibleSegments
geometry_msgs/PolygonStamped image2Dcube
bool isMoving
