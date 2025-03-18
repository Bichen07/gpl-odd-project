; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude steer_cmd.msg.html

(cl:defclass <steer_cmd> (roslisp-msg-protocol:ros-message)
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
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0)
   (torque
    :reader torque
    :initarg :torque
    :type cl:float
    :initform 0.0))
)

(cl:defclass steer_cmd (<steer_cmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <steer_cmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'steer_cmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<steer_cmd> is deprecated: use itri_msgs-msg:steer_cmd instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <steer_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <steer_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:type-val is deprecated.  Use itri_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <steer_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:angle-val is deprecated.  Use itri_msgs-msg:angle instead.")
  (angle m))

(cl:ensure-generic-function 'torque-val :lambda-list '(m))
(cl:defmethod torque-val ((m <steer_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:torque-val is deprecated.  Use itri_msgs-msg:torque instead.")
  (torque m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<steer_cmd>)))
    "Constants for message type '<steer_cmd>"
  '((:OPEN_LOOP . 0)
    (:CLOSE_LOOP . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'steer_cmd)))
    "Constants for message type 'steer_cmd"
  '((:OPEN_LOOP . 0)
    (:CLOSE_LOOP . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <steer_cmd>) ostream)
  "Serializes a message object of type '<steer_cmd>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <steer_cmd>) istream)
  "Deserializes a message object of type '<steer_cmd>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<steer_cmd>)))
  "Returns string type for a message object of type '<steer_cmd>"
  "itri_msgs/steer_cmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'steer_cmd)))
  "Returns string type for a message object of type 'steer_cmd"
  "itri_msgs/steer_cmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<steer_cmd>)))
  "Returns md5sum for a message object of type '<steer_cmd>"
  "0fb12a31a535257274c7d1fffc66590e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'steer_cmd)))
  "Returns md5sum for a message object of type 'steer_cmd"
  "0fb12a31a535257274c7d1fffc66590e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<steer_cmd>)))
  "Returns full string definition for message of type '<steer_cmd>"
  (cl:format cl:nil "Header header~%~%uint8 OPEN_LOOP = 0~%uint8 CLOSE_LOOP = 1~%~%uint8 type~%float32 angle~%float32 torque~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'steer_cmd)))
  "Returns full string definition for message of type 'steer_cmd"
  (cl:format cl:nil "Header header~%~%uint8 OPEN_LOOP = 0~%uint8 CLOSE_LOOP = 1~%~%uint8 type~%float32 angle~%float32 torque~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <steer_cmd>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <steer_cmd>))
  "Converts a ROS message object to a list"
  (cl:list 'steer_cmd
    (cl:cons ':header (header msg))
    (cl:cons ':type (type msg))
    (cl:cons ':angle (angle msg))
    (cl:cons ':torque (torque msg))
))
