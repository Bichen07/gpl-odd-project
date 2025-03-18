; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude AcceleratorPedalCmd.msg.html

(cl:defclass <AcceleratorPedalCmd> (roslisp-msg-protocol:ros-message)
  ((pedal_cmd
    :reader pedal_cmd
    :initarg :pedal_cmd
    :type cl:float
    :initform 0.0)
   (torque_cmd
    :reader torque_cmd
    :initarg :torque_cmd
    :type cl:float
    :initform 0.0)
   (speed_cmd
    :reader speed_cmd
    :initarg :speed_cmd
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
   (road_slope
    :reader road_slope
    :initarg :road_slope
    :type cl:float
    :initform 0.0)
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode))
   (accel_cmd_checksum
    :reader accel_cmd_checksum
    :initarg :accel_cmd_checksum
    :type cl:float
    :initform 0.0)
   (accel_limit
    :reader accel_limit
    :initarg :accel_limit
    :type cl:float
    :initform 0.0)
   (pos_jerk_limit
    :reader pos_jerk_limit
    :initarg :pos_jerk_limit
    :type cl:float
    :initform 0.0))
)

(cl:defclass AcceleratorPedalCmd (<AcceleratorPedalCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AcceleratorPedalCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AcceleratorPedalCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<AcceleratorPedalCmd> is deprecated: use dbw_pacifica_msgs-msg:AcceleratorPedalCmd instead.")))

(cl:ensure-generic-function 'pedal_cmd-val :lambda-list '(m))
(cl:defmethod pedal_cmd-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_cmd instead.")
  (pedal_cmd m))

(cl:ensure-generic-function 'torque_cmd-val :lambda-list '(m))
(cl:defmethod torque_cmd-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:torque_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:torque_cmd instead.")
  (torque_cmd m))

(cl:ensure-generic-function 'speed_cmd-val :lambda-list '(m))
(cl:defmethod speed_cmd-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:speed_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:speed_cmd instead.")
  (speed_cmd m))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enable-val is deprecated.  Use dbw_pacifica_msgs-msg:enable instead.")
  (enable m))

(cl:ensure-generic-function 'ignore-val :lambda-list '(m))
(cl:defmethod ignore-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ignore-val is deprecated.  Use dbw_pacifica_msgs-msg:ignore instead.")
  (ignore m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'road_slope-val :lambda-list '(m))
(cl:defmethod road_slope-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:road_slope-val is deprecated.  Use dbw_pacifica_msgs-msg:road_slope instead.")
  (road_slope m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))

(cl:ensure-generic-function 'accel_cmd_checksum-val :lambda-list '(m))
(cl:defmethod accel_cmd_checksum-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:accel_cmd_checksum-val is deprecated.  Use dbw_pacifica_msgs-msg:accel_cmd_checksum instead.")
  (accel_cmd_checksum m))

(cl:ensure-generic-function 'accel_limit-val :lambda-list '(m))
(cl:defmethod accel_limit-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:accel_limit-val is deprecated.  Use dbw_pacifica_msgs-msg:accel_limit instead.")
  (accel_limit m))

(cl:ensure-generic-function 'pos_jerk_limit-val :lambda-list '(m))
(cl:defmethod pos_jerk_limit-val ((m <AcceleratorPedalCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pos_jerk_limit-val is deprecated.  Use dbw_pacifica_msgs-msg:pos_jerk_limit instead.")
  (pos_jerk_limit m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AcceleratorPedalCmd>) ostream)
  "Serializes a message object of type '<AcceleratorPedalCmd>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pedal_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'road_slope))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accel_cmd_checksum))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accel_limit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pos_jerk_limit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AcceleratorPedalCmd>) istream)
  "Deserializes a message object of type '<AcceleratorPedalCmd>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_cmd) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:setf (cl:slot-value msg 'speed_cmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'ignore) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'road_slope) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accel_cmd_checksum) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accel_limit) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_jerk_limit) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AcceleratorPedalCmd>)))
  "Returns string type for a message object of type '<AcceleratorPedalCmd>"
  "dbw_pacifica_msgs/AcceleratorPedalCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AcceleratorPedalCmd)))
  "Returns string type for a message object of type 'AcceleratorPedalCmd"
  "dbw_pacifica_msgs/AcceleratorPedalCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AcceleratorPedalCmd>)))
  "Returns md5sum for a message object of type '<AcceleratorPedalCmd>"
  "a1a82e02e150ecb7c85bb191a9e67d46")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AcceleratorPedalCmd)))
  "Returns md5sum for a message object of type 'AcceleratorPedalCmd"
  "a1a82e02e150ecb7c85bb191a9e67d46")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AcceleratorPedalCmd>)))
  "Returns full string definition for message of type '<AcceleratorPedalCmd>"
  (cl:format cl:nil "# Accelerator pedal (%)~%float32 pedal_cmd~%~%float32 torque_cmd # %-torque~%~%float32 speed_cmd # m/s~%~%# Enable~%bool enable~%~%# Ignore driver overrides~%bool ignore~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 road_slope # degrees - used with speed mode~%~%ActuatorControlMode control_type~%~%float32 accel_cmd_checksum~%~%float32 accel_limit~%~%float32 pos_jerk_limit~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AcceleratorPedalCmd)))
  "Returns full string definition for message of type 'AcceleratorPedalCmd"
  (cl:format cl:nil "# Accelerator pedal (%)~%float32 pedal_cmd~%~%float32 torque_cmd # %-torque~%~%float32 speed_cmd # m/s~%~%# Enable~%bool enable~%~%# Ignore driver overrides~%bool ignore~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 road_slope # degrees - used with speed mode~%~%ActuatorControlMode control_type~%~%float32 accel_cmd_checksum~%~%float32 accel_limit~%~%float32 pos_jerk_limit~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AcceleratorPedalCmd>))
  (cl:+ 0
     4
     4
     4
     1
     1
     1
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AcceleratorPedalCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'AcceleratorPedalCmd
    (cl:cons ':pedal_cmd (pedal_cmd msg))
    (cl:cons ':torque_cmd (torque_cmd msg))
    (cl:cons ':speed_cmd (speed_cmd msg))
    (cl:cons ':enable (enable msg))
    (cl:cons ':ignore (ignore msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':road_slope (road_slope msg))
    (cl:cons ':control_type (control_type msg))
    (cl:cons ':accel_cmd_checksum (accel_cmd_checksum msg))
    (cl:cons ':accel_limit (accel_limit msg))
    (cl:cons ':pos_jerk_limit (pos_jerk_limit msg))
))
