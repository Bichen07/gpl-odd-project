; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CruiseState.msg.html

(cl:defclass <CruiseState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (available
    :reader available
    :initarg :available
    :type cl:boolean
    :initform cl:nil)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (speedOffset
    :reader speedOffset
    :initarg :speedOffset
    :type cl:float
    :initform 0.0)
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil)
   (standstill
    :reader standstill
    :initarg :standstill
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CruiseState (<CruiseState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CruiseState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CruiseState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CruiseState> is deprecated: use openpilot_bridge-msg:CruiseState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'available-val :lambda-list '(m))
(cl:defmethod available-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:available-val is deprecated.  Use openpilot_bridge-msg:available instead.")
  (available m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speed-val is deprecated.  Use openpilot_bridge-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'speedOffset-val :lambda-list '(m))
(cl:defmethod speedOffset-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedOffset-val is deprecated.  Use openpilot_bridge-msg:speedOffset instead.")
  (speedOffset m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enabled-val is deprecated.  Use openpilot_bridge-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'standstill-val :lambda-list '(m))
(cl:defmethod standstill-val ((m <CruiseState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:standstill-val is deprecated.  Use openpilot_bridge-msg:standstill instead.")
  (standstill m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CruiseState>) ostream)
  "Serializes a message object of type '<CruiseState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'available) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedOffset))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'standstill) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CruiseState>) istream)
  "Deserializes a message object of type '<CruiseState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'available) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedOffset) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'standstill) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CruiseState>)))
  "Returns string type for a message object of type '<CruiseState>"
  "openpilot_bridge/CruiseState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CruiseState)))
  "Returns string type for a message object of type 'CruiseState"
  "openpilot_bridge/CruiseState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CruiseState>)))
  "Returns md5sum for a message object of type '<CruiseState>"
  "28f2062975649fc54f74bcb3056b4d2e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CruiseState)))
  "Returns md5sum for a message object of type 'CruiseState"
  "28f2062975649fc54f74bcb3056b4d2e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CruiseState>)))
  "Returns full string definition for message of type '<CruiseState>"
  (cl:format cl:nil "Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CruiseState)))
  "Returns full string definition for message of type 'CruiseState"
  (cl:format cl:nil "Header header~%~%bool available~%float32 speed~%float32 speedOffset~%bool enabled~%bool standstill~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CruiseState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CruiseState>))
  "Converts a ROS message object to a list"
  (cl:list 'CruiseState
    (cl:cons ':header (header msg))
    (cl:cons ':available (available msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':speedOffset (speedOffset msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':standstill (standstill msg))
))
