; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude App.msg.html

(cl:defclass <App> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass App (<App>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <App>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'App)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<App> is deprecated: use openpilot_bridge-msg:App instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<App>)))
    "Constants for message type '<App>"
  '((:HOME . 0)
    (:NAV . 2)
    (:MUSIC . 1)
    (:SETTINGS . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'App)))
    "Constants for message type 'App"
  '((:HOME . 0)
    (:NAV . 2)
    (:MUSIC . 1)
    (:SETTINGS . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <App>) ostream)
  "Serializes a message object of type '<App>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <App>) istream)
  "Deserializes a message object of type '<App>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<App>)))
  "Returns string type for a message object of type '<App>"
  "openpilot_bridge/App")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'App)))
  "Returns string type for a message object of type 'App"
  "openpilot_bridge/App")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<App>)))
  "Returns md5sum for a message object of type '<App>"
  "4d8d5be50420b5f72e4c548858f9a27f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'App)))
  "Returns md5sum for a message object of type 'App"
  "4d8d5be50420b5f72e4c548858f9a27f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<App>)))
  "Returns full string definition for message of type '<App>"
  (cl:format cl:nil "uint32 home=0~%uint32 nav=2~%uint32 music=1~%uint32 settings=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'App)))
  "Returns full string definition for message of type 'App"
  (cl:format cl:nil "uint32 home=0~%uint32 nav=2~%uint32 music=1~%uint32 settings=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <App>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <App>))
  "Converts a ROS message object to a list"
  (cl:list 'App
))
