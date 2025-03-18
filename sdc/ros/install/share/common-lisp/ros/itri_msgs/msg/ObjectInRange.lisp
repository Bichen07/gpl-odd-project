; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ObjectInRange.msg.html

(cl:defclass <ObjectInRange> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (object_in_range
    :reader object_in_range
    :initarg :object_in_range
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ObjectInRange (<ObjectInRange>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectInRange>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectInRange)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ObjectInRange> is deprecated: use itri_msgs-msg:ObjectInRange instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ObjectInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'object_in_range-val :lambda-list '(m))
(cl:defmethod object_in_range-val ((m <ObjectInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:object_in_range-val is deprecated.  Use itri_msgs-msg:object_in_range instead.")
  (object_in_range m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectInRange>) ostream)
  "Serializes a message object of type '<ObjectInRange>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'object_in_range) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectInRange>) istream)
  "Deserializes a message object of type '<ObjectInRange>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'object_in_range) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectInRange>)))
  "Returns string type for a message object of type '<ObjectInRange>"
  "itri_msgs/ObjectInRange")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectInRange)))
  "Returns string type for a message object of type 'ObjectInRange"
  "itri_msgs/ObjectInRange")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectInRange>)))
  "Returns md5sum for a message object of type '<ObjectInRange>"
  "3eb2ed7d3d1e1673d0083e5d770b64d0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectInRange)))
  "Returns md5sum for a message object of type 'ObjectInRange"
  "3eb2ed7d3d1e1673d0083e5d770b64d0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectInRange>)))
  "Returns full string definition for message of type '<ObjectInRange>"
  (cl:format cl:nil "Header header~%bool object_in_range~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectInRange)))
  "Returns full string definition for message of type 'ObjectInRange"
  (cl:format cl:nil "Header header~%bool object_in_range~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectInRange>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectInRange>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectInRange
    (cl:cons ':header (header msg))
    (cl:cons ':object_in_range (object_in_range msg))
))
