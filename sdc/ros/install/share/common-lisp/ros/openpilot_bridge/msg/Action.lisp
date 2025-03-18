; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Action.msg.html

(cl:defclass <Action> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Action (<Action>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Action>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Action)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Action> is deprecated: use openpilot_bridge-msg:Action instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Action>)))
    "Constants for message type '<Action>"
  '((:NONE . 0)
    (:STOP . 2)
    (:RESUMEREADY . 3)
    (:YIELD . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Action)))
    "Constants for message type 'Action"
  '((:NONE . 0)
    (:STOP . 2)
    (:RESUMEREADY . 3)
    (:YIELD . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Action>) ostream)
  "Serializes a message object of type '<Action>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Action>) istream)
  "Deserializes a message object of type '<Action>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Action>)))
  "Returns string type for a message object of type '<Action>"
  "openpilot_bridge/Action")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Action)))
  "Returns string type for a message object of type 'Action"
  "openpilot_bridge/Action")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Action>)))
  "Returns md5sum for a message object of type '<Action>"
  "f807133cfc56a455de4e9a8e5b57aa0a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Action)))
  "Returns md5sum for a message object of type 'Action"
  "f807133cfc56a455de4e9a8e5b57aa0a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Action>)))
  "Returns full string definition for message of type '<Action>"
  (cl:format cl:nil "uint32 none=0~%uint32 stop=2~%uint32 resumeReady=3~%uint32 yield=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Action)))
  "Returns full string definition for message of type 'Action"
  (cl:format cl:nil "uint32 none=0~%uint32 stop=2~%uint32 resumeReady=3~%uint32 yield=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Action>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Action>))
  "Converts a ROS message object to a list"
  (cl:list 'Action
))
