; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude MeasurementReport.msg.html

(cl:defclass <MeasurementReport> (roslisp-msg-protocol:ros-message)
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
   (gpsWeek
    :reader gpsWeek
    :initarg :gpsWeek
    :type cl:integer
    :initform 0)
   (numMeas
    :reader numMeas
    :initarg :numMeas
    :type cl:integer
    :initform 0)
   (receiverStatus
    :reader receiverStatus
    :initarg :receiverStatus
    :type openpilot_bridge-msg:ReceiverStatus
    :initform (cl:make-instance 'openpilot_bridge-msg:ReceiverStatus))
   (leapSeconds
    :reader leapSeconds
    :initarg :leapSeconds
    :type cl:integer
    :initform 0)
   (rcvTow
    :reader rcvTow
    :initarg :rcvTow
    :type cl:float
    :initform 0.0))
)

(cl:defclass MeasurementReport (<MeasurementReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MeasurementReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MeasurementReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<MeasurementReport> is deprecated: use openpilot_bridge-msg:MeasurementReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'measurements-val :lambda-list '(m))
(cl:defmethod measurements-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measurements-val is deprecated.  Use openpilot_bridge-msg:measurements instead.")
  (measurements m))

(cl:ensure-generic-function 'gpsWeek-val :lambda-list '(m))
(cl:defmethod gpsWeek-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsWeek-val is deprecated.  Use openpilot_bridge-msg:gpsWeek instead.")
  (gpsWeek m))

(cl:ensure-generic-function 'numMeas-val :lambda-list '(m))
(cl:defmethod numMeas-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:numMeas-val is deprecated.  Use openpilot_bridge-msg:numMeas instead.")
  (numMeas m))

(cl:ensure-generic-function 'receiverStatus-val :lambda-list '(m))
(cl:defmethod receiverStatus-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:receiverStatus-val is deprecated.  Use openpilot_bridge-msg:receiverStatus instead.")
  (receiverStatus m))

(cl:ensure-generic-function 'leapSeconds-val :lambda-list '(m))
(cl:defmethod leapSeconds-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leapSeconds-val is deprecated.  Use openpilot_bridge-msg:leapSeconds instead.")
  (leapSeconds m))

(cl:ensure-generic-function 'rcvTow-val :lambda-list '(m))
(cl:defmethod rcvTow-val ((m <MeasurementReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rcvTow-val is deprecated.  Use openpilot_bridge-msg:rcvTow instead.")
  (rcvTow m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MeasurementReport>) ostream)
  "Serializes a message object of type '<MeasurementReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'measurements))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'measurements))
  (cl:let* ((signed (cl:slot-value msg 'gpsWeek)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'numMeas)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'receiverStatus) ostream)
  (cl:let* ((signed (cl:slot-value msg 'leapSeconds)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rcvTow))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MeasurementReport>) istream)
  "Deserializes a message object of type '<MeasurementReport>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gpsWeek) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'numMeas) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'receiverStatus) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'leapSeconds) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rcvTow) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MeasurementReport>)))
  "Returns string type for a message object of type '<MeasurementReport>"
  "openpilot_bridge/MeasurementReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MeasurementReport)))
  "Returns string type for a message object of type 'MeasurementReport"
  "openpilot_bridge/MeasurementReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MeasurementReport>)))
  "Returns md5sum for a message object of type '<MeasurementReport>"
  "72031e9f3d08f0e106b815c0c5630a15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MeasurementReport)))
  "Returns md5sum for a message object of type 'MeasurementReport"
  "72031e9f3d08f0e106b815c0c5630a15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MeasurementReport>)))
  "Returns full string definition for message of type '<MeasurementReport>"
  (cl:format cl:nil "Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MeasurementReport)))
  "Returns full string definition for message of type 'MeasurementReport"
  (cl:format cl:nil "Header header~%~%Measurement[] measurements~%int64 gpsWeek~%int64 numMeas~%ReceiverStatus receiverStatus~%int64 leapSeconds~%float32 rcvTow~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Measurement~%Header header~%~%int64 gnssId~%float32 carrierPhaseStdev~%float32 pseudorange~%float32 doppler~%int64 sigId~%int64 svId~%float32 carrierCycles~%float32 dopplerStdev~%float32 pseudorangeStdev~%int64 cno~%int64 locktime~%int64 glonassFrequencyIndex~%TrackingStatus trackingStatus~%~%================================================================================~%MSG: openpilot_bridge/TrackingStatus~%Header header~%~%bool halfCycleSubtracted~%bool carrierPhaseValid~%bool pseudorangeValid~%bool halfCycleValid~%~%================================================================================~%MSG: openpilot_bridge/ReceiverStatus~%Header header~%~%bool leapSecValid~%bool clkReset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MeasurementReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'measurements) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     8
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'receiverStatus))
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MeasurementReport>))
  "Converts a ROS message object to a list"
  (cl:list 'MeasurementReport
    (cl:cons ':header (header msg))
    (cl:cons ':measurements (measurements msg))
    (cl:cons ':gpsWeek (gpsWeek msg))
    (cl:cons ':numMeas (numMeas msg))
    (cl:cons ':receiverStatus (receiverStatus msg))
    (cl:cons ':leapSeconds (leapSeconds msg))
    (cl:cons ':rcvTow (rcvTow msg))
))
