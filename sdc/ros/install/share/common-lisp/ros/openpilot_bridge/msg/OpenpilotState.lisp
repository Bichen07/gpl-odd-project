; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude OpenpilotState.msg.html

(cl:defclass <OpenpilotState> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass OpenpilotState (<OpenpilotState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OpenpilotState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OpenpilotState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<OpenpilotState> is deprecated: use openpilot_bridge-msg:OpenpilotState instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<OpenpilotState>)))
    "Constants for message type '<OpenpilotState>"
  '((:DISABLED . 0)
    (:ENABLED . 2)
    (:PREENABLED . 1)
    (:SOFTDISABLING . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'OpenpilotState)))
    "Constants for message type 'OpenpilotState"
  '((:DISABLED . 0)
    (:ENABLED . 2)
    (:PREENABLED . 1)
    (:SOFTDISABLING . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OpenpilotState>) ostream)
  "Serializes a message object of type '<OpenpilotState>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OpenpilotState>) istream)
  "Deserializes a message object of type '<OpenpilotState>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OpenpilotState>)))
  "Returns string type for a message object of type '<OpenpilotState>"
  "openpilot_bridge/OpenpilotState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OpenpilotState)))
  "Returns string type for a message object of type 'OpenpilotState"
  "openpilot_bridge/OpenpilotState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OpenpilotState>)))
  "Returns md5sum for a message object of type '<OpenpilotState>"
  "c8df9612be1bf110e6fde5ec97fedc61")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OpenpilotState)))
  "Returns md5sum for a message object of type 'OpenpilotState"
  "c8df9612be1bf110e6fde5ec97fedc61")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OpenpilotState>)))
  "Returns full string definition for message of type '<OpenpilotState>"
  (cl:format cl:nil "uint32 disabled=0~%uint32 enabled=2~%uint32 preEnabled=1~%uint32 softDisabling=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OpenpilotState)))
  "Returns full string definition for message of type 'OpenpilotState"
  (cl:format cl:nil "uint32 disabled=0~%uint32 enabled=2~%uint32 preEnabled=1~%uint32 softDisabling=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OpenpilotState>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OpenpilotState>))
  "Converts a ROS message object to a list"
  (cl:list 'OpenpilotState
))
