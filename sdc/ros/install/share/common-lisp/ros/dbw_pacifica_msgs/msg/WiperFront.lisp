; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude WiperFront.msg.html

(cl:defclass <WiperFront> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass WiperFront (<WiperFront>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WiperFront>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WiperFront)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<WiperFront> is deprecated: use dbw_pacifica_msgs-msg:WiperFront instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <WiperFront>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:status-val is deprecated.  Use dbw_pacifica_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WiperFront>)))
    "Constants for message type '<WiperFront>"
  '((:OFF . 0)
    (:INTERVAL_1 . 1)
    (:INTERVAL_2 . 2)
    (:INTERVAL_3 . 3)
    (:INTERVAL_4 . 4)
    (:INTERVAL_5 . 5)
    (:INTERVAL_6 . 6)
    (:CONSTANT_LOW . 11)
    (:CONSTANT_HIGH . 12)
    (:WASH_BRIEF . 13)
    (:WASH_CONTINUOUS . 14))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WiperFront)))
    "Constants for message type 'WiperFront"
  '((:OFF . 0)
    (:INTERVAL_1 . 1)
    (:INTERVAL_2 . 2)
    (:INTERVAL_3 . 3)
    (:INTERVAL_4 . 4)
    (:INTERVAL_5 . 5)
    (:INTERVAL_6 . 6)
    (:CONSTANT_LOW . 11)
    (:CONSTANT_HIGH . 12)
    (:WASH_BRIEF . 13)
    (:WASH_CONTINUOUS . 14))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WiperFront>) ostream)
  "Serializes a message object of type '<WiperFront>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WiperFront>) istream)
  "Deserializes a message object of type '<WiperFront>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'status)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WiperFront>)))
  "Returns string type for a message object of type '<WiperFront>"
  "dbw_pacifica_msgs/WiperFront")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WiperFront)))
  "Returns string type for a message object of type 'WiperFront"
  "dbw_pacifica_msgs/WiperFront")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WiperFront>)))
  "Returns md5sum for a message object of type '<WiperFront>"
  "b1eedfdc97dc13843541e1f8f3eb65f3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WiperFront)))
  "Returns md5sum for a message object of type 'WiperFront"
  "b1eedfdc97dc13843541e1f8f3eb65f3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WiperFront>)))
  "Returns full string definition for message of type '<WiperFront>"
  (cl:format cl:nil "uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 INTERVAL_2 = 2~%uint8 INTERVAL_3 = 3~%uint8 INTERVAL_4 = 4~%uint8 INTERVAL_5 = 5~%uint8 INTERVAL_6 = 6~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WiperFront)))
  "Returns full string definition for message of type 'WiperFront"
  (cl:format cl:nil "uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 INTERVAL_2 = 2~%uint8 INTERVAL_3 = 3~%uint8 INTERVAL_4 = 4~%uint8 INTERVAL_5 = 5~%uint8 INTERVAL_6 = 6~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WiperFront>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WiperFront>))
  "Converts a ROS message object to a list"
  (cl:list 'WiperFront
    (cl:cons ':status (status msg))
))
