; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude SteeringReport.msg.html

(cl:defclass <SteeringReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (steering_wheel_angle
    :reader steering_wheel_angle
    :initarg :steering_wheel_angle
    :type cl:float
    :initform 0.0)
   (steering_wheel_angle_cmd
    :reader steering_wheel_angle_cmd
    :initarg :steering_wheel_angle_cmd
    :type cl:float
    :initform 0.0)
   (steering_wheel_torque
    :reader steering_wheel_torque
    :initarg :steering_wheel_torque
    :type cl:float
    :initform 0.0)
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil)
   (driver_activity
    :reader driver_activity
    :initarg :driver_activity
    :type cl:boolean
    :initform cl:nil)
   (fault_steering_system
    :reader fault_steering_system
    :initarg :fault_steering_system
    :type cl:boolean
    :initform cl:nil)
   (overheat_prevention_mode
    :reader overheat_prevention_mode
    :initarg :overheat_prevention_mode
    :type cl:boolean
    :initform cl:nil)
   (rolling_counter
    :reader rolling_counter
    :initarg :rolling_counter
    :type cl:fixnum
    :initform 0)
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode))
   (steering_over_heat_warning
    :reader steering_over_heat_warning
    :initarg :steering_over_heat_warning
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SteeringReport (<SteeringReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SteeringReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SteeringReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<SteeringReport> is deprecated: use dbw_pacifica_msgs-msg:SteeringReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'steering_wheel_angle-val :lambda-list '(m))
(cl:defmethod steering_wheel_angle-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steering_wheel_angle-val is deprecated.  Use dbw_pacifica_msgs-msg:steering_wheel_angle instead.")
  (steering_wheel_angle m))

(cl:ensure-generic-function 'steering_wheel_angle_cmd-val :lambda-list '(m))
(cl:defmethod steering_wheel_angle_cmd-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steering_wheel_angle_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:steering_wheel_angle_cmd instead.")
  (steering_wheel_angle_cmd m))

(cl:ensure-generic-function 'steering_wheel_torque-val :lambda-list '(m))
(cl:defmethod steering_wheel_torque-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steering_wheel_torque-val is deprecated.  Use dbw_pacifica_msgs-msg:steering_wheel_torque instead.")
  (steering_wheel_torque m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enabled-val is deprecated.  Use dbw_pacifica_msgs-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'driver_activity-val :lambda-list '(m))
(cl:defmethod driver_activity-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:driver_activity-val is deprecated.  Use dbw_pacifica_msgs-msg:driver_activity instead.")
  (driver_activity m))

(cl:ensure-generic-function 'fault_steering_system-val :lambda-list '(m))
(cl:defmethod fault_steering_system-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_steering_system-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_steering_system instead.")
  (fault_steering_system m))

(cl:ensure-generic-function 'overheat_prevention_mode-val :lambda-list '(m))
(cl:defmethod overheat_prevention_mode-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:overheat_prevention_mode-val is deprecated.  Use dbw_pacifica_msgs-msg:overheat_prevention_mode instead.")
  (overheat_prevention_mode m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))

(cl:ensure-generic-function 'steering_over_heat_warning-val :lambda-list '(m))
(cl:defmethod steering_over_heat_warning-val ((m <SteeringReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steering_over_heat_warning-val is deprecated.  Use dbw_pacifica_msgs-msg:steering_over_heat_warning instead.")
  (steering_over_heat_warning m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SteeringReport>) ostream)
  "Serializes a message object of type '<SteeringReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_wheel_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_wheel_angle_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_wheel_torque))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'driver_activity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_steering_system) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'overheat_prevention_mode) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'steering_over_heat_warning) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SteeringReport>) istream)
  "Deserializes a message object of type '<SteeringReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_wheel_angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_wheel_angle_cmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_wheel_torque) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'driver_activity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_steering_system) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'overheat_prevention_mode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
    (cl:setf (cl:slot-value msg 'steering_over_heat_warning) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SteeringReport>)))
  "Returns string type for a message object of type '<SteeringReport>"
  "dbw_pacifica_msgs/SteeringReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SteeringReport)))
  "Returns string type for a message object of type 'SteeringReport"
  "dbw_pacifica_msgs/SteeringReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SteeringReport>)))
  "Returns md5sum for a message object of type '<SteeringReport>"
  "3d804816a4b20624da24c6e1d360c70b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SteeringReport)))
  "Returns md5sum for a message object of type 'SteeringReport"
  "3d804816a4b20624da24c6e1d360c70b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SteeringReport>)))
  "Returns full string definition for message of type '<SteeringReport>"
  (cl:format cl:nil "Header header~%~%# Steering Wheel~%float32 steering_wheel_angle      # degrees~%float32 steering_wheel_angle_cmd  # degrees~%float32 steering_wheel_torque     # 0 to 100%~%~%# Status~%bool enabled~%bool driver_activity~%~%bool fault_steering_system~%~%bool overheat_prevention_mode~%~%uint8 rolling_counter~%~%ActuatorControlMode control_type~%~%bool steering_over_heat_warning~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SteeringReport)))
  "Returns full string definition for message of type 'SteeringReport"
  (cl:format cl:nil "Header header~%~%# Steering Wheel~%float32 steering_wheel_angle      # degrees~%float32 steering_wheel_angle_cmd  # degrees~%float32 steering_wheel_torque     # 0 to 100%~%~%# Status~%bool enabled~%bool driver_activity~%~%bool fault_steering_system~%~%bool overheat_prevention_mode~%~%uint8 rolling_counter~%~%ActuatorControlMode control_type~%~%bool steering_over_heat_warning~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SteeringReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     1
     1
     1
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SteeringReport>))
  "Converts a ROS message object to a list"
  (cl:list 'SteeringReport
    (cl:cons ':header (header msg))
    (cl:cons ':steering_wheel_angle (steering_wheel_angle msg))
    (cl:cons ':steering_wheel_angle_cmd (steering_wheel_angle_cmd msg))
    (cl:cons ':steering_wheel_torque (steering_wheel_torque msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':driver_activity (driver_activity msg))
    (cl:cons ':fault_steering_system (fault_steering_system msg))
    (cl:cons ':overheat_prevention_mode (overheat_prevention_mode msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':control_type (control_type msg))
    (cl:cons ':steering_over_heat_warning (steering_over_heat_warning msg))
))
