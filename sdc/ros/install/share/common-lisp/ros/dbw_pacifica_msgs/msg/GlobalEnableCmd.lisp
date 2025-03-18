; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude GlobalEnableCmd.msg.html

(cl:defclass <GlobalEnableCmd> (roslisp-msg-protocol:ros-message)
  ((global_enable
    :reader global_enable
    :initarg :global_enable
    :type cl:boolean
    :initform cl:nil)
   (enable_joystick_limits
    :reader enable_joystick_limits
    :initarg :enable_joystick_limits
    :type cl:boolean
    :initform cl:nil)
   (ecu_build_number
    :reader ecu_build_number
    :initarg :ecu_build_number
    :type cl:fixnum
    :initform 0)
   (rolling_counter
    :reader rolling_counter
    :initarg :rolling_counter
    :type cl:fixnum
    :initform 0)
   (global_cmd_checksum
    :reader global_cmd_checksum
    :initarg :global_cmd_checksum
    :type cl:float
    :initform 0.0))
)

(cl:defclass GlobalEnableCmd (<GlobalEnableCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GlobalEnableCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GlobalEnableCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<GlobalEnableCmd> is deprecated: use dbw_pacifica_msgs-msg:GlobalEnableCmd instead.")))

(cl:ensure-generic-function 'global_enable-val :lambda-list '(m))
(cl:defmethod global_enable-val ((m <GlobalEnableCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:global_enable-val is deprecated.  Use dbw_pacifica_msgs-msg:global_enable instead.")
  (global_enable m))

(cl:ensure-generic-function 'enable_joystick_limits-val :lambda-list '(m))
(cl:defmethod enable_joystick_limits-val ((m <GlobalEnableCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enable_joystick_limits-val is deprecated.  Use dbw_pacifica_msgs-msg:enable_joystick_limits instead.")
  (enable_joystick_limits m))

(cl:ensure-generic-function 'ecu_build_number-val :lambda-list '(m))
(cl:defmethod ecu_build_number-val ((m <GlobalEnableCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ecu_build_number-val is deprecated.  Use dbw_pacifica_msgs-msg:ecu_build_number instead.")
  (ecu_build_number m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <GlobalEnableCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'global_cmd_checksum-val :lambda-list '(m))
(cl:defmethod global_cmd_checksum-val ((m <GlobalEnableCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:global_cmd_checksum-val is deprecated.  Use dbw_pacifica_msgs-msg:global_cmd_checksum instead.")
  (global_cmd_checksum m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GlobalEnableCmd>) ostream)
  "Serializes a message object of type '<GlobalEnableCmd>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'global_enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable_joystick_limits) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ecu_build_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ecu_build_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'global_cmd_checksum))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GlobalEnableCmd>) istream)
  "Deserializes a message object of type '<GlobalEnableCmd>"
    (cl:setf (cl:slot-value msg 'global_enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'enable_joystick_limits) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'ecu_build_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'ecu_build_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'global_cmd_checksum) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GlobalEnableCmd>)))
  "Returns string type for a message object of type '<GlobalEnableCmd>"
  "dbw_pacifica_msgs/GlobalEnableCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GlobalEnableCmd)))
  "Returns string type for a message object of type 'GlobalEnableCmd"
  "dbw_pacifica_msgs/GlobalEnableCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GlobalEnableCmd>)))
  "Returns md5sum for a message object of type '<GlobalEnableCmd>"
  "6bed8b1974abe40f81a2b6c9d5a493f6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GlobalEnableCmd)))
  "Returns md5sum for a message object of type 'GlobalEnableCmd"
  "6bed8b1974abe40f81a2b6c9d5a493f6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GlobalEnableCmd>)))
  "Returns full string definition for message of type '<GlobalEnableCmd>"
  (cl:format cl:nil "bool global_enable~%~%bool enable_joystick_limits~%~%uint16 ecu_build_number~%~%uint8 rolling_counter~%~%float32 global_cmd_checksum~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GlobalEnableCmd)))
  "Returns full string definition for message of type 'GlobalEnableCmd"
  (cl:format cl:nil "bool global_enable~%~%bool enable_joystick_limits~%~%uint16 ecu_build_number~%~%uint8 rolling_counter~%~%float32 global_cmd_checksum~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GlobalEnableCmd>))
  (cl:+ 0
     1
     1
     2
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GlobalEnableCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'GlobalEnableCmd
    (cl:cons ':global_enable (global_enable msg))
    (cl:cons ':enable_joystick_limits (enable_joystick_limits msg))
    (cl:cons ':ecu_build_number (ecu_build_number msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':global_cmd_checksum (global_cmd_checksum msg))
))
