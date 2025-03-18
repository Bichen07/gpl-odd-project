;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Lateralcontrolstate)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Lateralcontrolstate (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALCONTROLSTATE")
  (make-package "OPENPILOT_BRIDGE::LATERALCONTROLSTATE"))

(in-package "ROS")
;;//! \htmlinclude Lateralcontrolstate.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Lateralcontrolstate
  :super ros::object
  :slots (_header _lqrState _pidState _indiState ))

(defmethod openpilot_bridge::Lateralcontrolstate
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:lqrState __lqrState) (instance openpilot_bridge::LateralLQRState :init))
    ((:pidState __pidState) (instance openpilot_bridge::LateralPIDState :init))
    ((:indiState __indiState) (instance openpilot_bridge::LateralINDIState :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _lqrState __lqrState)
   (setq _pidState __pidState)
   (setq _indiState __indiState)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:lqrState
   (&rest __lqrState)
   (if (keywordp (car __lqrState))
       (send* _lqrState __lqrState)
     (progn
       (if __lqrState (setq _lqrState (car __lqrState)))
       _lqrState)))
  (:pidState
   (&rest __pidState)
   (if (keywordp (car __pidState))
       (send* _pidState __pidState)
     (progn
       (if __pidState (setq _pidState (car __pidState)))
       _pidState)))
  (:indiState
   (&rest __indiState)
   (if (keywordp (car __indiState))
       (send* _indiState __indiState)
     (progn
       (if __indiState (setq _indiState (car __indiState)))
       _indiState)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/LateralLQRState _lqrState
    (send _lqrState :serialization-length)
    ;; openpilot_bridge/LateralPIDState _pidState
    (send _pidState :serialization-length)
    ;; openpilot_bridge/LateralINDIState _indiState
    (send _indiState :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/LateralLQRState _lqrState
       (send _lqrState :serialize s)
     ;; openpilot_bridge/LateralPIDState _pidState
       (send _pidState :serialize s)
     ;; openpilot_bridge/LateralINDIState _indiState
       (send _indiState :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/LateralLQRState _lqrState
     (send _lqrState :deserialize buf ptr-) (incf ptr- (send _lqrState :serialization-length))
   ;; openpilot_bridge/LateralPIDState _pidState
     (send _pidState :deserialize buf ptr-) (incf ptr- (send _pidState :serialization-length))
   ;; openpilot_bridge/LateralINDIState _indiState
     (send _indiState :deserialize buf ptr-) (incf ptr- (send _indiState :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::Lateralcontrolstate :md5sum-) "598a6ef5d0f69fbeaacc25e00cbce69b")
(setf (get openpilot_bridge::Lateralcontrolstate :datatype-) "openpilot_bridge/Lateralcontrolstate")
(setf (get openpilot_bridge::Lateralcontrolstate :definition-)
      "Header header

LateralLQRState lqrState
LateralPIDState pidState
LateralINDIState indiState

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
MSG: openpilot_bridge/LateralLQRState
Header header

bool saturated
float32 i
float32 lqrOutput
bool active
float32 output
float32 steerAngle

================================================================================
MSG: openpilot_bridge/LateralPIDState
Header header

bool saturated
float32 p
float32 steerRate
float32 f
float32 i
float32 angleError
bool active
float32 output
float32 steerAngle

================================================================================
MSG: openpilot_bridge/LateralINDIState
Header header

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

")



(provide :openpilot_bridge/Lateralcontrolstate "598a6ef5d0f69fbeaacc25e00cbce69b")


