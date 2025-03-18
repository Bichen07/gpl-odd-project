; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude VisualAlert.msg.html

(cl:defclass <VisualAlert> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass VisualAlert (<VisualAlert>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VisualAlert>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VisualAlert)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<VisualAlert> is deprecated: use openpilot_bridge-msg:VisualAlert instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<VisualAlert>)))
    "Constants for message type '<VisualAlert>"
  '((:NONE . 0)
    (:WRONGGEAR . 4)
    (:FCW . 1)
    (:STEERREQUIRED . 2)
    (:SPEEDTOOHIGH . 6)
    (:SEATBELTUNBUCKLED . 5)
    (:LDW . 7)
    (:BRAKEPRESSED . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'VisualAlert)))
    "Constants for message type 'VisualAlert"
  '((:NONE . 0)
    (:WRONGGEAR . 4)
    (:FCW . 1)
    (:STEERREQUIRED . 2)
    (:SPEEDTOOHIGH . 6)
    (:SEATBELTUNBUCKLED . 5)
    (:LDW . 7)
    (:BRAKEPRESSED . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VisualAlert>) ostream)
  "Serializes a message object of type '<VisualAlert>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VisualAlert>) istream)
  "Deserializes a message object of type '<VisualAlert>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VisualAlert>)))
  "Returns string type for a message object of type '<VisualAlert>"
  "openpilot_bridge/VisualAlert")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VisualAlert)))
  "Returns string type for a message object of type 'VisualAlert"
  "openpilot_bridge/VisualAlert")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VisualAlert>)))
  "Returns md5sum for a message object of type '<VisualAlert>"
  "051a9c2f807a04756a4e6edeb17dd056")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VisualAlert)))
  "Returns md5sum for a message object of type 'VisualAlert"
  "051a9c2f807a04756a4e6edeb17dd056")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VisualAlert>)))
  "Returns full string definition for message of type '<VisualAlert>"
  (cl:format cl:nil "uint32 none=0~%uint32 wrongGear=4~%uint32 fcw=1~%uint32 steerRequired=2~%uint32 speedTooHigh=6~%uint32 seatbeltUnbuckled=5~%uint32 ldw=7~%uint32 brakePressed=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VisualAlert)))
  "Returns full string definition for message of type 'VisualAlert"
  (cl:format cl:nil "uint32 none=0~%uint32 wrongGear=4~%uint32 fcw=1~%uint32 steerRequired=2~%uint32 speedTooHigh=6~%uint32 seatbeltUnbuckled=5~%uint32 ldw=7~%uint32 brakePressed=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VisualAlert>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VisualAlert>))
  "Converts a ROS message object to a list"
  (cl:list 'VisualAlert
))
