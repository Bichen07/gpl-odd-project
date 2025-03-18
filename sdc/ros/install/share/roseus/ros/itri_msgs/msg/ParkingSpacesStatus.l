;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ParkingSpacesStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ParkingSpacesStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PARKINGSPACESSTATUS")
  (make-package "ITRI_MSGS::PARKINGSPACESSTATUS"))

(in-package "ROS")
;;//! \htmlinclude ParkingSpacesStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ParkingSpacesStatus
  :super ros::object
  :slots (_header _spaces ))

(defmethod itri_msgs::ParkingSpacesStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:spaces __spaces) (let (r) (dotimes (i 0) (push (instance itri_msgs::ParkingSpaceStatus :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _spaces __spaces)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:spaces
   (&rest __spaces)
   (if (keywordp (car __spaces))
       (send* _spaces __spaces)
     (progn
       (if __spaces (setq _spaces (car __spaces)))
       _spaces)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/ParkingSpaceStatus[] _spaces
    (apply #'+ (send-all _spaces :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/ParkingSpaceStatus[] _spaces
     (write-long (length _spaces) s)
     (dolist (elem _spaces)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/ParkingSpaceStatus[] _spaces
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _spaces (let (r) (dotimes (i n) (push (instance itri_msgs::ParkingSpaceStatus :init) r)) r))
     (dolist (elem- _spaces)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::ParkingSpacesStatus :md5sum-) "b4c0b116a27f30edc8933f186c0da483")
(setf (get itri_msgs::ParkingSpacesStatus :datatype-) "itri_msgs/ParkingSpacesStatus")
(setf (get itri_msgs::ParkingSpacesStatus :definition-)
      "Header header

ParkingSpaceStatus[] spaces

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
MSG: itri_msgs/ParkingSpaceStatus
Header header

int32 id
int32 type
int32 status
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



(provide :itri_msgs/ParkingSpacesStatus "b4c0b116a27f30edc8933f186c0da483")


