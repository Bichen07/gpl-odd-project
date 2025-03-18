;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EmergencyCmd)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EmergencyCmd (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::EMERGENCYCMD")
  (make-package "ITRI_MSGS::EMERGENCYCMD"))

(in-package "ROS")
;;//! \htmlinclude EmergencyCmd.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*DEFAULT_STATE*" (find-package "ITRI_MSGS::EMERGENCYCMD"))
(shadow '*DEFAULT_STATE* (find-package "ITRI_MSGS::EMERGENCYCMD"))
(defconstant itri_msgs::EmergencyCmd::*DEFAULT_STATE* -1)
(intern "*RESUME_STATE*" (find-package "ITRI_MSGS::EMERGENCYCMD"))
(shadow '*RESUME_STATE* (find-package "ITRI_MSGS::EMERGENCYCMD"))
(defconstant itri_msgs::EmergencyCmd::*RESUME_STATE* 0)
(intern "*HARD_BRAKE*" (find-package "ITRI_MSGS::EMERGENCYCMD"))
(shadow '*HARD_BRAKE* (find-package "ITRI_MSGS::EMERGENCYCMD"))
(defconstant itri_msgs::EmergencyCmd::*HARD_BRAKE* 1)
(intern "*MILD_BRAKE*" (find-package "ITRI_MSGS::EMERGENCYCMD"))
(shadow '*MILD_BRAKE* (find-package "ITRI_MSGS::EMERGENCYCMD"))
(defconstant itri_msgs::EmergencyCmd::*MILD_BRAKE* 2)
(defclass itri_msgs::EmergencyCmd
  :super ros::object
  :slots (_header _emergency_cmd ))

(defmethod itri_msgs::EmergencyCmd
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:emergency_cmd __emergency_cmd) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _emergency_cmd (round __emergency_cmd))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:emergency_cmd
   (&optional __emergency_cmd)
   (if __emergency_cmd (setq _emergency_cmd __emergency_cmd)) _emergency_cmd)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _emergency_cmd
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _emergency_cmd
       (write-long _emergency_cmd s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _emergency_cmd
     (setq _emergency_cmd (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::EmergencyCmd :md5sum-) "b8e8a1e8d9087c63356a16f614d5bb5e")
(setf (get itri_msgs::EmergencyCmd :datatype-) "itri_msgs/EmergencyCmd")
(setf (get itri_msgs::EmergencyCmd :definition-)
      "Header header

int32 DEFAULT_STATE = -1
int32 RESUME_STATE = 0
int32 HARD_BRAKE = 1
int32 MILD_BRAKE = 2

int32 emergency_cmd

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



(provide :itri_msgs/EmergencyCmd "b8e8a1e8d9087c63356a16f614d5bb5e")


