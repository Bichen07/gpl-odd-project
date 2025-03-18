; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CarControl.msg.html

(cl:defclass <CarControl> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (brakeDEPRECATED
    :reader brakeDEPRECATED
    :initarg :brakeDEPRECATED
    :type cl:float
    :initform 0.0)
   (gasDEPRECATED
    :reader gasDEPRECATED
    :initarg :gasDEPRECATED
    :type cl:float
    :initform 0.0)
   (steeringTorqueDEPRECATED
    :reader steeringTorqueDEPRECATED
    :initarg :steeringTorqueDEPRECATED
    :type cl:float
    :initform 0.0)
   (cruiseControl
    :reader cruiseControl
    :initarg :cruiseControl
    :type openpilot_bridge-msg:CruiseControl
    :initform (cl:make-instance 'openpilot_bridge-msg:CruiseControl))
   (actuators
    :reader actuators
    :initarg :actuators
    :type openpilot_bridge-msg:Actuators
    :initform (cl:make-instance 'openpilot_bridge-msg:Actuators))
   (active
    :reader active
    :initarg :active
    :type cl:boolean
    :initform cl:nil)
   (hudControl
    :reader hudControl
    :initarg :hudControl
    :type openpilot_bridge-msg:HUDControl
    :initform (cl:make-instance 'openpilot_bridge-msg:HUDControl))
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CarControl (<CarControl>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CarControl>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CarControl)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CarControl> is deprecated: use openpilot_bridge-msg:CarControl instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'brakeDEPRECATED-val :lambda-list '(m))
(cl:defmethod brakeDEPRECATED-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:brakeDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:brakeDEPRECATED instead.")
  (brakeDEPRECATED m))

(cl:ensure-generic-function 'gasDEPRECATED-val :lambda-list '(m))
(cl:defmethod gasDEPRECATED-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gasDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:gasDEPRECATED instead.")
  (gasDEPRECATED m))

(cl:ensure-generic-function 'steeringTorqueDEPRECATED-val :lambda-list '(m))
(cl:defmethod steeringTorqueDEPRECATED-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:steeringTorqueDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:steeringTorqueDEPRECATED instead.")
  (steeringTorqueDEPRECATED m))

(cl:ensure-generic-function 'cruiseControl-val :lambda-list '(m))
(cl:defmethod cruiseControl-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cruiseControl-val is deprecated.  Use openpilot_bridge-msg:cruiseControl instead.")
  (cruiseControl m))

(cl:ensure-generic-function 'actuators-val :lambda-list '(m))
(cl:defmethod actuators-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:actuators-val is deprecated.  Use openpilot_bridge-msg:actuators instead.")
  (actuators m))

(cl:ensure-generic-function 'active-val :lambda-list '(m))
(cl:defmethod active-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:active-val is deprecated.  Use openpilot_bridge-msg:active instead.")
  (active m))

(cl:ensure-generic-function 'hudControl-val :lambda-list '(m))
(cl:defmethod hudControl-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:hudControl-val is deprecated.  Use openpilot_bridge-msg:hudControl instead.")
  (hudControl m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <CarControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enabled-val is deprecated.  Use openpilot_bridge-msg:enabled instead.")
  (enabled m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CarControl>) ostream)
  "Serializes a message object of type '<CarControl>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brakeDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gasDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steeringTorqueDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cruiseControl) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'actuators) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'active) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'hudControl) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CarControl>) istream)
  "Deserializes a message object of type '<CarControl>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brakeDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gasDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steeringTorqueDEPRECATED) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cruiseControl) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'actuators) istream)
    (cl:setf (cl:slot-value msg 'active) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'hudControl) istream)
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CarControl>)))
  "Returns string type for a message object of type '<CarControl>"
  "openpilot_bridge/CarControl")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CarControl)))
  "Returns string type for a message object of type 'CarControl"
  "openpilot_bridge/CarControl")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CarControl>)))
  "Returns md5sum for a message object of type '<CarControl>"
  "5052bf96d04aed7d203247b76e13ddb3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CarControl)))
  "Returns md5sum for a message object of type 'CarControl"
  "5052bf96d04aed7d203247b76e13ddb3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CarControl>)))
  "Returns full string definition for message of type '<CarControl>"
  (cl:format cl:nil "Header header~%~%float32 brakeDEPRECATED~%float32 gasDEPRECATED~%float32 steeringTorqueDEPRECATED~%CruiseControl cruiseControl~%Actuators actuators~%bool active~%HUDControl hudControl~%bool enabled~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CruiseControl~%Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: openpilot_bridge/Actuators~%Header header~%~%float32 brake~%float32 gas~%float32 steerAngle~%float32 steer~%~%================================================================================~%MSG: openpilot_bridge/HUDControl~%Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CarControl)))
  "Returns full string definition for message of type 'CarControl"
  (cl:format cl:nil "Header header~%~%float32 brakeDEPRECATED~%float32 gasDEPRECATED~%float32 steeringTorqueDEPRECATED~%CruiseControl cruiseControl~%Actuators actuators~%bool active~%HUDControl hudControl~%bool enabled~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/CruiseControl~%Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: openpilot_bridge/Actuators~%Header header~%~%float32 brake~%float32 gas~%float32 steerAngle~%float32 steer~%~%================================================================================~%MSG: openpilot_bridge/HUDControl~%Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CarControl>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cruiseControl))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'actuators))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'hudControl))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CarControl>))
  "Converts a ROS message object to a list"
  (cl:list 'CarControl
    (cl:cons ':header (header msg))
    (cl:cons ':brakeDEPRECATED (brakeDEPRECATED msg))
    (cl:cons ':gasDEPRECATED (gasDEPRECATED msg))
    (cl:cons ':steeringTorqueDEPRECATED (steeringTorqueDEPRECATED msg))
    (cl:cons ':cruiseControl (cruiseControl msg))
    (cl:cons ':actuators (actuators msg))
    (cl:cons ':active (active msg))
    (cl:cons ':hudControl (hudControl msg))
    (cl:cons ':enabled (enabled msg))
))
