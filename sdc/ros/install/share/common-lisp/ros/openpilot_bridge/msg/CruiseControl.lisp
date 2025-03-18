; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CruiseControl.msg.html

(cl:defclass <CruiseControl> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (cancel
    :reader cancel
    :initarg :cancel
    :type cl:boolean
    :initform cl:nil)
   (override
    :reader override
    :initarg :override
    :type cl:boolean
    :initform cl:nil)
   (speedOverride
    :reader speedOverride
    :initarg :speedOverride
    :type cl:float
    :initform 0.0)
   (accelOverride
    :reader accelOverride
    :initarg :accelOverride
    :type cl:float
    :initform 0.0))
)

(cl:defclass CruiseControl (<CruiseControl>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CruiseControl>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CruiseControl)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CruiseControl> is deprecated: use openpilot_bridge-msg:CruiseControl instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CruiseControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'cancel-val :lambda-list '(m))
(cl:defmethod cancel-val ((m <CruiseControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:cancel-val is deprecated.  Use openpilot_bridge-msg:cancel instead.")
  (cancel m))

(cl:ensure-generic-function 'override-val :lambda-list '(m))
(cl:defmethod override-val ((m <CruiseControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:override-val is deprecated.  Use openpilot_bridge-msg:override instead.")
  (override m))

(cl:ensure-generic-function 'speedOverride-val :lambda-list '(m))
(cl:defmethod speedOverride-val ((m <CruiseControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedOverride-val is deprecated.  Use openpilot_bridge-msg:speedOverride instead.")
  (speedOverride m))

(cl:ensure-generic-function 'accelOverride-val :lambda-list '(m))
(cl:defmethod accelOverride-val ((m <CruiseControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:accelOverride-val is deprecated.  Use openpilot_bridge-msg:accelOverride instead.")
  (accelOverride m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CruiseControl>) ostream)
  "Serializes a message object of type '<CruiseControl>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cancel) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'override) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedOverride))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accelOverride))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CruiseControl>) istream)
  "Deserializes a message object of type '<CruiseControl>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'cancel) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'override) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedOverride) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accelOverride) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CruiseControl>)))
  "Returns string type for a message object of type '<CruiseControl>"
  "openpilot_bridge/CruiseControl")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CruiseControl)))
  "Returns string type for a message object of type 'CruiseControl"
  "openpilot_bridge/CruiseControl")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CruiseControl>)))
  "Returns md5sum for a message object of type '<CruiseControl>"
  "08f6bd5b4e57f59d4c99b2a0ea459283")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CruiseControl)))
  "Returns md5sum for a message object of type 'CruiseControl"
  "08f6bd5b4e57f59d4c99b2a0ea459283")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CruiseControl>)))
  "Returns full string definition for message of type '<CruiseControl>"
  (cl:format cl:nil "Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CruiseControl)))
  "Returns full string definition for message of type 'CruiseControl"
  (cl:format cl:nil "Header header~%~%bool cancel~%bool override~%float32 speedOverride~%float32 accelOverride~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CruiseControl>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CruiseControl>))
  "Converts a ROS message object to a list"
  (cl:list 'CruiseControl
    (cl:cons ':header (header msg))
    (cl:cons ':cancel (cancel msg))
    (cl:cons ':override (override msg))
    (cl:cons ':speedOverride (speedOverride msg))
    (cl:cons ':accelOverride (accelOverride msg))
))
