; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Lateraltuning.msg.html

(cl:defclass <Lateraltuning> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (indi
    :reader indi
    :initarg :indi
    :type openpilot_bridge-msg:LateralINDITuning
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralINDITuning))
   (pid
    :reader pid
    :initarg :pid
    :type openpilot_bridge-msg:LateralPIDTuning
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralPIDTuning))
   (lqr
    :reader lqr
    :initarg :lqr
    :type openpilot_bridge-msg:LateralLQRTuning
    :initform (cl:make-instance 'openpilot_bridge-msg:LateralLQRTuning)))
)

(cl:defclass Lateraltuning (<Lateraltuning>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Lateraltuning>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Lateraltuning)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Lateraltuning> is deprecated: use openpilot_bridge-msg:Lateraltuning instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Lateraltuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'indi-val :lambda-list '(m))
(cl:defmethod indi-val ((m <Lateraltuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:indi-val is deprecated.  Use openpilot_bridge-msg:indi instead.")
  (indi m))

(cl:ensure-generic-function 'pid-val :lambda-list '(m))
(cl:defmethod pid-val ((m <Lateraltuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pid-val is deprecated.  Use openpilot_bridge-msg:pid instead.")
  (pid m))

(cl:ensure-generic-function 'lqr-val :lambda-list '(m))
(cl:defmethod lqr-val ((m <Lateraltuning>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lqr-val is deprecated.  Use openpilot_bridge-msg:lqr instead.")
  (lqr m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Lateraltuning>) ostream)
  "Serializes a message object of type '<Lateraltuning>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'indi) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pid) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lqr) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Lateraltuning>) istream)
  "Deserializes a message object of type '<Lateraltuning>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'indi) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pid) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lqr) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Lateraltuning>)))
  "Returns string type for a message object of type '<Lateraltuning>"
  "openpilot_bridge/Lateraltuning")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Lateraltuning)))
  "Returns string type for a message object of type 'Lateraltuning"
  "openpilot_bridge/Lateraltuning")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Lateraltuning>)))
  "Returns md5sum for a message object of type '<Lateraltuning>"
  "91bf1863abb4aef4fc1990bbeead3dc0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Lateraltuning)))
  "Returns md5sum for a message object of type 'Lateraltuning"
  "91bf1863abb4aef4fc1990bbeead3dc0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Lateraltuning>)))
  "Returns full string definition for message of type '<Lateraltuning>"
  (cl:format cl:nil "Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Lateraltuning)))
  "Returns full string definition for message of type 'Lateraltuning"
  (cl:format cl:nil "Header header~%~%LateralINDITuning indi~%LateralPIDTuning pid~%LateralLQRTuning lqr~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LateralINDITuning~%Header header~%~%float32 actuatorEffectiveness~%float32 outerLoopGain~%float32 innerLoopGain~%float32 timeConstant~%~%================================================================================~%MSG: openpilot_bridge/LateralPIDTuning~%Header header~%~%float32[] kiBP~%float32 kf~%float32[] kiV~%float32[] kpV~%float32[] kpBP~%~%================================================================================~%MSG: openpilot_bridge/LateralLQRTuning~%Header header~%~%float32[] a~%float32[] c~%float32 scale~%float32 ki~%float32[] l~%float32[] b~%float32 dcGain~%float32[] k~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Lateraltuning>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'indi))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pid))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lqr))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Lateraltuning>))
  "Converts a ROS message object to a list"
  (cl:list 'Lateraltuning
    (cl:cons ':header (header msg))
    (cl:cons ':indi (indi msg))
    (cl:cons ':pid (pid msg))
    (cl:cons ':lqr (lqr msg))
))
