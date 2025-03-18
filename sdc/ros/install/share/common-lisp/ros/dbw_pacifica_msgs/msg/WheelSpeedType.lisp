; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude WheelSpeedType.msg.html

(cl:defclass <WheelSpeedType> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0))
)

(cl:defclass WheelSpeedType (<WheelSpeedType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WheelSpeedType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WheelSpeedType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<WheelSpeedType> is deprecated: use dbw_pacifica_msgs-msg:WheelSpeedType instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <WheelSpeedType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:value-val is deprecated.  Use dbw_pacifica_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WheelSpeedType>)))
    "Constants for message type '<WheelSpeedType>"
  '((:ANGULAR . 0)
    (:LINEAR . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WheelSpeedType)))
    "Constants for message type 'WheelSpeedType"
  '((:ANGULAR . 0)
    (:LINEAR . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WheelSpeedType>) ostream)
  "Serializes a message object of type '<WheelSpeedType>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WheelSpeedType>) istream)
  "Deserializes a message object of type '<WheelSpeedType>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WheelSpeedType>)))
  "Returns string type for a message object of type '<WheelSpeedType>"
  "dbw_pacifica_msgs/WheelSpeedType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WheelSpeedType)))
  "Returns string type for a message object of type 'WheelSpeedType"
  "dbw_pacifica_msgs/WheelSpeedType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WheelSpeedType>)))
  "Returns md5sum for a message object of type '<WheelSpeedType>"
  "3449744e3a452eb36b1db88cb52b05b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WheelSpeedType)))
  "Returns md5sum for a message object of type 'WheelSpeedType"
  "3449744e3a452eb36b1db88cb52b05b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WheelSpeedType>)))
  "Returns full string definition for message of type '<WheelSpeedType>"
  (cl:format cl:nil "uint8 value~%~%uint8 ANGULAR = 0~%uint8 LINEAR = 1~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WheelSpeedType)))
  "Returns full string definition for message of type 'WheelSpeedType"
  (cl:format cl:nil "uint8 value~%~%uint8 ANGULAR = 0~%uint8 LINEAR = 1~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WheelSpeedType>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WheelSpeedType>))
  "Converts a ROS message object to a list"
  (cl:list 'WheelSpeedType
    (cl:cons ':value (value msg))
))
