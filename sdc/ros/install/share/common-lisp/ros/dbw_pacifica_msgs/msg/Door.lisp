; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude Door.msg.html

(cl:defclass <Door> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Door (<Door>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Door>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Door)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<Door> is deprecated: use dbw_pacifica_msgs-msg:Door instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <Door>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:value-val is deprecated.  Use dbw_pacifica_msgs-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Door>)))
    "Constants for message type '<Door>"
  '((:NO_REQUEST . 0)
    (:CLOSE_DOOR . 1)
    (:OPEN_DOOR . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Door)))
    "Constants for message type 'Door"
  '((:NO_REQUEST . 0)
    (:CLOSE_DOOR . 1)
    (:OPEN_DOOR . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Door>) ostream)
  "Serializes a message object of type '<Door>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Door>) istream)
  "Deserializes a message object of type '<Door>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'value)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Door>)))
  "Returns string type for a message object of type '<Door>"
  "dbw_pacifica_msgs/Door")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Door)))
  "Returns string type for a message object of type 'Door"
  "dbw_pacifica_msgs/Door")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Door>)))
  "Returns md5sum for a message object of type '<Door>"
  "ef631e91af857251c9f65d6fb4ccb53d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Door)))
  "Returns md5sum for a message object of type 'Door"
  "ef631e91af857251c9f65d6fb4ccb53d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Door>)))
  "Returns full string definition for message of type '<Door>"
  (cl:format cl:nil "uint8 value~%~%uint8 NO_REQUEST=0~%uint8 CLOSE_DOOR=1~%uint8 OPEN_DOOR=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Door)))
  "Returns full string definition for message of type 'Door"
  (cl:format cl:nil "uint8 value~%~%uint8 NO_REQUEST=0~%uint8 CLOSE_DOOR=1~%uint8 OPEN_DOOR=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Door>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Door>))
  "Converts a ROS message object to a list"
  (cl:list 'Door
    (cl:cons ':value (value msg))
))
