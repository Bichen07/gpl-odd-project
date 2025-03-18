; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude WheelSpeeds.msg.html

(cl:defclass <WheelSpeeds> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (rl
    :reader rl
    :initarg :rl
    :type cl:float
    :initform 0.0)
   (fr
    :reader fr
    :initarg :fr
    :type cl:float
    :initform 0.0)
   (fl
    :reader fl
    :initarg :fl
    :type cl:float
    :initform 0.0)
   (rr
    :reader rr
    :initarg :rr
    :type cl:float
    :initform 0.0))
)

(cl:defclass WheelSpeeds (<WheelSpeeds>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WheelSpeeds>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WheelSpeeds)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<WheelSpeeds> is deprecated: use openpilot_bridge-msg:WheelSpeeds instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <WheelSpeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'rl-val :lambda-list '(m))
(cl:defmethod rl-val ((m <WheelSpeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rl-val is deprecated.  Use openpilot_bridge-msg:rl instead.")
  (rl m))

(cl:ensure-generic-function 'fr-val :lambda-list '(m))
(cl:defmethod fr-val ((m <WheelSpeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fr-val is deprecated.  Use openpilot_bridge-msg:fr instead.")
  (fr m))

(cl:ensure-generic-function 'fl-val :lambda-list '(m))
(cl:defmethod fl-val ((m <WheelSpeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:fl-val is deprecated.  Use openpilot_bridge-msg:fl instead.")
  (fl m))

(cl:ensure-generic-function 'rr-val :lambda-list '(m))
(cl:defmethod rr-val ((m <WheelSpeeds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rr-val is deprecated.  Use openpilot_bridge-msg:rr instead.")
  (rr m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WheelSpeeds>) ostream)
  "Serializes a message object of type '<WheelSpeeds>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rl))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fr))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fl))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rr))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WheelSpeeds>) istream)
  "Deserializes a message object of type '<WheelSpeeds>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rl) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fr) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fl) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rr) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WheelSpeeds>)))
  "Returns string type for a message object of type '<WheelSpeeds>"
  "openpilot_bridge/WheelSpeeds")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WheelSpeeds)))
  "Returns string type for a message object of type 'WheelSpeeds"
  "openpilot_bridge/WheelSpeeds")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WheelSpeeds>)))
  "Returns md5sum for a message object of type '<WheelSpeeds>"
  "835b7f85819edc320a2569cabd6d06bb")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WheelSpeeds)))
  "Returns md5sum for a message object of type 'WheelSpeeds"
  "835b7f85819edc320a2569cabd6d06bb")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WheelSpeeds>)))
  "Returns full string definition for message of type '<WheelSpeeds>"
  (cl:format cl:nil "Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WheelSpeeds)))
  "Returns full string definition for message of type 'WheelSpeeds"
  (cl:format cl:nil "Header header~%~%float32 rl~%float32 fr~%float32 fl~%float32 rr~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WheelSpeeds>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WheelSpeeds>))
  "Converts a ROS message object to a list"
  (cl:list 'WheelSpeeds
    (cl:cons ':header (header msg))
    (cl:cons ':rl (rl msg))
    (cl:cons ':fr (fr msg))
    (cl:cons ':fl (fl msg))
    (cl:cons ':rr (rr msg))
))
