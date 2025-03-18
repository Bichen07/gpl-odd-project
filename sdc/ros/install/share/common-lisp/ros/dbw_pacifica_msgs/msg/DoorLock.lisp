; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude DoorLock.msg.html

(cl:defclass <DoorLock> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0))
)

(cl:defclass DoorLock (<DoorLock>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DoorLock>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DoorLock)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<DoorLock> is deprecated: use dbw_pacifica_msgs-msg:DoorLock instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <DoorLock>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:value-val is deprecated.  Use dbw_pacifica_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<DoorLock>)))
    "Constants for message type '<DoorLock>"
  '((:NOREQUEST . 0)
    (:UNLOCK . 1)
    (:LOCK . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'DoorLock)))
    "Constants for message type 'DoorLock"
  '((:NOREQUEST . 0)
    (:UNLOCK . 1)
    (:LOCK . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DoorLock>) ostream)
  "Serializes a message object of type '<DoorLock>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DoorLock>) istream)
  "Deserializes a message object of type '<DoorLock>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DoorLock>)))
  "Returns string type for a message object of type '<DoorLock>"
  "dbw_pacifica_msgs/DoorLock")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DoorLock)))
  "Returns string type for a message object of type 'DoorLock"
  "dbw_pacifica_msgs/DoorLock")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DoorLock>)))
  "Returns md5sum for a message object of type '<DoorLock>"
  "eb6b773be48793fa970a0f8044cb491f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DoorLock)))
  "Returns md5sum for a message object of type 'DoorLock"
  "eb6b773be48793fa970a0f8044cb491f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DoorLock>)))
  "Returns full string definition for message of type '<DoorLock>"
  (cl:format cl:nil "uint8 value~%~%uint8 NOREQUEST=0~%uint8 UNLOCK=1~%uint8 LOCK=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DoorLock)))
  "Returns full string definition for message of type 'DoorLock"
  (cl:format cl:nil "uint8 value~%~%uint8 NOREQUEST=0~%uint8 UNLOCK=1~%uint8 LOCK=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DoorLock>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DoorLock>))
  "Converts a ROS message object to a list"
  (cl:list 'DoorLock
    (cl:cons ':value (value msg))
))
