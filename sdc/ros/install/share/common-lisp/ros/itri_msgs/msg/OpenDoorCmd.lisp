; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude OpenDoorCmd.msg.html

(cl:defclass <OpenDoorCmd> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (left_door
    :reader left_door
    :initarg :left_door
    :type cl:fixnum
    :initform 0)
   (right_door
    :reader right_door
    :initarg :right_door
    :type cl:fixnum
    :initform 0)
   (lift_gate
    :reader lift_gate
    :initarg :lift_gate
    :type cl:fixnum
    :initform 0))
)

(cl:defclass OpenDoorCmd (<OpenDoorCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OpenDoorCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OpenDoorCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<OpenDoorCmd> is deprecated: use itri_msgs-msg:OpenDoorCmd instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <OpenDoorCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'left_door-val :lambda-list '(m))
(cl:defmethod left_door-val ((m <OpenDoorCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left_door-val is deprecated.  Use itri_msgs-msg:left_door instead.")
  (left_door m))

(cl:ensure-generic-function 'right_door-val :lambda-list '(m))
(cl:defmethod right_door-val ((m <OpenDoorCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right_door-val is deprecated.  Use itri_msgs-msg:right_door instead.")
  (right_door m))

(cl:ensure-generic-function 'lift_gate-val :lambda-list '(m))
(cl:defmethod lift_gate-val ((m <OpenDoorCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lift_gate-val is deprecated.  Use itri_msgs-msg:lift_gate instead.")
  (lift_gate m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<OpenDoorCmd>)))
    "Constants for message type '<OpenDoorCmd>"
  '((:CLOSE . 0)
    (:OPEN . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'OpenDoorCmd)))
    "Constants for message type 'OpenDoorCmd"
  '((:CLOSE . 0)
    (:OPEN . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OpenDoorCmd>) ostream)
  "Serializes a message object of type '<OpenDoorCmd>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'left_door)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'right_door)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lift_gate)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OpenDoorCmd>) istream)
  "Deserializes a message object of type '<OpenDoorCmd>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'left_door)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'right_door)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lift_gate)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OpenDoorCmd>)))
  "Returns string type for a message object of type '<OpenDoorCmd>"
  "itri_msgs/OpenDoorCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OpenDoorCmd)))
  "Returns string type for a message object of type 'OpenDoorCmd"
  "itri_msgs/OpenDoorCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OpenDoorCmd>)))
  "Returns md5sum for a message object of type '<OpenDoorCmd>"
  "332bf344cd0038f6923ce7682ee1fd53")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OpenDoorCmd)))
  "Returns md5sum for a message object of type 'OpenDoorCmd"
  "332bf344cd0038f6923ce7682ee1fd53")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OpenDoorCmd>)))
  "Returns full string definition for message of type '<OpenDoorCmd>"
  (cl:format cl:nil "Header header~%~%uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 left_door~%uint8 right_door~%uint8 lift_gate~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OpenDoorCmd)))
  "Returns full string definition for message of type 'OpenDoorCmd"
  (cl:format cl:nil "Header header~%~%uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 left_door~%uint8 right_door~%uint8 lift_gate~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OpenDoorCmd>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OpenDoorCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'OpenDoorCmd
    (cl:cons ':header (header msg))
    (cl:cons ':left_door (left_door msg))
    (cl:cons ':right_door (right_door msg))
    (cl:cons ':lift_gate (lift_gate msg))
))
