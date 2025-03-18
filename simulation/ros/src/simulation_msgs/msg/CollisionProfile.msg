std_msgs/Header header
string opponent_id
string opponent_class_id

uint8 COLLISION_ENGINE_BOX2D=0
uint8 COLLISION_ENGINE_OVERLAP=1
uint8 collision_engine

# If collision_engine = 1, contact_point should be the
# center of overlapped area.
geometry_msgs/Point[] contact_points  # Global frame

# Waypoint information
uint8 ROAD_TYPE_UNKNOWN = 0
uint8 ROAD_TYPE_STRAIGHT = 1
uint8 ROAD_TYPE_CURVE = 2
uint8 ROAD_TYPE_INTERSECTION = 3
uint8 road_type

# Route Information
# Nearby routes are from scenario/map_navigation_path service
# Current waypoints are from /waypoints (route_mission_handler/WaypointArray)
path_msgs/RouteWaypoint[] nearby_forward_route
path_msgs/RouteWaypoint[] nearby_opposite_route
itri_msgs/WaypointArray current_waypoints

CollisionState ego
CollisionState agent
