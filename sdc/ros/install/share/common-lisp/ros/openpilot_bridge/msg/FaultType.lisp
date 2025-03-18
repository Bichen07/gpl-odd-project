; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude FaultType.msg.html

(cl:defclass <FaultType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass FaultType (<FaultType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FaultType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FaultType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<FaultType> is deprecated: use openpilot_bridge-msg:FaultType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<FaultType>)))
    "Constants for message type '<FaultType>"
  '((:RELAYMALFUNCTION . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'FaultType)))
    "Constants for message type 'FaultType"
  '((:RELAYMALFUNCTION . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FaultType>) ostream)
  "Serializes a message object of type '<FaultType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FaultType>) istream)
  "Deserializes a message object of type '<FaultType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FaultType>)))
  "Returns string type for a message object of type '<FaultType>"
  "openpilot_bridge/FaultType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FaultType)))
  "Returns string type for a message object of type 'FaultType"
  "openpilot_bridge/FaultType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FaultType>)))
  "Returns md5sum for a message object of type '<FaultType>"
  "197e186f39d4aadb0366bf19217c7333")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FaultType)))
  "Returns md5sum for a message object of type 'FaultType"
  "197e186f39d4aadb0366bf19217c7333")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FaultType>)))
  "Returns full string definition for message of type '<FaultType>"
  (cl:format cl:nil "uint32 relayMalfunction=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FaultType)))
  "Returns full string definition for message of type 'FaultType"
  (cl:format cl:nil "uint32 relayMalfunction=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FaultType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FaultType>))
  "Converts a ROS message object to a list"
  (cl:list 'FaultType
))
