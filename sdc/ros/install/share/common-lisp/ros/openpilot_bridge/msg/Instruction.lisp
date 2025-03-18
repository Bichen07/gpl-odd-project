; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Instruction.msg.html

(cl:defclass <Instruction> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Instruction (<Instruction>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Instruction>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Instruction)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Instruction> is deprecated: use openpilot_bridge-msg:Instruction instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Instruction>)))
    "Constants for message type '<Instruction>"
  '((:UTURN . 19)
    (:ROUNDABOUTUTURN . 13)
    (:ARRIVE . 15)
    (:ROUNDABOUTSTRAIGHT . 9)
    (:TURNLEFT . 0)
    (:UNKN12 . 12)
    (:ROUNDABOUTEXITNUMBER . 5)
    (:EXITLEFT . 16)
    (:UNKN8 . 8)
    (:TURNRIGHT . 1)
    (:ROUNDABOUTEXIT . 6)
    (:ROUNDABOUTTURNRIGHT . 11)
    (:ROUNDABOUTTURNLEFT . 7)
    (:UNKN18 . 18)
    (:EXITRIGHT . 17)
    (:KEEPRIGHT . 3)
    (:UNKN14 . 14)
    (:KEEPLEFT . 2)
    (:STRAIGHT . 4)
    (:UNKN10 . 10))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Instruction)))
    "Constants for message type 'Instruction"
  '((:UTURN . 19)
    (:ROUNDABOUTUTURN . 13)
    (:ARRIVE . 15)
    (:ROUNDABOUTSTRAIGHT . 9)
    (:TURNLEFT . 0)
    (:UNKN12 . 12)
    (:ROUNDABOUTEXITNUMBER . 5)
    (:EXITLEFT . 16)
    (:UNKN8 . 8)
    (:TURNRIGHT . 1)
    (:ROUNDABOUTEXIT . 6)
    (:ROUNDABOUTTURNRIGHT . 11)
    (:ROUNDABOUTTURNLEFT . 7)
    (:UNKN18 . 18)
    (:EXITRIGHT . 17)
    (:KEEPRIGHT . 3)
    (:UNKN14 . 14)
    (:KEEPLEFT . 2)
    (:STRAIGHT . 4)
    (:UNKN10 . 10))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Instruction>) ostream)
  "Serializes a message object of type '<Instruction>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Instruction>) istream)
  "Deserializes a message object of type '<Instruction>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Instruction>)))
  "Returns string type for a message object of type '<Instruction>"
  "openpilot_bridge/Instruction")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Instruction)))
  "Returns string type for a message object of type 'Instruction"
  "openpilot_bridge/Instruction")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Instruction>)))
  "Returns md5sum for a message object of type '<Instruction>"
  "0ae55be583a3a2e13a4008c6f0412834")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Instruction)))
  "Returns md5sum for a message object of type 'Instruction"
  "0ae55be583a3a2e13a4008c6f0412834")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Instruction>)))
  "Returns full string definition for message of type '<Instruction>"
  (cl:format cl:nil "uint32 uturn=19~%uint32 roundaboutUturn=13~%uint32 arrive=15~%uint32 roundaboutStraight=9~%uint32 turnLeft=0~%uint32 unkn12=12~%uint32 roundaboutExitNumber=5~%uint32 exitLeft=16~%uint32 unkn8=8~%uint32 turnRight=1~%uint32 roundaboutExit=6~%uint32 roundaboutTurnRight=11~%uint32 roundaboutTurnLeft=7~%uint32 unkn18=18~%uint32 exitRight=17~%uint32 keepRight=3~%uint32 unkn14=14~%uint32 keepLeft=2~%uint32 straight=4~%uint32 unkn10=10~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Instruction)))
  "Returns full string definition for message of type 'Instruction"
  (cl:format cl:nil "uint32 uturn=19~%uint32 roundaboutUturn=13~%uint32 arrive=15~%uint32 roundaboutStraight=9~%uint32 turnLeft=0~%uint32 unkn12=12~%uint32 roundaboutExitNumber=5~%uint32 exitLeft=16~%uint32 unkn8=8~%uint32 turnRight=1~%uint32 roundaboutExit=6~%uint32 roundaboutTurnRight=11~%uint32 roundaboutTurnLeft=7~%uint32 unkn18=18~%uint32 exitRight=17~%uint32 keepRight=3~%uint32 unkn14=14~%uint32 keepLeft=2~%uint32 straight=4~%uint32 unkn10=10~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Instruction>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Instruction>))
  "Converts a ROS message object to a list"
  (cl:list 'Instruction
))
