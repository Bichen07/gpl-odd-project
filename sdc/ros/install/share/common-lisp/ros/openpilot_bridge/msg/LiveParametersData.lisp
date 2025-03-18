; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LiveParametersData.msg.html

(cl:defclass <LiveParametersData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (steerRatio
    :reader steerRatio
    :initarg :steerRatio
    :type cl:float
    :initform 0.0)
   (sensorValid
    :reader sensorValid
    :initarg :sensorValid
    :type cl:boolean
    :initform cl:nil)
   (stiffnessFactor
    :reader stiffnessFactor
    :initarg :stiffnessFactor
    :type cl:float
    :initform 0.0)
   (posenetValid
    :reader posenetValid
    :initarg :posenetValid
    :type cl:boolean
    :initform cl:nil)
   (angleOffset
    :reader angleOffset
    :initarg :angleOffset
    :type cl:float
    :initform 0.0)
   (yawRate
    :reader yawRate
    :initarg :yawRate
    :type cl:float
    :initform 0.0)
   (gyroBias
    :reader gyroBias
    :initarg :gyroBias
    :type cl:float
    :initform 0.0)
   (valid
    :reader valid
    :initarg :valid
    :type cl:boolean
    :initform cl:nil)
   (posenetSpeed
    :reader posenetSpeed
    :initarg :posenetSpeed
    :type cl:float
    :initform 0.0)
   (angleOffsetAverage
    :reader angleOffsetAverage
    :initarg :angleOffsetAverage
    :type cl:float
    :initform 0.0))
)

(cl:defclass LiveParametersData (<LiveParametersData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LiveParametersData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LiveParametersData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LiveParametersData> is deprecated: use openpilot_bridge-msg:LiveParametersData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'steerRatio-val :lambda-list '(m))
(cl:defmethod steerRatio-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerRatio-val is deprecated.  Use openpilot_bridge-msg:steerRatio instead.")
  (steerRatio m))

(cl:ensure-generic-function 'sensorValid-val :lambda-list '(m))
(cl:defmethod sensorValid-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensorValid-val is deprecated.  Use openpilot_bridge-msg:sensorValid instead.")
  (sensorValid m))

(cl:ensure-generic-function 'stiffnessFactor-val :lambda-list '(m))
(cl:defmethod stiffnessFactor-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stiffnessFactor-val is deprecated.  Use openpilot_bridge-msg:stiffnessFactor instead.")
  (stiffnessFactor m))

(cl:ensure-generic-function 'posenetValid-val :lambda-list '(m))
(cl:defmethod posenetValid-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:posenetValid-val is deprecated.  Use openpilot_bridge-msg:posenetValid instead.")
  (posenetValid m))

(cl:ensure-generic-function 'angleOffset-val :lambda-list '(m))
(cl:defmethod angleOffset-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleOffset-val is deprecated.  Use openpilot_bridge-msg:angleOffset instead.")
  (angleOffset m))

(cl:ensure-generic-function 'yawRate-val :lambda-list '(m))
(cl:defmethod yawRate-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yawRate-val is deprecated.  Use openpilot_bridge-msg:yawRate instead.")
  (yawRate m))

(cl:ensure-generic-function 'gyroBias-val :lambda-list '(m))
(cl:defmethod gyroBias-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gyroBias-val is deprecated.  Use openpilot_bridge-msg:gyroBias instead.")
  (gyroBias m))

(cl:ensure-generic-function 'valid-val :lambda-list '(m))
(cl:defmethod valid-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:valid-val is deprecated.  Use openpilot_bridge-msg:valid instead.")
  (valid m))

(cl:ensure-generic-function 'posenetSpeed-val :lambda-list '(m))
(cl:defmethod posenetSpeed-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:posenetSpeed-val is deprecated.  Use openpilot_bridge-msg:posenetSpeed instead.")
  (posenetSpeed m))

(cl:ensure-generic-function 'angleOffsetAverage-val :lambda-list '(m))
(cl:defmethod angleOffsetAverage-val ((m <LiveParametersData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:angleOffsetAverage-val is deprecated.  Use openpilot_bridge-msg:angleOffsetAverage instead.")
  (angleOffsetAverage m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LiveParametersData>) ostream)
  "Serializes a message object of type '<LiveParametersData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerRatio))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'sensorValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'stiffnessFactor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'posenetValid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleOffset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yawRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gyroBias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'valid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'posenetSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angleOffsetAverage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LiveParametersData>) istream)
  "Deserializes a message object of type '<LiveParametersData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerRatio) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'sensorValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stiffnessFactor) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'posenetValid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleOffset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yawRate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gyroBias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'valid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'posenetSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angleOffsetAverage) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LiveParametersData>)))
  "Returns string type for a message object of type '<LiveParametersData>"
  "openpilot_bridge/LiveParametersData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LiveParametersData)))
  "Returns string type for a message object of type 'LiveParametersData"
  "openpilot_bridge/LiveParametersData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LiveParametersData>)))
  "Returns md5sum for a message object of type '<LiveParametersData>"
  "2c7f16316c870354eebb72d972911e81")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LiveParametersData)))
  "Returns md5sum for a message object of type 'LiveParametersData"
  "2c7f16316c870354eebb72d972911e81")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LiveParametersData>)))
  "Returns full string definition for message of type '<LiveParametersData>"
  (cl:format cl:nil "Header header~%~%float32 steerRatio~%bool sensorValid~%float32 stiffnessFactor~%bool posenetValid~%float32 angleOffset~%float32 yawRate~%float32 gyroBias~%bool valid~%float32 posenetSpeed~%float32 angleOffsetAverage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LiveParametersData)))
  "Returns full string definition for message of type 'LiveParametersData"
  (cl:format cl:nil "Header header~%~%float32 steerRatio~%bool sensorValid~%float32 stiffnessFactor~%bool posenetValid~%float32 angleOffset~%float32 yawRate~%float32 gyroBias~%bool valid~%float32 posenetSpeed~%float32 angleOffsetAverage~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LiveParametersData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     4
     1
     4
     4
     4
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LiveParametersData>))
  "Converts a ROS message object to a list"
  (cl:list 'LiveParametersData
    (cl:cons ':header (header msg))
    (cl:cons ':steerRatio (steerRatio msg))
    (cl:cons ':sensorValid (sensorValid msg))
    (cl:cons ':stiffnessFactor (stiffnessFactor msg))
    (cl:cons ':posenetValid (posenetValid msg))
    (cl:cons ':angleOffset (angleOffset msg))
    (cl:cons ':yawRate (yawRate msg))
    (cl:cons ':gyroBias (gyroBias msg))
    (cl:cons ':valid (valid msg))
    (cl:cons ':posenetSpeed (posenetSpeed msg))
    (cl:cons ':angleOffsetAverage (angleOffsetAverage msg))
))
