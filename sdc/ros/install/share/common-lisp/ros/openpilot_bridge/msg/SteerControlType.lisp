; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SteerControlType.msg.html

(cl:defclass <SteerControlType> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SteerControlType (<SteerControlType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SteerControlType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SteerControlType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SteerControlType> is deprecated: use openpilot_bridge-msg:SteerControlType instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SteerControlType>)))
    "Constants for message type '<SteerControlType>"
  '((:ANGLE . 1)
    (:TORQUE . 0))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SteerControlType)))
    "Constants for message type 'SteerControlType"
  '((:ANGLE . 1)
    (:TORQUE . 0))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SteerControlType>) ostream)
  "Serializes a message object of type '<SteerControlType>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SteerControlType>) istream)
  "Deserializes a message object of type '<SteerControlType>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SteerControlType>)))
  "Returns string type for a message object of type '<SteerControlType>"
  "openpilot_bridge/SteerControlType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SteerControlType)))
  "Returns string type for a message object of type 'SteerControlType"
  "openpilot_bridge/SteerControlType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SteerControlType>)))
  "Returns md5sum for a message object of type '<SteerControlType>"
  "b226a11115e5e44a2546beb49ffa97fa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SteerControlType)))
  "Returns md5sum for a message object of type 'SteerControlType"
  "b226a11115e5e44a2546beb49ffa97fa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SteerControlType>)))
  "Returns full string definition for message of type '<SteerControlType>"
  (cl:format cl:nil "uint32 angle=1~%uint32 torque=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SteerControlType)))
  "Returns full string definition for message of type 'SteerControlType"
  (cl:format cl:nil "uint32 angle=1~%uint32 torque=0~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SteerControlType>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SteerControlType>))
  "Converts a ROS message object to a list"
  (cl:list 'SteerControlType
))
