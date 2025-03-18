; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LateralINDIState.msg.html

(cl:defclass <LateralINDIState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (rateSetPoint
    :reader rateSetPoint
    :initarg :rateSetPoint
    :type cl:float
    :initform 0.0)
   (delayedOutput
    :reader delayedOutput
    :initarg :delayedOutput
    :type cl:float
    :initform 0.0)
   (saturated
    :reader saturated
    :initarg :saturated
    :type cl:boolean
    :initform cl:nil)
   (steerAccel
    :reader steerAccel
    :initarg :steerAccel
    :type cl:float
    :initform 0.0)
   (steerRate
    :reader steerRate
    :initarg :steerRate
    :type cl:float
    :initform 0.0)
   (delta
    :reader delta
    :initarg :delta
    :type cl:float
    :initform 0.0)
   (accelError
    :reader accelError
    :initarg :accelError
    :type cl:float
    :initform 0.0)
   (accelSetPoint
    :reader accelSetPoint
    :initarg :accelSetPoint
    :type cl:float
    :initform 0.0)
   (active
    :reader active
    :initarg :active
    :type cl:boolean
    :initform cl:nil)
   (output
    :reader output
    :initarg :output
    :type cl:float
    :initform 0.0)
   (steerAngle
    :reader steerAngle
    :initarg :steerAngle
    :type cl:float
    :initform 0.0))
)

(cl:defclass LateralINDIState (<LateralINDIState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LateralINDIState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LateralINDIState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LateralINDIState> is deprecated: use openpilot_bridge-msg:LateralINDIState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'rateSetPoint-val :lambda-list '(m))
(cl:defmethod rateSetPoint-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rateSetPoint-val is deprecated.  Use openpilot_bridge-msg:rateSetPoint instead.")
  (rateSetPoint m))

(cl:ensure-generic-function 'delayedOutput-val :lambda-list '(m))
(cl:defmethod delayedOutput-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:delayedOutput-val is deprecated.  Use openpilot_bridge-msg:delayedOutput instead.")
  (delayedOutput m))

(cl:ensure-generic-function 'saturated-val :lambda-list '(m))
(cl:defmethod saturated-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:saturated-val is deprecated.  Use openpilot_bridge-msg:saturated instead.")
  (saturated m))

(cl:ensure-generic-function 'steerAccel-val :lambda-list '(m))
(cl:defmethod steerAccel-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerAccel-val is deprecated.  Use openpilot_bridge-msg:steerAccel instead.")
  (steerAccel m))

(cl:ensure-generic-function 'steerRate-val :lambda-list '(m))
(cl:defmethod steerRate-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerRate-val is deprecated.  Use openpilot_bridge-msg:steerRate instead.")
  (steerRate m))

(cl:ensure-generic-function 'delta-val :lambda-list '(m))
(cl:defmethod delta-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:delta-val is deprecated.  Use openpilot_bridge-msg:delta instead.")
  (delta m))

(cl:ensure-generic-function 'accelError-val :lambda-list '(m))
(cl:defmethod accelError-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:accelError-val is deprecated.  Use openpilot_bridge-msg:accelError instead.")
  (accelError m))

(cl:ensure-generic-function 'accelSetPoint-val :lambda-list '(m))
(cl:defmethod accelSetPoint-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:accelSetPoint-val is deprecated.  Use openpilot_bridge-msg:accelSetPoint instead.")
  (accelSetPoint m))

(cl:ensure-generic-function 'active-val :lambda-list '(m))
(cl:defmethod active-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:active-val is deprecated.  Use openpilot_bridge-msg:active instead.")
  (active m))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:output-val is deprecated.  Use openpilot_bridge-msg:output instead.")
  (output m))

(cl:ensure-generic-function 'steerAngle-val :lambda-list '(m))
(cl:defmethod steerAngle-val ((m <LateralINDIState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerAngle-val is deprecated.  Use openpilot_bridge-msg:steerAngle instead.")
  (steerAngle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LateralINDIState>) ostream)
  "Serializes a message object of type '<LateralINDIState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rateSetPoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delayedOutput))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'saturated) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerAccel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerRate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'delta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accelError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accelSetPoint))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'active) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'output))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steerAngle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LateralINDIState>) istream)
  "Deserializes a message object of type '<LateralINDIState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rateSetPoint) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delayedOutput) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'saturated) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerAccel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerRate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'delta) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accelError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accelSetPoint) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'active) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'output) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steerAngle) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LateralINDIState>)))
  "Returns string type for a message object of type '<LateralINDIState>"
  "openpilot_bridge/LateralINDIState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LateralINDIState)))
  "Returns string type for a message object of type 'LateralINDIState"
  "openpilot_bridge/LateralINDIState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LateralINDIState>)))
  "Returns md5sum for a message object of type '<LateralINDIState>"
  "bd5a4c19a89365a4aac92df08c09943f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LateralINDIState)))
  "Returns md5sum for a message object of type 'LateralINDIState"
  "bd5a4c19a89365a4aac92df08c09943f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LateralINDIState>)))
  "Returns full string definition for message of type '<LateralINDIState>"
  (cl:format cl:nil "Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LateralINDIState)))
  "Returns full string definition for message of type 'LateralINDIState"
  (cl:format cl:nil "Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LateralINDIState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     1
     4
     4
     4
     4
     4
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LateralINDIState>))
  "Converts a ROS message object to a list"
  (cl:list 'LateralINDIState
    (cl:cons ':header (header msg))
    (cl:cons ':rateSetPoint (rateSetPoint msg))
    (cl:cons ':delayedOutput (delayedOutput msg))
    (cl:cons ':saturated (saturated msg))
    (cl:cons ':steerAccel (steerAccel msg))
    (cl:cons ':steerRate (steerRate msg))
    (cl:cons ':delta (delta msg))
    (cl:cons ':accelError (accelError msg))
    (cl:cons ':accelSetPoint (accelSetPoint msg))
    (cl:cons ':active (active msg))
    (cl:cons ':output (output msg))
    (cl:cons ':steerAngle (steerAngle msg))
))
