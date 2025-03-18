;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::QcomGnss)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'QcomGnss (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::QCOMGNSS")
  (make-package "OPENPILOT_BRIDGE::QCOMGNSS"))

(in-package "ROS")
;;//! \htmlinclude QcomGnss.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::QcomGnss
  :super ros::object
  :slots (_header _rawLog _measurementReport _logTs _drSvPoly _clockReport _drMeasurementReport ))

(defmethod openpilot_bridge::QcomGnss
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rawLog __rawLog) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:measurementReport __measurementReport) (instance openpilot_bridge::MeasurementReport :init))
    ((:logTs __logTs) 0)
    ((:drSvPoly __drSvPoly) (instance openpilot_bridge::DrSvPolyReport :init))
    ((:clockReport __clockReport) (instance openpilot_bridge::ClockReport :init))
    ((:drMeasurementReport __drMeasurementReport) (instance openpilot_bridge::DrMeasurementReport :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _rawLog __rawLog)
   (setq _measurementReport __measurementReport)
   (setq _logTs (round __logTs))
   (setq _drSvPoly __drSvPoly)
   (setq _clockReport __clockReport)
   (setq _drMeasurementReport __drMeasurementReport)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rawLog
   (&optional __rawLog)
   (if __rawLog (setq _rawLog __rawLog)) _rawLog)
  (:measurementReport
   (&rest __measurementReport)
   (if (keywordp (car __measurementReport))
       (send* _measurementReport __measurementReport)
     (progn
       (if __measurementReport (setq _measurementReport (car __measurementReport)))
       _measurementReport)))
  (:logTs
   (&optional __logTs)
   (if __logTs (setq _logTs __logTs)) _logTs)
  (:drSvPoly
   (&rest __drSvPoly)
   (if (keywordp (car __drSvPoly))
       (send* _drSvPoly __drSvPoly)
     (progn
       (if __drSvPoly (setq _drSvPoly (car __drSvPoly)))
       _drSvPoly)))
  (:clockReport
   (&rest __clockReport)
   (if (keywordp (car __clockReport))
       (send* _clockReport __clockReport)
     (progn
       (if __clockReport (setq _clockReport (car __clockReport)))
       _clockReport)))
  (:drMeasurementReport
   (&rest __drMeasurementReport)
   (if (keywordp (car __drMeasurementReport))
       (send* _drMeasurementReport __drMeasurementReport)
     (progn
       (if __drMeasurementReport (setq _drMeasurementReport (car __drMeasurementReport)))
       _drMeasurementReport)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _rawLog
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _rawLog)) 4
    ;; openpilot_bridge/MeasurementReport _measurementReport
    (send _measurementReport :serialization-length)
    ;; int64 _logTs
    8
    ;; openpilot_bridge/DrSvPolyReport _drSvPoly
    (send _drSvPoly :serialization-length)
    ;; openpilot_bridge/ClockReport _clockReport
    (send _clockReport :serialization-length)
    ;; openpilot_bridge/DrMeasurementReport _drMeasurementReport
    (send _drMeasurementReport :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _rawLog
     (write-long (length _rawLog) s)
     (dolist (elem _rawLog)
       (write-long (length elem) s) (princ elem s)
       )
     ;; openpilot_bridge/MeasurementReport _measurementReport
       (send _measurementReport :serialize s)
     ;; int64 _logTs
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _logTs (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _logTs) (= (length (_logTs . bv)) 2)) ;; bignum
              (write-long (ash (elt (_logTs . bv) 0) 0) s)
              (write-long (ash (elt (_logTs . bv) 1) -1) s))
             ((and (class _logTs) (= (length (_logTs . bv)) 1)) ;; big1
              (write-long (elt (_logTs . bv) 0) s)
              (write-long (if (>= _logTs 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _logTs s)(write-long (if (>= _logTs 0) 0 #xffffffff) s)))
     ;; openpilot_bridge/DrSvPolyReport _drSvPoly
       (send _drSvPoly :serialize s)
     ;; openpilot_bridge/ClockReport _clockReport
       (send _clockReport :serialize s)
     ;; openpilot_bridge/DrMeasurementReport _drMeasurementReport
       (send _drMeasurementReport :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _rawLog
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rawLog (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _rawLog i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; openpilot_bridge/MeasurementReport _measurementReport
     (send _measurementReport :deserialize buf ptr-) (incf ptr- (send _measurementReport :serialization-length))
   ;; int64 _logTs
#+(or :alpha :irix6 :x86_64)
      (setf _logTs (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _logTs (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; openpilot_bridge/DrSvPolyReport _drSvPoly
     (send _drSvPoly :deserialize buf ptr-) (incf ptr- (send _drSvPoly :serialization-length))
   ;; openpilot_bridge/ClockReport _clockReport
     (send _clockReport :deserialize buf ptr-) (incf ptr- (send _clockReport :serialization-length))
   ;; openpilot_bridge/DrMeasurementReport _drMeasurementReport
     (send _drMeasurementReport :deserialize buf ptr-) (incf ptr- (send _drMeasurementReport :serialization-length))
   ;;
   self)
  )

(setf (get openpilot_bridge::QcomGnss :md5sum-) "bb37eb2c5e7693de7d76101f66f26778")
(setf (get openpilot_bridge::QcomGnss :datatype-) "openpilot_bridge/QcomGnss")
(setf (get openpilot_bridge::QcomGnss :definition-)
      "Header header

string[] rawLog
MeasurementReport measurementReport
int64 logTs
DrSvPolyReport drSvPoly
ClockReport clockReport
DrMeasurementReport drMeasurementReport

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
MSG: openpilot_bridge/DrSvPolyReport
Header header

float32[] xyzN
bool hasSbasIono
float32 positionUncertainty
int64 svId
float32 elevationUncertainty
bool polyFromXtra
float32[] other
float32 ionoDot
bool hasIono
int32 frequencyIndex
float32[] velocityCoeff
float32 elevation
float32 ionoDelay
float32 sbasIonoDelay
bool hasPosition
bool hasElevation
int64 iode
float32 elevationDot
float32 t0
float32[] xyz0
bool hasTropo
float32 tropoDelay
float32 sbasIonoDot

================================================================================
MSG: openpilot_bridge/ClockReport
Header header

float32 galToBdsTimeBiasMillisecondsUncertainty
bool hasFCount
int64 bdsClockSource
float32 clockFrequencyUncertainty
int64 gpsMilliseconds
bool hasGpsWeek
float32 gpsToGlonassTimeBiasMilliseconds
int64 galWeek
int64 bdsMilliseconds
float32 gpsToGalTimeBiasMilliseconds
float32 glonassTimeBias
int64 gpsClockSource
float32 bdsClockTimeUncertainty
float32 gpsToBdsTimeBiasMillisecondsUncertainty
int64 glonassYear
float32 galToGloTimeBiasMilliseconds
int64 galMilliseconds
float32 galToGloTimeBiasMillisecondsUncertainty
float32 clockFrequencyBias
int64 fCount
int64 gpsLeapSeconds
bool hasRtcTime
int64 bdsWeek
float32 glonassClockTimeUncertainty
bool hasGlonassMilliseconds
int64 systemRtcTime
float32 bdsTimeBias
int64 frequencySource
int64 glonassDay
bool hasGlonassDay
float32 gpsToGalTimeBiasMillisecondsUncertainty
float32 galTimeBias
float32 galClockTimeUncertainty
float32 gpsTimeBias
int64 lpmRtcCount
int64 glonassMilliseconds
int64 fCountOffset
float32 bdsToGloTimeBiasMilliseconds
int64 clockResets
int64 gpsLeapSecondsSource
int64 galClockSource
bool hasGpsMilliseconds
float32 gpsToBdsTimeBiasMilliseconds
int64 gpsWeek
float32 gpsClockTimeUncertainty
float32 bdsToGloTimeBiasMillisecondsUncertainty
bool hasGlonassYear
float32 gpsToGlonassTimeBiasMillisecondsUncertainty
int64 glonassClockSource
float32 galToBdsTimeBiasMilliseconds
int64 gpsLeapSecondsUncertainty

================================================================================
MSG: openpilot_bridge/DrMeasurementReport
Header header

float32 gpsToGlonassTimeBiasMilliseconds
int64 gpsMilliseconds
int64 seqMax
int64 gpsClockTimeUncertaintyMs
int64 glonassClockSource
float32 glonassTimeBias
int64 gpsClockSource
float32 clockFrequencyBias
uint32 source # enum const: MeasurementSource
int64 rfLoss
int64 fCount
int64 gpsTimeBiasMs
float32 clockFrequencyUncertainty
int64 systemRtcTime
int64 seqNum
int64 frequencySource
int64 glonassDay
int64 reason
int64 glonassMilliseconds
int64 clockResets
SV[] sv
int64 gpsLeapSeconds
float32 glonassClockTimeUncertainty
int64 gpsWeek
bool systemRtcValid
float32 gpsToGlonassTimeBiasMillisecondsUncertainty
int64 glonassYear
int64 gpsLeapSecondsUncertainty

================================================================================
MSG: openpilot_bridge/SV
Header header

float32 unfilteredTimeUncertainty
int64 cycleSlipCount
int64 unfilteredMeasurementIntegral
MeasurementStatus measurementStatus
float32 filteredSpeedUncertainty
int64 predetectInterval
float32 unfilteredMeasurementFraction
float32 filteredTimeUncertainty
int64 carrierNoise
int64 postdetections
int32 latency
int64 filterStages
int64 multipathEstimate
int64 svId
float32 filteredMeasurementFraction
int64 rfLoss
int64 observations
int64 fCount
float32 dopplerAcceleration
float32 elevation
float32 filteredSpeed
float32 fineSpeed
int64 goodObservations
uint32 observationState # enum const: SVObservationState
bool goodParity
float32 carrierPhase
int64 filteredMeasurementIntegral
int64 parityErrorCount
float32 unfilteredSpeedUncertainty
float32 fineSpeedUncertainty
float32 azimuth
float32 unfilteredSpeed
int32 glonassFrequencyIndex

================================================================================
MSG: openpilot_bridge/MeasurementStatus
Header header

bool glonassTimeMarkValid
bool lockPointValid
bool imdJammingIndicator
bool measuredVelocity
bool fineOrCoarseVelocity
bool gpsHighBandwidthNu4
bool gpsRxDiversity
bool gpsHighBandwidthUniform
bool gpsHighBandwidthNu8
bool subMillisecondIsValid
bool lastUpdateFromDifference
bool tentativeMeasurement
bool probationMode
bool directionIsValid
bool bitEdgeConfirmedFromSignal
bool gpsRoundRobinRxDiversity
bool freshMeasurementIndicator
bool lteB13TxJammingIndicator
bool lastUpdateFromVelocityDifference
bool measurementNotUsable
bool glonassMeanderBitEdgeValid
bool gpsLowBandwidthRxDiversityCombined
bool satelliteTimeIsKnown
bool strongIndicationOfCrossCorelation
bool subBitTimeIsKnown
bool lockPointPositive
bool multipathIndicator
bool sirCheckIsNeeded
bool multipathEstimateIsValid

")



(provide :openpilot_bridge/QcomGnss "bb37eb2c5e7693de7d76101f66f26778")


