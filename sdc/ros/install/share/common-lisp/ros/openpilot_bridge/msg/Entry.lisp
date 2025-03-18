; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Entry.msg.html

(cl:defclass <Entry> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (value
    :reader value
    :initarg :value
    :type cl:string
    :initform "")
   (key
    :reader key
    :initarg :key
    :type cl:string
    :initform ""))
)

(cl:defclass Entry (<Entry>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Entry>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Entry)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Entry> is deprecated: use openpilot_bridge-msg:Entry instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Entry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <Entry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:value-val is deprecated.  Use openpilot_bridge-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'key-val :lambda-list '(m))
(cl:defmethod key-val ((m <Entry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:key-val is deprecated.  Use openpilot_bridge-msg:key instead.")
  (key m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Entry>) ostream)
  "Serializes a message object of type '<Entry>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'value))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'key))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'key))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Entry>) istream)
  "Deserializes a message object of type '<Entry>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'key) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'key) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Entry>)))
  "Returns string type for a message object of type '<Entry>"
  "openpilot_bridge/Entry")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Entry)))
  "Returns string type for a message object of type 'Entry"
  "openpilot_bridge/Entry")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Entry>)))
  "Returns md5sum for a message object of type '<Entry>"
  "c96b3d5eb32e99f751779f00e5ab98f6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Entry)))
  "Returns md5sum for a message object of type 'Entry"
  "c96b3d5eb32e99f751779f00e5ab98f6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Entry>)))
  "Returns full string definition for message of type '<Entry>"
  (cl:format cl:nil "Header header~%~%string value~%string key~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Entry)))
  "Returns full string definition for message of type 'Entry"
  (cl:format cl:nil "Header header~%~%string value~%string key~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Entry>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'value))
     4 (cl:length (cl:slot-value msg 'key))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Entry>))
  "Converts a ROS message object to a list"
  (cl:list 'Entry
    (cl:cons ':header (header msg))
    (cl:cons ':value (value msg))
    (cl:cons ':key (key msg))
))
