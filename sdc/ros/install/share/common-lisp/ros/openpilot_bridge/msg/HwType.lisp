; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude HwType.msg.html

(cl:defclass <HwType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass HwType (<HwType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HwType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HwType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<HwType> is deprecated: use openpilot_bridge-msg:HwType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<HwType>)))
    "Constants for message type '<HwType>"
  '((:GREYPANDA . 2)
    (:UNKNOWN . 0)
    (:BLACKPANDA . 3)
    (:PEDAL . 4)
    (:WHITEPANDA . 1)
    (:UNO . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'HwType)))
    "Constants for message type 'HwType"
  '((:GREYPANDA . 2)
    (:UNKNOWN . 0)
    (:BLACKPANDA . 3)
    (:PEDAL . 4)
    (:WHITEPANDA . 1)
    (:UNO . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HwType>) ostream)
  "Serializes a message object of type '<HwType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HwType>) istream)
  "Deserializes a message object of type '<HwType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HwType>)))
  "Returns string type for a message object of type '<HwType>"
  "openpilot_bridge/HwType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HwType)))
  "Returns string type for a message object of type 'HwType"
  "openpilot_bridge/HwType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HwType>)))
  "Returns md5sum for a message object of type '<HwType>"
  "75860a38b6f0e635f9859e3fbce3d516")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HwType)))
  "Returns md5sum for a message object of type 'HwType"
  "75860a38b6f0e635f9859e3fbce3d516")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HwType>)))
  "Returns full string definition for message of type '<HwType>"
  (cl:format cl:nil "uint32 greyPanda=2~%uint32 unknown=0~%uint32 blackPanda=3~%uint32 pedal=4~%uint32 whitePanda=1~%uint32 uno=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HwType)))
  "Returns full string definition for message of type 'HwType"
  (cl:format cl:nil "uint32 greyPanda=2~%uint32 unknown=0~%uint32 blackPanda=3~%uint32 pedal=4~%uint32 whitePanda=1~%uint32 uno=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HwType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HwType>))
  "Converts a ROS message object to a list"
  (cl:list 'HwType
))
