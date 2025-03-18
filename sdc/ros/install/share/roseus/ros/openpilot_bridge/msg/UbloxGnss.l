;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::UbloxGnss)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'UbloxGnss (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::UBLOXGNSS")
  (make-package "OPENPILOT_BRIDGE::UBLOXGNSS"))

(in-package "ROS")
;;//! \htmlinclude UbloxGnss.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::UbloxGnss
  :super ros::object
  :slots (_header _ionoData _measurementReport _ephemeris ))

(defmethod openpilot_bridge::UbloxGnss
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:ionoData __ionoData) (instance openpilot_bridge::IonoData :init))
    ((:measurementReport __measurementReport) (instance openpilot_bridge::MeasurementReport :init))
    ((:ephemeris __ephemeris) (instance openpilot_bridge::Ephemeris :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _ionoData __ionoData)
   (setq _measurementReport __measurementReport)
   (setq _ephemeris __ephemeris)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:ionoData
   (&rest __ionoData)
   (if (keywordp (car __ionoData))
       (send* _ionoData __ionoData)
     (progn
       (if __ionoData (setq _ionoData (car __ionoData)))
       _ionoData)))
  (:measurementReport
   (&rest __measurementReport)
   (if (keywordp (car __measurementReport))
       (send* _measurementReport __measurementReport)
     (progn
       (if __measurementReport (setq _measurementReport (car __measurementReport)))
       _measurementReport)))
  (:ephemeris
   (&rest __ephemeris)
   (if (keywordp (car __ephemeris))
       (send* _ephemeris __ephemeris)
     (progn
       (if __ephemeris (setq _ephemeris (car __ephemeris)))
       _ephemeris)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/IonoData _ionoData
    (send _ionoData :serialization-length)
    ;; openpilot_bridge/MeasurementReport _measurementReport
    (send _measurementReport :serialization-length)
    ;; openpilot_bridge/Ephemeris _ephemeris
    (send _ephemeris :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/IonoData _ionoData
       (send _ionoData :serialize s)
     ;; openpilot_bridge/MeasurementReport _measurementReport
       (send _measurementReport :serialize s)
     ;; openpilot_bridge/Ephemeris _ephemeris
       (send _ephemeris :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/IonoData _ionoData
     (send _ionoData :deserialize buf ptr-) (incf ptr- (send _ionoData :serialization-length))
   ;; openpilot_bridge/MeasurementReport _measurementReport
     (send _measurementReport :deserialize buf ptr-) (incf ptr- (send _measurementReport :serialization-length))
   ;; openpilot_bridge/Ephemeris _ephemeris
     (send _ephemeris :deserialize buf ptr-) (incf ptr- (send _ephemeris :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::UbloxGnss :md5sum-) "64057f9ece7684e899d76ef9539f0d83")
(setf (get openpilot_bridge::UbloxGnss :datatype-) "openpilot_bridge/UbloxGnss")
(setf (get openpilot_bridge::UbloxGnss :definition-)
      "Header header

IonoData ionoData
MeasurementReport measurementReport
Ephemeris ephemeris

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
MSG: openpilot_bridge/IonoData
Header header

bool healthValid
float32[] ionoAlpha
float32 tow
float32 gpsWeek
float32[] ionoBeta
int64 svHealth
bool ionoCoeffsValid

================================================================================
MSG: openpilot_bridge/MeasurementReport
Header header

Measurement[] measurements
int64 gpsWeek
int64 numMeas
ReceiverStatus receiverStatus
int64 leapSeconds
float32 rcvTow

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
MSG: openpilot_bridge/ReceiverStatus
Header header

bool leapSecValid
bool clkReset

================================================================================
MSG: openpilot_bridge/Ephemeris
Header header

float32 iodc
float32 fitInterval
int64 month
float32 second
float32 tgd
int64 year
float32 gpsWeek
float32 cus
bool ionoCoeffsValid
int64 svId
float32 svAcc
float32 cuc
float32 m0
float32 toc
float32 deltaN
float32 toe
float32 cic
float32[] ionoBeta
float32 ecc
float32 iDot
float32 i0
float32 svHealth
float32 codesL2
float32 omega
int64 day
int64 minute
float32 a
float32 crs
float32[] ionoAlpha
int64 hour
float32 iode
float32 af1
float32 cis
float32 crc
float32 l2
float32 omegaDot
float32 af0
float32 omega0
float32 af2
float32 transmissionTime

")



(provide :openpilot_bridge/UbloxGnss "64057f9ece7684e899d76ef9539f0d83")


