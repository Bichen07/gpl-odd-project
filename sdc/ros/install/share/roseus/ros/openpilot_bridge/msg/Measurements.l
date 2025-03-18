;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Measurements)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Measurements (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEASUREMENTS")
  (make-package "OPENPILOT_BRIDGE::MEASUREMENTS"))

(in-package "ROS")
;;//! \htmlinclude Measurements.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Measurements
  :super ros::object
  :slots (_header _measurements _clock ))

(defmethod openpilot_bridge::Measurements
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:measurements __measurements) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::Measurement :init) r)) r))
    ((:clock __clock) (instance openpilot_bridge::Clock :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _measurements __measurements)
   (setq _clock __clock)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:measurements
   (&rest __measurements)
   (if (keywordp (car __measurements))
       (send* _measurements __measurements)
     (progn
       (if __measurements (setq _measurements (car __measurements)))
       _measurements)))
  (:clock
   (&rest __clock)
   (if (keywordp (car __clock))
       (send* _clock __clock)
     (progn
       (if __clock (setq _clock (car __clock)))
       _clock)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/Measurement[] _measurements
    (apply #'+ (send-all _measurements :serialization-length)) 4
    ;; openpilot_bridge/Clock _clock
    (send _clock :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/Measurement[] _measurements
     (write-long (length _measurements) s)
     (dolist (elem _measurements)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/Clock _clock
       (send _clock :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/Measurement[] _measurements
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _measurements (let (r) (dotimes (i n) (push (instance openpilot_bridge::Measurement :init) r)) r))
     (dolist (elem- _measurements)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/Clock _clock
     (send _clock :deserialize buf ptr-) (incf ptr- (send _clock :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::Measurements :md5sum-) "415db0e73f1e2a0ab9033dcedb4bc3d3")
(setf (get openpilot_bridge::Measurements :datatype-) "openpilot_bridge/Measurements")
(setf (get openpilot_bridge::Measurements :definition-)
      "Header header

Measurement[] measurements
Clock clock

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



(provide :openpilot_bridge/Measurements "415db0e73f1e2a0ab9033dcedb4bc3d3")


