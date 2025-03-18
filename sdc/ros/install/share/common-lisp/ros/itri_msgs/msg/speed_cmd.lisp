; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude speed_cmd.msg.html

(cl:defclass <speed_cmd> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (kph
    :reader kph
    :initarg :kph
    :type cl:float
    :initform 0.0)
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type cl:float
    :initform 0.0)
   (velocityCmdState
    :reader velocityCmdState
    :initarg :velocityCmdState
    :type cl:fixnum
    :initform 0))
)

(cl:defclass speed_cmd (<speed_cmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <speed_cmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'speed_cmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<speed_cmd> is deprecated: use itri_msgs-msg:speed_cmd instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <speed_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <speed_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:type-val is deprecated.  Use itri_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'kph-val :lambda-list '(m))
(cl:defmethod kph-val ((m <speed_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:kph-val is deprecated.  Use itri_msgs-msg:kph instead.")
  (kph m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <speed_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:acceleration-val is deprecated.  Use itri_msgs-msg:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'velocityCmdState-val :lambda-list '(m))
(cl:defmethod velocityCmdState-val ((m <speed_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocityCmdState-val is deprecated.  Use itri_msgs-msg:velocityCmdState instead.")
  (velocityCmdState m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<speed_cmd>)))
    "Constants for message type '<speed_cmd>"
  '((:OPEN_LOOP . 0)
    (:CLOSE_LOOP . 1)
    (:NON_DEFINE . 0)
    (:ACCELERATION . 1)
    (:CONSTANT_SPEED . 2)
    (:DEACCELERATION . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'speed_cmd)))
    "Constants for message type 'speed_cmd"
  '((:OPEN_LOOP . 0)
    (:CLOSE_LOOP . 1)
    (:NON_DEFINE . 0)
    (:ACCELERATION . 1)
    (:CONSTANT_SPEED . 2)
    (:DEACCELERATION . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <speed_cmd>) ostream)
  "Serializes a message object of type '<speed_cmd>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'kph))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'acceleration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'velocityCmdState)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <speed_cmd>) istream)
  "Deserializes a message object of type '<speed_cmd>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'kph) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'acceleration) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'velocityCmdState)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<speed_cmd>)))
  "Returns string type for a message object of type '<speed_cmd>"
  "itri_msgs/speed_cmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'speed_cmd)))
  "Returns string type for a message object of type 'speed_cmd"
  "itri_msgs/speed_cmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<speed_cmd>)))
  "Returns md5sum for a message object of type '<speed_cmd>"
  "72fdcf92cab2efe452f034bb122ac210")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'speed_cmd)))
  "Returns md5sum for a message object of type 'speed_cmd"
  "72fdcf92cab2efe452f034bb122ac210")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<speed_cmd>)))
  "Returns full string definition for message of type '<speed_cmd>"
  (cl:format cl:nil "Header header~%~%uint8 OPEN_LOOP = 0~%uint8 CLOSE_LOOP = 1~%~%uint8 NON_DEFINE = 0~%uint8 ACCELERATION = 1~%uint8 CONSTANT_SPEED = 2~%uint8 DEACCELERATION = 3~%~%uint8 type~%float32 kph~%float32 acceleration~%uint8 velocityCmdState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'speed_cmd)))
  "Returns full string definition for message of type 'speed_cmd"
  (cl:format cl:nil "Header header~%~%uint8 OPEN_LOOP = 0~%uint8 CLOSE_LOOP = 1~%~%uint8 NON_DEFINE = 0~%uint8 ACCELERATION = 1~%uint8 CONSTANT_SPEED = 2~%uint8 DEACCELERATION = 3~%~%uint8 type~%float32 kph~%float32 acceleration~%uint8 velocityCmdState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <speed_cmd>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <speed_cmd>))
  "Converts a ROS message object to a list"
  (cl:list 'speed_cmd
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':kph (kph msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':velocityCmdState (velocityCmdState msg))
))
