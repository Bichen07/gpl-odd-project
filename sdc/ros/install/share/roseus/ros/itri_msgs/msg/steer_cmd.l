;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::steer_cmd)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'steer_cmd (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::STEER_CMD")
  (make-package "ITRI_MSGS::STEER_CMD"))

(in-package "ROS")
;;//! \htmlinclude steer_cmd.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*OPEN_LOOP*" (find-package "ITRI_MSGS::STEER_CMD"))
(shadow '*OPEN_LOOP* (find-package "ITRI_MSGS::STEER_CMD"))
(defconstant itri_msgs::steer_cmd::*OPEN_LOOP* 0)
(intern "*CLOSE_LOOP*" (find-package "ITRI_MSGS::STEER_CMD"))
(shadow '*CLOSE_LOOP* (find-package "ITRI_MSGS::STEER_CMD"))
(defconstant itri_msgs::steer_cmd::*CLOSE_LOOP* 1)
(defclass itri_msgs::steer_cmd
  :super ros::object
  :slots (_header _type _angle _torque ))

(defmethod itri_msgs::steer_cmd
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:type __type) 0)
    ((:angle __angle) 0.0)
    ((:torque __torque) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _type (round __type))
   (setq _angle (float __angle))
   (setq _torque (float __torque))
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
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:torque
   (&optional __torque)
   (if __torque (setq _torque __torque)) _torque)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _type
    1
    ;; float32 _angle
    4
    ;; float32 _torque
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _type
       (write-byte _type s)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _torque
       (sys::poke _torque (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _type
     (setq _type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _torque
     (setq _torque (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::steer_cmd :md5sum-) "0fb12a31a535257274c7d1fffc66590e")
(setf (get itri_msgs::steer_cmd :datatype-) "itri_msgs/steer_cmd")
(setf (get itri_msgs::steer_cmd :definition-)
      "Header header

uint8 OPEN_LOOP = 0
uint8 CLOSE_LOOP = 1

uint8 type
float32 angle
float32 torque

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



(provide :itri_msgs/steer_cmd "0fb12a31a535257274c7d1fffc66590e")


