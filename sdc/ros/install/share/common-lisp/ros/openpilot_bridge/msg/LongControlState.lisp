; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LongControlState.msg.html

(cl:defclass <LongControlState> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LongControlState (<LongControlState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LongControlState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LongControlState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LongControlState> is deprecated: use openpilot_bridge-msg:LongControlState instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<LongControlState>)))
    "Constants for message type '<LongControlState>"
  '((:STOPPING . 2)
    (:PID . 1)
    (:OFF . 0)
    (:STARTING . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'LongControlState)))
    "Constants for message type 'LongControlState"
  '((:STOPPING . 2)
    (:PID . 1)
    (:OFF . 0)
    (:STARTING . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LongControlState>) ostream)
  "Serializes a message object of type '<LongControlState>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LongControlState>) istream)
  "Deserializes a message object of type '<LongControlState>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LongControlState>)))
  "Returns string type for a message object of type '<LongControlState>"
  "openpilot_bridge/LongControlState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LongControlState)))
  "Returns string type for a message object of type 'LongControlState"
  "openpilot_bridge/LongControlState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LongControlState>)))
  "Returns md5sum for a message object of type '<LongControlState>"
  "3b1d735b18fedde2cd52ffbcd57e63c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LongControlState)))
  "Returns md5sum for a message object of type 'LongControlState"
  "3b1d735b18fedde2cd52ffbcd57e63c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LongControlState>)))
  "Returns full string definition for message of type '<LongControlState>"
  (cl:format cl:nil "uint32 stopping=2~%uint32 pid=1~%uint32 off=0~%uint32 starting=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LongControlState)))
  "Returns full string definition for message of type 'LongControlState"
  (cl:format cl:nil "uint32 stopping=2~%uint32 pid=1~%uint32 off=0~%uint32 starting=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LongControlState>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LongControlState>))
  "Converts a ROS message object to a list"
  (cl:list 'LongControlState
))
