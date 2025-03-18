;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::SpeedControlState)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'SpeedControlState (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::SPEEDCONTROLSTATE")
  (make-package "ITRI_MSGS::SPEEDCONTROLSTATE"))

(in-package "ROS")
;;//! \htmlinclude SpeedControlState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::SpeedControlState
  :super ros::object
  :slots (_header _speed_control_enable _CANLostFromECU _CANLostFromEPS _faultDBW _readyAVCU _CANLostFromiBooster _CANLostFrom2024C _CANLostFromAVCU _velocityCmdState _speedCmdState _acceleration _forceComp _target_speed _current_speed _integral_term_action _p_term_action _feedforward_action _brake_pressure_f _brake_pressure_r _brake_pressure_f_tank _brake_pressure_r_tank ))

(defmethod itri_msgs::SpeedControlState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:speed_control_enable __speed_control_enable) nil)
    ((:CANLostFromECU __CANLostFromECU) nil)
    ((:CANLostFromEPS __CANLostFromEPS) nil)
    ((:faultDBW __faultDBW) nil)
    ((:readyAVCU __readyAVCU) nil)
    ((:CANLostFromiBooster __CANLostFromiBooster) nil)
    ((:CANLostFrom2024C __CANLostFrom2024C) nil)
    ((:CANLostFromAVCU __CANLostFromAVCU) nil)
    ((:velocityCmdState __velocityCmdState) 0)
    ((:speedCmdState __speedCmdState) 0)
    ((:acceleration __acceleration) 0.0)
    ((:forceComp __forceComp) 0.0)
    ((:target_speed __target_speed) 0.0)
    ((:current_speed __current_speed) 0.0)
    ((:integral_term_action __integral_term_action) 0.0)
    ((:p_term_action __p_term_action) 0.0)
    ((:feedforward_action __feedforward_action) 0.0)
    ((:brake_pressure_f __brake_pressure_f) 0.0)
    ((:brake_pressure_r __brake_pressure_r) 0.0)
    ((:brake_pressure_f_tank __brake_pressure_f_tank) 0.0)
    ((:brake_pressure_r_tank __brake_pressure_r_tank) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _speed_control_enable __speed_control_enable)
   (setq _CANLostFromECU __CANLostFromECU)
   (setq _CANLostFromEPS __CANLostFromEPS)
   (setq _faultDBW __faultDBW)
   (setq _readyAVCU __readyAVCU)
   (setq _CANLostFromiBooster __CANLostFromiBooster)
   (setq _CANLostFrom2024C __CANLostFrom2024C)
   (setq _CANLostFromAVCU __CANLostFromAVCU)
   (setq _velocityCmdState (round __velocityCmdState))
   (setq _speedCmdState (round __speedCmdState))
   (setq _acceleration (float __acceleration))
   (setq _forceComp (float __forceComp))
   (setq _target_speed (float __target_speed))
   (setq _current_speed (float __current_speed))
   (setq _integral_term_action (float __integral_term_action))
   (setq _p_term_action (float __p_term_action))
   (setq _feedforward_action (float __feedforward_action))
   (setq _brake_pressure_f (float __brake_pressure_f))
   (setq _brake_pressure_r (float __brake_pressure_r))
   (setq _brake_pressure_f_tank (float __brake_pressure_f_tank))
   (setq _brake_pressure_r_tank (float __brake_pressure_r_tank))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:speed_control_enable
   (&optional __speed_control_enable)
   (if __speed_control_enable (setq _speed_control_enable __speed_control_enable)) _speed_control_enable)
  (:CANLostFromECU
   (&optional __CANLostFromECU)
   (if __CANLostFromECU (setq _CANLostFromECU __CANLostFromECU)) _CANLostFromECU)
  (:CANLostFromEPS
   (&optional __CANLostFromEPS)
   (if __CANLostFromEPS (setq _CANLostFromEPS __CANLostFromEPS)) _CANLostFromEPS)
  (:faultDBW
   (&optional __faultDBW)
   (if __faultDBW (setq _faultDBW __faultDBW)) _faultDBW)
  (:readyAVCU
   (&optional __readyAVCU)
   (if __readyAVCU (setq _readyAVCU __readyAVCU)) _readyAVCU)
  (:CANLostFromiBooster
   (&optional __CANLostFromiBooster)
   (if __CANLostFromiBooster (setq _CANLostFromiBooster __CANLostFromiBooster)) _CANLostFromiBooster)
  (:CANLostFrom2024C
   (&optional __CANLostFrom2024C)
   (if __CANLostFrom2024C (setq _CANLostFrom2024C __CANLostFrom2024C)) _CANLostFrom2024C)
  (:CANLostFromAVCU
   (&optional __CANLostFromAVCU)
   (if __CANLostFromAVCU (setq _CANLostFromAVCU __CANLostFromAVCU)) _CANLostFromAVCU)
  (:velocityCmdState
   (&optional __velocityCmdState)
   (if __velocityCmdState (setq _velocityCmdState __velocityCmdState)) _velocityCmdState)
  (:speedCmdState
   (&optional __speedCmdState)
   (if __speedCmdState (setq _speedCmdState __speedCmdState)) _speedCmdState)
  (:acceleration
   (&optional __acceleration)
   (if __acceleration (setq _acceleration __acceleration)) _acceleration)
  (:forceComp
   (&optional __forceComp)
   (if __forceComp (setq _forceComp __forceComp)) _forceComp)
  (:target_speed
   (&optional __target_speed)
   (if __target_speed (setq _target_speed __target_speed)) _target_speed)
  (:current_speed
   (&optional __current_speed)
   (if __current_speed (setq _current_speed __current_speed)) _current_speed)
  (:integral_term_action
   (&optional __integral_term_action)
   (if __integral_term_action (setq _integral_term_action __integral_term_action)) _integral_term_action)
  (:p_term_action
   (&optional __p_term_action)
   (if __p_term_action (setq _p_term_action __p_term_action)) _p_term_action)
  (:feedforward_action
   (&optional __feedforward_action)
   (if __feedforward_action (setq _feedforward_action __feedforward_action)) _feedforward_action)
  (:brake_pressure_f
   (&optional __brake_pressure_f)
   (if __brake_pressure_f (setq _brake_pressure_f __brake_pressure_f)) _brake_pressure_f)
  (:brake_pressure_r
   (&optional __brake_pressure_r)
   (if __brake_pressure_r (setq _brake_pressure_r __brake_pressure_r)) _brake_pressure_r)
  (:brake_pressure_f_tank
   (&optional __brake_pressure_f_tank)
   (if __brake_pressure_f_tank (setq _brake_pressure_f_tank __brake_pressure_f_tank)) _brake_pressure_f_tank)
  (:brake_pressure_r_tank
   (&optional __brake_pressure_r_tank)
   (if __brake_pressure_r_tank (setq _brake_pressure_r_tank __brake_pressure_r_tank)) _brake_pressure_r_tank)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _speed_control_enable
    1
    ;; bool _CANLostFromECU
    1
    ;; bool _CANLostFromEPS
    1
    ;; bool _faultDBW
    1
    ;; bool _readyAVCU
    1
    ;; bool _CANLostFromiBooster
    1
    ;; bool _CANLostFrom2024C
    1
    ;; bool _CANLostFromAVCU
    1
    ;; uint8 _velocityCmdState
    1
    ;; int8 _speedCmdState
    1
    ;; float32 _acceleration
    4
    ;; float32 _forceComp
    4
    ;; float32 _target_speed
    4
    ;; float32 _current_speed
    4
    ;; float32 _integral_term_action
    4
    ;; float32 _p_term_action
    4
    ;; float32 _feedforward_action
    4
    ;; float32 _brake_pressure_f
    4
    ;; float32 _brake_pressure_r
    4
    ;; float32 _brake_pressure_f_tank
    4
    ;; float32 _brake_pressure_r_tank
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _speed_control_enable
       (if _speed_control_enable (write-byte -1 s) (write-byte 0 s))
     ;; bool _CANLostFromECU
       (if _CANLostFromECU (write-byte -1 s) (write-byte 0 s))
     ;; bool _CANLostFromEPS
       (if _CANLostFromEPS (write-byte -1 s) (write-byte 0 s))
     ;; bool _faultDBW
       (if _faultDBW (write-byte -1 s) (write-byte 0 s))
     ;; bool _readyAVCU
       (if _readyAVCU (write-byte -1 s) (write-byte 0 s))
     ;; bool _CANLostFromiBooster
       (if _CANLostFromiBooster (write-byte -1 s) (write-byte 0 s))
     ;; bool _CANLostFrom2024C
       (if _CANLostFrom2024C (write-byte -1 s) (write-byte 0 s))
     ;; bool _CANLostFromAVCU
       (if _CANLostFromAVCU (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _velocityCmdState
       (write-byte _velocityCmdState s)
     ;; int8 _speedCmdState
       (write-byte _speedCmdState s)
     ;; float32 _acceleration
       (sys::poke _acceleration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _forceComp
       (sys::poke _forceComp (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _target_speed
       (sys::poke _target_speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _current_speed
       (sys::poke _current_speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _integral_term_action
       (sys::poke _integral_term_action (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _p_term_action
       (sys::poke _p_term_action (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _feedforward_action
       (sys::poke _feedforward_action (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _brake_pressure_f
       (sys::poke _brake_pressure_f (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _brake_pressure_r
       (sys::poke _brake_pressure_r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _brake_pressure_f_tank
       (sys::poke _brake_pressure_f_tank (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _brake_pressure_r_tank
       (sys::poke _brake_pressure_r_tank (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _speed_control_enable
     (setq _speed_control_enable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _CANLostFromECU
     (setq _CANLostFromECU (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _CANLostFromEPS
     (setq _CANLostFromEPS (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _faultDBW
     (setq _faultDBW (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _readyAVCU
     (setq _readyAVCU (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _CANLostFromiBooster
     (setq _CANLostFromiBooster (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _CANLostFrom2024C
     (setq _CANLostFrom2024C (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _CANLostFromAVCU
     (setq _CANLostFromAVCU (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _velocityCmdState
     (setq _velocityCmdState (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int8 _speedCmdState
     (setq _speedCmdState (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _speedCmdState 127) (setq _speedCmdState (- _speedCmdState 256)))
   ;; float32 _acceleration
     (setq _acceleration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _forceComp
     (setq _forceComp (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _target_speed
     (setq _target_speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _current_speed
     (setq _current_speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _integral_term_action
     (setq _integral_term_action (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _p_term_action
     (setq _p_term_action (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _feedforward_action
     (setq _feedforward_action (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _brake_pressure_f
     (setq _brake_pressure_f (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _brake_pressure_r
     (setq _brake_pressure_r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _brake_pressure_f_tank
     (setq _brake_pressure_f_tank (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _brake_pressure_r_tank
     (setq _brake_pressure_r_tank (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::SpeedControlState :md5sum-) "78bc1c667e28edd5e1f5d662fd51ba0b")
(setf (get itri_msgs::SpeedControlState :datatype-) "itri_msgs/SpeedControlState")
(setf (get itri_msgs::SpeedControlState :definition-)
      "Header header

bool speed_control_enable
bool CANLostFromECU
bool CANLostFromEPS
bool faultDBW
bool readyAVCU
bool CANLostFromiBooster
bool CANLostFrom2024C
bool CANLostFromAVCU
uint8 velocityCmdState
int8 speedCmdState
float32 acceleration
float32 forceComp
float32 target_speed
float32 current_speed
float32 integral_term_action
float32 p_term_action
float32 feedforward_action
float32 brake_pressure_f
float32 brake_pressure_r
float32 brake_pressure_f_tank
float32 brake_pressure_r_tank

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



(provide :itri_msgs/SpeedControlState "78bc1c667e28edd5e1f5d662fd51ba0b")


