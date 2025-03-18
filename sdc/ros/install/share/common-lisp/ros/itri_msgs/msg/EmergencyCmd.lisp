; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EmergencyCmd.msg.html

(cl:defclass <EmergencyCmd> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (emergency_cmd
    :reader emergency_cmd
    :initarg :emergency_cmd
    :type cl:integer
    :initform 0))
)

(cl:defclass EmergencyCmd (<EmergencyCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EmergencyCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EmergencyCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EmergencyCmd> is deprecated: use itri_msgs-msg:EmergencyCmd instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EmergencyCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'emergency_cmd-val :lambda-list '(m))
(cl:defmethod emergency_cmd-val ((m <EmergencyCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:emergency_cmd-val is deprecated.  Use itri_msgs-msg:emergency_cmd instead.")
  (emergency_cmd m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<EmergencyCmd>)))
    "Constants for message type '<EmergencyCmd>"
  '((:DEFAULT_STATE . -1)
    (:RESUME_STATE . 0)
    (:HARD_BRAKE . 1)
    (:MILD_BRAKE . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'EmergencyCmd)))
    "Constants for message type 'EmergencyCmd"
  '((:DEFAULT_STATE . -1)
    (:RESUME_STATE . 0)
    (:HARD_BRAKE . 1)
    (:MILD_BRAKE . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EmergencyCmd>) ostream)
  "Serializes a message object of type '<EmergencyCmd>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'emergency_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EmergencyCmd>) istream)
  "Deserializes a message object of type '<EmergencyCmd>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'emergency_cmd) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EmergencyCmd>)))
  "Returns string type for a message object of type '<EmergencyCmd>"
  "itri_msgs/EmergencyCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EmergencyCmd)))
  "Returns string type for a message object of type 'EmergencyCmd"
  "itri_msgs/EmergencyCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EmergencyCmd>)))
  "Returns md5sum for a message object of type '<EmergencyCmd>"
  "b8e8a1e8d9087c63356a16f614d5bb5e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EmergencyCmd)))
  "Returns md5sum for a message object of type 'EmergencyCmd"
  "b8e8a1e8d9087c63356a16f614d5bb5e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EmergencyCmd>)))
  "Returns full string definition for message of type '<EmergencyCmd>"
  (cl:format cl:nil "Header header~%~%int32 DEFAULT_STATE = -1~%int32 RESUME_STATE = 0~%int32 HARD_BRAKE = 1~%int32 MILD_BRAKE = 2~%~%int32 emergency_cmd~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EmergencyCmd)))
  "Returns full string definition for message of type 'EmergencyCmd"
  (cl:format cl:nil "Header header~%~%int32 DEFAULT_STATE = -1~%int32 RESUME_STATE = 0~%int32 HARD_BRAKE = 1~%int32 MILD_BRAKE = 2~%~%int32 emergency_cmd~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EmergencyCmd>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EmergencyCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'EmergencyCmd
    (cl:cons ':header (header msg))
    (cl:cons ':emergency_cmd (emergency_cmd msg))
))
