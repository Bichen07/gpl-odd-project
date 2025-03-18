; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Measurements.msg.html

(cl:defclass <Measurements> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (measurements
    :reader measurements
    :initarg :measurements
    :type (cl:vector openpilot_bridge-msg:Measurement)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:Measurement :initial-element (cl:make-instance 'openpilot_bridge-msg:Measurement)))
   (clock
    :reader clock
    :initarg :clock
    :type openpilot_bridge-msg:Clock
    :initform (cl:make-instance 'openpilot_bridge-msg:Clock)))
)

(cl:defclass Measurements (<Measurements>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Measurements>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Measurements)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Measurements> is deprecated: use openpilot_bridge-msg:Measurements instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Measurements>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'measurements-val :lambda-list '(m))
(cl:defmethod measurements-val ((m <Measurements>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurements-val is deprecated.  Use openpilot_bridge-msg:measurements instead.")
  (measurements m))

(cl:ensure-generic-function 'clock-val :lambda-list '(m))
(cl:defmethod clock-val ((m <Measurements>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:clock-val is deprecated.  Use openpilot_bridge-msg:clock instead.")
  (clock m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Measurements>) ostream)
  "Serializes a message object of type '<Measurements>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'measurements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'measurements))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'clock) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Measurements>) istream)
  "Deserializes a message object of type '<Measurements>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'measurements) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'measurements)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:Measurement))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'clock) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Measurements>)))
  "Returns string type for a message object of type '<Measurements>"
  "openpilot_bridge/Measurements")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Measurements)))
  "Returns string type for a message object of type 'Measurements"
  "openpilot_bridge/Measurements")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Measurements>)))
  "Returns md5sum for a message object of type '<Measurements>"
  "415db0e73f1e2a0ab9033dcedb4bc3d3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Measurements)))
  "Returns md5sum for a message object of type 'Measurements"
  "415db0e73f1e2a0ab9033dcedb4bc3d3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Measurements>)))
  "Returns full string definition for message of type '<Measurements>"
  (cl:format cl:nil "Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Measurements)))
  "Returns full string definition for message of type 'Measurements"
  (cl:format cl:nil "Header header~%~%Measurement[] measurements~%Clock clock~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/Clock~%Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Measurements>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'measurements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'clock))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Measurements>))
  "Converts a ROS message object to a list"
  (cl:list 'Measurements
    (cl:cons ':header (header msg))
    (cl:cons ':measurements (measurements msg))
    (cl:cons ':clock (clock msg))
))
