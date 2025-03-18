; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude FaultStatus.msg.html

(cl:defclass <FaultStatus> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass FaultStatus (<FaultStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FaultStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FaultStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<FaultStatus> is deprecated: use openpilot_bridge-msg:FaultStatus instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<FaultStatus>)))
    "Constants for message type '<FaultStatus>"
  '((:NONE . 0)
    (:FAULTPERM . 2)
    (:FAULTTEMP . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'FaultStatus)))
    "Constants for message type 'FaultStatus"
  '((:NONE . 0)
    (:FAULTPERM . 2)
    (:FAULTTEMP . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FaultStatus>) ostream)
  "Serializes a message object of type '<FaultStatus>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FaultStatus>) istream)
  "Deserializes a message object of type '<FaultStatus>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FaultStatus>)))
  "Returns string type for a message object of type '<FaultStatus>"
  "openpilot_bridge/FaultStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FaultStatus)))
  "Returns string type for a message object of type 'FaultStatus"
  "openpilot_bridge/FaultStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FaultStatus>)))
  "Returns md5sum for a message object of type '<FaultStatus>"
  "f810ab59824d94736267917644323f17")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FaultStatus)))
  "Returns md5sum for a message object of type 'FaultStatus"
  "f810ab59824d94736267917644323f17")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FaultStatus>)))
  "Returns full string definition for message of type '<FaultStatus>"
  (cl:format cl:nil "uint32 none=0~%uint32 faultPerm=2~%uint32 faultTemp=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FaultStatus)))
  "Returns full string definition for message of type 'FaultStatus"
  (cl:format cl:nil "uint32 none=0~%uint32 faultPerm=2~%uint32 faultTemp=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FaultStatus>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FaultStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'FaultStatus
))
