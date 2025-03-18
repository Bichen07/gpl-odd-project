;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CarControl)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CarControl (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CARCONTROL")
  (make-package "OPENPILOT_BRIDGE::CARCONTROL"))

(in-package "ROS")
;;//! \htmlinclude CarControl.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CarControl
  :super ros::object
  :slots (_header _brakeDEPRECATED _gasDEPRECATED _steeringTorqueDEPRECATED _cruiseControl _actuators _active _hudControl _enabled ))

(defmethod openpilot_bridge::CarControl
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:brakeDEPRECATED __brakeDEPRECATED) 0.0)
    ((:gasDEPRECATED __gasDEPRECATED) 0.0)
    ((:steeringTorqueDEPRECATED __steeringTorqueDEPRECATED) 0.0)
    ((:cruiseControl __cruiseControl) (instance openpilot_bridge::CruiseControl :init))
    ((:actuators __actuators) (instance openpilot_bridge::Actuators :init))
    ((:active __active) nil)
    ((:hudControl __hudControl) (instance openpilot_bridge::HUDControl :init))
    ((:enabled __enabled) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _brakeDEPRECATED (float __brakeDEPRECATED))
   (setq _gasDEPRECATED (float __gasDEPRECATED))
   (setq _steeringTorqueDEPRECATED (float __steeringTorqueDEPRECATED))
   (setq _cruiseControl __cruiseControl)
   (setq _actuators __actuators)
   (setq _active __active)
   (setq _hudControl __hudControl)
   (setq _enabled __enabled)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:brakeDEPRECATED
   (&optional __brakeDEPRECATED)
   (if __brakeDEPRECATED (setq _brakeDEPRECATED __brakeDEPRECATED)) _brakeDEPRECATED)
  (:gasDEPRECATED
   (&optional __gasDEPRECATED)
   (if __gasDEPRECATED (setq _gasDEPRECATED __gasDEPRECATED)) _gasDEPRECATED)
  (:steeringTorqueDEPRECATED
   (&optional __steeringTorqueDEPRECATED)
   (if __steeringTorqueDEPRECATED (setq _steeringTorqueDEPRECATED __steeringTorqueDEPRECATED)) _steeringTorqueDEPRECATED)
  (:cruiseControl
   (&rest __cruiseControl)
   (if (keywordp (car __cruiseControl))
       (send* _cruiseControl __cruiseControl)
     (progn
       (if __cruiseControl (setq _cruiseControl (car __cruiseControl)))
       _cruiseControl)))
  (:actuators
   (&rest __actuators)
   (if (keywordp (car __actuators))
       (send* _actuators __actuators)
     (progn
       (if __actuators (setq _actuators (car __actuators)))
       _actuators)))
  (:active
   (&optional __active)
   (if __active (setq _active __active)) _active)
  (:hudControl
   (&rest __hudControl)
   (if (keywordp (car __hudControl))
       (send* _hudControl __hudControl)
     (progn
       (if __hudControl (setq _hudControl (car __hudControl)))
       _hudControl)))
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _brakeDEPRECATED
    4
    ;; float32 _gasDEPRECATED
    4
    ;; float32 _steeringTorqueDEPRECATED
    4
    ;; openpilot_bridge/CruiseControl _cruiseControl
    (send _cruiseControl :serialization-length)
    ;; openpilot_bridge/Actuators _actuators
    (send _actuators :serialization-length)
    ;; bool _active
    1
    ;; openpilot_bridge/HUDControl _hudControl
    (send _hudControl :serialization-length)
    ;; bool _enabled
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _brakeDEPRECATED
       (sys::poke _brakeDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gasDEPRECATED
       (sys::poke _gasDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steeringTorqueDEPRECATED
       (sys::poke _steeringTorqueDEPRECATED (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; openpilot_bridge/CruiseControl _cruiseControl
       (send _cruiseControl :serialize s)
     ;; openpilot_bridge/Actuators _actuators
       (send _actuators :serialize s)
     ;; bool _active
       (if _active (write-byte -1 s) (write-byte 0 s))
     ;; openpilot_bridge/HUDControl _hudControl
       (send _hudControl :serialize s)
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _brakeDEPRECATED
     (setq _brakeDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gasDEPRECATED
     (setq _gasDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steeringTorqueDEPRECATED
     (setq _steeringTorqueDEPRECATED (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; openpilot_bridge/CruiseControl _cruiseControl
     (send _cruiseControl :deserialize buf ptr-) (incf ptr- (send _cruiseControl :serialization-length))
   ;; openpilot_bridge/Actuators _actuators
     (send _actuators :deserialize buf ptr-) (incf ptr- (send _actuators :serialization-length))
   ;; bool _active
     (setq _active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; openpilot_bridge/HUDControl _hudControl
     (send _hudControl :deserialize buf ptr-) (incf ptr- (send _hudControl :serialization-length))
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::CarControl :md5sum-) "5052bf96d04aed7d203247b76e13ddb3")
(setf (get openpilot_bridge::CarControl :datatype-) "openpilot_bridge/CarControl")
(setf (get openpilot_bridge::CarControl :definition-)
      "Header header

float32 brakeDEPRECATED
float32 gasDEPRECATED
float32 steeringTorqueDEPRECATED
CruiseControl cruiseControl
Actuators actuators
bool active
HUDControl hudControl
bool enabled

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
MSG: openpilot_bridge/CruiseControl
Header header

bool cancel
bool override
float32 speedOverride
float32 accelOverride

================================================================================
MSG: openpilot_bridge/Actuators
Header header

float32 brake
float32 gas
float32 steerAngle
float32 steer

================================================================================
MSG: openpilot_bridge/HUDControl
Header header

bool leadVisible
float32 setSpeed
bool leftLaneDepart
bool lanesVisible
bool leftLaneVisible
uint32 visualAlert # enum const: VisualAlert
uint32 audibleAlert # enum const: AudibleAlert
bool speedVisible
bool rightLaneVisible
bool rightLaneDepart

")



(provide :openpilot_bridge/CarControl "5052bf96d04aed7d203247b76e13ddb3")


