;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::ParkingSpaceArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'ParkingSpaceArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PARKINGSPACEARRAY")
  (make-package "ITRI_MSGS::PARKINGSPACEARRAY"))

(in-package "ROS")
;;//! \htmlinclude ParkingSpaceArray.msg.html


(defclass itri_msgs::ParkingSpaceArray
  :super ros::object
  :slots (_spaces ))

(defmethod itri_msgs::ParkingSpaceArray
  (:init
   (&key
    ((:spaces __spaces) (let (r) (dotimes (i 0) (push (instance itri_msgs::ParkingSpace :init) r)) r))
    )
   (send-super :init)
   (setq _spaces __spaces)
   self)
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
    ;; itri_msgs/ParkingSpace[] _spaces
    (apply #'+ (send-all _spaces :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; itri_msgs/ParkingSpace[] _spaces
     (write-long (length _spaces) s)
     (dolist (elem _spaces)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; itri_msgs/ParkingSpace[] _spaces
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _spaces (let (r) (dotimes (i n) (push (instance itri_msgs::ParkingSpace :init) r)) r))
     (dolist (elem- _spaces)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::ParkingSpaceArray :md5sum-) "560ded1967ea6933ff0a5db78942a991")
(setf (get itri_msgs::ParkingSpaceArray :datatype-) "itri_msgs/ParkingSpaceArray")
(setf (get itri_msgs::ParkingSpaceArray :definition-)
      "ParkingSpace[] spaces
================================================================================
MSG: itri_msgs/ParkingSpace
Header header

int32 id
int32 type
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



(provide :itri_msgs/ParkingSpaceArray "560ded1967ea6933ff0a5db78942a991")


