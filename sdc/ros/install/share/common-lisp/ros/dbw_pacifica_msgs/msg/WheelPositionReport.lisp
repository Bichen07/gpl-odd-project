; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude WheelPositionReport.msg.html

(cl:defclass <WheelPositionReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (front_left
    :reader front_left
    :initarg :front_left
    :type cl:fixnum
    :initform 0)
   (front_right
    :reader front_right
    :initarg :front_right
    :type cl:fixnum
    :initform 0)
   (rear_left
    :reader rear_left
    :initarg :rear_left
    :type cl:fixnum
    :initform 0)
   (rear_right
    :reader rear_right
    :initarg :rear_right
    :type cl:fixnum
    :initform 0)
   (wheel_pulses_per_rev
    :reader wheel_pulses_per_rev
    :initarg :wheel_pulses_per_rev
    :type cl:float
    :initform 0.0))
)

(cl:defclass WheelPositionReport (<WheelPositionReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WheelPositionReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WheelPositionReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<WheelPositionReport> is deprecated: use dbw_pacifica_msgs-msg:WheelPositionReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'front_left-val :lambda-list '(m))
(cl:defmethod front_left-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_left-val is deprecated.  Use dbw_pacifica_msgs-msg:front_left instead.")
  (front_left m))

(cl:ensure-generic-function 'front_right-val :lambda-list '(m))
(cl:defmethod front_right-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_right-val is deprecated.  Use dbw_pacifica_msgs-msg:front_right instead.")
  (front_right m))

(cl:ensure-generic-function 'rear_left-val :lambda-list '(m))
(cl:defmethod rear_left-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_left-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_left instead.")
  (rear_left m))

(cl:ensure-generic-function 'rear_right-val :lambda-list '(m))
(cl:defmethod rear_right-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_right-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_right instead.")
  (rear_right m))

(cl:ensure-generic-function 'wheel_pulses_per_rev-val :lambda-list '(m))
(cl:defmethod wheel_pulses_per_rev-val ((m <WheelPositionReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:wheel_pulses_per_rev-val is deprecated.  Use dbw_pacifica_msgs-msg:wheel_pulses_per_rev instead.")
  (wheel_pulses_per_rev m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WheelPositionReport>) ostream)
  "Serializes a message object of type '<WheelPositionReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'front_left)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'front_right)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'rear_left)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'rear_right)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'wheel_pulses_per_rev))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WheelPositionReport>) istream)
  "Deserializes a message object of type '<WheelPositionReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'front_left) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'front_right) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rear_left) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rear_right) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'wheel_pulses_per_rev) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WheelPositionReport>)))
  "Returns string type for a message object of type '<WheelPositionReport>"
  "dbw_pacifica_msgs/WheelPositionReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WheelPositionReport)))
  "Returns string type for a message object of type 'WheelPositionReport"
  "dbw_pacifica_msgs/WheelPositionReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WheelPositionReport>)))
  "Returns md5sum for a message object of type '<WheelPositionReport>"
  "dcdb40156270607476a632a433cc6d45")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WheelPositionReport)))
  "Returns md5sum for a message object of type 'WheelPositionReport"
  "dcdb40156270607476a632a433cc6d45")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WheelPositionReport>)))
  "Returns full string definition for message of type '<WheelPositionReport>"
  (cl:format cl:nil "Header header~%~%# Wheel positions (counts)~%int16 front_left~%int16 front_right~%int16 rear_left~%int16 rear_right~%~%# Conversion factor~%float32 wheel_pulses_per_rev~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WheelPositionReport)))
  "Returns full string definition for message of type 'WheelPositionReport"
  (cl:format cl:nil "Header header~%~%# Wheel positions (counts)~%int16 front_left~%int16 front_right~%int16 rear_left~%int16 rear_right~%~%# Conversion factor~%float32 wheel_pulses_per_rev~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WheelPositionReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     2
     2
     2
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WheelPositionReport>))
  "Converts a ROS message object to a list"
  (cl:list 'WheelPositionReport
    (cl:cons ':header (header msg))
    (cl:cons ':front_left (front_left msg))
    (cl:cons ':front_right (front_right msg))
    (cl:cons ':rear_left (rear_left msg))
    (cl:cons ':rear_right (rear_right msg))
    (cl:cons ':wheel_pulses_per_rev (wheel_pulses_per_rev msg))
))
