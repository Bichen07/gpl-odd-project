; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude ChffrAndroidExtra.msg.html

(cl:defclass <ChffrAndroidExtra> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (allCameraCharacteristics
    :reader allCameraCharacteristics
    :initarg :allCameraCharacteristics
    :type openpilot_bridge-msg:Map
    :initform (cl:make-instance 'openpilot_bridge-msg:Map)))
)

(cl:defclass ChffrAndroidExtra (<ChffrAndroidExtra>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ChffrAndroidExtra>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ChffrAndroidExtra)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<ChffrAndroidExtra> is deprecated: use openpilot_bridge-msg:ChffrAndroidExtra instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ChffrAndroidExtra>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'allCameraCharacteristics-val :lambda-list '(m))
(cl:defmethod allCameraCharacteristics-val ((m <ChffrAndroidExtra>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:allCameraCharacteristics-val is deprecated.  Use openpilot_bridge-msg:allCameraCharacteristics instead.")
  (allCameraCharacteristics m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ChffrAndroidExtra>) ostream)
  "Serializes a message object of type '<ChffrAndroidExtra>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'allCameraCharacteristics) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ChffrAndroidExtra>) istream)
  "Deserializes a message object of type '<ChffrAndroidExtra>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'allCameraCharacteristics) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ChffrAndroidExtra>)))
  "Returns string type for a message object of type '<ChffrAndroidExtra>"
  "openpilot_bridge/ChffrAndroidExtra")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ChffrAndroidExtra)))
  "Returns string type for a message object of type 'ChffrAndroidExtra"
  "openpilot_bridge/ChffrAndroidExtra")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ChffrAndroidExtra>)))
  "Returns md5sum for a message object of type '<ChffrAndroidExtra>"
  "b43d42df107e761f273426529e592a9c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ChffrAndroidExtra)))
  "Returns md5sum for a message object of type 'ChffrAndroidExtra"
  "b43d42df107e761f273426529e592a9c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ChffrAndroidExtra>)))
  "Returns full string definition for message of type '<ChffrAndroidExtra>"
  (cl:format cl:nil "Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ChffrAndroidExtra)))
  "Returns full string definition for message of type 'ChffrAndroidExtra"
  (cl:format cl:nil "Header header~%~%Map allCameraCharacteristics~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Map~%Header header~%~%Entry[] entries~%~%================================================================================~%MSG: openpilot_bridge/Entry~%Header header~%~%string value~%string key~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ChffrAndroidExtra>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'allCameraCharacteristics))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ChffrAndroidExtra>))
  "Converts a ROS message object to a list"
  (cl:list 'ChffrAndroidExtra
    (cl:cons ':header (header msg))
    (cl:cons ':allCameraCharacteristics (allCameraCharacteristics msg))
))
