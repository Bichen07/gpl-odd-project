; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude WiperRear.msg.html

(cl:defclass <WiperRear> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass WiperRear (<WiperRear>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WiperRear>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WiperRear)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<WiperRear> is deprecated: use dbw_pacifica_msgs-msg:WiperRear instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <WiperRear>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:status-val is deprecated.  Use dbw_pacifica_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WiperRear>)))
    "Constants for message type '<WiperRear>"
  '((:OFF . 0)
    (:INTERVAL_1 . 1)
    (:CONSTANT_LOW . 11)
    (:CONSTANT_HIGH . 12)
    (:WASH_BRIEF . 13)
    (:WASH_CONTINUOUS . 14))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WiperRear)))
    "Constants for message type 'WiperRear"
  '((:OFF . 0)
    (:INTERVAL_1 . 1)
    (:CONSTANT_LOW . 11)
    (:CONSTANT_HIGH . 12)
    (:WASH_BRIEF . 13)
    (:WASH_CONTINUOUS . 14))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WiperRear>) ostream)
  "Serializes a message object of type '<WiperRear>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WiperRear>) istream)
  "Deserializes a message object of type '<WiperRear>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WiperRear>)))
  "Returns string type for a message object of type '<WiperRear>"
  "dbw_pacifica_msgs/WiperRear")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WiperRear)))
  "Returns string type for a message object of type 'WiperRear"
  "dbw_pacifica_msgs/WiperRear")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WiperRear>)))
  "Returns md5sum for a message object of type '<WiperRear>"
  "ecdeee19b7a512c7247c7a840809bea5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WiperRear)))
  "Returns md5sum for a message object of type 'WiperRear"
  "ecdeee19b7a512c7247c7a840809bea5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WiperRear>)))
  "Returns full string definition for message of type '<WiperRear>"
  (cl:format cl:nil "uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WiperRear)))
  "Returns full string definition for message of type 'WiperRear"
  (cl:format cl:nil "uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WiperRear>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WiperRear>))
  "Converts a ROS message object to a list"
  (cl:list 'WiperRear
    (cl:cons ':status (status msg))
))
