;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LateralINDIState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LateralINDIState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALINDISTATE")
  (make-package "OPENPILOT_BRIDGE::LATERALINDISTATE"))

(in-package "ROS")
;;//! \htmlinclude LateralINDIState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LateralINDIState
  :super ros::object
  :slots (_header _rateSetPoint _delayedOutput _saturated _steerAccel _steerRate _delta _accelError _accelSetPoint _active _output _steerAngle ))

(defmethod openpilot_bridge::LateralINDIState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rateSetPoint __rateSetPoint) 0.0)
    ((:delayedOutput __delayedOutput) 0.0)
    ((:saturated __saturated) nil)
    ((:steerAccel __steerAccel) 0.0)
    ((:steerRate __steerRate) 0.0)
    ((:delta __delta) 0.0)
    ((:accelError __accelError) 0.0)
    ((:accelSetPoint __accelSetPoint) 0.0)
    ((:active __active) nil)
    ((:output __output) 0.0)
    ((:steerAngle __steerAngle) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _rateSetPoint (float __rateSetPoint))
   (setq _delayedOutput (float __delayedOutput))
   (setq _saturated __saturated)
   (setq _steerAccel (float __steerAccel))
   (setq _steerRate (float __steerRate))
   (setq _delta (float __delta))
   (setq _accelError (float __accelError))
   (setq _accelSetPoint (float __accelSetPoint))
   (setq _active __active)
   (setq _output (float __output))
   (setq _steerAngle (float __steerAngle))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rateSetPoint
   (&optional __rateSetPoint)
   (if __rateSetPoint (setq _rateSetPoint __rateSetPoint)) _rateSetPoint)
  (:delayedOutput
   (&optional __delayedOutput)
   (if __delayedOutput (setq _delayedOutput __delayedOutput)) _delayedOutput)
  (:saturated
   (&optional __saturated)
   (if __saturated (setq _saturated __saturated)) _saturated)
  (:steerAccel
   (&optional __steerAccel)
   (if __steerAccel (setq _steerAccel __steerAccel)) _steerAccel)
  (:steerRate
   (&optional __steerRate)
   (if __steerRate (setq _steerRate __steerRate)) _steerRate)
  (:delta
   (&optional __delta)
   (if __delta (setq _delta __delta)) _delta)
  (:accelError
   (&optional __accelError)
   (if __accelError (setq _accelError __accelError)) _accelError)
  (:accelSetPoint
   (&optional __accelSetPoint)
   (if __accelSetPoint (setq _accelSetPoint __accelSetPoint)) _accelSetPoint)
  (:active
   (&optional __active)
   (if __active (setq _active __active)) _active)
  (:output
   (&optional __output)
   (if __output (setq _output __output)) _output)
  (:steerAngle
   (&optional __steerAngle)
   (if __steerAngle (setq _steerAngle __steerAngle)) _steerAngle)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _rateSetPoint
    4
    ;; float32 _delayedOutput
    4
    ;; bool _saturated
    1
    ;; float32 _steerAccel
    4
    ;; float32 _steerRate
    4
    ;; float32 _delta
    4
    ;; float32 _accelError
    4
    ;; float32 _accelSetPoint
    4
    ;; bool _active
    1
    ;; float32 _output
    4
    ;; float32 _steerAngle
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _rateSetPoint
       (sys::poke _rateSetPoint (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delayedOutput
       (sys::poke _delayedOutput (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _saturated
       (if _saturated (write-byte -1 s) (write-byte 0 s))
     ;; float32 _steerAccel
       (sys::poke _steerAccel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerRate
       (sys::poke _steerRate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _delta
       (sys::poke _delta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accelError
       (sys::poke _accelError (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accelSetPoint
       (sys::poke _accelSetPoint (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _active
       (if _active (write-byte -1 s) (write-byte 0 s))
     ;; float32 _output
       (sys::poke _output (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerAngle
       (sys::poke _steerAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _rateSetPoint
     (setq _rateSetPoint (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delayedOutput
     (setq _delayedOutput (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _saturated
     (setq _saturated (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _steerAccel
     (setq _steerAccel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerRate
     (setq _steerRate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _delta
     (setq _delta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accelError
     (setq _accelError (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accelSetPoint
     (setq _accelSetPoint (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _active
     (setq _active (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _output
     (setq _output (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerAngle
     (setq _steerAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LateralINDIState :md5sum-) "bd5a4c19a89365a4aac92df08c09943f")
(setf (get openpilot_bridge::LateralINDIState :datatype-) "openpilot_bridge/LateralINDIState")
(setf (get openpilot_bridge::LateralINDIState :definition-)
      "Header header

float32 rateSetPoint
float32 delayedOutput
bool saturated
float32 steerAccel
float32 steerRate
float32 delta
float32 accelError
float32 accelSetPoint
bool active
float32 output
float32 steerAngle

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



(provide :openpilot_bridge/LateralINDIState "bd5a4c19a89365a4aac92df08c09943f")


