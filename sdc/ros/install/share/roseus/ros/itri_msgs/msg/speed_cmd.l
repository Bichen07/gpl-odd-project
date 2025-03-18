;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::speed_cmd)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'speed_cmd (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::SPEED_CMD")
  (make-package "ITRI_MSGS::SPEED_CMD"))

(in-package "ROS")
;;//! \htmlinclude speed_cmd.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*OPEN_LOOP*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*OPEN_LOOP* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*OPEN_LOOP* 0)
(intern "*CLOSE_LOOP*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*CLOSE_LOOP* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*CLOSE_LOOP* 1)
(intern "*NON_DEFINE*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*NON_DEFINE* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*NON_DEFINE* 0)
(intern "*ACCELERATION*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*ACCELERATION* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*ACCELERATION* 1)
(intern "*CONSTANT_SPEED*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*CONSTANT_SPEED* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*CONSTANT_SPEED* 2)
(intern "*DEACCELERATION*" (find-package "ITRI_MSGS::SPEED_CMD"))
(shadow '*DEACCELERATION* (find-package "ITRI_MSGS::SPEED_CMD"))
(defconstant itri_msgs::speed_cmd::*DEACCELERATION* 3)
(defclass itri_msgs::speed_cmd
  :super ros::object
  :slots (_header _type _kph _acceleration _velocityCmdState ))

(defmethod itri_msgs::speed_cmd
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:kph __kph) 0.0)
    ((:acceleration __acceleration) 0.0)
    ((:velocityCmdState __velocityCmdState) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _kph (float __kph))
   (setq _acceleration (float __acceleration))
   (setq _velocityCmdState (round __velocityCmdState))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:kph
   (&optional __kph)
   (if __kph (setq _kph __kph)) _kph)
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:velocityCmdState
   (&optional __velocityCmdState)
   (if __velocityCmdState (setq _velocityCmdState __velocityCmdState)) _velocityCmdState)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _type
    1
    ;; float32 _kph
    4
    ;; float32 _acceleration
    4
    ;; uint8 _velocityCmdState
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _type
       (write-byte _type s)
     ;; float32 _kph
       (sys::poke _kph (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _velocityCmdState
       (write-byte _velocityCmdState s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _kph
     (setq _kph (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _velocityCmdState
     (setq _velocityCmdState (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::speed_cmd :md5sum-) "72fdcf92cab2efe452f034bb122ac210")
(setf (get itri_msgs::speed_cmd :datatype-) "itri_msgs/speed_cmd")
(setf (get itri_msgs::speed_cmd :definition-)
      "Header header

uint8 OPEN_LOOP = 0
uint8 CLOSE_LOOP = 1

uint8 NON_DEFINE = 0
uint8 ACCELERATION = 1
uint8 CONSTANT_SPEED = 2
uint8 DEACCELERATION = 3

uint8 type
float32 kph
float32 acceleration
uint8 velocityCmdState

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

")



(provide :itri_msgs/speed_cmd "72fdcf92cab2efe452f034bb122ac210")


