; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ThermalStatus.msg.html

(cl:defclass <ThermalStatus> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ThermalStatus (<ThermalStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ThermalStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ThermalStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ThermalStatus> is deprecated: use openpilot_bridge-msg:ThermalStatus instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ThermalStatus>)))
    "Constants for message type '<ThermalStatus>"
  '((:GREEN . 0)
    (:RED . 2)
    (:YELLOW . 1)
    (:DANGER . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ThermalStatus)))
    "Constants for message type 'ThermalStatus"
  '((:GREEN . 0)
    (:RED . 2)
    (:YELLOW . 1)
    (:DANGER . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ThermalStatus>) ostream)
  "Serializes a message object of type '<ThermalStatus>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ThermalStatus>) istream)
  "Deserializes a message object of type '<ThermalStatus>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ThermalStatus>)))
  "Returns string type for a message object of type '<ThermalStatus>"
  "openpilot_bridge/ThermalStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ThermalStatus)))
  "Returns string type for a message object of type 'ThermalStatus"
  "openpilot_bridge/ThermalStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ThermalStatus>)))
  "Returns md5sum for a message object of type '<ThermalStatus>"
  "8ca17fd4cb32043ad3a4b48c68d9d536")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ThermalStatus)))
  "Returns md5sum for a message object of type 'ThermalStatus"
  "8ca17fd4cb32043ad3a4b48c68d9d536")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ThermalStatus>)))
  "Returns full string definition for message of type '<ThermalStatus>"
  (cl:format cl:nil "uint32 green=0~%uint32 red=2~%uint32 yellow=1~%uint32 danger=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ThermalStatus)))
  "Returns full string definition for message of type 'ThermalStatus"
  (cl:format cl:nil "uint32 green=0~%uint32 red=2~%uint32 yellow=1~%uint32 danger=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ThermalStatus>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ThermalStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'ThermalStatus
))
