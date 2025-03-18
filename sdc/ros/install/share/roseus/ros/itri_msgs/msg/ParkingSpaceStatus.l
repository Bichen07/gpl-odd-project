;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ParkingSpaceStatus)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ParkingSpaceStatus (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PARKINGSPACESTATUS")
  (make-package "ITRI_MSGS::PARKINGSPACESTATUS"))

(in-package "ROS")
;;//! \htmlinclude ParkingSpaceStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::ParkingSpaceStatus
  :super ros::object
  :slots (_header _id _type _status _array ))

(defmethod itri_msgs::ParkingSpaceStatus
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) 0)
    ((:type __type) 0)
    ((:status __status) 0)
    ((:array __array) (instance itri_msgs::WaypointArray :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _id (round __id))
   (setq _type (round __type))
   (setq _status (round __status))
   (setq _array __array)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:array
   (&rest __array)
   (if (keywordp (car __array))
       (send* _array __array)
     (progn
       (if __array (setq _array (car __array)))
       _array)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _id
    4
    ;; int32 _type
    4
    ;; int32 _status
    4
    ;; itri_msgs/WaypointArray _array
    (send _array :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _id
       (write-long _id s)
     ;; int32 _type
       (write-long _type s)
     ;; int32 _status
       (write-long _status s)
     ;; itri_msgs/WaypointArray _array
       (send _array :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; itri_msgs/WaypointArray _array
     (send _array :deserialize buf ptr-) (incf ptr- (send _array :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::ParkingSpaceStatus :md5sum-) "80fd54c49f4ba8417b790d526b4c3d1e")
(setf (get itri_msgs::ParkingSpaceStatus :datatype-) "itri_msgs/ParkingSpaceStatus")
(setf (get itri_msgs::ParkingSpaceStatus :definition-)
      "Header header

int32 id
int32 type
int32 status
WaypointArray array

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



(provide :itri_msgs/ParkingSpaceStatus "80fd54c49f4ba8417b790d526b4c3d1e")


