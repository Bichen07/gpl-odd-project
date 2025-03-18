; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude LaneLine.msg.html

(cl:defclass <LaneLine> (roslisp-msg-protocol:ros-message)
  ((left_line
    :reader left_line
    :initarg :left_line
    :type itri_msgs-msg:LanePoly
    :initform (cl:make-instance 'itri_msgs-msg:LanePoly))
   (right_line
    :reader right_line
    :initarg :right_line
    :type itri_msgs-msg:LanePoly
    :initform (cl:make-instance 'itri_msgs-msg:LanePoly)))
)

(cl:defclass LaneLine (<LaneLine>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneLine>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneLine)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<LaneLine> is deprecated: use itri_msgs-msg:LaneLine instead.")))

(cl:ensure-generic-function 'left_line-val :lambda-list '(m))
(cl:defmethod left_line-val ((m <LaneLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left_line-val is deprecated.  Use itri_msgs-msg:left_line instead.")
  (left_line m))

(cl:ensure-generic-function 'right_line-val :lambda-list '(m))
(cl:defmethod right_line-val ((m <LaneLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right_line-val is deprecated.  Use itri_msgs-msg:right_line instead.")
  (right_line m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneLine>) ostream)
  "Serializes a message object of type '<LaneLine>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'left_line) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'right_line) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneLine>) istream)
  "Deserializes a message object of type '<LaneLine>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'left_line) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'right_line) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneLine>)))
  "Returns string type for a message object of type '<LaneLine>"
  "itri_msgs/LaneLine")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneLine)))
  "Returns string type for a message object of type 'LaneLine"
  "itri_msgs/LaneLine")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneLine>)))
  "Returns md5sum for a message object of type '<LaneLine>"
  "df0610fafa5521c03719095763a8f984")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneLine)))
  "Returns md5sum for a message object of type 'LaneLine"
  "df0610fafa5521c03719095763a8f984")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneLine>)))
  "Returns full string definition for message of type '<LaneLine>"
  (cl:format cl:nil "LanePoly left_line~%LanePoly right_line~%~%================================================================================~%MSG: itri_msgs/LanePoly~%std_msgs/Header header~%float32 c0~%float32 c1~%float32 c2~%float32 c3~%~%uint16 confidentScore~%float32 distance~%float32 width~%float32 right_bound~%float32 left_bound~%float32 prob~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneLine)))
  "Returns full string definition for message of type 'LaneLine"
  (cl:format cl:nil "LanePoly left_line~%LanePoly right_line~%~%================================================================================~%MSG: itri_msgs/LanePoly~%std_msgs/Header header~%float32 c0~%float32 c1~%float32 c2~%float32 c3~%~%uint16 confidentScore~%float32 distance~%float32 width~%float32 right_bound~%float32 left_bound~%float32 prob~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneLine>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'left_line))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'right_line))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneLine>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneLine
    (cl:cons ':left_line (left_line msg))
    (cl:cons ':right_line (right_line msg))
))
