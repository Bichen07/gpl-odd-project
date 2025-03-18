; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude UbloxGnss.msg.html

(cl:defclass <UbloxGnss> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (ionoData
    :reader ionoData
    :initarg :ionoData
    :type openpilot_bridge-msg:IonoData
    :initform (cl:make-instance 'openpilot_bridge-msg:IonoData))
   (measurementReport
    :reader measurementReport
    :initarg :measurementReport
    :type openpilot_bridge-msg:MeasurementReport
    :initform (cl:make-instance 'openpilot_bridge-msg:MeasurementReport))
   (ephemeris
    :reader ephemeris
    :initarg :ephemeris
    :type openpilot_bridge-msg:Ephemeris
    :initform (cl:make-instance 'openpilot_bridge-msg:Ephemeris)))
)

(cl:defclass UbloxGnss (<UbloxGnss>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UbloxGnss>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UbloxGnss)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<UbloxGnss> is deprecated: use openpilot_bridge-msg:UbloxGnss instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UbloxGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'ionoData-val :lambda-list '(m))
(cl:defmethod ionoData-val ((m <UbloxGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoData-val is deprecated.  Use openpilot_bridge-msg:ionoData instead.")
  (ionoData m))

(cl:ensure-generic-function 'measurementReport-val :lambda-list '(m))
(cl:defmethod measurementReport-val ((m <UbloxGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurementReport-val is deprecated.  Use openpilot_bridge-msg:measurementReport instead.")
  (measurementReport m))

(cl:ensure-generic-function 'ephemeris-val :lambda-list '(m))
(cl:defmethod ephemeris-val ((m <UbloxGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ephemeris-val is deprecated.  Use openpilot_bridge-msg:ephemeris instead.")
  (ephemeris m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UbloxGnss>) ostream)
  "Serializes a message object of type '<UbloxGnss>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ionoData) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measurementReport) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ephemeris) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UbloxGnss>) istream)
  "Deserializes a message object of type '<UbloxGnss>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ionoData) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measurementReport) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ephemeris) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UbloxGnss>)))
  "Returns string type for a message object of type '<UbloxGnss>"
  "openpilot_bridge/UbloxGnss")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UbloxGnss)))
  "Returns string type for a message object of type 'UbloxGnss"
  "openpilot_bridge/UbloxGnss")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UbloxGnss>)))
  "Returns md5sum for a message object of type '<UbloxGnss>"
  "64057f9ece7684e899d76ef9539f0d83")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UbloxGnss)))
  "Returns md5sum for a message object of type 'UbloxGnss"
  "64057f9ece7684e899d76ef9539f0d83")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UbloxGnss>)))
  "Returns full string definition for message of type '<UbloxGnss>"
  (cl:format cl:nil "Header header~%~%IonoData ionoData~%MeasurementReport measurementReport~%Ephemeris ephemeris~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/IonoData~%Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/Ephemeris~%Header header~%~%float32 iodc~%float32 fitInterval~%int64 month~%float32 second~%float32 tgd~%int64 year~%float32 gpsWeek~%float32 cus~%bool ionoCoeffsValid~%int64 svId~%float32 svAcc~%float32 cuc~%float32 m0~%float32 toc~%float32 deltaN~%float32 toe~%float32 cic~%float32[] ionoBeta~%float32 ecc~%float32 iDot~%float32 i0~%float32 svHealth~%float32 codesL2~%float32 omega~%int64 day~%int64 minute~%float32 a~%float32 crs~%float32[] ionoAlpha~%int64 hour~%float32 iode~%float32 af1~%float32 cis~%float32 crc~%float32 l2~%float32 omegaDot~%float32 af0~%float32 omega0~%float32 af2~%float32 transmissionTime~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UbloxGnss)))
  "Returns full string definition for message of type 'UbloxGnss"
  (cl:format cl:nil "Header header~%~%IonoData ionoData~%MeasurementReport measurementReport~%Ephemeris ephemeris~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/IonoData~%Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: openpilot_bridge/MeasurementReport~%Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%================================================================================~%MSG: openpilot_bridge/Ephemeris~%Header header~%~%float32 iodc~%float32 fitInterval~%int64 month~%float32 second~%float32 tgd~%int64 year~%float32 gpsWeek~%float32 cus~%bool ionoCoeffsValid~%int64 svId~%float32 svAcc~%float32 cuc~%float32 m0~%float32 toc~%float32 deltaN~%float32 toe~%float32 cic~%float32[] ionoBeta~%float32 ecc~%float32 iDot~%float32 i0~%float32 svHealth~%float32 codesL2~%float32 omega~%int64 day~%int64 minute~%float32 a~%float32 crs~%float32[] ionoAlpha~%int64 hour~%float32 iode~%float32 af1~%float32 cis~%float32 crc~%float32 l2~%float32 omegaDot~%float32 af0~%float32 omega0~%float32 af2~%float32 transmissionTime~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UbloxGnss>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ionoData))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measurementReport))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ephemeris))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UbloxGnss>))
  "Converts a ROS message object to a list"
  (cl:list 'UbloxGnss
    (cl:cons ':header (header msg))
    (cl:cons ':ionoData (ionoData msg))
    (cl:cons ':measurementReport (measurementReport msg))
    (cl:cons ':ephemeris (ephemeris msg))
))
