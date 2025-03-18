;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Clock)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Clock (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CLOCK")
  (make-package "OPENPILOT_BRIDGE::CLOCK"))

(in-package "ROS")
;;//! \htmlinclude Clock.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Clock
  :super ros::object
  :slots (_header _hasDriftUncertaintyNanosPerSecond _timeNanos _driftUncertaintyNanosPerSecond _hasBiasNanos _timeUncertaintyNanos _fullBiasNanos _hasLeapSecond _leapSecond _hasTimeUncertaintyNanos _hardwareClockDiscontinuityCount _driftNanosPerSecond _biasNanos _hasDriftNanosPerSecond _hasFullBiasNanos _biasUncertaintyNanos _hasBiasUncertaintyNanos ))

(defmethod openpilot_bridge::Clock
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:hasDriftUncertaintyNanosPerSecond __hasDriftUncertaintyNanosPerSecond) nil)
    ((:timeNanos __timeNanos) 0)
    ((:driftUncertaintyNanosPerSecond __driftUncertaintyNanosPerSecond) 0.0)
    ((:hasBiasNanos __hasBiasNanos) nil)
    ((:timeUncertaintyNanos __timeUncertaintyNanos) 0.0)
    ((:fullBiasNanos __fullBiasNanos) 0)
    ((:hasLeapSecond __hasLeapSecond) nil)
    ((:leapSecond __leapSecond) 0)
    ((:hasTimeUncertaintyNanos __hasTimeUncertaintyNanos) nil)
    ((:hardwareClockDiscontinuityCount __hardwareClockDiscontinuityCount) 0)
    ((:driftNanosPerSecond __driftNanosPerSecond) 0.0)
    ((:biasNanos __biasNanos) 0.0)
    ((:hasDriftNanosPerSecond __hasDriftNanosPerSecond) nil)
    ((:hasFullBiasNanos __hasFullBiasNanos) nil)
    ((:biasUncertaintyNanos __biasUncertaintyNanos) 0.0)
    ((:hasBiasUncertaintyNanos __hasBiasUncertaintyNanos) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _hasDriftUncertaintyNanosPerSecond __hasDriftUncertaintyNanosPerSecond)
   (setq _timeNanos (round __timeNanos))
   (setq _driftUncertaintyNanosPerSecond (float __driftUncertaintyNanosPerSecond))
   (setq _hasBiasNanos __hasBiasNanos)
   (setq _timeUncertaintyNanos (float __timeUncertaintyNanos))
   (setq _fullBiasNanos (round __fullBiasNanos))
   (setq _hasLeapSecond __hasLeapSecond)
   (setq _leapSecond (round __leapSecond))
   (setq _hasTimeUncertaintyNanos __hasTimeUncertaintyNanos)
   (setq _hardwareClockDiscontinuityCount (round __hardwareClockDiscontinuityCount))
   (setq _driftNanosPerSecond (float __driftNanosPerSecond))
   (setq _biasNanos (float __biasNanos))
   (setq _hasDriftNanosPerSecond __hasDriftNanosPerSecond)
   (setq _hasFullBiasNanos __hasFullBiasNanos)
   (setq _biasUncertaintyNanos (float __biasUncertaintyNanos))
   (setq _hasBiasUncertaintyNanos __hasBiasUncertaintyNanos)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:hasDriftUncertaintyNanosPerSecond
   (&optional __hasDriftUncertaintyNanosPerSecond)
   (if __hasDriftUncertaintyNanosPerSecond (setq _hasDriftUncertaintyNanosPerSecond __hasDriftUncertaintyNanosPerSecond)) _hasDriftUncertaintyNanosPerSecond)
  (:timeNanos
   (&optional __timeNanos)
   (if __timeNanos (setq _timeNanos __timeNanos)) _timeNanos)
  (:driftUncertaintyNanosPerSecond
   (&optional __driftUncertaintyNanosPerSecond)
   (if __driftUncertaintyNanosPerSecond (setq _driftUncertaintyNanosPerSecond __driftUncertaintyNanosPerSecond)) _driftUncertaintyNanosPerSecond)
  (:hasBiasNanos
   (&optional __hasBiasNanos)
   (if __hasBiasNanos (setq _hasBiasNanos __hasBiasNanos)) _hasBiasNanos)
  (:timeUncertaintyNanos
   (&optional __timeUncertaintyNanos)
   (if __timeUncertaintyNanos (setq _timeUncertaintyNanos __timeUncertaintyNanos)) _timeUncertaintyNanos)
  (:fullBiasNanos
   (&optional __fullBiasNanos)
   (if __fullBiasNanos (setq _fullBiasNanos __fullBiasNanos)) _fullBiasNanos)
  (:hasLeapSecond
   (&optional __hasLeapSecond)
   (if __hasLeapSecond (setq _hasLeapSecond __hasLeapSecond)) _hasLeapSecond)
  (:leapSecond
   (&optional __leapSecond)
   (if __leapSecond (setq _leapSecond __leapSecond)) _leapSecond)
  (:hasTimeUncertaintyNanos
   (&optional __hasTimeUncertaintyNanos)
   (if __hasTimeUncertaintyNanos (setq _hasTimeUncertaintyNanos __hasTimeUncertaintyNanos)) _hasTimeUncertaintyNanos)
  (:hardwareClockDiscontinuityCount
   (&optional __hardwareClockDiscontinuityCount)
   (if __hardwareClockDiscontinuityCount (setq _hardwareClockDiscontinuityCount __hardwareClockDiscontinuityCount)) _hardwareClockDiscontinuityCount)
  (:driftNanosPerSecond
   (&optional __driftNanosPerSecond)
   (if __driftNanosPerSecond (setq _driftNanosPerSecond __driftNanosPerSecond)) _driftNanosPerSecond)
  (:biasNanos
   (&optional __biasNanos)
   (if __biasNanos (setq _biasNanos __biasNanos)) _biasNanos)
  (:hasDriftNanosPerSecond
   (&optional __hasDriftNanosPerSecond)
   (if __hasDriftNanosPerSecond (setq _hasDriftNanosPerSecond __hasDriftNanosPerSecond)) _hasDriftNanosPerSecond)
  (:hasFullBiasNanos
   (&optional __hasFullBiasNanos)
   (if __hasFullBiasNanos (setq _hasFullBiasNanos __hasFullBiasNanos)) _hasFullBiasNanos)
  (:biasUncertaintyNanos
   (&optional __biasUncertaintyNanos)
   (if __biasUncertaintyNanos (setq _biasUncertaintyNanos __biasUncertaintyNanos)) _biasUncertaintyNanos)
  (:hasBiasUncertaintyNanos
   (&optional __hasBiasUncertaintyNanos)
   (if __hasBiasUncertaintyNanos (setq _hasBiasUncertaintyNanos __hasBiasUncertaintyNanos)) _hasBiasUncertaintyNanos)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _hasDriftUncertaintyNanosPerSecond
    1
    ;; int32 _timeNanos
    4
    ;; float32 _driftUncertaintyNanosPerSecond
    4
    ;; bool _hasBiasNanos
    1
    ;; float32 _timeUncertaintyNanos
    4
    ;; int32 _fullBiasNanos
    4
    ;; bool _hasLeapSecond
    1
    ;; int32 _leapSecond
    4
    ;; bool _hasTimeUncertaintyNanos
    1
    ;; int32 _hardwareClockDiscontinuityCount
    4
    ;; float32 _driftNanosPerSecond
    4
    ;; float32 _biasNanos
    4
    ;; bool _hasDriftNanosPerSecond
    1
    ;; bool _hasFullBiasNanos
    1
    ;; float32 _biasUncertaintyNanos
    4
    ;; bool _hasBiasUncertaintyNanos
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _hasDriftUncertaintyNanosPerSecond
       (if _hasDriftUncertaintyNanosPerSecond (write-byte -1 s) (write-byte 0 s))
     ;; int32 _timeNanos
       (write-long _timeNanos s)
     ;; float32 _driftUncertaintyNanosPerSecond
       (sys::poke _driftUncertaintyNanosPerSecond (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasBiasNanos
       (if _hasBiasNanos (write-byte -1 s) (write-byte 0 s))
     ;; float32 _timeUncertaintyNanos
       (sys::poke _timeUncertaintyNanos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _fullBiasNanos
       (write-long _fullBiasNanos s)
     ;; bool _hasLeapSecond
       (if _hasLeapSecond (write-byte -1 s) (write-byte 0 s))
     ;; int32 _leapSecond
       (write-long _leapSecond s)
     ;; bool _hasTimeUncertaintyNanos
       (if _hasTimeUncertaintyNanos (write-byte -1 s) (write-byte 0 s))
     ;; int32 _hardwareClockDiscontinuityCount
       (write-long _hardwareClockDiscontinuityCount s)
     ;; float32 _driftNanosPerSecond
       (sys::poke _driftNanosPerSecond (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _biasNanos
       (sys::poke _biasNanos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasDriftNanosPerSecond
       (if _hasDriftNanosPerSecond (write-byte -1 s) (write-byte 0 s))
     ;; bool _hasFullBiasNanos
       (if _hasFullBiasNanos (write-byte -1 s) (write-byte 0 s))
     ;; float32 _biasUncertaintyNanos
       (sys::poke _biasUncertaintyNanos (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _hasBiasUncertaintyNanos
       (if _hasBiasUncertaintyNanos (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _hasDriftUncertaintyNanosPerSecond
     (setq _hasDriftUncertaintyNanosPerSecond (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _timeNanos
     (setq _timeNanos (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _driftUncertaintyNanosPerSecond
     (setq _driftUncertaintyNanosPerSecond (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasBiasNanos
     (setq _hasBiasNanos (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _timeUncertaintyNanos
     (setq _timeUncertaintyNanos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _fullBiasNanos
     (setq _fullBiasNanos (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _hasLeapSecond
     (setq _hasLeapSecond (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _leapSecond
     (setq _leapSecond (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _hasTimeUncertaintyNanos
     (setq _hasTimeUncertaintyNanos (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _hardwareClockDiscontinuityCount
     (setq _hardwareClockDiscontinuityCount (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _driftNanosPerSecond
     (setq _driftNanosPerSecond (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _biasNanos
     (setq _biasNanos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasDriftNanosPerSecond
     (setq _hasDriftNanosPerSecond (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _hasFullBiasNanos
     (setq _hasFullBiasNanos (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _biasUncertaintyNanos
     (setq _biasUncertaintyNanos (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _hasBiasUncertaintyNanos
     (setq _hasBiasUncertaintyNanos (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::Clock :md5sum-) "17720c4456ed360b148a53bf937ff2b3")
(setf (get openpilot_bridge::Clock :datatype-) "openpilot_bridge/Clock")
(setf (get openpilot_bridge::Clock :definition-)
      "Header header

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



(provide :openpilot_bridge/Clock "17720c4456ed360b148a53bf937ff2b3")


