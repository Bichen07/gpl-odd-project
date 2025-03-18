; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude AndroidGnss.msg.html

(cl:defclass <AndroidGnss> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (navigationMessage
    :reader navigationMessage
    :initarg :navigationMessage
    :type openpilot_bridge-msg:NavigationMessage
    :initform (cl:make-instance 'openpilot_bridge-msg:NavigationMessage))
   (measurements
    :reader measurements
    :initarg :measurements
    :type openpilot_bridge-msg:Measurements
    :initform (cl:make-instance 'openpilot_bridge-msg:Measurements)))
)

(cl:defclass AndroidGnss (<AndroidGnss>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AndroidGnss>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AndroidGnss)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<AndroidGnss> is deprecated: use openpilot_bridge-msg:AndroidGnss instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <AndroidGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'navigationMessage-val :lambda-list '(m))
(cl:defmethod navigationMessage-val ((m <AndroidGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:navigationMessage-val is deprecated.  Use openpilot_bridge-msg:navigationMessage instead.")
  (navigationMessage m))

(cl:ensure-generic-function 'measurements-val :lambda-list '(m))
(cl:defmethod measurements-val ((m <AndroidGnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurements-val is deprecated.  Use openpilot_bridge-msg:measurements instead.")
  (measurements m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AndroidGnss>) ostream)
  "Serializes a message object of type '<AndroidGnss>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'navigationMessage) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measurements) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AndroidGnss>) istream)
  "Deserializes a message object of type '<AndroidGnss>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'navigationMessage) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measurements) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AndroidGnss>)))
  "Returns string type for a message object of type '<AndroidGnss>"
  "openpilot_bridge/AndroidGnss")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AndroidGnss)))
  "Returns string type for a message object of type 'AndroidGnss"
  "openpilot_bridge/AndroidGnss")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AndroidGnss>)))
  "Returns md5sum for a message object of type '<AndroidGnss>"
  "b7e8e88d266ebdcdd6f44e7888ccfd09")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AndroidGnss)))
  "Returns md5sum for a message object of type 'AndroidGnss"
  "b7e8e88d266ebdcdd6f44e7888ccfd09")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AndroidGnss>)))
  "Returns full string definition for message of type '<AndroidGnss>"
  (cl:format cl:nil "Header header~%~%NavigationMessage navigationMessage~%Measurements measurements~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/NavigationMessage~%Header header~%~%uint32 status # enum const: Status~%string[] data~%int32 svId~%int32 messageId~%int32 submessageId~%int32 type~%~%================================================================================~%MSG: openpilot_bridge/Measurements~%Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AndroidGnss)))
  "Returns full string definition for message of type 'AndroidGnss"
  (cl:format cl:nil "Header header~%~%NavigationMessage navigationMessage~%Measurements measurements~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/NavigationMessage~%Header header~%~%uint32 status # enum const: Status~%string[] data~%int32 svId~%int32 messageId~%int32 submessageId~%int32 type~%~%================================================================================~%MSG: openpilot_bridge/Measurements~%Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AndroidGnss>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'navigationMessage))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measurements))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AndroidGnss>))
  "Converts a ROS message object to a list"
  (cl:list 'AndroidGnss
    (cl:cons ':header (header msg))
    (cl:cons ':navigationMessage (navigationMessage msg))
    (cl:cons ':measurements (measurements msg))
))
