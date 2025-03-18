; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LaneChangeState.msg.html

(cl:defclass <LaneChangeState> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass LaneChangeState (<LaneChangeState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneChangeState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneChangeState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LaneChangeState> is deprecated: use openpilot_bridge-msg:LaneChangeState instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<LaneChangeState>)))
    "Constants for message type '<LaneChangeState>"
  '((:PRELANECHANGE . 1)
    (:LANECHANGESTARTING . 2)
    (:OFF . 0)
    (:LANECHANGEFINISHING . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'LaneChangeState)))
    "Constants for message type 'LaneChangeState"
  '((:PRELANECHANGE . 1)
    (:LANECHANGESTARTING . 2)
    (:OFF . 0)
    (:LANECHANGEFINISHING . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneChangeState>) ostream)
  "Serializes a message object of type '<LaneChangeState>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneChangeState>) istream)
  "Deserializes a message object of type '<LaneChangeState>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneChangeState>)))
  "Returns string type for a message object of type '<LaneChangeState>"
  "openpilot_bridge/LaneChangeState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneChangeState)))
  "Returns string type for a message object of type 'LaneChangeState"
  "openpilot_bridge/LaneChangeState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneChangeState>)))
  "Returns md5sum for a message object of type '<LaneChangeState>"
  "39b0857fa3f626379332a3d9c60e1641")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneChangeState)))
  "Returns md5sum for a message object of type 'LaneChangeState"
  "39b0857fa3f626379332a3d9c60e1641")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneChangeState>)))
  "Returns full string definition for message of type '<LaneChangeState>"
  (cl:format cl:nil "uint32 preLaneChange=1~%uint32 laneChangeStarting=2~%uint32 off=0~%uint32 laneChangeFinishing=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneChangeState)))
  "Returns full string definition for message of type 'LaneChangeState"
  (cl:format cl:nil "uint32 preLaneChange=1~%uint32 laneChangeStarting=2~%uint32 off=0~%uint32 laneChangeFinishing=3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneChangeState>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneChangeState>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneChangeState
))
