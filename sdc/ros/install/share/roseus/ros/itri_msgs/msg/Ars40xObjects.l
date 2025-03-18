;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Ars40xObjects)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Ars40xObjects (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ARS40XOBJECTS")
  (make-package "ITRI_MSGS::ARS40XOBJECTS"))

(in-package "ROS")
;;//! \htmlinclude Ars40xObjects.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::Ars40xObjects
  :super ros::object
  :slots (_header _objs ))

(defmethod itri_msgs::Ars40xObjects
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:objs __objs) (let (r) (dotimes (i 0) (push (instance itri_msgs::Ars40xObject :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _objs __objs)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:objs
   (&rest __objs)
   (if (keywordp (car __objs))
       (send* _objs __objs)
     (progn
       (if __objs (setq _objs (car __objs)))
       _objs)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/Ars40xObject[] _objs
    (apply #'+ (send-all _objs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/Ars40xObject[] _objs
     (write-long (length _objs) s)
     (dolist (elem _objs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/Ars40xObject[] _objs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objs (let (r) (dotimes (i n) (push (instance itri_msgs::Ars40xObject :init) r)) r))
     (dolist (elem- _objs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::Ars40xObjects :md5sum-) "4164e9c06a4bd1d54578ef1b78fe9ad7")
(setf (get itri_msgs::Ars40xObjects :datatype-) "itri_msgs/Ars40xObjects")
(setf (get itri_msgs::Ars40xObjects :definition-)
      "Header header
Ars40xObject[] objs
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
MSG: itri_msgs/Ars40xObject
# while persists in consecutive messages - it is the same object, if disappears and appears again - new one
uint8 id

float32 width
float32 length

geometry_msgs/Pose pose
geometry_msgs/Twist velocity
geometry_msgs/Accel acceleration

# dBm^2
float32 radar_cross_section

uint8 POINT = 0
uint8 CAR = 1
uint8 TRUCK = 2
uint8 MOTORCYCLE = 4
uint8 BICYCLE = 5
uint8 WIDE = 6
uint8 Class

uint8 MOVING = 0
uint8 STATIONARY = 1
uint8 ONCOMING = 2
uint8 STATIONARY_CANDIDATE = 3
uint8 UNKNOWN = 4
uint8 CROSSING_STATIONARY = 5
uint8 CROSSING_MOVING = 6
uint8 STOPPED = 7
uint8 dynamic

uint8 DELETED = 0
uint8 NEW_CREATED = 1
uint8 MEASURED = 2
uint8 PREDICTED = 3
uint8 DELETED_FOR_MERGE = 4
uint8 NEW_FROM_MERGE = 5
uint8 measurment

# probability of existence, percentage
float32 probability
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
MSG: geometry_msgs/Accel
# This expresses acceleration in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

")



(provide :itri_msgs/Ars40xObjects "4164e9c06a4bd1d54578ef1b78fe9ad7")


