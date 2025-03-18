; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude OpenPilotLines.msg.html

(cl:defclass <OpenPilotLines> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (left_line
    :reader left_line
    :initarg :left_line
    :type itri_msgs-msg:OpenPilotLine
    :initform (cl:make-instance 'itri_msgs-msg:OpenPilotLine))
   (right_line
    :reader right_line
    :initarg :right_line
    :type itri_msgs-msg:OpenPilotLine
    :initform (cl:make-instance 'itri_msgs-msg:OpenPilotLine))
   (desired_line
    :reader desired_line
    :initarg :desired_line
    :type itri_msgs-msg:OpenPilotLine
    :initform (cl:make-instance 'itri_msgs-msg:OpenPilotLine)))
)

(cl:defclass OpenPilotLines (<OpenPilotLines>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OpenPilotLines>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OpenPilotLines)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<OpenPilotLines> is deprecated: use itri_msgs-msg:OpenPilotLines instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <OpenPilotLines>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'left_line-val :lambda-list '(m))
(cl:defmethod left_line-val ((m <OpenPilotLines>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left_line-val is deprecated.  Use itri_msgs-msg:left_line instead.")
  (left_line m))

(cl:ensure-generic-function 'right_line-val :lambda-list '(m))
(cl:defmethod right_line-val ((m <OpenPilotLines>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right_line-val is deprecated.  Use itri_msgs-msg:right_line instead.")
  (right_line m))

(cl:ensure-generic-function 'desired_line-val :lambda-list '(m))
(cl:defmethod desired_line-val ((m <OpenPilotLines>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:desired_line-val is deprecated.  Use itri_msgs-msg:desired_line instead.")
  (desired_line m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OpenPilotLines>) ostream)
  "Serializes a message object of type '<OpenPilotLines>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'left_line) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'right_line) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'desired_line) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OpenPilotLines>) istream)
  "Deserializes a message object of type '<OpenPilotLines>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'left_line) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'right_line) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'desired_line) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OpenPilotLines>)))
  "Returns string type for a message object of type '<OpenPilotLines>"
  "itri_msgs/OpenPilotLines")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OpenPilotLines)))
  "Returns string type for a message object of type 'OpenPilotLines"
  "itri_msgs/OpenPilotLines")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OpenPilotLines>)))
  "Returns md5sum for a message object of type '<OpenPilotLines>"
  "9096eb6f351b82a595c1de88685f239b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OpenPilotLines)))
  "Returns md5sum for a message object of type 'OpenPilotLines"
  "9096eb6f351b82a595c1de88685f239b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OpenPilotLines>)))
  "Returns full string definition for message of type '<OpenPilotLines>"
  (cl:format cl:nil "std_msgs/Header header~%OpenPilotLine left_line~%OpenPilotLine right_line~%OpenPilotLine desired_line~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/OpenPilotLine~%std_msgs/Header header~%~%uint8 probability~%float32[] coefficient~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OpenPilotLines)))
  "Returns full string definition for message of type 'OpenPilotLines"
  (cl:format cl:nil "std_msgs/Header header~%OpenPilotLine left_line~%OpenPilotLine right_line~%OpenPilotLine desired_line~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/OpenPilotLine~%std_msgs/Header header~%~%uint8 probability~%float32[] coefficient~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OpenPilotLines>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'left_line))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'right_line))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'desired_line))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OpenPilotLines>))
  "Converts a ROS message object to a list"
  (cl:list 'OpenPilotLines
    (cl:cons ':header (header msg))
    (cl:cons ':left_line (left_line msg))
    (cl:cons ':right_line (right_line msg))
    (cl:cons ':desired_line (desired_line msg))
))
