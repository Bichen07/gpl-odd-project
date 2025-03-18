; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude SteeringCmd.msg.html

(cl:defclass <SteeringCmd> (roslisp-msg-protocol:ros-message)
  ((angle_cmd
    :reader angle_cmd
    :initarg :angle_cmd
    :type cl:float
    :initform 0.0)
   (angle_velocity
    :reader angle_velocity
    :initarg :angle_velocity
    :type cl:float
    :initform 0.0)
   (enable
    :reader enable
    :initarg :enable
    :type cl:boolean
    :initform cl:nil)
   (ignore
    :reader ignore
    :initarg :ignore
    :type cl:boolean
    :initform cl:nil)
   (rolling_counter
    :reader rolling_counter
    :initarg :rolling_counter
    :type cl:fixnum
    :initform 0)
   (torque_cmd
    :reader torque_cmd
    :initarg :torque_cmd
    :type cl:float
    :initform 0.0)
   (vehicle_curvature_cmd
    :reader vehicle_curvature_cmd
    :initarg :vehicle_curvature_cmd
    :type cl:float
    :initform 0.0)
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode))
   (steering_cmd_checksum
    :reader steering_cmd_checksum
    :initarg :steering_cmd_checksum
    :type cl:float
    :initform 0.0))
)

(cl:defclass SteeringCmd (<SteeringCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SteeringCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SteeringCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<SteeringCmd> is deprecated: use dbw_pacifica_msgs-msg:SteeringCmd instead.")))

(cl:ensure-generic-function 'angle_cmd-val :lambda-list '(m))
(cl:defmethod angle_cmd-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:angle_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:angle_cmd instead.")
  (angle_cmd m))

(cl:ensure-generic-function 'angle_velocity-val :lambda-list '(m))
(cl:defmethod angle_velocity-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:angle_velocity-val is deprecated.  Use dbw_pacifica_msgs-msg:angle_velocity instead.")
  (angle_velocity m))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enable-val is deprecated.  Use dbw_pacifica_msgs-msg:enable instead.")
  (enable m))

(cl:ensure-generic-function 'ignore-val :lambda-list '(m))
(cl:defmethod ignore-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ignore-val is deprecated.  Use dbw_pacifica_msgs-msg:ignore instead.")
  (ignore m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'torque_cmd-val :lambda-list '(m))
(cl:defmethod torque_cmd-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:torque_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:torque_cmd instead.")
  (torque_cmd m))

(cl:ensure-generic-function 'vehicle_curvature_cmd-val :lambda-list '(m))
(cl:defmethod vehicle_curvature_cmd-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_curvature_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_curvature_cmd instead.")
  (vehicle_curvature_cmd m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))

(cl:ensure-generic-function 'steering_cmd_checksum-val :lambda-list '(m))
(cl:defmethod steering_cmd_checksum-val ((m <SteeringCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:steering_cmd_checksum-val is deprecated.  Use dbw_pacifica_msgs-msg:steering_cmd_checksum instead.")
  (steering_cmd_checksum m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SteeringCmd>) ostream)
  "Serializes a message object of type '<SteeringCmd>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle_velocity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_curvature_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_cmd_checksum))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SteeringCmd>) istream)
  "Deserializes a message object of type '<SteeringCmd>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle_cmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle_velocity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'ignore) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque_cmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_curvature_cmd) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_cmd_checksum) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SteeringCmd>)))
  "Returns string type for a message object of type '<SteeringCmd>"
  "dbw_pacifica_msgs/SteeringCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SteeringCmd)))
  "Returns string type for a message object of type 'SteeringCmd"
  "dbw_pacifica_msgs/SteeringCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SteeringCmd>)))
  "Returns md5sum for a message object of type '<SteeringCmd>"
  "01afefccdc79bc13944f883510af8807")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SteeringCmd)))
  "Returns md5sum for a message object of type 'SteeringCmd"
  "01afefccdc79bc13944f883510af8807")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SteeringCmd>)))
  "Returns full string definition for message of type '<SteeringCmd>"
  (cl:format cl:nil "# Steering Wheel~%float32 angle_cmd        # degrees, range -500 to 500~%float32 angle_velocity   # degrees/s, range 0 to 498, 0 = maximum~%~%# Enable~%bool enable~%~%# Ignore driver overrides~%bool ignore~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 torque_cmd # %-torque~%~%float32 vehicle_curvature_cmd # 1/m~%~%ActuatorControlMode control_type~%~%float32 steering_cmd_checksum~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SteeringCmd)))
  "Returns full string definition for message of type 'SteeringCmd"
  (cl:format cl:nil "# Steering Wheel~%float32 angle_cmd        # degrees, range -500 to 500~%float32 angle_velocity   # degrees/s, range 0 to 498, 0 = maximum~%~%# Enable~%bool enable~%~%# Ignore driver overrides~%bool ignore~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 torque_cmd # %-torque~%~%float32 vehicle_curvature_cmd # 1/m~%~%ActuatorControlMode control_type~%~%float32 steering_cmd_checksum~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SteeringCmd>))
  (cl:+ 0
     4
     4
     1
     1
     1
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SteeringCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'SteeringCmd
    (cl:cons ':angle_cmd (angle_cmd msg))
    (cl:cons ':angle_velocity (angle_velocity msg))
    (cl:cons ':enable (enable msg))
    (cl:cons ':ignore (ignore msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':torque_cmd (torque_cmd msg))
    (cl:cons ':vehicle_curvature_cmd (vehicle_curvature_cmd msg))
    (cl:cons ':control_type (control_type msg))
    (cl:cons ':steering_cmd_checksum (steering_cmd_checksum msg))
))
