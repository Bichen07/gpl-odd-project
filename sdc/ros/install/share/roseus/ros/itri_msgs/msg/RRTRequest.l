;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::RRTRequest)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'RRTRequest (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::RRTREQUEST")
  (make-package "ITRI_MSGS::RRTREQUEST"))

(in-package "ROS")
;;//! \htmlinclude RRTRequest.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*ENTER*" (find-package "ITRI_MSGS::RRTREQUEST"))
(shadow '*ENTER* (find-package "ITRI_MSGS::RRTREQUEST"))
(defconstant itri_msgs::RRTRequest::*ENTER* 0)
(intern "*LEAVE*" (find-package "ITRI_MSGS::RRTREQUEST"))
(shadow '*LEAVE* (find-package "ITRI_MSGS::RRTREQUEST"))
(defconstant itri_msgs::RRTRequest::*LEAVE* 1)
(defclass itri_msgs::RRTRequest
  :super ros::object
  :slots (_header _wait_time _start _end _parking_space _set_radius _radius _directional ))

(defmethod itri_msgs::RRTRequest
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:wait_time __wait_time) 0.0)
    ((:start __start) (instance itri_msgs::CarState :init))
    ((:end __end) (instance itri_msgs::CarState :init))
    ((:parking_space __parking_space) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:set_radius __set_radius) nil)
    ((:radius __radius) 0.0)
    ((:directional __directional) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _wait_time (float __wait_time))
   (setq _start __start)
   (setq _end __end)
   (setq _parking_space __parking_space)
   (setq _set_radius __set_radius)
   (setq _radius (float __radius))
   (setq _directional (round __directional))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:wait_time
   (&optional __wait_time)
   (if __wait_time (setq _wait_time __wait_time)) _wait_time)
  (:start
   (&rest __start)
   (if (keywordp (car __start))
       (send* _start __start)
     (progn
       (if __start (setq _start (car __start)))
       _start)))
  (:end
   (&rest __end)
   (if (keywordp (car __end))
       (send* _end __end)
     (progn
       (if __end (setq _end (car __end)))
       _end)))
  (:parking_space
   (&rest __parking_space)
   (if (keywordp (car __parking_space))
       (send* _parking_space __parking_space)
     (progn
       (if __parking_space (setq _parking_space (car __parking_space)))
       _parking_space)))
  (:set_radius
   (&optional __set_radius)
   (if __set_radius (setq _set_radius __set_radius)) _set_radius)
  (:radius
   (&optional __radius)
   (if __radius (setq _radius __radius)) _radius)
  (:directional
   (&optional __directional)
   (if __directional (setq _directional __directional)) _directional)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _wait_time
    4
    ;; itri_msgs/CarState _start
    (send _start :serialization-length)
    ;; itri_msgs/CarState _end
    (send _end :serialization-length)
    ;; geometry_msgs/Point[] _parking_space
    (apply #'+ (send-all _parking_space :serialization-length)) 4
    ;; bool _set_radius
    1
    ;; float32 _radius
    4
    ;; uint8 _directional
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _wait_time
       (sys::poke _wait_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; itri_msgs/CarState _start
       (send _start :serialize s)
     ;; itri_msgs/CarState _end
       (send _end :serialize s)
     ;; geometry_msgs/Point[] _parking_space
     (write-long (length _parking_space) s)
     (dolist (elem _parking_space)
       (send elem :serialize s)
       )
     ;; bool _set_radius
       (if _set_radius (write-byte -1 s) (write-byte 0 s))
     ;; float32 _radius
       (sys::poke _radius (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _directional
       (write-byte _directional s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _wait_time
     (setq _wait_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; itri_msgs/CarState _start
     (send _start :deserialize buf ptr-) (incf ptr- (send _start :serialization-length))
   ;; itri_msgs/CarState _end
     (send _end :deserialize buf ptr-) (incf ptr- (send _end :serialization-length))
   ;; geometry_msgs/Point[] _parking_space
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _parking_space (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _parking_space)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; bool _set_radius
     (setq _set_radius (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _radius
     (setq _radius (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _directional
     (setq _directional (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::RRTRequest :md5sum-) "45ab4e6a1f02be793e6ab32ee1973a5e")
(setf (get itri_msgs::RRTRequest :datatype-) "itri_msgs/RRTRequest")
(setf (get itri_msgs::RRTRequest :definition-)
      "Header header
float32 wait_time
CarState start
CarState end
geometry_msgs/Point[] parking_space
bool set_radius
float32 radius

uint8 ENTER = 0
uint8 LEAVE = 1
uint8 directional

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
MSG: itri_msgs/CarState
Header header
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



(provide :itri_msgs/RRTRequest "45ab4e6a1f02be793e6ab32ee1973a5e")


