; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Lateralcontrolstate.msg.html

(cl:defclass <Lateralcontrolstate> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lqrState
    :reader lqrState
    :initarg :lqrState
    :type openpilot_bridge-msg:LateralLQRState
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralLQRState))
   (pidState
    :reader pidState
    :initarg :pidState
    :type openpilot_bridge-msg:LateralPIDState
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralPIDState))
   (indiState
    :reader indiState
    :initarg :indiState
    :type openpilot_bridge-msg:LateralINDIState
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralINDIState)))
)

(cl:defclass Lateralcontrolstate (<Lateralcontrolstate>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Lateralcontrolstate>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Lateralcontrolstate)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Lateralcontrolstate> is deprecated: use openpilot_bridge-msg:Lateralcontrolstate instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Lateralcontrolstate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lqrState-val :lambda-list '(m))
(cl:defmethod lqrState-val ((m <Lateralcontrolstate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lqrState-val is deprecated.  Use openpilot_bridge-msg:lqrState instead.")
  (lqrState m))

(cl:ensure-generic-function 'pidState-val :lambda-list '(m))
(cl:defmethod pidState-val ((m <Lateralcontrolstate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pidState-val is deprecated.  Use openpilot_bridge-msg:pidState instead.")
  (pidState m))

(cl:ensure-generic-function 'indiState-val :lambda-list '(m))
(cl:defmethod indiState-val ((m <Lateralcontrolstate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:indiState-val is deprecated.  Use openpilot_bridge-msg:indiState instead.")
  (indiState m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Lateralcontrolstate>) ostream)
  "Serializes a message object of type '<Lateralcontrolstate>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lqrState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pidState) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'indiState) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Lateralcontrolstate>) istream)
  "Deserializes a message object of type '<Lateralcontrolstate>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lqrState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pidState) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'indiState) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Lateralcontrolstate>)))
  "Returns string type for a message object of type '<Lateralcontrolstate>"
  "openpilot_bridge/Lateralcontrolstate")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Lateralcontrolstate)))
  "Returns string type for a message object of type 'Lateralcontrolstate"
  "openpilot_bridge/Lateralcontrolstate")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Lateralcontrolstate>)))
  "Returns md5sum for a message object of type '<Lateralcontrolstate>"
  "598a6ef5d0f69fbeaacc25e00cbce69b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Lateralcontrolstate)))
  "Returns md5sum for a message object of type 'Lateralcontrolstate"
  "598a6ef5d0f69fbeaacc25e00cbce69b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Lateralcontrolstate>)))
  "Returns full string definition for message of type '<Lateralcontrolstate>"
  (cl:format cl:nil "Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Lateralcontrolstate)))
  "Returns full string definition for message of type 'Lateralcontrolstate"
  (cl:format cl:nil "Header header~%~%LateralLQRState lqrState~%LateralPIDState pidState~%LateralINDIState indiState~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRState~%Header header~%~%bool saturated~%float32 i~%float32 lqrOutput~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDState~%Header header~%~%bool saturated~%float32 p~%float32 steerRate~%float32 f~%float32 i~%float32 angleError~%bool active~%float32 output~%float32 steerAngle~%~%================================================================================~%MSG: openpilot_bridge/LateralINDIState~%Header header~%~%float32 rateSetPoint~%float32 delayedOutput~%bool saturated~%float32 steerAccel~%float32 steerRate~%float32 delta~%float32 accelError~%float32 accelSetPoint~%bool active~%float32 output~%float32 steerAngle~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Lateralcontrolstate>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lqrState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pidState))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'indiState))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Lateralcontrolstate>))
  "Converts a ROS message object to a list"
  (cl:list 'Lateralcontrolstate
    (cl:cons ':header (header msg))
    (cl:cons ':lqrState (lqrState msg))
    (cl:cons ':pidState (pidState msg))
    (cl:cons ':indiState (indiState msg))
))
