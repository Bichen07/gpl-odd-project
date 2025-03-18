; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ProgramOutput.msg.html

(cl:defclass <ProgramOutput> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (output
    :reader output
    :initarg :output
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass ProgramOutput (<ProgramOutput>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProgramOutput>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProgramOutput)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ProgramOutput> is deprecated: use itri_msgs-msg:ProgramOutput instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ProgramOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <ProgramOutput>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:output-val is deprecated.  Use itri_msgs-msg:output instead.")
  (output m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProgramOutput>) ostream)
  "Serializes a message object of type '<ProgramOutput>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'output))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'output))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProgramOutput>) istream)
  "Deserializes a message object of type '<ProgramOutput>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'output) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'output)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProgramOutput>)))
  "Returns string type for a message object of type '<ProgramOutput>"
  "itri_msgs/ProgramOutput")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProgramOutput)))
  "Returns string type for a message object of type 'ProgramOutput"
  "itri_msgs/ProgramOutput")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProgramOutput>)))
  "Returns md5sum for a message object of type '<ProgramOutput>"
  "a0307b07c162469a5f8993c1679034b8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProgramOutput)))
  "Returns md5sum for a message object of type 'ProgramOutput"
  "a0307b07c162469a5f8993c1679034b8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProgramOutput>)))
  "Returns full string definition for message of type '<ProgramOutput>"
  (cl:format cl:nil "Header header~%char[] output~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProgramOutput)))
  "Returns full string definition for message of type 'ProgramOutput"
  (cl:format cl:nil "Header header~%char[] output~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProgramOutput>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'output) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProgramOutput>))
  "Converts a ROS message object to a list"
  (cl:list 'ProgramOutput
    (cl:cons ':header (header msg))
    (cl:cons ':output (output msg))
))
