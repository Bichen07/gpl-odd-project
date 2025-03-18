; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LaneChangeDirection.msg.html

(cl:defclass <LaneChangeDirection> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LaneChangeDirection (<LaneChangeDirection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneChangeDirection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneChangeDirection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LaneChangeDirection> is deprecated: use openpilot_bridge-msg:LaneChangeDirection instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<LaneChangeDirection>)))
    "Constants for message type '<LaneChangeDirection>"
  '((:NONE . 0)
    (:RIGHT . 2)
    (:LEFT . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'LaneChangeDirection)))
    "Constants for message type 'LaneChangeDirection"
  '((:NONE . 0)
    (:RIGHT . 2)
    (:LEFT . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneChangeDirection>) ostream)
  "Serializes a message object of type '<LaneChangeDirection>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneChangeDirection>) istream)
  "Deserializes a message object of type '<LaneChangeDirection>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneChangeDirection>)))
  "Returns string type for a message object of type '<LaneChangeDirection>"
  "openpilot_bridge/LaneChangeDirection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneChangeDirection)))
  "Returns string type for a message object of type 'LaneChangeDirection"
  "openpilot_bridge/LaneChangeDirection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneChangeDirection>)))
  "Returns md5sum for a message object of type '<LaneChangeDirection>"
  "c3f618df475623ce28a1741078c37b19")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneChangeDirection)))
  "Returns md5sum for a message object of type 'LaneChangeDirection"
  "c3f618df475623ce28a1741078c37b19")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneChangeDirection>)))
  "Returns full string definition for message of type '<LaneChangeDirection>"
  (cl:format cl:nil "uint32 none=0~%uint32 right=2~%uint32 left=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneChangeDirection)))
  "Returns full string definition for message of type 'LaneChangeDirection"
  (cl:format cl:nil "uint32 none=0~%uint32 right=2~%uint32 left=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneChangeDirection>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneChangeDirection>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneChangeDirection
))
