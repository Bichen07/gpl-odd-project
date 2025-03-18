; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude MultipathIndicator.msg.html

(cl:defclass <MultipathIndicator> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass MultipathIndicator (<MultipathIndicator>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MultipathIndicator>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MultipathIndicator)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<MultipathIndicator> is deprecated: use openpilot_bridge-msg:MultipathIndicator instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MultipathIndicator>)))
    "Constants for message type '<MultipathIndicator>"
  '((:UNKNOWN . 0)
    (:DETECTED . 1)
    (:NOTDETECTED . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MultipathIndicator)))
    "Constants for message type 'MultipathIndicator"
  '((:UNKNOWN . 0)
    (:DETECTED . 1)
    (:NOTDETECTED . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MultipathIndicator>) ostream)
  "Serializes a message object of type '<MultipathIndicator>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MultipathIndicator>) istream)
  "Deserializes a message object of type '<MultipathIndicator>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MultipathIndicator>)))
  "Returns string type for a message object of type '<MultipathIndicator>"
  "openpilot_bridge/MultipathIndicator")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MultipathIndicator)))
  "Returns string type for a message object of type 'MultipathIndicator"
  "openpilot_bridge/MultipathIndicator")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MultipathIndicator>)))
  "Returns md5sum for a message object of type '<MultipathIndicator>"
  "33afdf2f17a81ec894bf0c7faeb6aca3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MultipathIndicator)))
  "Returns md5sum for a message object of type 'MultipathIndicator"
  "33afdf2f17a81ec894bf0c7faeb6aca3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MultipathIndicator>)))
  "Returns full string definition for message of type '<MultipathIndicator>"
  (cl:format cl:nil "uint32 unknown=0~%uint32 detected=1~%uint32 notDetected=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MultipathIndicator)))
  "Returns full string definition for message of type 'MultipathIndicator"
  (cl:format cl:nil "uint32 unknown=0~%uint32 detected=1~%uint32 notDetected=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MultipathIndicator>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MultipathIndicator>))
  "Converts a ROS message object to a list"
  (cl:list 'MultipathIndicator
))
