; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Ecu.msg.html

(cl:defclass <Ecu> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Ecu (<Ecu>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ecu>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ecu)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Ecu> is deprecated: use openpilot_bridge-msg:Ecu instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Ecu>)))
    "Constants for message type '<Ecu>"
  '((:ENGINE . 4)
    (:ESP . 1)
    (:UNKNOWN . 5)
    (:DSU . 6)
    (:EPS . 0)
    (:APGS . 7)
    (:FWDRADAR . 2)
    (:FWDCAMERA . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Ecu)))
    "Constants for message type 'Ecu"
  '((:ENGINE . 4)
    (:ESP . 1)
    (:UNKNOWN . 5)
    (:DSU . 6)
    (:EPS . 0)
    (:APGS . 7)
    (:FWDRADAR . 2)
    (:FWDCAMERA . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ecu>) ostream)
  "Serializes a message object of type '<Ecu>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ecu>) istream)
  "Deserializes a message object of type '<Ecu>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ecu>)))
  "Returns string type for a message object of type '<Ecu>"
  "openpilot_bridge/Ecu")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ecu)))
  "Returns string type for a message object of type 'Ecu"
  "openpilot_bridge/Ecu")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ecu>)))
  "Returns md5sum for a message object of type '<Ecu>"
  "b4567db0d123c6b76edb282c1d1130de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ecu)))
  "Returns md5sum for a message object of type 'Ecu"
  "b4567db0d123c6b76edb282c1d1130de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ecu>)))
  "Returns full string definition for message of type '<Ecu>"
  (cl:format cl:nil "uint32 engine=4~%uint32 esp=1~%uint32 unknown=5~%uint32 dsu=6~%uint32 eps=0~%uint32 apgs=7~%uint32 fwdRadar=2~%uint32 fwdCamera=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ecu)))
  "Returns full string definition for message of type 'Ecu"
  (cl:format cl:nil "uint32 engine=4~%uint32 esp=1~%uint32 unknown=5~%uint32 dsu=6~%uint32 eps=0~%uint32 apgs=7~%uint32 fwdRadar=2~%uint32 fwdCamera=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ecu>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ecu>))
  "Converts a ROS message object to a list"
  (cl:list 'Ecu
))
