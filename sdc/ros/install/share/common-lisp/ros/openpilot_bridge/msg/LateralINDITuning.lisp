; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LateralINDITuning.msg.html

(cl:defclass <LateralINDITuning> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (actuatorEffectiveness
    :reader actuatorEffectiveness
    :initarg :actuatorEffectiveness
    :type cl:float
    :initform 0.0)
   (outerLoopGain
    :reader outerLoopGain
    :initarg :outerLoopGain
    :type cl:float
    :initform 0.0)
   (innerLoopGain
    :reader innerLoopGain
    :initarg :innerLoopGain
    :type cl:float
    :initform 0.0)
   (timeConstant
    :reader timeConstant
    :initarg :timeConstant
    :type cl:float
    :initform 0.0))
)

(cl:defclass LateralINDITuning (<LateralINDITuning>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LateralINDITuning>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LateralINDITuning)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LateralINDITuning> is deprecated: use openpilot_bridge-msg:LateralINDITuning instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LateralINDITuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'actuatorEffectiveness-val :lambda-list '(m))
(cl:defmethod actuatorEffectiveness-val ((m <LateralINDITuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:actuatorEffectiveness-val is deprecated.  Use openpilot_bridge-msg:actuatorEffectiveness instead.")
  (actuatorEffectiveness m))

(cl:ensure-generic-function 'outerLoopGain-val :lambda-list '(m))
(cl:defmethod outerLoopGain-val ((m <LateralINDITuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:outerLoopGain-val is deprecated.  Use openpilot_bridge-msg:outerLoopGain instead.")
  (outerLoopGain m))

(cl:ensure-generic-function 'innerLoopGain-val :lambda-list '(m))
(cl:defmethod innerLoopGain-val ((m <LateralINDITuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:innerLoopGain-val is deprecated.  Use openpilot_bridge-msg:innerLoopGain instead.")
  (innerLoopGain m))

(cl:ensure-generic-function 'timeConstant-val :lambda-list '(m))
(cl:defmethod timeConstant-val ((m <LateralINDITuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timeConstant-val is deprecated.  Use openpilot_bridge-msg:timeConstant instead.")
  (timeConstant m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LateralINDITuning>) ostream)
  "Serializes a message object of type '<LateralINDITuning>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'actuatorEffectiveness))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'outerLoopGain))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'innerLoopGain))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'timeConstant))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LateralINDITuning>) istream)
  "Deserializes a message object of type '<LateralINDITuning>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'actuatorEffectiveness) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'outerLoopGain) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'innerLoopGain) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timeConstant) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LateralINDITuning>)))
  "Returns string type for a message object of type '<LateralINDITuning>"
  "openpilot_bridge/LateralINDITuning")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LateralINDITuning)))
  "Returns string type for a message object of type 'LateralINDITuning"
  "openpilot_bridge/LateralINDITuning")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LateralINDITuning>)))
  "Returns md5sum for a message object of type '<LateralINDITuning>"
  "9ff2e2f4cb8a2e149864fcfa0d8adca2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LateralINDITuning)))
  "Returns md5sum for a message object of type 'LateralINDITuning"
  "9ff2e2f4cb8a2e149864fcfa0d8adca2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LateralINDITuning>)))
  "Returns full string definition for message of type '<LateralINDITuning>"
  (cl:format cl:nil "Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LateralINDITuning)))
  "Returns full string definition for message of type 'LateralINDITuning"
  (cl:format cl:nil "Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LateralINDITuning>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LateralINDITuning>))
  "Converts a ROS message object to a list"
  (cl:list 'LateralINDITuning
    (cl:cons ':header (header msg))
    (cl:cons ':actuatorEffectiveness (actuatorEffectiveness msg))
    (cl:cons ':outerLoopGain (outerLoopGain msg))
    (cl:cons ':innerLoopGain (innerLoopGain msg))
    (cl:cons ':timeConstant (timeConstant msg))
))
