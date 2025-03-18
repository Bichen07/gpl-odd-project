;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::GearReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'GearReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::GEARREPORT")
  (make-package "DBW_PACIFICA_MSGS::GEARREPORT"))

(in-package "ROS")
;;//! \htmlinclude GearReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::GearReport
  :super ros::object
  :slots (_header _state _reject _driver_activity _enabled _gear_select_system_fault _trans_cur_gear ))

(defmethod dbw_pacifica_msgs::GearReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:state __state) (instance dbw_pacifica_msgs::Gear :init))
    ((:reject __reject) nil)
    ((:driver_activity __driver_activity) nil)
    ((:enabled __enabled) nil)
    ((:gear_select_system_fault __gear_select_system_fault) nil)
    ((:trans_cur_gear __trans_cur_gear) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _state __state)
   (setq _reject __reject)
   (setq _driver_activity __driver_activity)
   (setq _enabled __enabled)
   (setq _gear_select_system_fault __gear_select_system_fault)
   (setq _trans_cur_gear (round __trans_cur_gear))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:state
   (&rest __state)
   (if (keywordp (car __state))
       (send* _state __state)
     (progn
       (if __state (setq _state (car __state)))
       _state)))
  (:reject
   (&optional __reject)
   (if __reject (setq _reject __reject)) _reject)
  (:driver_activity
   (&optional __driver_activity)
   (if __driver_activity (setq _driver_activity __driver_activity)) _driver_activity)
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:gear_select_system_fault
   (&optional __gear_select_system_fault)
   (if __gear_select_system_fault (setq _gear_select_system_fault __gear_select_system_fault)) _gear_select_system_fault)
  (:trans_cur_gear
   (&optional __trans_cur_gear)
   (if __trans_cur_gear (setq _trans_cur_gear __trans_cur_gear)) _trans_cur_gear)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; dbw_pacifica_msgs/Gear _state
    (send _state :serialization-length)
    ;; bool _reject
    1
    ;; bool _driver_activity
    1
    ;; bool _enabled
    1
    ;; bool _gear_select_system_fault
    1
    ;; uint8 _trans_cur_gear
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; dbw_pacifica_msgs/Gear _state
       (send _state :serialize s)
     ;; bool _reject
       (if _reject (write-byte -1 s) (write-byte 0 s))
     ;; bool _driver_activity
       (if _driver_activity (write-byte -1 s) (write-byte 0 s))
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;; bool _gear_select_system_fault
       (if _gear_select_system_fault (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _trans_cur_gear
       (write-byte _trans_cur_gear s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; dbw_pacifica_msgs/Gear _state
     (send _state :deserialize buf ptr-) (incf ptr- (send _state :serialization-length))
   ;; bool _reject
     (setq _reject (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _driver_activity
     (setq _driver_activity (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _gear_select_system_fault
     (setq _gear_select_system_fault (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _trans_cur_gear
     (setq _trans_cur_gear (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::GearReport :md5sum-) "82edf69509597cc6f96e7ba84e5d0077")
(setf (get dbw_pacifica_msgs::GearReport :datatype-) "dbw_pacifica_msgs/GearReport")
(setf (get dbw_pacifica_msgs::GearReport :definition-)
      "Header header

# Current gear enumeration
Gear state

# Gear reject flag
bool reject

# Status
bool driver_activity
bool enabled

# Faults
bool gear_select_system_fault

#TransCurGear
uint8 trans_cur_gear

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
MSG: dbw_pacifica_msgs/Gear
uint8 gear

uint8 NONE=0
uint8 PARK=1
uint8 REVERSE=2
uint8 NEUTRAL=3
uint8 DRIVE=4
uint8 LOW=5

")



(provide :dbw_pacifica_msgs/GearReport "82edf69509597cc6f96e7ba84e5d0077")


