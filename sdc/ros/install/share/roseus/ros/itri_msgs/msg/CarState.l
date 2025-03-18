;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::CarState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'CarState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::CARSTATE")
  (make-package "ITRI_MSGS::CARSTATE"))

(in-package "ROS")
;;//! \htmlinclude CarState.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*RANDOM*" (find-package "ITRI_MSGS::CARSTATE"))
(shadow '*RANDOM* (find-package "ITRI_MSGS::CARSTATE"))
(defconstant itri_msgs::CarState::*RANDOM* 0)
(intern "*DIRECTIONAL*" (find-package "ITRI_MSGS::CARSTATE"))
(shadow '*DIRECTIONAL* (find-package "ITRI_MSGS::CARSTATE"))
(defconstant itri_msgs::CarState::*DIRECTIONAL* 1)
(intern "*REVERSE_DIRECTIONAL*" (find-package "ITRI_MSGS::CARSTATE"))
(shadow '*REVERSE_DIRECTIONAL* (find-package "ITRI_MSGS::CARSTATE"))
(defconstant itri_msgs::CarState::*REVERSE_DIRECTIONAL* 2)
(defclass itri_msgs::CarState
  :super ros::object
  :slots (_header _pose _twist _is_stable _sampler_type _acceleration _jerk ))

(defmethod itri_msgs::CarState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pose __pose) (instance geometry_msgs::PoseStamped :init))
    ((:twist __twist) (instance geometry_msgs::TwistStamped :init))
    ((:is_stable __is_stable) nil)
    ((:sampler_type __sampler_type) 0)
    ((:acceleration __acceleration) 0.0)
    ((:jerk __jerk) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _pose __pose)
   (setq _twist __twist)
   (setq _is_stable __is_stable)
   (setq _sampler_type (round __sampler_type))
   (setq _acceleration (float __acceleration))
   (setq _jerk (float __jerk))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:twist
   (&rest __twist)
   (if (keywordp (car __twist))
       (send* _twist __twist)
     (progn
       (if __twist (setq _twist (car __twist)))
       _twist)))
  (:is_stable
   (&optional __is_stable)
   (if __is_stable (setq _is_stable __is_stable)) _is_stable)
  (:sampler_type
   (&optional __sampler_type)
   (if __sampler_type (setq _sampler_type __sampler_type)) _sampler_type)
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:jerk
   (&optional __jerk)
   (if __jerk (setq _jerk __jerk)) _jerk)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/PoseStamped _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/TwistStamped _twist
    (send _twist :serialization-length)
    ;; bool _is_stable
    1
    ;; uint8 _sampler_type
    1
    ;; float32 _acceleration
    4
    ;; float32 _jerk
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/PoseStamped _pose
       (send _pose :serialize s)
     ;; geometry_msgs/TwistStamped _twist
       (send _twist :serialize s)
     ;; bool _is_stable
       (if _is_stable (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _sampler_type
       (write-byte _sampler_type s)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _jerk
       (sys::poke _jerk (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/PoseStamped _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/TwistStamped _twist
     (send _twist :deserialize buf ptr-) (incf ptr- (send _twist :serialization-length))
   ;; bool _is_stable
     (setq _is_stable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _sampler_type
     (setq _sampler_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _jerk
     (setq _jerk (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::CarState :md5sum-) "e29dfa68c85fb4e233bbfc19ecfc0749")
(setf (get itri_msgs::CarState :datatype-) "itri_msgs/CarState")
(setf (get itri_msgs::CarState :definition-)
      "Header header
geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
bool is_stable

uint8 RANDOM = 0
uint8 DIRECTIONAL = 1
uint8 REVERSE_DIRECTIONAL = 2
uint8 sampler_type

float32 acceleration
float32 jerk

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



(provide :itri_msgs/CarState "e29dfa68c85fb4e233bbfc19ecfc0749")


