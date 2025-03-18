;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::lane_waypoints_info)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'lane_waypoints_info (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LANE_WAYPOINTS_INFO")
  (make-package "ITRI_MSGS::LANE_WAYPOINTS_INFO"))

(in-package "ROS")
;;//! \htmlinclude lane_waypoints_info.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::lane_waypoints_info
  :super ros::object
  :slots (_header _point ))

(defmethod itri_msgs::lane_waypoints_info
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:point __point) (let (r) (dotimes (i 0) (push (instance itri_msgs::lane_info :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _point __point)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:point
   (&rest __point)
   (if (keywordp (car __point))
       (send* _point __point)
     (progn
       (if __point (setq _point (car __point)))
       _point)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/lane_info[] _point
    (apply #'+ (send-all _point :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/lane_info[] _point
     (write-long (length _point) s)
     (dolist (elem _point)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/lane_info[] _point
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _point (let (r) (dotimes (i n) (push (instance itri_msgs::lane_info :init) r)) r))
     (dolist (elem- _point)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::lane_waypoints_info :md5sum-) "01267141f4f69eaeb661c3d3af07f166")
(setf (get itri_msgs::lane_waypoints_info :datatype-) "itri_msgs/lane_waypoints_info")
(setf (get itri_msgs::lane_waypoints_info :definition-)
      "Header header

lane_info[] point

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: itri_msgs/lane_info
Header header
int32 lane_id   #current lane
int32 lane_num  #total number of lane
float32 lane_width

string[] line_pos

# Right = 'R'
# Left  = 'L'
# Front = 'F'

uint32[] line_type

# EMPTY = 0
# WHITE_DASHED_LINE = 1
# WHITE_SOLID_LINE = 2
# WHITE_DOUBLE_LINE = 3
# YELLOW_DASHED_LINE
# YELLOW_SOLID_LINE
# YELLOW_DOUBLE_LINE
# RED_SOLID_LINE
# STRAIGHT_ARROW
# TURN_LEFT_ARROW
# TURN_RIGHT_ARROW
# STRAIGHT_OR_RIGHT_ARROW
# STRAIGHT_OR_LEFT_ARROW
# TURN_RIGHT_ONLY
# STOP_LINE
# LONGER_BUMP
# SHORTER_BUMP
# SLOWDOWN
# YIELD
# STOP_SIGN
# SPEED_LIMIT_20KPH
# SPEED_LIMIT_30KPH
# SPEED_LIMIT_50KPH
# SCOOTER_PARKING_PLACE
# PARKING_SPACE

float64 front_line_dis

bool[] on_route_hint
int32[] traffic_stop_line
int32[] bumper
int32[] start_right_turn
int32[] end_right_turn
int32[] start_left_turn
int32[] end_left_turn

Waypoint front_marker_point

StationInfo[] stations
string station_msg

float64 remind_distance
int32 remind_time

int32 turn_type
float64 length_to_turn

================================================================================
MSG: itri_msgs/Waypoint
geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
int32 laneId
int32 pointId
geometry_msgs/Point point
float32 heading
float32 curvature
float32 speed_limit
int32 point_id
int32 lane_id
int32 nroad_id
float32 s
float32 d
float32 left_space
float32 right_space
float32 width
int32 road_type

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/TwistStamped
# A twist with reference coordinate frame and timestamp
Header header
Twist twist

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: itri_msgs/StationInfo
string name
bool isPass
Waypoint location
int32 nearPointIndex

")



(provide :itri_msgs/lane_waypoints_info "01267141f4f69eaeb661c3d3af07f166")


