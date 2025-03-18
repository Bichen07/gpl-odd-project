; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ChannelWidth.msg.html

(cl:defclass <ChannelWidth> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ChannelWidth (<ChannelWidth>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ChannelWidth>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ChannelWidth)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ChannelWidth> is deprecated: use openpilot_bridge-msg:ChannelWidth instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ChannelWidth>)))
    "Constants for message type '<ChannelWidth>"
  '((:W40MHZ . 1)
    (:W160MHZ . 3)
    (:W80MHZ . 2)
    (:W80PLUS80MHZ . 4)
    (:W20MHZ . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ChannelWidth)))
    "Constants for message type 'ChannelWidth"
  '((:W40MHZ . 1)
    (:W160MHZ . 3)
    (:W80MHZ . 2)
    (:W80PLUS80MHZ . 4)
    (:W20MHZ . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ChannelWidth>) ostream)
  "Serializes a message object of type '<ChannelWidth>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ChannelWidth>) istream)
  "Deserializes a message object of type '<ChannelWidth>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ChannelWidth>)))
  "Returns string type for a message object of type '<ChannelWidth>"
  "openpilot_bridge/ChannelWidth")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ChannelWidth)))
  "Returns string type for a message object of type 'ChannelWidth"
  "openpilot_bridge/ChannelWidth")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ChannelWidth>)))
  "Returns md5sum for a message object of type '<ChannelWidth>"
  "9ae570201d6a8de5bc884fa5c20bf751")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ChannelWidth)))
  "Returns md5sum for a message object of type 'ChannelWidth"
  "9ae570201d6a8de5bc884fa5c20bf751")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ChannelWidth>)))
  "Returns full string definition for message of type '<ChannelWidth>"
  (cl:format cl:nil "uint32 w40Mhz=1~%uint32 w160Mhz=3~%uint32 w80Mhz=2~%uint32 w80Plus80Mhz=4~%uint32 w20Mhz=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ChannelWidth)))
  "Returns full string definition for message of type 'ChannelWidth"
  (cl:format cl:nil "uint32 w40Mhz=1~%uint32 w160Mhz=3~%uint32 w80Mhz=2~%uint32 w80Plus80Mhz=4~%uint32 w20Mhz=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ChannelWidth>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ChannelWidth>))
  "Converts a ROS message object to a list"
  (cl:list 'ChannelWidth
))
