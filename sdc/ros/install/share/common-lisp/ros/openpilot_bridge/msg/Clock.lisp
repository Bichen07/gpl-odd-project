; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Clock.msg.html

(cl:defclass <Clock> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (hasDriftUncertaintyNanosPerSecond
    :reader hasDriftUncertaintyNanosPerSecond
    :initarg :hasDriftUncertaintyNanosPerSecond
    :type cl:boolean
    :initform cl:nil)
   (timeNanos
    :reader timeNanos
    :initarg :timeNanos
    :type cl:integer
    :initform 0)
   (driftUncertaintyNanosPerSecond
    :reader driftUncertaintyNanosPerSecond
    :initarg :driftUncertaintyNanosPerSecond
    :type cl:float
    :initform 0.0)
   (hasBiasNanos
    :reader hasBiasNanos
    :initarg :hasBiasNanos
    :type cl:boolean
    :initform cl:nil)
   (timeUncertaintyNanos
    :reader timeUncertaintyNanos
    :initarg :timeUncertaintyNanos
    :type cl:float
    :initform 0.0)
   (fullBiasNanos
    :reader fullBiasNanos
    :initarg :fullBiasNanos
    :type cl:integer
    :initform 0)
   (hasLeapSecond
    :reader hasLeapSecond
    :initarg :hasLeapSecond
    :type cl:boolean
    :initform cl:nil)
   (leapSecond
    :reader leapSecond
    :initarg :leapSecond
    :type cl:integer
    :initform 0)
   (hasTimeUncertaintyNanos
    :reader hasTimeUncertaintyNanos
    :initarg :hasTimeUncertaintyNanos
    :type cl:boolean
    :initform cl:nil)
   (hardwareClockDiscontinuityCount
    :reader hardwareClockDiscontinuityCount
    :initarg :hardwareClockDiscontinuityCount
    :type cl:integer
    :initform 0)
   (driftNanosPerSecond
    :reader driftNanosPerSecond
    :initarg :driftNanosPerSecond
    :type cl:float
    :initform 0.0)
   (biasNanos
    :reader biasNanos
    :initarg :biasNanos
    :type cl:float
    :initform 0.0)
   (hasDriftNanosPerSecond
    :reader hasDriftNanosPerSecond
    :initarg :hasDriftNanosPerSecond
    :type cl:boolean
    :initform cl:nil)
   (hasFullBiasNanos
    :reader hasFullBiasNanos
    :initarg :hasFullBiasNanos
    :type cl:boolean
    :initform cl:nil)
   (biasUncertaintyNanos
    :reader biasUncertaintyNanos
    :initarg :biasUncertaintyNanos
    :type cl:float
    :initform 0.0)
   (hasBiasUncertaintyNanos
    :reader hasBiasUncertaintyNanos
    :initarg :hasBiasUncertaintyNanos
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Clock (<Clock>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Clock>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Clock)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Clock> is deprecated: use openpilot_bridge-msg:Clock instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'hasDriftUncertaintyNanosPerSecond-val :lambda-list '(m))
(cl:defmethod hasDriftUncertaintyNanosPerSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasDriftUncertaintyNanosPerSecond-val is deprecated.  Use openpilot_bridge-msg:hasDriftUncertaintyNanosPerSecond instead.")
  (hasDriftUncertaintyNanosPerSecond m))

(cl:ensure-generic-function 'timeNanos-val :lambda-list '(m))
(cl:defmethod timeNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timeNanos-val is deprecated.  Use openpilot_bridge-msg:timeNanos instead.")
  (timeNanos m))

(cl:ensure-generic-function 'driftUncertaintyNanosPerSecond-val :lambda-list '(m))
(cl:defmethod driftUncertaintyNanosPerSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:driftUncertaintyNanosPerSecond-val is deprecated.  Use openpilot_bridge-msg:driftUncertaintyNanosPerSecond instead.")
  (driftUncertaintyNanosPerSecond m))

(cl:ensure-generic-function 'hasBiasNanos-val :lambda-list '(m))
(cl:defmethod hasBiasNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasBiasNanos-val is deprecated.  Use openpilot_bridge-msg:hasBiasNanos instead.")
  (hasBiasNanos m))

(cl:ensure-generic-function 'timeUncertaintyNanos-val :lambda-list '(m))
(cl:defmethod timeUncertaintyNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timeUncertaintyNanos-val is deprecated.  Use openpilot_bridge-msg:timeUncertaintyNanos instead.")
  (timeUncertaintyNanos m))

(cl:ensure-generic-function 'fullBiasNanos-val :lambda-list '(m))
(cl:defmethod fullBiasNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fullBiasNanos-val is deprecated.  Use openpilot_bridge-msg:fullBiasNanos instead.")
  (fullBiasNanos m))

(cl:ensure-generic-function 'hasLeapSecond-val :lambda-list '(m))
(cl:defmethod hasLeapSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasLeapSecond-val is deprecated.  Use openpilot_bridge-msg:hasLeapSecond instead.")
  (hasLeapSecond m))

(cl:ensure-generic-function 'leapSecond-val :lambda-list '(m))
(cl:defmethod leapSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leapSecond-val is deprecated.  Use openpilot_bridge-msg:leapSecond instead.")
  (leapSecond m))

(cl:ensure-generic-function 'hasTimeUncertaintyNanos-val :lambda-list '(m))
(cl:defmethod hasTimeUncertaintyNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasTimeUncertaintyNanos-val is deprecated.  Use openpilot_bridge-msg:hasTimeUncertaintyNanos instead.")
  (hasTimeUncertaintyNanos m))

(cl:ensure-generic-function 'hardwareClockDiscontinuityCount-val :lambda-list '(m))
(cl:defmethod hardwareClockDiscontinuityCount-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hardwareClockDiscontinuityCount-val is deprecated.  Use openpilot_bridge-msg:hardwareClockDiscontinuityCount instead.")
  (hardwareClockDiscontinuityCount m))

(cl:ensure-generic-function 'driftNanosPerSecond-val :lambda-list '(m))
(cl:defmethod driftNanosPerSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:driftNanosPerSecond-val is deprecated.  Use openpilot_bridge-msg:driftNanosPerSecond instead.")
  (driftNanosPerSecond m))

(cl:ensure-generic-function 'biasNanos-val :lambda-list '(m))
(cl:defmethod biasNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:biasNanos-val is deprecated.  Use openpilot_bridge-msg:biasNanos instead.")
  (biasNanos m))

(cl:ensure-generic-function 'hasDriftNanosPerSecond-val :lambda-list '(m))
(cl:defmethod hasDriftNanosPerSecond-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasDriftNanosPerSecond-val is deprecated.  Use openpilot_bridge-msg:hasDriftNanosPerSecond instead.")
  (hasDriftNanosPerSecond m))

(cl:ensure-generic-function 'hasFullBiasNanos-val :lambda-list '(m))
(cl:defmethod hasFullBiasNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasFullBiasNanos-val is deprecated.  Use openpilot_bridge-msg:hasFullBiasNanos instead.")
  (hasFullBiasNanos m))

(cl:ensure-generic-function 'biasUncertaintyNanos-val :lambda-list '(m))
(cl:defmethod biasUncertaintyNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:biasUncertaintyNanos-val is deprecated.  Use openpilot_bridge-msg:biasUncertaintyNanos instead.")
  (biasUncertaintyNanos m))

(cl:ensure-generic-function 'hasBiasUncertaintyNanos-val :lambda-list '(m))
(cl:defmethod hasBiasUncertaintyNanos-val ((m <Clock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hasBiasUncertaintyNanos-val is deprecated.  Use openpilot_bridge-msg:hasBiasUncertaintyNanos instead.")
  (hasBiasUncertaintyNanos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Clock>) ostream)
  "Serializes a message object of type '<Clock>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasDriftUncertaintyNanosPerSecond) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'timeNanos)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'driftUncertaintyNanosPerSecond))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasBiasNanos) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'timeUncertaintyNanos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'fullBiasNanos)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasLeapSecond) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'leapSecond)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasTimeUncertaintyNanos) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'hardwareClockDiscontinuityCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'driftNanosPerSecond))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'biasNanos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasDriftNanosPerSecond) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasFullBiasNanos) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'biasUncertaintyNanos))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hasBiasUncertaintyNanos) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Clock>) istream)
  "Deserializes a message object of type '<Clock>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'hasDriftUncertaintyNanosPerSecond) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timeNanos) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'driftUncertaintyNanosPerSecond) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasBiasNanos) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timeUncertaintyNanos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'fullBiasNanos) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'hasLeapSecond) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'leapSecond) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'hasTimeUncertaintyNanos) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'hardwareClockDiscontinuityCount) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'driftNanosPerSecond) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'biasNanos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasDriftNanosPerSecond) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'hasFullBiasNanos) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'biasUncertaintyNanos) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'hasBiasUncertaintyNanos) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Clock>)))
  "Returns string type for a message object of type '<Clock>"
  "openpilot_bridge/Clock")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Clock)))
  "Returns string type for a message object of type 'Clock"
  "openpilot_bridge/Clock")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Clock>)))
  "Returns md5sum for a message object of type '<Clock>"
  "17720c4456ed360b148a53bf937ff2b3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Clock)))
  "Returns md5sum for a message object of type 'Clock"
  "17720c4456ed360b148a53bf937ff2b3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Clock>)))
  "Returns full string definition for message of type '<Clock>"
  (cl:format cl:nil "Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Clock)))
  "Returns full string definition for message of type 'Clock"
  (cl:format cl:nil "Header header~%~%bool hasDriftUncertaintyNanosPerSecond~%int32 timeNanos~%float32 driftUncertaintyNanosPerSecond~%bool hasBiasNanos~%float32 timeUncertaintyNanos~%int32 fullBiasNanos~%bool hasLeapSecond~%int32 leapSecond~%bool hasTimeUncertaintyNanos~%int32 hardwareClockDiscontinuityCount~%float32 driftNanosPerSecond~%float32 biasNanos~%bool hasDriftNanosPerSecond~%bool hasFullBiasNanos~%float32 biasUncertaintyNanos~%bool hasBiasUncertaintyNanos~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Clock>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
     1
     4
     4
     1
     4
     1
     4
     4
     4
     1
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Clock>))
  "Converts a ROS message object to a list"
  (cl:list 'Clock
    (cl:cons ':header (header msg))
    (cl:cons ':hasDriftUncertaintyNanosPerSecond (hasDriftUncertaintyNanosPerSecond msg))
    (cl:cons ':timeNanos (timeNanos msg))
    (cl:cons ':driftUncertaintyNanosPerSecond (driftUncertaintyNanosPerSecond msg))
    (cl:cons ':hasBiasNanos (hasBiasNanos msg))
    (cl:cons ':timeUncertaintyNanos (timeUncertaintyNanos msg))
    (cl:cons ':fullBiasNanos (fullBiasNanos msg))
    (cl:cons ':hasLeapSecond (hasLeapSecond msg))
    (cl:cons ':leapSecond (leapSecond msg))
    (cl:cons ':hasTimeUncertaintyNanos (hasTimeUncertaintyNanos msg))
    (cl:cons ':hardwareClockDiscontinuityCount (hardwareClockDiscontinuityCount msg))
    (cl:cons ':driftNanosPerSecond (driftNanosPerSecond msg))
    (cl:cons ':biasNanos (biasNanos msg))
    (cl:cons ':hasDriftNanosPerSecond (hasDriftNanosPerSecond msg))
    (cl:cons ':hasFullBiasNanos (hasFullBiasNanos msg))
    (cl:cons ':biasUncertaintyNanos (biasUncertaintyNanos msg))
    (cl:cons ':hasBiasUncertaintyNanos (hasBiasUncertaintyNanos msg))
))
