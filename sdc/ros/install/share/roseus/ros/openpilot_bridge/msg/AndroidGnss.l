;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AndroidGnss)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AndroidGnss (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ANDROIDGNSS")
  (make-package "OPENPILOT_BRIDGE::ANDROIDGNSS"))

(in-package "ROS")
;;//! \htmlinclude AndroidGnss.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::AndroidGnss
  :super ros::object
  :slots (_header _navigationMessage _measurements ))

(defmethod openpilot_bridge::AndroidGnss
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:navigationMessage __navigationMessage) (instance openpilot_bridge::NavigationMessage :init))
    ((:measurements __measurements) (instance openpilot_bridge::Measurements :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _navigationMessage __navigationMessage)
   (setq _measurements __measurements)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:navigationMessage
   (&rest __navigationMessage)
   (if (keywordp (car __navigationMessage))
       (send* _navigationMessage __navigationMessage)
     (progn
       (if __navigationMessage (setq _navigationMessage (car __navigationMessage)))
       _navigationMessage)))
  (:measurements
   (&rest __measurements)
   (if (keywordp (car __measurements))
       (send* _measurements __measurements)
     (progn
       (if __measurements (setq _measurements (car __measurements)))
       _measurements)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/NavigationMessage _navigationMessage
    (send _navigationMessage :serialization-length)
    ;; openpilot_bridge/Measurements _measurements
    (send _measurements :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/NavigationMessage _navigationMessage
       (send _navigationMessage :serialize s)
     ;; openpilot_bridge/Measurements _measurements
       (send _measurements :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/NavigationMessage _navigationMessage
     (send _navigationMessage :deserialize buf ptr-) (incf ptr- (send _navigationMessage :serialization-length))
   ;; openpilot_bridge/Measurements _measurements
     (send _measurements :deserialize buf ptr-) (incf ptr- (send _measurements :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::AndroidGnss :md5sum-) "b7e8e88d266ebdcdd6f44e7888ccfd09")
(setf (get openpilot_bridge::AndroidGnss :datatype-) "openpilot_bridge/AndroidGnss")
(setf (get openpilot_bridge::AndroidGnss :definition-)
      "Header header

NavigationMessage navigationMessage
Measurements measurements

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
MSG: openpilot_bridge/NavigationMessage
Header header

uint32 status # enum const: Status
string[] data
int32 svId
int32 messageId
int32 submessageId
int32 type

================================================================================
MSG: openpilot_bridge/Measurements
Header header

Measurement[] measurements
Clock clock

================================================================================
MSG: openpilot_bridge/Measurement
Header header

int64 gnssId
float32 carrierPhaseStdev
float32 pseudorange
float32 doppler
int64 sigId
int64 svId
float32 carrierCycles
float32 dopplerStdev
float32 pseudorangeStdev
int64 cno
int64 locktime
int64 glonassFrequencyIndex
TrackingStatus trackingStatus

================================================================================
MSG: openpilot_bridge/TrackingStatus
Header header

bool halfCycleSubtracted
bool carrierPhaseValid
bool pseudorangeValid
bool halfCycleValid

================================================================================
MSG: openpilot_bridge/Clock
Header header

bool hasDriftUncertaintyNanosPerSecond
int32 timeNanos
float32 driftUncertaintyNanosPerSecond
bool hasBiasNanos
float32 timeUncertaintyNanos
int32 fullBiasNanos
bool hasLeapSecond
int32 leapSecond
bool hasTimeUncertaintyNanos
int32 hardwareClockDiscontinuityCount
float32 driftNanosPerSecond
float32 biasNanos
bool hasDriftNanosPerSecond
bool hasFullBiasNanos
float32 biasUncertaintyNanos
bool hasBiasUncertaintyNanos

")



(provide :openpilot_bridge/AndroidGnss "b7e8e88d266ebdcdd6f44e7888ccfd09")


