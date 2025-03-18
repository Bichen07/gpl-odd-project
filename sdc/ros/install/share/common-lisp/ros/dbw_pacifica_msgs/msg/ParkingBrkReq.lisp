; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude ParkingBrkReq.msg.html

(cl:defclass <ParkingBrkReq> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ParkingBrkReq (<ParkingBrkReq>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingBrkReq>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingBrkReq)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<ParkingBrkReq> is deprecated: use dbw_pacifica_msgs-msg:ParkingBrkReq instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <ParkingBrkReq>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:value-val is deprecated.  Use dbw_pacifica_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ParkingBrkReq>)))
    "Constants for message type '<ParkingBrkReq>"
  '((:NO_REQUEST . 0)
    (:OFF . 1)
    (:ON . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ParkingBrkReq)))
    "Constants for message type 'ParkingBrkReq"
  '((:NO_REQUEST . 0)
    (:OFF . 1)
    (:ON . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingBrkReq>) ostream)
  "Serializes a message object of type '<ParkingBrkReq>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingBrkReq>) istream)
  "Deserializes a message object of type '<ParkingBrkReq>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingBrkReq>)))
  "Returns string type for a message object of type '<ParkingBrkReq>"
  "dbw_pacifica_msgs/ParkingBrkReq")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingBrkReq)))
  "Returns string type for a message object of type 'ParkingBrkReq"
  "dbw_pacifica_msgs/ParkingBrkReq")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingBrkReq>)))
  "Returns md5sum for a message object of type '<ParkingBrkReq>"
  "b1249cdc94b958f2fedb6cc0c469cda0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingBrkReq)))
  "Returns md5sum for a message object of type 'ParkingBrkReq"
  "b1249cdc94b958f2fedb6cc0c469cda0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingBrkReq>)))
  "Returns full string definition for message of type '<ParkingBrkReq>"
  (cl:format cl:nil "uint8 value~%~%uint8 NO_REQUEST=0~%uint8 OFF=1~%uint8 ON=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingBrkReq)))
  "Returns full string definition for message of type 'ParkingBrkReq"
  (cl:format cl:nil "uint8 value~%~%uint8 NO_REQUEST=0~%uint8 OFF=1~%uint8 ON=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingBrkReq>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingBrkReq>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingBrkReq
    (cl:cons ':value (value msg))
))
