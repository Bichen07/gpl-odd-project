; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LateralLQRState.msg.html

(cl:defclass <LateralLQRState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (saturated
    :reader saturated
    :initarg :saturated
    :type cl:boolean
    :initform cl:nil)
   (i
    :reader i
    :initarg :i
    :type cl:float
    :initform 0.0)
   (lqrOutput
    :reader lqrOutput
    :initarg :lqrOutput
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

(cl:defclass LateralLQRState (<LateralLQRState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LateralLQRState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LateralLQRState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LateralLQRState> is deprecated: use openpilot_bridge-msg:LateralLQRState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'saturated-val :lambda-list '(m))
(cl:defmethod saturated-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:saturated-val is deprecated.  Use openpilot_bridge-msg:saturated instead.")
  (saturated m))

(cl:ensure-generic-function 'i-val :lambda-list '(m))
(cl:defmethod i-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:i-val is deprecated.  Use openpilot_bridge-msg:i instead.")
  (i m))

(cl:ensure-generic-function 'lqrOutput-val :lambda-list '(m))
(cl:defmethod lqrOutput-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lqrOutput-val is deprecated.  Use openpilot_bridge-msg:lqrOutput instead.")
  (lqrOutput m))

(cl:ensure-generic-function 'active-val :lambda-list '(m))
(cl:defmethod active-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:active-val is deprecated.  Use openpilot_bridge-msg:active instead.")
  (active m))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:output-val is deprecated.  Use openpilot_bridge-msg:output instead.")
  (output m))

(cl:ensure-generic-function 'steerAngle-val :lambda-list '(m))
(cl:defmethod steerAngle-val ((m <LateralLQRState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steerAngle-val is deprecated.  Use openpilot_bridge-msg:steerAngle instead.")
  (steerAngle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LateralLQRState>) ostream)
  "Serializes a message object of type '<LateralLQRState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'saturated) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'i))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'lqrOutput))))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LateralLQRState>) istream)
  "Deserializes a message object of type '<LateralLQRState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'saturated) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'i) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lqrOutput) (roslisp-utils:decode-single-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LateralLQRState>)))
  "Returns string type for a message object of type '<LateralLQRState>"
  "openpilot_bridge/LateralLQRState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LateralLQRState)))
  "Returns string type for a message object of type 'LateralLQRState"
  "openpilot_bridge/LateralLQRState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LateralLQRState>)))
  "Returns md5sum for a message object of type '<LateralLQRState>"
  "ff5983ad96ee2fa8c9b3219e5644acd9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LateralLQRState)))
  "Returns md5sum for a message object of type 'LateralLQRState"
  "ff5983ad96ee2fa8c9b3219e5644acd9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LateralLQRState>)))
  "Returns full string definition for message of type '<LateralLQRState>"
  (cl:format cl:nil "Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LateralLQRState)))
  "Returns full string definition for message of type 'LateralLQRState"
  (cl:format cl:nil "Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LateralLQRState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LateralLQRState>))
  "Converts a ROS message object to a list"
  (cl:list 'LateralLQRState
    (cl:cons ':header (header msg))
    (cl:cons ':saturated (saturated msg))
    (cl:cons ':i (i msg))
    (cl:cons ':lqrOutput (lqrOutput msg))
    (cl:cons ':active (active msg))
    (cl:cons ':output (output msg))
    (cl:cons ':steerAngle (steerAngle msg))
))
