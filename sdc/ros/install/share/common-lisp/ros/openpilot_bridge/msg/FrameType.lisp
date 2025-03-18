; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude FrameType.msg.html

(cl:defclass <FrameType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass FrameType (<FrameType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FrameType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FrameType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<FrameType> is deprecated: use openpilot_bridge-msg:FrameType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<FrameType>)))
    "Constants for message type '<FrameType>"
  '((:FRONT . 3)
    (:UNKNOWN . 0)
    (:CHFFRANDROID . 2)
    (:NEO . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'FrameType)))
    "Constants for message type 'FrameType"
  '((:FRONT . 3)
    (:UNKNOWN . 0)
    (:CHFFRANDROID . 2)
    (:NEO . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FrameType>) ostream)
  "Serializes a message object of type '<FrameType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FrameType>) istream)
  "Deserializes a message object of type '<FrameType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FrameType>)))
  "Returns string type for a message object of type '<FrameType>"
  "openpilot_bridge/FrameType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FrameType)))
  "Returns string type for a message object of type 'FrameType"
  "openpilot_bridge/FrameType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FrameType>)))
  "Returns md5sum for a message object of type '<FrameType>"
  "2a992a2c8d63e13eb9c0cdee6ef2a62f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FrameType)))
  "Returns md5sum for a message object of type 'FrameType"
  "2a992a2c8d63e13eb9c0cdee6ef2a62f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FrameType>)))
  "Returns full string definition for message of type '<FrameType>"
  (cl:format cl:nil "uint32 front=3~%uint32 unknown=0~%uint32 chffrAndroid=2~%uint32 neo=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FrameType)))
  "Returns full string definition for message of type 'FrameType"
  (cl:format cl:nil "uint32 front=3~%uint32 unknown=0~%uint32 chffrAndroid=2~%uint32 neo=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FrameType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FrameType>))
  "Converts a ROS message object to a list"
  (cl:list 'FrameType
))
