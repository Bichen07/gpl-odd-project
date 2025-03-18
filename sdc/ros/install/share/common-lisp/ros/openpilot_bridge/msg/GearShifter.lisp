; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude GearShifter.msg.html

(cl:defclass <GearShifter> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GearShifter (<GearShifter>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GearShifter>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GearShifter)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<GearShifter> is deprecated: use openpilot_bridge-msg:GearShifter instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<GearShifter>)))
    "Constants for message type '<GearShifter>"
  '((:REVERSE . 4)
    (:ECO . 8)
    (:UNKNOWN . 0)
    (:PARK . 1)
    (:DRIVE . 2)
    (:MANUMATIC . 9)
    (:NEUTRAL . 3)
    (:BRAKE . 7)
    (:LOW . 6)
    (:SPORT . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'GearShifter)))
    "Constants for message type 'GearShifter"
  '((:REVERSE . 4)
    (:ECO . 8)
    (:UNKNOWN . 0)
    (:PARK . 1)
    (:DRIVE . 2)
    (:MANUMATIC . 9)
    (:NEUTRAL . 3)
    (:BRAKE . 7)
    (:LOW . 6)
    (:SPORT . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GearShifter>) ostream)
  "Serializes a message object of type '<GearShifter>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GearShifter>) istream)
  "Deserializes a message object of type '<GearShifter>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GearShifter>)))
  "Returns string type for a message object of type '<GearShifter>"
  "openpilot_bridge/GearShifter")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GearShifter)))
  "Returns string type for a message object of type 'GearShifter"
  "openpilot_bridge/GearShifter")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GearShifter>)))
  "Returns md5sum for a message object of type '<GearShifter>"
  "273b4e52e60e160fcc38ba4e49c7ae28")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GearShifter)))
  "Returns md5sum for a message object of type 'GearShifter"
  "273b4e52e60e160fcc38ba4e49c7ae28")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GearShifter>)))
  "Returns full string definition for message of type '<GearShifter>"
  (cl:format cl:nil "uint32 reverse=4~%uint32 eco=8~%uint32 unknown=0~%uint32 park=1~%uint32 drive=2~%uint32 manumatic=9~%uint32 neutral=3~%uint32 brake=7~%uint32 low=6~%uint32 sport=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GearShifter)))
  "Returns full string definition for message of type 'GearShifter"
  (cl:format cl:nil "uint32 reverse=4~%uint32 eco=8~%uint32 unknown=0~%uint32 park=1~%uint32 drive=2~%uint32 manumatic=9~%uint32 neutral=3~%uint32 brake=7~%uint32 low=6~%uint32 sport=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GearShifter>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GearShifter>))
  "Converts a ROS message object to a list"
  (cl:list 'GearShifter
))
