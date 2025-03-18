;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::WaypointArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'WaypointArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::WAYPOINTARRAY")
  (make-package "ITRI_MSGS::WAYPOINTARRAY"))

(in-package "ROS")
;;//! \htmlinclude WaypointArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*FORWARD*" (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(shadow '*FORWARD* (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(defconstant itri_msgs::WaypointArray::*FORWARD* 0)
(intern "*BACKWARD*" (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(shadow '*BACKWARD* (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(defconstant itri_msgs::WaypointArray::*BACKWARD* 1)
(intern "*REGULAR*" (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(shadow '*REGULAR* (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(defconstant itri_msgs::WaypointArray::*REGULAR* 0)
(intern "*RRT*" (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(shadow '*RRT* (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(defconstant itri_msgs::WaypointArray::*RRT* 1)
(intern "*NONE*" (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(shadow '*NONE* (find-package "ITRI_MSGS::WAYPOINTARRAY"))
(defconstant itri_msgs::WaypointArray::*NONE* 2)
(defclass itri_msgs::WaypointArray
  :super ros::object
  :slots (_header _direction _type _waypoints _updateId _prob ))

(defmethod itri_msgs::WaypointArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:direction __direction) 0)
    ((:type __type) 0)
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance itri_msgs::Waypoint :init) r)) r))
    ((:updateId __updateId) 0)
    ((:prob __prob) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _direction (round __direction))
   (setq _type (round __type))
   (setq _waypoints __waypoints)
   (setq _updateId (round __updateId))
   (setq _prob (float __prob))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:direction
   (&optional __direction)
   (if __direction (setq _direction __direction)) _direction)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:updateId
   (&optional __updateId)
   (if __updateId (setq _updateId __updateId)) _updateId)
  (:prob
   (&optional __prob)
   (if __prob (setq _prob __prob)) _prob)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _direction
    1
    ;; uint8 _type
    1
    ;; itri_msgs/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ;; uint8 _updateId
    1
    ;; float32 _prob
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _direction
       (write-byte _direction s)
     ;; uint8 _type
       (write-byte _type s)
     ;; itri_msgs/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;; uint8 _updateId
       (write-byte _updateId s)
     ;; float32 _prob
       (sys::poke _prob (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _direction
     (setq _direction (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; itri_msgs/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance itri_msgs::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8 _updateId
     (setq _updateId (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _prob
     (setq _prob (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::WaypointArray :md5sum-) "59bb88c37fb9ca7353ec25612718a484")
(setf (get itri_msgs::WaypointArray :datatype-) "itri_msgs/WaypointArray")
(setf (get itri_msgs::WaypointArray :definition-)
      "Header header

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



(provide :itri_msgs/WaypointArray "59bb88c37fb9ca7353ec25612718a484")


