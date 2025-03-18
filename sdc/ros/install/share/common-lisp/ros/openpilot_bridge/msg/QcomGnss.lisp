; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude QcomGnss.msg.html

(cl:defclass <QcomGnss> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (rawLog
    :reader rawLog
    :initarg :rawLog
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (measurementReport
    :reader measurementReport
    :initarg :measurementReport
    :type openpilot_bridge-msg:MeasurementReport
    :initform (cl:make-instance 'openpilot_bridge-msg:MeasurementReport))
   (logTs
    :reader logTs
    :initarg :logTs
    :type cl:integer
    :initform 0)
   (drSvPoly
    :reader drSvPoly
    :initarg :drSvPoly
    :type openpilot_bridge-msg:DrSvPolyReport
    :initform (cl:make-instance 'openpilot_bridge-msg:DrSvPolyReport))
   (clockReport
    :reader clockReport
    :initarg :clockReport
    :type openpilot_bridge-msg:ClockReport
    :initform (cl:make-instance 'openpilot_bridge-msg:ClockReport))
   (drMeasurementReport
    :reader drMeasurementReport
    :initarg :drMeasurementReport
    :type openpilot_bridge-msg:DrMeasurementReport
    :initform (cl:make-instance 'openpilot_bridge-msg:DrMeasurementReport)))
)

(cl:defclass QcomGnss (<QcomGnss>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <QcomGnss>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'QcomGnss)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<QcomGnss> is deprecated: use openpilot_bridge-msg:QcomGnss instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'rawLog-val :lambda-list '(m))
(cl:defmethod rawLog-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rawLog-val is deprecated.  Use openpilot_bridge-msg:rawLog instead.")
  (rawLog m))

(cl:ensure-generic-function 'measurementReport-val :lambda-list '(m))
(cl:defmethod measurementReport-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurementReport-val is deprecated.  Use openpilot_bridge-msg:measurementReport instead.")
  (measurementReport m))

(cl:ensure-generic-function 'logTs-val :lambda-list '(m))
(cl:defmethod logTs-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:logTs-val is deprecated.  Use openpilot_bridge-msg:logTs instead.")
  (logTs m))

(cl:ensure-generic-function 'drSvPoly-val :lambda-list '(m))
(cl:defmethod drSvPoly-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:drSvPoly-val is deprecated.  Use openpilot_bridge-msg:drSvPoly instead.")
  (drSvPoly m))

(cl:ensure-generic-function 'clockReport-val :lambda-list '(m))
(cl:defmethod clockReport-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clockReport-val is deprecated.  Use openpilot_bridge-msg:clockReport instead.")
  (clockReport m))

(cl:ensure-generic-function 'drMeasurementReport-val :lambda-list '(m))
(cl:defmethod drMeasurementReport-val ((m <QcomGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:drMeasurementReport-val is deprecated.  Use openpilot_bridge-msg:drMeasurementReport instead.")
  (drMeasurementReport m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <QcomGnss>) ostream)
  "Serializes a message object of type '<QcomGnss>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rawLog))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'rawLog))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measurementReport) ostream)
  (cl:let* ((signed (cl:slot-value msg 'logTs)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'drSvPoly) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'clockReport) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'drMeasurementReport) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <QcomGnss>) istream)
  "Deserializes a message object of type '<QcomGnss>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rawLog) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rawLog)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measurementReport) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'logTs) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'drSvPoly) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'clockReport) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'drMeasurementReport) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<QcomGnss>)))
  "Returns string type for a message object of type '<QcomGnss>"
  "openpilot_bridge/QcomGnss")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'QcomGnss)))
  "Returns string type for a message object of type 'QcomGnss"
  "openpilot_bridge/QcomGnss")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<QcomGnss>)))
  "Returns md5sum for a message object of type '<QcomGnss>"
  "bb37eb2c5e7693de7d76101f66f26778")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'QcomGnss)))
  "Returns md5sum for a message object of type 'QcomGnss"
  "bb37eb2c5e7693de7d76101f66f26778")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<QcomGnss>)))
  "Returns full string definition for message of type '<QcomGnss>"
  (cl:format cl:nil "Header header~%~%string[] rawLog~%MeasurementReport measurementReport~%int64 logTs~%DrSvPolyReport drSvPoly~%ClockReport clockReport~%DrMeasurementReport drMeasurementReport~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/DrSvPolyReport~%Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: openpilot_bridge/ClockReport~%Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/DrMeasurementReport~%Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'QcomGnss)))
  "Returns full string definition for message of type 'QcomGnss"
  (cl:format cl:nil "Header header~%~%string[] rawLog~%MeasurementReport measurementReport~%int64 logTs~%DrSvPolyReport drSvPoly~%ClockReport clockReport~%DrMeasurementReport drMeasurementReport~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/DrSvPolyReport~%Header header~%~%float32[] xyzN~%bool hasSbasIono~%float32 positionUncertainty~%int64 svId~%float32 elevationUncertainty~%bool polyFromXtra~%float32[] other~%float32 ionoDot~%bool hasIono~%int32 frequencyIndex~%float32[] velocityCoeff~%float32 elevation~%float32 ionoDelay~%float32 sbasIonoDelay~%bool hasPosition~%bool hasElevation~%int64 iode~%float32 elevationDot~%float32 t0~%float32[] xyz0~%bool hasTropo~%float32 tropoDelay~%float32 sbasIonoDot~%~%================================================================================~%MSG: openpilot_bridge/ClockReport~%Header header~%~%float32 galToBdsTimeBiasMillisecondsUncertainty~%bool hasFCount~%int64 bdsClockSource~%float32 clockFrequencyUncertainty~%int64 gpsMilliseconds~%bool hasGpsWeek~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 galWeek~%int64 bdsMilliseconds~%float32 gpsToGalTimeBiasMilliseconds~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 bdsClockTimeUncertainty~%float32 gpsToBdsTimeBiasMillisecondsUncertainty~%int64 glonassYear~%float32 galToGloTimeBiasMilliseconds~%int64 galMilliseconds~%float32 galToGloTimeBiasMillisecondsUncertainty~%float32 clockFrequencyBias~%int64 fCount~%int64 gpsLeapSeconds~%bool hasRtcTime~%int64 bdsWeek~%float32 glonassClockTimeUncertainty~%bool hasGlonassMilliseconds~%int64 systemRtcTime~%float32 bdsTimeBias~%int64 frequencySource~%int64 glonassDay~%bool hasGlonassDay~%float32 gpsToGalTimeBiasMillisecondsUncertainty~%float32 galTimeBias~%float32 galClockTimeUncertainty~%float32 gpsTimeBias~%int64 lpmRtcCount~%int64 glonassMilliseconds~%int64 fCountOffset~%float32 bdsToGloTimeBiasMilliseconds~%int64 clockResets~%int64 gpsLeapSecondsSource~%int64 galClockSource~%bool hasGpsMilliseconds~%float32 gpsToBdsTimeBiasMilliseconds~%int64 gpsWeek~%float32 gpsClockTimeUncertainty~%float32 bdsToGloTimeBiasMillisecondsUncertainty~%bool hasGlonassYear~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassClockSource~%float32 galToBdsTimeBiasMilliseconds~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/DrMeasurementReport~%Header header~%~%float32 gpsToGlonassTimeBiasMilliseconds~%int64 gpsMilliseconds~%int64 seqMax~%int64 gpsClockTimeUncertaintyMs~%int64 glonassClockSource~%float32 glonassTimeBias~%int64 gpsClockSource~%float32 clockFrequencyBias~%uint32 source # enum const: MeasurementSource~%int64 rfLoss~%int64 fCount~%int64 gpsTimeBiasMs~%float32 clockFrequencyUncertainty~%int64 systemRtcTime~%int64 seqNum~%int64 frequencySource~%int64 glonassDay~%int64 reason~%int64 glonassMilliseconds~%int64 clockResets~%SV[] sv~%int64 gpsLeapSeconds~%float32 glonassClockTimeUncertainty~%int64 gpsWeek~%bool systemRtcValid~%float32 gpsToGlonassTimeBiasMillisecondsUncertainty~%int64 glonassYear~%int64 gpsLeapSecondsUncertainty~%~%================================================================================~%MSG: openpilot_bridge/SV~%Header header~%~%float32 unfilteredTimeUncertainty~%int64 cycleSlipCount~%int64 unfilteredMeasurementIntegral~%MeasurementStatus measurementStatus~%float32 filteredSpeedUncertainty~%int64 predetectInterval~%float32 unfilteredMeasurementFraction~%float32 filteredTimeUncertainty~%int64 carrierNoise~%int64 postdetections~%int32 latency~%int64 filterStages~%int64 multipathEstimate~%int64 svId~%float32 filteredMeasurementFraction~%int64 rfLoss~%int64 observations~%int64 fCount~%float32 dopplerAcceleration~%float32 elevation~%float32 filteredSpeed~%float32 fineSpeed~%int64 goodObservations~%uint32 observationState # enum const: SVObservationState~%bool goodParity~%float32 carrierPhase~%int64 filteredMeasurementIntegral~%int64 parityErrorCount~%float32 unfilteredSpeedUncertainty~%float32 fineSpeedUncertainty~%float32 azimuth~%float32 unfilteredSpeed~%int32 glonassFrequencyIndex~%~%================================================================================~%MSG: openpilot_bridge/MeasurementStatus~%Header header~%~%bool glonassTimeMarkValid~%bool lockPointValid~%bool imdJammingIndicator~%bool measuredVelocity~%bool fineOrCoarseVelocity~%bool gpsHighBandwidthNu4~%bool gpsRxDiversity~%bool gpsHighBandwidthUniform~%bool gpsHighBandwidthNu8~%bool subMillisecondIsValid~%bool lastUpdateFromDifference~%bool tentativeMeasurement~%bool probationMode~%bool directionIsValid~%bool bitEdgeConfirmedFromSignal~%bool gpsRoundRobinRxDiversity~%bool freshMeasurementIndicator~%bool lteB13TxJammingIndicator~%bool lastUpdateFromVelocityDifference~%bool measurementNotUsable~%bool glonassMeanderBitEdgeValid~%bool gpsLowBandwidthRxDiversityCombined~%bool satelliteTimeIsKnown~%bool strongIndicationOfCrossCorelation~%bool subBitTimeIsKnown~%bool lockPointPositive~%bool multipathIndicator~%bool sirCheckIsNeeded~%bool multipathEstimateIsValid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <QcomGnss>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rawLog) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measurementReport))
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'drSvPoly))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'clockReport))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'drMeasurementReport))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <QcomGnss>))
  "Converts a ROS message object to a list"
  (cl:list 'QcomGnss
    (cl:cons ':header (header msg))
    (cl:cons ':rawLog (rawLog msg))
    (cl:cons ':measurementReport (measurementReport msg))
    (cl:cons ':logTs (logTs msg))
    (cl:cons ':drSvPoly (drSvPoly msg))
    (cl:cons ':clockReport (clockReport msg))
    (cl:cons ':drMeasurementReport (drMeasurementReport msg))
))
