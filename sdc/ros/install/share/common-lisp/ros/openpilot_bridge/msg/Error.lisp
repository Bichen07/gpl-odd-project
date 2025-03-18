; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Error.msg.html

(cl:defclass <Error> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Error (<Error>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Error>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Error)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Error> is deprecated: use openpilot_bridge-msg:Error instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Error>)))
    "Constants for message type '<Error>"
  '((:FAULT . 1)
    (:CANERROR . 0)
    (:WRONGCONFIG . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Error)))
    "Constants for message type 'Error"
  '((:FAULT . 1)
    (:CANERROR . 0)
    (:WRONGCONFIG . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Error>) ostream)
  "Serializes a message object of type '<Error>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Error>) istream)
  "Deserializes a message object of type '<Error>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Error>)))
  "Returns string type for a message object of type '<Error>"
  "openpilot_bridge/Error")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Error)))
  "Returns string type for a message object of type 'Error"
  "openpilot_bridge/Error")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Error>)))
  "Returns md5sum for a message object of type '<Error>"
  "48460582da2a88bb26d24722889db26d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Error)))
  "Returns md5sum for a message object of type 'Error"
  "48460582da2a88bb26d24722889db26d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Error>)))
  "Returns full string definition for message of type '<Error>"
  (cl:format cl:nil "uint32 fault=1~%uint32 canError=0~%uint32 wrongConfig=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Error)))
  "Returns full string definition for message of type 'Error"
  (cl:format cl:nil "uint32 fault=1~%uint32 canError=0~%uint32 wrongConfig=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Error>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Error>))
  "Converts a ROS message object to a list"
  (cl:list 'Error
))
