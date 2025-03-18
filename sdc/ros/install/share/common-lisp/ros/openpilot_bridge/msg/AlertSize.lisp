; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude AlertSize.msg.html

(cl:defclass <AlertSize> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass AlertSize (<AlertSize>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AlertSize>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AlertSize)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<AlertSize> is deprecated: use openpilot_bridge-msg:AlertSize instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<AlertSize>)))
    "Constants for message type '<AlertSize>"
  '((:SMALL . 1)
    (:NONE . 0)
    (:FULL . 3)
    (:MID . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'AlertSize)))
    "Constants for message type 'AlertSize"
  '((:SMALL . 1)
    (:NONE . 0)
    (:FULL . 3)
    (:MID . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AlertSize>) ostream)
  "Serializes a message object of type '<AlertSize>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AlertSize>) istream)
  "Deserializes a message object of type '<AlertSize>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AlertSize>)))
  "Returns string type for a message object of type '<AlertSize>"
  "openpilot_bridge/AlertSize")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AlertSize)))
  "Returns string type for a message object of type 'AlertSize"
  "openpilot_bridge/AlertSize")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AlertSize>)))
  "Returns md5sum for a message object of type '<AlertSize>"
  "0ea349938bab8f497baa9a2b7b4823c9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AlertSize)))
  "Returns md5sum for a message object of type 'AlertSize"
  "0ea349938bab8f497baa9a2b7b4823c9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AlertSize>)))
  "Returns full string definition for message of type '<AlertSize>"
  (cl:format cl:nil "uint32 small=1~%uint32 none=0~%uint32 full=3~%uint32 mid=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AlertSize)))
  "Returns full string definition for message of type 'AlertSize"
  (cl:format cl:nil "uint32 small=1~%uint32 none=0~%uint32 full=3~%uint32 mid=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AlertSize>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AlertSize>))
  "Converts a ROS message object to a list"
  (cl:list 'AlertSize
))
