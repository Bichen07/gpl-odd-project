;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ParkingStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ParkingStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PARKINGSTATUS")
  (make-package "ITRI_MSGS::PARKINGSTATUS"))

(in-package "ROS")
;;//! \htmlinclude ParkingStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ParkingStatus
  :super ros::object
  :slots (_header _parking_space _phase ))

(defmethod itri_msgs::ParkingStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:parking_space __parking_space) (instance itri_msgs::ParkingSpace :init))
    ((:phase __phase) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _parking_space __parking_space)
   (setq _phase (round __phase))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:parking_space
   (&rest __parking_space)
   (if (keywordp (car __parking_space))
       (send* _parking_space __parking_space)
     (progn
       (if __parking_space (setq _parking_space (car __parking_space)))
       _parking_space)))
  (:phase
   (&optional __phase)
   (if __phase (setq _phase __phase)) _phase)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/ParkingSpace _parking_space
    (send _parking_space :serialization-length)
    ;; int32 _phase
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/ParkingSpace _parking_space
       (send _parking_space :serialize s)
     ;; int32 _phase
       (write-long _phase s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/ParkingSpace _parking_space
     (send _parking_space :deserialize buf ptr-) (incf ptr- (send _parking_space :serialization-length))
   ;; int32 _phase
     (setq _phase (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::ParkingStatus :md5sum-) "2c35161911edba697231b25bf8199cb1")
(setf (get itri_msgs::ParkingStatus :datatype-) "itri_msgs/ParkingStatus")
(setf (get itri_msgs::ParkingStatus :definition-)
      "Header header

ParkingSpace parking_space
int32 phase

# Type of phase:
# INITIAL   = 0
# PHASE1    = 1
# PHASE2    = 2
# PHASE3    = 3
# FINISH    = 4

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
MSG: itri_msgs/ParkingSpace
Header header

int32 id
int32 type
WaypointArray array

================================================================================
MSG: itri_msgs/WaypointArray
Header header

uint8 FORWARD = 0
uint8 BACKWARD = 1
uint8 direction

uint8 REGULAR = 0
uint8 RRT = 1
uint8 NONE = 2
uint8 type

Waypoint[] waypoints

uint8 updateId
float32 prob

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
")



(provide :itri_msgs/ParkingStatus "2c35161911edba697231b25bf8199cb1")


