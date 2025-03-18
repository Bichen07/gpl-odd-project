;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Path)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Path (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PATH")
  (make-package "ITRI_MSGS::PATH"))

(in-package "ROS")
;;//! \htmlinclude Path.msg.html


(defclass itri_msgs::Path
  :super ros::object
  :slots (_waypoints _segments _distances _directions _isParkingPath _parkingInfo _updateId ))

(defmethod itri_msgs::Path
  (:init
   (&key
    ((:waypoints __waypoints) (let (r) (dotimes (i 0) (push (instance itri_msgs::Waypoint :init) r)) r))
    ((:segments __segments) (let (r) (dotimes (i 0) (push (instance itri_msgs::PathSegment :init) r)) r))
    ((:distances __distances) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:directions __directions) (make-array 0 :initial-element 0 :element-type :integer))
    ((:isParkingPath __isParkingPath) nil)
    ((:parkingInfo __parkingInfo) (instance itri_msgs::ParkingInfo :init))
    ((:updateId __updateId) 0)
    )
   (send-super :init)
   (setq _waypoints __waypoints)
   (setq _segments __segments)
   (setq _distances __distances)
   (setq _directions __directions)
   (setq _isParkingPath __isParkingPath)
   (setq _parkingInfo __parkingInfo)
   (setq _updateId (round __updateId))
   self)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:segments
   (&rest __segments)
   (if (keywordp (car __segments))
       (send* _segments __segments)
     (progn
       (if __segments (setq _segments (car __segments)))
       _segments)))
  (:distances
   (&optional __distances)
   (if __distances (setq _distances __distances)) _distances)
  (:directions
   (&optional __directions)
   (if __directions (setq _directions __directions)) _directions)
  (:isParkingPath
   (&optional __isParkingPath)
   (if __isParkingPath (setq _isParkingPath __isParkingPath)) _isParkingPath)
  (:parkingInfo
   (&rest __parkingInfo)
   (if (keywordp (car __parkingInfo))
       (send* _parkingInfo __parkingInfo)
     (progn
       (if __parkingInfo (setq _parkingInfo (car __parkingInfo)))
       _parkingInfo)))
  (:updateId
   (&optional __updateId)
   (if __updateId (setq _updateId __updateId)) _updateId)
  (:serialization-length
   ()
   (+
    ;; itri_msgs/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ;; itri_msgs/PathSegment[] _segments
    (apply #'+ (send-all _segments :serialization-length)) 4
    ;; float64[] _distances
    (* 8    (length _distances)) 4
    ;; uint32[] _directions
    (* 4    (length _directions)) 4
    ;; bool _isParkingPath
    1
    ;; itri_msgs/ParkingInfo _parkingInfo
    (send _parkingInfo :serialization-length)
    ;; uint8 _updateId
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; itri_msgs/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;; itri_msgs/PathSegment[] _segments
     (write-long (length _segments) s)
     (dolist (elem _segments)
       (send elem :serialize s)
       )
     ;; float64[] _distances
     (write-long (length _distances) s)
     (dotimes (i (length _distances))
       (sys::poke (elt _distances i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; uint32[] _directions
     (write-long (length _directions) s)
     (dotimes (i (length _directions))
       (write-long (elt _directions i) s)
       )
     ;; bool _isParkingPath
       (if _isParkingPath (write-byte -1 s) (write-byte 0 s))
     ;; itri_msgs/ParkingInfo _parkingInfo
       (send _parkingInfo :serialize s)
     ;; uint8 _updateId
       (write-byte _updateId s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; itri_msgs/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance itri_msgs::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/PathSegment[] _segments
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _segments (let (r) (dotimes (i n) (push (instance itri_msgs::PathSegment :init) r)) r))
     (dolist (elem- _segments)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float64[] _distances
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _distances (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _distances i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; uint32[] _directions
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _directions (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _directions i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; bool _isParkingPath
     (setq _isParkingPath (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; itri_msgs/ParkingInfo _parkingInfo
     (send _parkingInfo :deserialize buf ptr-) (incf ptr- (send _parkingInfo :serialization-length))
   ;; uint8 _updateId
     (setq _updateId (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::Path :md5sum-) "bbb2b65af491134fde46ec00be05096f")
(setf (get itri_msgs::Path :datatype-) "itri_msgs/Path")
(setf (get itri_msgs::Path :definition-)
      "Waypoint[] waypoints
PathSegment[] segments
float64[] distances
uint32[] directions
bool isParkingPath
ParkingInfo parkingInfo
uint8 updateId

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
MSG: itri_msgs/PathSegment
int32 laneId
int32 startPoint
int32 endPoint
================================================================================
MSG: itri_msgs/ParkingInfo
int32 totalParkingPathCount
int32 currentPathNumber
")



(provide :itri_msgs/Path "bbb2b65af491134fde46ec00be05096f")


