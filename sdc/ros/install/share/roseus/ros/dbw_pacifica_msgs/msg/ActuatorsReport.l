;; Auto-generated. Do not edit!


(when (boundp 'dbw_pacifica_msgs::ActuatorsReport)
  (if (not (find-package "DBW_PACIFICA_MSGS"))
    (make-package "DBW_PACIFICA_MSGS"))
  (shadow 'ActuatorsReport (find-package "DBW_PACIFICA_MSGS")))
(unless (find-package "DBW_PACIFICA_MSGS::ACTUATORSREPORT")
  (make-package "DBW_PACIFICA_MSGS::ACTUATORSREPORT"))

(in-package "ROS")
;;//! \htmlinclude ActuatorsReport.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass dbw_pacifica_msgs::ActuatorsReport
  :super ros::object
  :slots (_header _turn_signal_state _high_beam_headlights_state _low_beam_headlights_state _front_wiper_state _rear_wiper_state _rolling_counter _ignition_state _rear_left_door_state _rear_right_door_state _liftgate_state _door_lock_state ))

(defmethod dbw_pacifica_msgs::ActuatorsReport
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:turn_signal_state __turn_signal_state) (instance dbw_pacifica_msgs::TurnSignal :init))
    ((:high_beam_headlights_state __high_beam_headlights_state) (instance dbw_pacifica_msgs::HighBeam :init))
    ((:low_beam_headlights_state __low_beam_headlights_state) (instance dbw_pacifica_msgs::LowBeam :init))
    ((:front_wiper_state __front_wiper_state) (instance dbw_pacifica_msgs::WiperFront :init))
    ((:rear_wiper_state __rear_wiper_state) (instance dbw_pacifica_msgs::WiperRear :init))
    ((:rolling_counter __rolling_counter) 0)
    ((:ignition_state __ignition_state) (instance dbw_pacifica_msgs::Ignition :init))
    ((:rear_left_door_state __rear_left_door_state) (instance dbw_pacifica_msgs::Door :init))
    ((:rear_right_door_state __rear_right_door_state) (instance dbw_pacifica_msgs::Door :init))
    ((:liftgate_state __liftgate_state) (instance dbw_pacifica_msgs::Door :init))
    ((:door_lock_state __door_lock_state) (instance dbw_pacifica_msgs::DoorLock :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _turn_signal_state __turn_signal_state)
   (setq _high_beam_headlights_state __high_beam_headlights_state)
   (setq _low_beam_headlights_state __low_beam_headlights_state)
   (setq _front_wiper_state __front_wiper_state)
   (setq _rear_wiper_state __rear_wiper_state)
   (setq _rolling_counter (round __rolling_counter))
   (setq _ignition_state __ignition_state)
   (setq _rear_left_door_state __rear_left_door_state)
   (setq _rear_right_door_state __rear_right_door_state)
   (setq _liftgate_state __liftgate_state)
   (setq _door_lock_state __door_lock_state)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:turn_signal_state
   (&rest __turn_signal_state)
   (if (keywordp (car __turn_signal_state))
       (send* _turn_signal_state __turn_signal_state)
     (progn
       (if __turn_signal_state (setq _turn_signal_state (car __turn_signal_state)))
       _turn_signal_state)))
  (:high_beam_headlights_state
   (&rest __high_beam_headlights_state)
   (if (keywordp (car __high_beam_headlights_state))
       (send* _high_beam_headlights_state __high_beam_headlights_state)
     (progn
       (if __high_beam_headlights_state (setq _high_beam_headlights_state (car __high_beam_headlights_state)))
       _high_beam_headlights_state)))
  (:low_beam_headlights_state
   (&rest __low_beam_headlights_state)
   (if (keywordp (car __low_beam_headlights_state))
       (send* _low_beam_headlights_state __low_beam_headlights_state)
     (progn
       (if __low_beam_headlights_state (setq _low_beam_headlights_state (car __low_beam_headlights_state)))
       _low_beam_headlights_state)))
  (:front_wiper_state
   (&rest __front_wiper_state)
   (if (keywordp (car __front_wiper_state))
       (send* _front_wiper_state __front_wiper_state)
     (progn
       (if __front_wiper_state (setq _front_wiper_state (car __front_wiper_state)))
       _front_wiper_state)))
  (:rear_wiper_state
   (&rest __rear_wiper_state)
   (if (keywordp (car __rear_wiper_state))
       (send* _rear_wiper_state __rear_wiper_state)
     (progn
       (if __rear_wiper_state (setq _rear_wiper_state (car __rear_wiper_state)))
       _rear_wiper_state)))
  (:rolling_counter
   (&optional __rolling_counter)
   (if __rolling_counter (setq _rolling_counter __rolling_counter)) _rolling_counter)
  (:ignition_state
   (&rest __ignition_state)
   (if (keywordp (car __ignition_state))
       (send* _ignition_state __ignition_state)
     (progn
       (if __ignition_state (setq _ignition_state (car __ignition_state)))
       _ignition_state)))
  (:rear_left_door_state
   (&rest __rear_left_door_state)
   (if (keywordp (car __rear_left_door_state))
       (send* _rear_left_door_state __rear_left_door_state)
     (progn
       (if __rear_left_door_state (setq _rear_left_door_state (car __rear_left_door_state)))
       _rear_left_door_state)))
  (:rear_right_door_state
   (&rest __rear_right_door_state)
   (if (keywordp (car __rear_right_door_state))
       (send* _rear_right_door_state __rear_right_door_state)
     (progn
       (if __rear_right_door_state (setq _rear_right_door_state (car __rear_right_door_state)))
       _rear_right_door_state)))
  (:liftgate_state
   (&rest __liftgate_state)
   (if (keywordp (car __liftgate_state))
       (send* _liftgate_state __liftgate_state)
     (progn
       (if __liftgate_state (setq _liftgate_state (car __liftgate_state)))
       _liftgate_state)))
  (:door_lock_state
   (&rest __door_lock_state)
   (if (keywordp (car __door_lock_state))
       (send* _door_lock_state __door_lock_state)
     (progn
       (if __door_lock_state (setq _door_lock_state (car __door_lock_state)))
       _door_lock_state)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; dbw_pacifica_msgs/TurnSignal _turn_signal_state
    (send _turn_signal_state :serialization-length)
    ;; dbw_pacifica_msgs/HighBeam _high_beam_headlights_state
    (send _high_beam_headlights_state :serialization-length)
    ;; dbw_pacifica_msgs/LowBeam _low_beam_headlights_state
    (send _low_beam_headlights_state :serialization-length)
    ;; dbw_pacifica_msgs/WiperFront _front_wiper_state
    (send _front_wiper_state :serialization-length)
    ;; dbw_pacifica_msgs/WiperRear _rear_wiper_state
    (send _rear_wiper_state :serialization-length)
    ;; uint8 _rolling_counter
    1
    ;; dbw_pacifica_msgs/Ignition _ignition_state
    (send _ignition_state :serialization-length)
    ;; dbw_pacifica_msgs/Door _rear_left_door_state
    (send _rear_left_door_state :serialization-length)
    ;; dbw_pacifica_msgs/Door _rear_right_door_state
    (send _rear_right_door_state :serialization-length)
    ;; dbw_pacifica_msgs/Door _liftgate_state
    (send _liftgate_state :serialization-length)
    ;; dbw_pacifica_msgs/DoorLock _door_lock_state
    (send _door_lock_state :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; dbw_pacifica_msgs/TurnSignal _turn_signal_state
       (send _turn_signal_state :serialize s)
     ;; dbw_pacifica_msgs/HighBeam _high_beam_headlights_state
       (send _high_beam_headlights_state :serialize s)
     ;; dbw_pacifica_msgs/LowBeam _low_beam_headlights_state
       (send _low_beam_headlights_state :serialize s)
     ;; dbw_pacifica_msgs/WiperFront _front_wiper_state
       (send _front_wiper_state :serialize s)
     ;; dbw_pacifica_msgs/WiperRear _rear_wiper_state
       (send _rear_wiper_state :serialize s)
     ;; uint8 _rolling_counter
       (write-byte _rolling_counter s)
     ;; dbw_pacifica_msgs/Ignition _ignition_state
       (send _ignition_state :serialize s)
     ;; dbw_pacifica_msgs/Door _rear_left_door_state
       (send _rear_left_door_state :serialize s)
     ;; dbw_pacifica_msgs/Door _rear_right_door_state
       (send _rear_right_door_state :serialize s)
     ;; dbw_pacifica_msgs/Door _liftgate_state
       (send _liftgate_state :serialize s)
     ;; dbw_pacifica_msgs/DoorLock _door_lock_state
       (send _door_lock_state :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; dbw_pacifica_msgs/TurnSignal _turn_signal_state
     (send _turn_signal_state :deserialize buf ptr-) (incf ptr- (send _turn_signal_state :serialization-length))
   ;; dbw_pacifica_msgs/HighBeam _high_beam_headlights_state
     (send _high_beam_headlights_state :deserialize buf ptr-) (incf ptr- (send _high_beam_headlights_state :serialization-length))
   ;; dbw_pacifica_msgs/LowBeam _low_beam_headlights_state
     (send _low_beam_headlights_state :deserialize buf ptr-) (incf ptr- (send _low_beam_headlights_state :serialization-length))
   ;; dbw_pacifica_msgs/WiperFront _front_wiper_state
     (send _front_wiper_state :deserialize buf ptr-) (incf ptr- (send _front_wiper_state :serialization-length))
   ;; dbw_pacifica_msgs/WiperRear _rear_wiper_state
     (send _rear_wiper_state :deserialize buf ptr-) (incf ptr- (send _rear_wiper_state :serialization-length))
   ;; uint8 _rolling_counter
     (setq _rolling_counter (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; dbw_pacifica_msgs/Ignition _ignition_state
     (send _ignition_state :deserialize buf ptr-) (incf ptr- (send _ignition_state :serialization-length))
   ;; dbw_pacifica_msgs/Door _rear_left_door_state
     (send _rear_left_door_state :deserialize buf ptr-) (incf ptr- (send _rear_left_door_state :serialization-length))
   ;; dbw_pacifica_msgs/Door _rear_right_door_state
     (send _rear_right_door_state :deserialize buf ptr-) (incf ptr- (send _rear_right_door_state :serialization-length))
   ;; dbw_pacifica_msgs/Door _liftgate_state
     (send _liftgate_state :deserialize buf ptr-) (incf ptr- (send _liftgate_state :serialization-length))
   ;; dbw_pacifica_msgs/DoorLock _door_lock_state
     (send _door_lock_state :deserialize buf ptr-) (incf ptr- (send _door_lock_state :serialization-length))
   ;;
   self)
  )

(setf (get dbw_pacifica_msgs::ActuatorsReport :md5sum-) "d66d15b164e1cf2d467650778182b722")
(setf (get dbw_pacifica_msgs::ActuatorsReport :datatype-) "dbw_pacifica_msgs/ActuatorsReport")
(setf (get dbw_pacifica_msgs::ActuatorsReport :definition-)
      "Header header

# Turn Signal enumeration
TurnSignal turn_signal_state

# High beams
HighBeam high_beam_headlights_state

# Low beams
LowBeam low_beam_headlights_state

# Windshield Wipers enumeration
WiperFront front_wiper_state
WiperRear rear_wiper_state

# Watchdog counter
uint8 rolling_counter

# Ignition
Ignition ignition_state

# HornState
#HornState

# Door status
Door rear_left_door_state
Door rear_right_door_state
Door liftgate_state

#Door lock
DoorLock door_lock_state

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
MSG: dbw_pacifica_msgs/TurnSignal
uint8 value

uint8 NONE=0
uint8 LEFT=1
uint8 RIGHT=2

================================================================================
MSG: dbw_pacifica_msgs/HighBeam
uint8 status

uint8 OFF = 0
uint8 ON = 1
uint8 FLASH = 2

================================================================================
MSG: dbw_pacifica_msgs/LowBeam
uint8 status

uint8 OFF = 0
uint8 ON = 1
uint8 FLASH = 2

================================================================================
MSG: dbw_pacifica_msgs/WiperFront
uint8 status

uint8 OFF = 0
uint8 INTERVAL_1 = 1
uint8 INTERVAL_2 = 2
uint8 INTERVAL_3 = 3
uint8 INTERVAL_4 = 4
uint8 INTERVAL_5 = 5
uint8 INTERVAL_6 = 6
uint8 CONSTANT_LOW = 11
uint8 CONSTANT_HIGH = 12
uint8 WASH_BRIEF = 13
uint8 WASH_CONTINUOUS = 14

================================================================================
MSG: dbw_pacifica_msgs/WiperRear
uint8 status

uint8 OFF = 0
uint8 INTERVAL_1 = 1
uint8 CONSTANT_LOW = 11
uint8 CONSTANT_HIGH = 12
uint8 WASH_BRIEF = 13
uint8 WASH_CONTINUOUS = 14

================================================================================
MSG: dbw_pacifica_msgs/Ignition
uint8 status

uint8 NO_REQUEST = 0
uint8 FORCE_OFF = 0
uint8 ACCESSORY = 0
uint8 RUN = 0
uint8 CRANK = 0
================================================================================
MSG: dbw_pacifica_msgs/Door
uint8 value

uint8 NO_REQUEST=0
uint8 CLOSE_DOOR=1
uint8 OPEN_DOOR=2

================================================================================
MSG: dbw_pacifica_msgs/DoorLock
uint8 value

uint8 NOREQUEST=0
uint8 UNLOCK=1
uint8 LOCK=2

")



(provide :dbw_pacifica_msgs/ActuatorsReport "d66d15b164e1cf2d467650778182b722")


