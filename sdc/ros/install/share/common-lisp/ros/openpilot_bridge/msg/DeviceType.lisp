; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude DeviceType.msg.html

(cl:defclass <DeviceType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass DeviceType (<DeviceType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DeviceType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DeviceType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<DeviceType> is deprecated: use openpilot_bridge-msg:DeviceType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<DeviceType>)))
    "Constants for message type '<DeviceType>"
  '((:CHFFRIOS . 3)
    (:UNKNOWN . 0)
    (:CHFFRANDROID . 2)
    (:NEO . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'DeviceType)))
    "Constants for message type 'DeviceType"
  '((:CHFFRIOS . 3)
    (:UNKNOWN . 0)
    (:CHFFRANDROID . 2)
    (:NEO . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DeviceType>) ostream)
  "Serializes a message object of type '<DeviceType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DeviceType>) istream)
  "Deserializes a message object of type '<DeviceType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DeviceType>)))
  "Returns string type for a message object of type '<DeviceType>"
  "openpilot_bridge/DeviceType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DeviceType)))
  "Returns string type for a message object of type 'DeviceType"
  "openpilot_bridge/DeviceType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DeviceType>)))
  "Returns md5sum for a message object of type '<DeviceType>"
  "82413ac418dda4ec5bf96c9c7090008f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DeviceType)))
  "Returns md5sum for a message object of type 'DeviceType"
  "82413ac418dda4ec5bf96c9c7090008f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DeviceType>)))
  "Returns full string definition for message of type '<DeviceType>"
  (cl:format cl:nil "uint32 chffrIos=3~%uint32 unknown=0~%uint32 chffrAndroid=2~%uint32 neo=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DeviceType)))
  "Returns full string definition for message of type 'DeviceType"
  (cl:format cl:nil "uint32 chffrIos=3~%uint32 unknown=0~%uint32 chffrAndroid=2~%uint32 neo=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DeviceType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DeviceType>))
  "Converts a ROS message object to a list"
  (cl:list 'DeviceType
))
