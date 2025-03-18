;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Gnss)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Gnss (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::GNSS")
  (make-package "ITRI_MSGS::GNSS"))

(in-package "ROS")
;;//! \htmlinclude Gnss.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*INVALID*" (find-package "ITRI_MSGS::GNSS"))
(shadow '*INVALID* (find-package "ITRI_MSGS::GNSS"))
(defconstant itri_msgs::Gnss::*INVALID* 0)
(intern "*GPS*" (find-package "ITRI_MSGS::GNSS"))
(shadow '*GPS* (find-package "ITRI_MSGS::GNSS"))
(defconstant itri_msgs::Gnss::*GPS* 1)
(intern "*DGPS*" (find-package "ITRI_MSGS::GNSS"))
(shadow '*DGPS* (find-package "ITRI_MSGS::GNSS"))
(defconstant itri_msgs::Gnss::*DGPS* 2)
(intern "*RTK_FIXED*" (find-package "ITRI_MSGS::GNSS"))
(shadow '*RTK_FIXED* (find-package "ITRI_MSGS::GNSS"))
(defconstant itri_msgs::Gnss::*RTK_FIXED* 4)
(intern "*RTK_FLOAT*" (find-package "ITRI_MSGS::GNSS"))
(shadow '*RTK_FLOAT* (find-package "ITRI_MSGS::GNSS"))
(defconstant itri_msgs::Gnss::*RTK_FLOAT* 5)
(defclass itri_msgs::Gnss
  :super ros::object
  :slots (_header _pose _gps_state _heading_info _gpgga_is_exit ))

(defmethod itri_msgs::Gnss
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:gps_state __gps_state) 0)
    ((:heading_info __heading_info) nil)
    ((:gpgga_is_exit __gpgga_is_exit) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _pose __pose)
   (setq _gps_state (round __gps_state))
   (setq _heading_info __heading_info)
   (setq _gpgga_is_exit __gpgga_is_exit)
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
  (:gps_state
   (&optional __gps_state)
   (if __gps_state (setq _gps_state __gps_state)) _gps_state)
  (:heading_info
   (&optional __heading_info)
   (if __heading_info (setq _heading_info __heading_info)) _heading_info)
  (:gpgga_is_exit
   (&optional __gpgga_is_exit)
   (if __gpgga_is_exit (setq _gpgga_is_exit __gpgga_is_exit)) _gpgga_is_exit)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; uint8 _gps_state
    1
    ;; bool _heading_info
    1
    ;; bool _gpgga_is_exit
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; uint8 _gps_state
       (write-byte _gps_state s)
     ;; bool _heading_info
       (if _heading_info (write-byte -1 s) (write-byte 0 s))
     ;; bool _gpgga_is_exit
       (if _gpgga_is_exit (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; uint8 _gps_state
     (setq _gps_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _heading_info
     (setq _heading_info (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gpgga_is_exit
     (setq _gpgga_is_exit (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::Gnss :md5sum-) "61f647323695d7fb42c71d38c42a68c5")
(setf (get itri_msgs::Gnss :datatype-) "itri_msgs/Gnss")
(setf (get itri_msgs::Gnss :definition-)
      "uint8 INVALID=0
uint8 GPS=1
uint8 DGPS=2
uint8 RTK_FIXED=4
uint8 RTK_FLOAT=5

Header header
geometry_msgs/Pose pose
uint8 gps_state
bool heading_info
bool gpgga_is_exit

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

")



(provide :itri_msgs/Gnss "61f647323695d7fb42c71d38c42a68c5")


