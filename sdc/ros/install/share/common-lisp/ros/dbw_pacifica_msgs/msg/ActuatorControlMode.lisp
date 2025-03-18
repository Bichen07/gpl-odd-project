; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude ActuatorControlMode.msg.html

(cl:defclass <ActuatorControlMode> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ActuatorControlMode (<ActuatorControlMode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActuatorControlMode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActuatorControlMode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<ActuatorControlMode> is deprecated: use dbw_pacifica_msgs-msg:ActuatorControlMode instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <ActuatorControlMode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:value-val is deprecated.  Use dbw_pacifica_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ActuatorControlMode>)))
    "Constants for message type '<ActuatorControlMode>"
  '((:OPEN_LOOP . 0)
    (:CLOSED_LOOP_ACTUATOR . 1)
    (:CLOSED_LOOP_VEHICLE . 2)
    (:NONE . 255))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ActuatorControlMode)))
    "Constants for message type 'ActuatorControlMode"
  '((:OPEN_LOOP . 0)
    (:CLOSED_LOOP_ACTUATOR . 1)
    (:CLOSED_LOOP_VEHICLE . 2)
    (:NONE . 255))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActuatorControlMode>) ostream)
  "Serializes a message object of type '<ActuatorControlMode>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActuatorControlMode>) istream)
  "Deserializes a message object of type '<ActuatorControlMode>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActuatorControlMode>)))
  "Returns string type for a message object of type '<ActuatorControlMode>"
  "dbw_pacifica_msgs/ActuatorControlMode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActuatorControlMode)))
  "Returns string type for a message object of type 'ActuatorControlMode"
  "dbw_pacifica_msgs/ActuatorControlMode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActuatorControlMode>)))
  "Returns md5sum for a message object of type '<ActuatorControlMode>"
  "1994ebf1d0f443ac1da4b214c3affc7f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActuatorControlMode)))
  "Returns md5sum for a message object of type 'ActuatorControlMode"
  "1994ebf1d0f443ac1da4b214c3affc7f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActuatorControlMode>)))
  "Returns full string definition for message of type '<ActuatorControlMode>"
  (cl:format cl:nil "uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActuatorControlMode)))
  "Returns full string definition for message of type 'ActuatorControlMode"
  (cl:format cl:nil "uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActuatorControlMode>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActuatorControlMode>))
  "Converts a ROS message object to a list"
  (cl:list 'ActuatorControlMode
    (cl:cons ':value (value msg))
))
