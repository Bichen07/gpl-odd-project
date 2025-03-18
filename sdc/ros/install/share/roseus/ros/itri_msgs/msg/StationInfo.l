;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::StationInfo)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'StationInfo (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::STATIONINFO")
  (make-package "ITRI_MSGS::STATIONINFO"))

(in-package "ROS")
;;//! \htmlinclude StationInfo.msg.html


(defclass itri_msgs::StationInfo
  :super ros::object
  :slots (_name _isPass _location _nearPointIndex ))

(defmethod itri_msgs::StationInfo
  (:init
   (&key
    ((:name __name) "")
    ((:isPass __isPass) nil)
    ((:location __location) (instance itri_msgs::Waypoint :init))
    ((:nearPointIndex __nearPointIndex) 0)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _isPass __isPass)
   (setq _location __location)
   (setq _nearPointIndex (round __nearPointIndex))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:isPass
   (&optional __isPass)
   (if __isPass (setq _isPass __isPass)) _isPass)
  (:location
   (&rest __location)
   (if (keywordp (car __location))
       (send* _location __location)
     (progn
       (if __location (setq _location (car __location)))
       _location)))
  (:nearPointIndex
   (&optional __nearPointIndex)
   (if __nearPointIndex (setq _nearPointIndex __nearPointIndex)) _nearPointIndex)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _isPass
    1
    ;; itri_msgs/Waypoint _location
    (send _location :serialization-length)
    ;; int32 _nearPointIndex
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _isPass
       (if _isPass (write-byte -1 s) (write-byte 0 s))
     ;; itri_msgs/Waypoint _location
       (send _location :serialize s)
     ;; int32 _nearPointIndex
       (write-long _nearPointIndex s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _isPass
     (setq _isPass (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; itri_msgs/Waypoint _location
     (send _location :deserialize buf ptr-) (incf ptr- (send _location :serialization-length))
   ;; int32 _nearPointIndex
     (setq _nearPointIndex (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::StationInfo :md5sum-) "e7a3f5a74c48de2ccad6a3ed9c173332")
(setf (get itri_msgs::StationInfo :datatype-) "itri_msgs/StationInfo")
(setf (get itri_msgs::StationInfo :definition-)
      "string name
bool isPass
Waypoint location
int32 nearPointIndex

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
")



(provide :itri_msgs/StationInfo "e7a3f5a74c48de2ccad6a3ed9c173332")


