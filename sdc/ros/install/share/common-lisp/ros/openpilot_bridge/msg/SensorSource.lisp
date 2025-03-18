; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude SensorSource.msg.html

(cl:defclass <SensorSource> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SensorSource (<SensorSource>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SensorSource>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SensorSource)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<SensorSource> is deprecated: use openpilot_bridge-msg:SensorSource instead.")))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SensorSource>)))
    "Constants for message type '<SensorSource>"
  '((:TIMING . 3)
    (:DUMMY . 4)
    (:ORBSLAM . 2)
    (:APPLANIX . 0)
    (:KALMAN . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SensorSource)))
    "Constants for message type 'SensorSource"
  '((:TIMING . 3)
    (:DUMMY . 4)
    (:ORBSLAM . 2)
    (:APPLANIX . 0)
    (:KALMAN . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SensorSource>) ostream)
  "Serializes a message object of type '<SensorSource>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SensorSource>) istream)
  "Deserializes a message object of type '<SensorSource>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SensorSource>)))
  "Returns string type for a message object of type '<SensorSource>"
  "openpilot_bridge/SensorSource")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SensorSource)))
  "Returns string type for a message object of type 'SensorSource"
  "openpilot_bridge/SensorSource")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SensorSource>)))
  "Returns md5sum for a message object of type '<SensorSource>"
  "4e71318379cc48f045877905e946e09e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SensorSource)))
  "Returns md5sum for a message object of type 'SensorSource"
  "4e71318379cc48f045877905e946e09e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SensorSource>)))
  "Returns full string definition for message of type '<SensorSource>"
  (cl:format cl:nil "uint32 timing=3~%uint32 dummy=4~%uint32 orbslam=2~%uint32 applanix=0~%uint32 kalman=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SensorSource)))
  "Returns full string definition for message of type 'SensorSource"
  (cl:format cl:nil "uint32 timing=3~%uint32 dummy=4~%uint32 orbslam=2~%uint32 applanix=0~%uint32 kalman=1~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SensorSource>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SensorSource>))
  "Converts a ROS message object to a list"
  (cl:list 'SensorSource
))
