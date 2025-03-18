; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude TransmissionType.msg.html

(cl:defclass <TransmissionType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass TransmissionType (<TransmissionType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TransmissionType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TransmissionType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<TransmissionType> is deprecated: use openpilot_bridge-msg:TransmissionType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<TransmissionType>)))
    "Constants for message type '<TransmissionType>"
  '((:UNKNOWN . 0)
    (:AUTOMATIC . 1)
    (:MANUAL . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'TransmissionType)))
    "Constants for message type 'TransmissionType"
  '((:UNKNOWN . 0)
    (:AUTOMATIC . 1)
    (:MANUAL . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TransmissionType>) ostream)
  "Serializes a message object of type '<TransmissionType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TransmissionType>) istream)
  "Deserializes a message object of type '<TransmissionType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TransmissionType>)))
  "Returns string type for a message object of type '<TransmissionType>"
  "openpilot_bridge/TransmissionType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TransmissionType)))
  "Returns string type for a message object of type 'TransmissionType"
  "openpilot_bridge/TransmissionType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TransmissionType>)))
  "Returns md5sum for a message object of type '<TransmissionType>"
  "6a285d0e2a6ddfeacb68fed4d3099191")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TransmissionType)))
  "Returns md5sum for a message object of type 'TransmissionType"
  "6a285d0e2a6ddfeacb68fed4d3099191")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TransmissionType>)))
  "Returns full string definition for message of type '<TransmissionType>"
  (cl:format cl:nil "uint32 unknown=0~%uint32 automatic=1~%uint32 manual=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TransmissionType)))
  "Returns full string definition for message of type 'TransmissionType"
  (cl:format cl:nil "uint32 unknown=0~%uint32 automatic=1~%uint32 manual=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TransmissionType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TransmissionType>))
  "Converts a ROS message object to a list"
  (cl:list 'TransmissionType
))
