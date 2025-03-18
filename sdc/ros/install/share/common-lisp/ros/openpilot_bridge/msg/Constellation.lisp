; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Constellation.msg.html

(cl:defclass <Constellation> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Constellation (<Constellation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Constellation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Constellation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Constellation> is deprecated: use openpilot_bridge-msg:Constellation instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Constellation>)))
    "Constants for message type '<Constellation>"
  '((:GLONASS . 3)
    (:SBAS . 2)
    (:UNKNOWN . 0)
    (:QZSS . 4)
    (:GALILEO . 6)
    (:BEIDOU . 5)
    (:GPS . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Constellation)))
    "Constants for message type 'Constellation"
  '((:GLONASS . 3)
    (:SBAS . 2)
    (:UNKNOWN . 0)
    (:QZSS . 4)
    (:GALILEO . 6)
    (:BEIDOU . 5)
    (:GPS . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Constellation>) ostream)
  "Serializes a message object of type '<Constellation>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Constellation>) istream)
  "Deserializes a message object of type '<Constellation>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Constellation>)))
  "Returns string type for a message object of type '<Constellation>"
  "openpilot_bridge/Constellation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Constellation)))
  "Returns string type for a message object of type 'Constellation"
  "openpilot_bridge/Constellation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Constellation>)))
  "Returns md5sum for a message object of type '<Constellation>"
  "10e258dff61ddb857e38cc71c876c0f6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Constellation)))
  "Returns md5sum for a message object of type 'Constellation"
  "10e258dff61ddb857e38cc71c876c0f6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Constellation>)))
  "Returns full string definition for message of type '<Constellation>"
  (cl:format cl:nil "uint32 glonass=3~%uint32 sbas=2~%uint32 unknown=0~%uint32 qzss=4~%uint32 galileo=6~%uint32 beidou=5~%uint32 gps=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Constellation)))
  "Returns full string definition for message of type 'Constellation"
  (cl:format cl:nil "uint32 glonass=3~%uint32 sbas=2~%uint32 unknown=0~%uint32 qzss=4~%uint32 galileo=6~%uint32 beidou=5~%uint32 gps=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Constellation>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Constellation>))
  "Converts a ROS message object to a list"
  (cl:list 'Constellation
))
