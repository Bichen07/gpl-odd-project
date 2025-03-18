; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude TrafficEvent.msg.html

(cl:defclass <TrafficEvent> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (action
    :reader action
    :initarg :action
    :type cl:integer
    :initform 0)
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (resuming
    :reader resuming
    :initarg :resuming
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TrafficEvent (<TrafficEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<TrafficEvent> is deprecated: use openpilot_bridge-msg:TrafficEvent instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <TrafficEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:action-val is deprecated.  Use openpilot_bridge-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <TrafficEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:distance-val is deprecated.  Use openpilot_bridge-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <TrafficEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:type-val is deprecated.  Use openpilot_bridge-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'resuming-val :lambda-list '(m))
(cl:defmethod resuming-val ((m <TrafficEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:resuming-val is deprecated.  Use openpilot_bridge-msg:resuming instead.")
  (resuming m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficEvent>) ostream)
  "Serializes a message object of type '<TrafficEvent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'action)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'action)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'action)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'resuming) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficEvent>) istream)
  "Deserializes a message object of type '<TrafficEvent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'action)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'resuming) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficEvent>)))
  "Returns string type for a message object of type '<TrafficEvent>"
  "openpilot_bridge/TrafficEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficEvent)))
  "Returns string type for a message object of type 'TrafficEvent"
  "openpilot_bridge/TrafficEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficEvent>)))
  "Returns md5sum for a message object of type '<TrafficEvent>"
  "df9e6938ac7ed3b8cc96f41615535461")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficEvent)))
  "Returns md5sum for a message object of type 'TrafficEvent"
  "df9e6938ac7ed3b8cc96f41615535461")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficEvent>)))
  "Returns full string definition for message of type '<TrafficEvent>"
  (cl:format cl:nil "Header header~%~%uint32 action # enum const: Action~%float32 distance~%uint32 type # enum const: Type~%bool resuming~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficEvent)))
  "Returns full string definition for message of type 'TrafficEvent"
  (cl:format cl:nil "Header header~%~%uint32 action # enum const: Action~%float32 distance~%uint32 type # enum const: Type~%bool resuming~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficEvent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficEvent
    (cl:cons ':header (header msg))
    (cl:cons ':action (action msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':type (type msg))
    (cl:cons ':resuming (resuming msg))
))
