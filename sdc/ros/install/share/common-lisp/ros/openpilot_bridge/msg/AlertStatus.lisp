; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude AlertStatus.msg.html

(cl:defclass <AlertStatus> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AlertStatus (<AlertStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AlertStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AlertStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<AlertStatus> is deprecated: use openpilot_bridge-msg:AlertStatus instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AlertStatus>)))
    "Constants for message type '<AlertStatus>"
  '((:USERPROMPT . 1)
    (:CRITICAL . 2)
    (:NORMAL . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AlertStatus)))
    "Constants for message type 'AlertStatus"
  '((:USERPROMPT . 1)
    (:CRITICAL . 2)
    (:NORMAL . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AlertStatus>) ostream)
  "Serializes a message object of type '<AlertStatus>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AlertStatus>) istream)
  "Deserializes a message object of type '<AlertStatus>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AlertStatus>)))
  "Returns string type for a message object of type '<AlertStatus>"
  "openpilot_bridge/AlertStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AlertStatus)))
  "Returns string type for a message object of type 'AlertStatus"
  "openpilot_bridge/AlertStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AlertStatus>)))
  "Returns md5sum for a message object of type '<AlertStatus>"
  "f1701a0e87965803964a3d98d28cc804")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AlertStatus)))
  "Returns md5sum for a message object of type 'AlertStatus"
  "f1701a0e87965803964a3d98d28cc804")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AlertStatus>)))
  "Returns full string definition for message of type '<AlertStatus>"
  (cl:format cl:nil "uint32 userPrompt=1~%uint32 critical=2~%uint32 normal=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AlertStatus)))
  "Returns full string definition for message of type 'AlertStatus"
  (cl:format cl:nil "uint32 userPrompt=1~%uint32 critical=2~%uint32 normal=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AlertStatus>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AlertStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'AlertStatus
))
