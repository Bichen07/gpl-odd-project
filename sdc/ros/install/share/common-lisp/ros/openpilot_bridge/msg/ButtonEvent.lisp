; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ButtonEvent.msg.html

(cl:defclass <ButtonEvent> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (pressed
    :reader pressed
    :initarg :pressed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ButtonEvent (<ButtonEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ButtonEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ButtonEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ButtonEvent> is deprecated: use openpilot_bridge-msg:ButtonEvent instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ButtonEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ButtonEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:type-val is deprecated.  Use openpilot_bridge-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'pressed-val :lambda-list '(m))
(cl:defmethod pressed-val ((m <ButtonEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pressed-val is deprecated.  Use openpilot_bridge-msg:pressed instead.")
  (pressed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ButtonEvent>) ostream)
  "Serializes a message object of type '<ButtonEvent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pressed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ButtonEvent>) istream)
  "Deserializes a message object of type '<ButtonEvent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pressed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ButtonEvent>)))
  "Returns string type for a message object of type '<ButtonEvent>"
  "openpilot_bridge/ButtonEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ButtonEvent)))
  "Returns string type for a message object of type 'ButtonEvent"
  "openpilot_bridge/ButtonEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ButtonEvent>)))
  "Returns md5sum for a message object of type '<ButtonEvent>"
  "a73eec4face11f6e7d39beb188805386")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ButtonEvent)))
  "Returns md5sum for a message object of type 'ButtonEvent"
  "a73eec4face11f6e7d39beb188805386")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ButtonEvent>)))
  "Returns full string definition for message of type '<ButtonEvent>"
  (cl:format cl:nil "Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ButtonEvent)))
  "Returns full string definition for message of type 'ButtonEvent"
  (cl:format cl:nil "Header header~%~%uint32 type # enum const: Type~%bool pressed~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ButtonEvent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ButtonEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'ButtonEvent
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':pressed (pressed msg))
))
