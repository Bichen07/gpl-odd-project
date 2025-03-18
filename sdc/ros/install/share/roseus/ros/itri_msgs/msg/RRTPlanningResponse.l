;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::RRTPlanningResponse)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'RRTPlanningResponse (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::RRTPLANNINGRESPONSE")
  (make-package "ITRI_MSGS::RRTPLANNINGRESPONSE"))

(in-package "ROS")
;;//! \htmlinclude RRTPlanningResponse.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::RRTPlanningResponse
  :super ros::object
  :slots (_header _valid_request _waypointArrays ))

(defmethod itri_msgs::RRTPlanningResponse
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:valid_request __valid_request) nil)
    ((:waypointArrays __waypointArrays) (let (r) (dotimes (i 0) (push (instance itri_msgs::WaypointArray :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _valid_request __valid_request)
   (setq _waypointArrays __waypointArrays)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:valid_request
   (&optional __valid_request)
   (if __valid_request (setq _valid_request __valid_request)) _valid_request)
  (:waypointArrays
   (&rest __waypointArrays)
   (if (keywordp (car __waypointArrays))
       (send* _waypointArrays __waypointArrays)
     (progn
       (if __waypointArrays (setq _waypointArrays (car __waypointArrays)))
       _waypointArrays)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _valid_request
    1
    ;; itri_msgs/WaypointArray[] _waypointArrays
    (apply #'+ (send-all _waypointArrays :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _valid_request
       (if _valid_request (write-byte -1 s) (write-byte 0 s))
     ;; itri_msgs/WaypointArray[] _waypointArrays
     (write-long (length _waypointArrays) s)
     (dolist (elem _waypointArrays)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _valid_request
     (setq _valid_request (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; itri_msgs/WaypointArray[] _waypointArrays
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypointArrays (let (r) (dotimes (i n) (push (instance itri_msgs::WaypointArray :init) r)) r))
     (dolist (elem- _waypointArrays)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::RRTPlanningResponse :md5sum-) "da3c34a66d10f37158e4a2e93421a6b1")
(setf (get itri_msgs::RRTPlanningResponse :datatype-) "itri_msgs/RRTPlanningResponse")
(setf (get itri_msgs::RRTPlanningResponse :definition-)
      "Header header

bool valid_request
WaypointArray[] waypointArrays

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



(provide :itri_msgs/RRTPlanningResponse "da3c34a66d10f37158e4a2e93421a6b1")


