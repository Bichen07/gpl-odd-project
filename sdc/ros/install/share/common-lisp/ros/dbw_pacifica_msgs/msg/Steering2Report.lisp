; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude Steering2Report.msg.html

(cl:defclass <Steering2Report> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (vehicle_curvature_actual
    :reader vehicle_curvature_actual
    :initarg :vehicle_curvature_actual
    :type cl:float
    :initform 0.0)
   (steer_torque_driver
    :reader steer_torque_driver
    :initarg :steer_torque_driver
    :type cl:float
    :initform 0.0)
   (steer_torque_motor
    :reader steer_torque_motor
    :initarg :steer_torque_motor
    :type cl:float
    :initform 0.0))
)

(cl:defclass Steering2Report (<Steering2Report>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Steering2Report>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Steering2Report)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<Steering2Report> is deprecated: use dbw_pacifica_msgs-msg:Steering2Report instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Steering2Report>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'vehicle_curvature_actual-val :lambda-list '(m))
(cl:defmethod vehicle_curvature_actual-val ((m <Steering2Report>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_curvature_actual-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_curvature_actual instead.")
  (vehicle_curvature_actual m))

(cl:ensure-generic-function 'steer_torque_driver-val :lambda-list '(m))
(cl:defmethod steer_torque_driver-val ((m <Steering2Report>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steer_torque_driver-val is deprecated.  Use dbw_pacifica_msgs-msg:steer_torque_driver instead.")
  (steer_torque_driver m))

(cl:ensure-generic-function 'steer_torque_motor-val :lambda-list '(m))
(cl:defmethod steer_torque_motor-val ((m <Steering2Report>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steer_torque_motor-val is deprecated.  Use dbw_pacifica_msgs-msg:steer_torque_motor instead.")
  (steer_torque_motor m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Steering2Report>) ostream)
  "Serializes a message object of type '<Steering2Report>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_curvature_actual))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steer_torque_driver))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steer_torque_motor))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Steering2Report>) istream)
  "Deserializes a message object of type '<Steering2Report>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_curvature_actual) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steer_torque_driver) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steer_torque_motor) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Steering2Report>)))
  "Returns string type for a message object of type '<Steering2Report>"
  "dbw_pacifica_msgs/Steering2Report")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Steering2Report)))
  "Returns string type for a message object of type 'Steering2Report"
  "dbw_pacifica_msgs/Steering2Report")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Steering2Report>)))
  "Returns md5sum for a message object of type '<Steering2Report>"
  "009145df632b20263fd61a2cbd47cc87")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Steering2Report)))
  "Returns md5sum for a message object of type 'Steering2Report"
  "009145df632b20263fd61a2cbd47cc87")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Steering2Report>)))
  "Returns full string definition for message of type '<Steering2Report>"
  (cl:format cl:nil "Header header~%~%float32 vehicle_curvature_actual # units are 1/m~%float32 steer_torque_driver~%float32 steer_torque_motor~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Steering2Report)))
  "Returns full string definition for message of type 'Steering2Report"
  (cl:format cl:nil "Header header~%~%float32 vehicle_curvature_actual # units are 1/m~%float32 steer_torque_driver~%float32 steer_torque_motor~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Steering2Report>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Steering2Report>))
  "Converts a ROS message object to a list"
  (cl:list 'Steering2Report
    (cl:cons ':header (header msg))
    (cl:cons ':vehicle_curvature_actual (vehicle_curvature_actual msg))
    (cl:cons ':steer_torque_driver (steer_torque_driver msg))
    (cl:cons ':steer_torque_motor (steer_torque_motor msg))
))
