; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude PointSet.msg.html

(cl:defclass <PointSet> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (left_lane
    :reader left_lane
    :initarg :left_lane
    :type itri_msgs-msg:PointArray
    :initform (cl:make-instance 'itri_msgs-msg:PointArray))
   (right_lane
    :reader right_lane
    :initarg :right_lane
    :type itri_msgs-msg:PointArray
    :initform (cl:make-instance 'itri_msgs-msg:PointArray))
   (next_left_lane
    :reader next_left_lane
    :initarg :next_left_lane
    :type itri_msgs-msg:PointArray
    :initform (cl:make-instance 'itri_msgs-msg:PointArray))
   (next_right_lane
    :reader next_right_lane
    :initarg :next_right_lane
    :type itri_msgs-msg:PointArray
    :initform (cl:make-instance 'itri_msgs-msg:PointArray)))
)

(cl:defclass PointSet (<PointSet>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PointSet>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PointSet)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<PointSet> is deprecated: use itri_msgs-msg:PointSet instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PointSet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'left_lane-val :lambda-list '(m))
(cl:defmethod left_lane-val ((m <PointSet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:left_lane-val is deprecated.  Use itri_msgs-msg:left_lane instead.")
  (left_lane m))

(cl:ensure-generic-function 'right_lane-val :lambda-list '(m))
(cl:defmethod right_lane-val ((m <PointSet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:right_lane-val is deprecated.  Use itri_msgs-msg:right_lane instead.")
  (right_lane m))

(cl:ensure-generic-function 'next_left_lane-val :lambda-list '(m))
(cl:defmethod next_left_lane-val ((m <PointSet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:next_left_lane-val is deprecated.  Use itri_msgs-msg:next_left_lane instead.")
  (next_left_lane m))

(cl:ensure-generic-function 'next_right_lane-val :lambda-list '(m))
(cl:defmethod next_right_lane-val ((m <PointSet>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:next_right_lane-val is deprecated.  Use itri_msgs-msg:next_right_lane instead.")
  (next_right_lane m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PointSet>) ostream)
  "Serializes a message object of type '<PointSet>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'left_lane) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'right_lane) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'next_left_lane) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'next_right_lane) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PointSet>) istream)
  "Deserializes a message object of type '<PointSet>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'left_lane) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'right_lane) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'next_left_lane) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'next_right_lane) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PointSet>)))
  "Returns string type for a message object of type '<PointSet>"
  "itri_msgs/PointSet")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PointSet)))
  "Returns string type for a message object of type 'PointSet"
  "itri_msgs/PointSet")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PointSet>)))
  "Returns md5sum for a message object of type '<PointSet>"
  "23be87864922d3c27fd77ea6bdfa8034")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PointSet)))
  "Returns md5sum for a message object of type 'PointSet"
  "23be87864922d3c27fd77ea6bdfa8034")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PointSet>)))
  "Returns full string definition for message of type '<PointSet>"
  (cl:format cl:nil "std_msgs/Header header~%PointArray left_lane~%PointArray right_lane~%PointArray next_left_lane~%PointArray next_right_lane~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PointArray~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PointSet)))
  "Returns full string definition for message of type 'PointSet"
  (cl:format cl:nil "std_msgs/Header header~%PointArray left_lane~%PointArray right_lane~%PointArray next_left_lane~%PointArray next_right_lane~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PointArray~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PointSet>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'left_lane))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'right_lane))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'next_left_lane))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'next_right_lane))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PointSet>))
  "Converts a ROS message object to a list"
  (cl:list 'PointSet
    (cl:cons ':header (header msg))
    (cl:cons ':left_lane (left_lane msg))
    (cl:cons ':right_lane (right_lane msg))
    (cl:cons ':next_left_lane (next_left_lane msg))
    (cl:cons ':next_right_lane (next_right_lane msg))
))
