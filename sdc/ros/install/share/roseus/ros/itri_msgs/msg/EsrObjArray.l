;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EsrObjArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EsrObjArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ESROBJARRAY")
  (make-package "ITRI_MSGS::ESROBJARRAY"))

(in-package "ROS")
;;//! \htmlinclude EsrObjArray.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::EsrObjArray
  :super ros::object
  :slots (_header _objs _motion ))

(defmethod itri_msgs::EsrObjArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:objs __objs) (let (r) (dotimes (i 0) (push (instance itri_msgs::EsrObj :init) r)) r))
    ((:motion __motion) (let (r) (dotimes (i 64) (push (instance itri_msgs::EsrMotionPower :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _objs __objs)
   (setq _motion __motion)
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
  (:motion
   (&rest __motion)
   (if (keywordp (car __motion))
       (send* _motion __motion)
     (progn
       (if __motion (setq _motion (car __motion)))
       _motion)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/EsrObj[] _objs
    (apply #'+ (send-all _objs :serialization-length)) 4
    ;; itri_msgs/EsrMotionPower[64] _motion
    (apply #'+ (send-all _motion :serialization-length))
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/EsrObj[] _objs
     (write-long (length _objs) s)
     (dolist (elem _objs)
       (send elem :serialize s)
       )
     ;; itri_msgs/EsrMotionPower[64] _motion
     (dolist (elem _motion)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/EsrObj[] _objs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objs (let (r) (dotimes (i n) (push (instance itri_msgs::EsrObj :init) r)) r))
     (dolist (elem- _objs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/EsrMotionPower[64] _motion
   (dotimes (i 64)
     (send (elt _motion i) :deserialize buf ptr-) (incf ptr- (send (elt _motion i) :serialization-length))
     )
   ;;
   self)
  )

(setf (get itri_msgs::EsrObjArray :md5sum-) "9e3f4db5a2b7e811d4b4df0dff33e220")
(setf (get itri_msgs::EsrObjArray :datatype-) "itri_msgs/EsrObjArray")
(setf (get itri_msgs::EsrObjArray :definition-)
      "Header header
EsrObj[] objs
EsrMotionPower[64] motion

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
MSG: itri_msgs/EsrObj
uint8 trackId
uint8 status
uint8 medRangeMode
geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
bool oncoming
bool isBridge
bool groupingChanged
float32 width
float32 rangeAccel

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
MSG: itri_msgs/EsrMotionPower
bool track_moving
bool track_movable_fast
bool track_movable_slow
int16 track_power

")



(provide :itri_msgs/EsrObjArray "9e3f4db5a2b7e811d4b4df0dff33e220")


