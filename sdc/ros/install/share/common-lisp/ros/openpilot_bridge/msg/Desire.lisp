; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Desire.msg.html

(cl:defclass <Desire> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Desire (<Desire>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Desire>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Desire)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Desire> is deprecated: use openpilot_bridge-msg:Desire instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Desire>)))
    "Constants for message type '<Desire>"
  '((:NONE . 0)
    (:TURNLEFT . 1)
    (:LANECHANGERIGHT . 4)
    (:LANECHANGELEFT . 3)
    (:TURNRIGHT . 2)
    (:KEEPRIGHT . 6)
    (:KEEPLEFT . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Desire)))
    "Constants for message type 'Desire"
  '((:NONE . 0)
    (:TURNLEFT . 1)
    (:LANECHANGERIGHT . 4)
    (:LANECHANGELEFT . 3)
    (:TURNRIGHT . 2)
    (:KEEPRIGHT . 6)
    (:KEEPLEFT . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Desire>) ostream)
  "Serializes a message object of type '<Desire>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Desire>) istream)
  "Deserializes a message object of type '<Desire>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Desire>)))
  "Returns string type for a message object of type '<Desire>"
  "openpilot_bridge/Desire")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Desire)))
  "Returns string type for a message object of type 'Desire"
  "openpilot_bridge/Desire")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Desire>)))
  "Returns md5sum for a message object of type '<Desire>"
  "b80700589a9a6c06d4798f291a92dd6e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Desire)))
  "Returns md5sum for a message object of type 'Desire"
  "b80700589a9a6c06d4798f291a92dd6e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Desire>)))
  "Returns full string definition for message of type '<Desire>"
  (cl:format cl:nil "uint32 none=0~%uint32 turnLeft=1~%uint32 laneChangeRight=4~%uint32 laneChangeLeft=3~%uint32 turnRight=2~%uint32 keepRight=6~%uint32 keepLeft=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Desire)))
  "Returns full string definition for message of type 'Desire"
  (cl:format cl:nil "uint32 none=0~%uint32 turnLeft=1~%uint32 laneChangeRight=4~%uint32 laneChangeLeft=3~%uint32 turnRight=2~%uint32 keepRight=6~%uint32 keepLeft=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Desire>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Desire>))
  "Converts a ROS message object to a list"
  (cl:list 'Desire
))
