; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude BrakeCmd.msg.html

(cl:defclass <BrakeCmd> (roslisp-msg-protocol:ros-message)
  ((pedal_cmd
    :reader pedal_cmd
    :initarg :pedal_cmd
    :type cl:float
    :initform 0.0)
   (enable
    :reader enable
    :initarg :enable
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
   (accel_limit
    :reader accel_limit
    :initarg :accel_limit
    :type cl:float
    :initform 0.0)
   (decel_limit
    :reader decel_limit
    :initarg :decel_limit
    :type cl:float
    :initform 0.0)
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode))
   (brake_cmd_checksum
    :reader brake_cmd_checksum
    :initarg :brake_cmd_checksum
    :type cl:float
    :initform 0.0)
   (parking_brake_req
    :reader parking_brake_req
    :initarg :parking_brake_req
    :type dbw_pacifica_msgs-msg:ParkingBrkReq
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ParkingBrkReq)))
)

(cl:defclass BrakeCmd (<BrakeCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BrakeCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BrakeCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<BrakeCmd> is deprecated: use dbw_pacifica_msgs-msg:BrakeCmd instead.")))

(cl:ensure-generic-function 'pedal_cmd-val :lambda-list '(m))
(cl:defmethod pedal_cmd-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_cmd instead.")
  (pedal_cmd m))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enable-val is deprecated.  Use dbw_pacifica_msgs-msg:enable instead.")
  (enable m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'torque_cmd-val :lambda-list '(m))
(cl:defmethod torque_cmd-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:torque_cmd-val is deprecated.  Use dbw_pacifica_msgs-msg:torque_cmd instead.")
  (torque_cmd m))

(cl:ensure-generic-function 'accel_limit-val :lambda-list '(m))
(cl:defmethod accel_limit-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:accel_limit-val is deprecated.  Use dbw_pacifica_msgs-msg:accel_limit instead.")
  (accel_limit m))

(cl:ensure-generic-function 'decel_limit-val :lambda-list '(m))
(cl:defmethod decel_limit-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:decel_limit-val is deprecated.  Use dbw_pacifica_msgs-msg:decel_limit instead.")
  (decel_limit m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))

(cl:ensure-generic-function 'brake_cmd_checksum-val :lambda-list '(m))
(cl:defmethod brake_cmd_checksum-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:brake_cmd_checksum-val is deprecated.  Use dbw_pacifica_msgs-msg:brake_cmd_checksum instead.")
  (brake_cmd_checksum m))

(cl:ensure-generic-function 'parking_brake_req-val :lambda-list '(m))
(cl:defmethod parking_brake_req-val ((m <BrakeCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:parking_brake_req-val is deprecated.  Use dbw_pacifica_msgs-msg:parking_brake_req instead.")
  (parking_brake_req m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BrakeCmd>) ostream)
  "Serializes a message object of type '<BrakeCmd>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pedal_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque_cmd))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accel_limit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'decel_limit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_cmd_checksum))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'parking_brake_req) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BrakeCmd>) istream)
  "Deserializes a message object of type '<BrakeCmd>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_cmd) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enable) (cl:not (cl:zerop (cl:read-byte istream))))
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
    (cl:setf (cl:slot-value msg 'accel_limit) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'decel_limit) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_cmd_checksum) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'parking_brake_req) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BrakeCmd>)))
  "Returns string type for a message object of type '<BrakeCmd>"
  "dbw_pacifica_msgs/BrakeCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BrakeCmd)))
  "Returns string type for a message object of type 'BrakeCmd"
  "dbw_pacifica_msgs/BrakeCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BrakeCmd>)))
  "Returns md5sum for a message object of type '<BrakeCmd>"
  "df5046f02deb0972bd5ea27261595bc6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BrakeCmd)))
  "Returns md5sum for a message object of type 'BrakeCmd"
  "df5046f02deb0972bd5ea27261595bc6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BrakeCmd>)))
  "Returns full string definition for message of type '<BrakeCmd>"
  (cl:format cl:nil "# Brake pedal (%)~%float32 pedal_cmd~%~%# Enable~%bool enable~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 torque_cmd # %-torque~%float32 accel_limit # m/s^2~%float32 decel_limit # m/s^2~%~%ActuatorControlMode control_type~%~%float32 brake_cmd_checksum~%~%ParkingBrkReq parking_brake_req~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%================================================================================~%MSG: dbw_pacifica_msgs/ParkingBrkReq~%uint8 value~%~%uint8 NO_REQUEST=0~%uint8 OFF=1~%uint8 ON=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BrakeCmd)))
  "Returns full string definition for message of type 'BrakeCmd"
  (cl:format cl:nil "# Brake pedal (%)~%float32 pedal_cmd~%~%# Enable~%bool enable~%~%# Watchdog counter (optional)~%uint8 rolling_counter~%~%float32 torque_cmd # %-torque~%float32 accel_limit # m/s^2~%float32 decel_limit # m/s^2~%~%ActuatorControlMode control_type~%~%float32 brake_cmd_checksum~%~%ParkingBrkReq parking_brake_req~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%================================================================================~%MSG: dbw_pacifica_msgs/ParkingBrkReq~%uint8 value~%~%uint8 NO_REQUEST=0~%uint8 OFF=1~%uint8 ON=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BrakeCmd>))
  (cl:+ 0
     4
     1
     1
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'parking_brake_req))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BrakeCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'BrakeCmd
    (cl:cons ':pedal_cmd (pedal_cmd msg))
    (cl:cons ':enable (enable msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':torque_cmd (torque_cmd msg))
    (cl:cons ':accel_limit (accel_limit msg))
    (cl:cons ':decel_limit (decel_limit msg))
    (cl:cons ':control_type (control_type msg))
    (cl:cons ':brake_cmd_checksum (brake_cmd_checksum msg))
    (cl:cons ':parking_brake_req (parking_brake_req msg))
))
