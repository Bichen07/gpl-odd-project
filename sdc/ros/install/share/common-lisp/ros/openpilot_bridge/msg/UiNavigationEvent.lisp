; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude UiNavigationEvent.msg.html

(cl:defclass <UiNavigationEvent> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (distanceTo
    :reader distanceTo
    :initarg :distanceTo
    :type cl:float
    :initform 0.0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (endRoadPointDEPRECATED
    :reader endRoadPointDEPRECATED
    :initarg :endRoadPointDEPRECATED
    :type openpilot_bridge-msg:ECEFPointDEPRECATED
    :initform (cl:make-instance 'openpilot_bridge-msg:ECEFPointDEPRECATED))
   (endRoadPoint
    :reader endRoadPoint
    :initarg :endRoadPoint
    :type openpilot_bridge-msg:ECEFPoint
    :initform (cl:make-instance 'openpilot_bridge-msg:ECEFPoint)))
)

(cl:defclass UiNavigationEvent (<UiNavigationEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UiNavigationEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UiNavigationEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<UiNavigationEvent> is deprecated: use openpilot_bridge-msg:UiNavigationEvent instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:status-val is deprecated.  Use openpilot_bridge-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'distanceTo-val :lambda-list '(m))
(cl:defmethod distanceTo-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:distanceTo-val is deprecated.  Use openpilot_bridge-msg:distanceTo instead.")
  (distanceTo m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:type-val is deprecated.  Use openpilot_bridge-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'endRoadPointDEPRECATED-val :lambda-list '(m))
(cl:defmethod endRoadPointDEPRECATED-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:endRoadPointDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:endRoadPointDEPRECATED instead.")
  (endRoadPointDEPRECATED m))

(cl:ensure-generic-function 'endRoadPoint-val :lambda-list '(m))
(cl:defmethod endRoadPoint-val ((m <UiNavigationEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:endRoadPoint-val is deprecated.  Use openpilot_bridge-msg:endRoadPoint instead.")
  (endRoadPoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UiNavigationEvent>) ostream)
  "Serializes a message object of type '<UiNavigationEvent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'status)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'status)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distanceTo))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'endRoadPointDEPRECATED) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'endRoadPoint) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UiNavigationEvent>) istream)
  "Deserializes a message object of type '<UiNavigationEvent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'status)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distanceTo) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'type)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'endRoadPointDEPRECATED) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'endRoadPoint) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UiNavigationEvent>)))
  "Returns string type for a message object of type '<UiNavigationEvent>"
  "openpilot_bridge/UiNavigationEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UiNavigationEvent)))
  "Returns string type for a message object of type 'UiNavigationEvent"
  "openpilot_bridge/UiNavigationEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UiNavigationEvent>)))
  "Returns md5sum for a message object of type '<UiNavigationEvent>"
  "6c5e4c8da028603156189c75ad9e7343")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UiNavigationEvent)))
  "Returns md5sum for a message object of type 'UiNavigationEvent"
  "6c5e4c8da028603156189c75ad9e7343")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UiNavigationEvent>)))
  "Returns full string definition for message of type '<UiNavigationEvent>"
  (cl:format cl:nil "Header header~%~%uint32 status # enum const: Status~%float32 distanceTo~%uint32 type # enum const: Type~%ECEFPointDEPRECATED endRoadPointDEPRECATED~%ECEFPoint endRoadPoint~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UiNavigationEvent)))
  "Returns full string definition for message of type 'UiNavigationEvent"
  (cl:format cl:nil "Header header~%~%uint32 status # enum const: Status~%float32 distanceTo~%uint32 type # enum const: Type~%ECEFPointDEPRECATED endRoadPointDEPRECATED~%ECEFPoint endRoadPoint~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UiNavigationEvent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'endRoadPointDEPRECATED))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'endRoadPoint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UiNavigationEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'UiNavigationEvent
    (cl:cons ':header (header msg))
    (cl:cons ':status (status msg))
    (cl:cons ':distanceTo (distanceTo msg))
    (cl:cons ':type (type msg))
    (cl:cons ':endRoadPointDEPRECATED (endRoadPointDEPRECATED msg))
    (cl:cons ':endRoadPoint (endRoadPoint msg))
))
