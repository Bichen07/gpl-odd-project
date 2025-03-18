; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude turn_signal_cmd.msg.html

(cl:defclass <turn_signal_cmd> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (turn_signal
    :reader turn_signal
    :initarg :turn_signal
    :type cl:fixnum
    :initform 0)
   (source
    :reader source
    :initarg :source
    :type cl:string
    :initform ""))
)

(cl:defclass turn_signal_cmd (<turn_signal_cmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <turn_signal_cmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'turn_signal_cmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<turn_signal_cmd> is deprecated: use itri_msgs-msg:turn_signal_cmd instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <turn_signal_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'turn_signal-val :lambda-list '(m))
(cl:defmethod turn_signal-val ((m <turn_signal_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:turn_signal-val is deprecated.  Use itri_msgs-msg:turn_signal instead.")
  (turn_signal m))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <turn_signal_cmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:source-val is deprecated.  Use itri_msgs-msg:source instead.")
  (source m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<turn_signal_cmd>)))
    "Constants for message type '<turn_signal_cmd>"
  '((:NONE . 0)
    (:LEFT . 1)
    (:RIGHT . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'turn_signal_cmd)))
    "Constants for message type 'turn_signal_cmd"
  '((:NONE . 0)
    (:LEFT . 1)
    (:RIGHT . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <turn_signal_cmd>) ostream)
  "Serializes a message object of type '<turn_signal_cmd>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'turn_signal)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'source))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'source))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <turn_signal_cmd>) istream)
  "Deserializes a message object of type '<turn_signal_cmd>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'turn_signal)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'source) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<turn_signal_cmd>)))
  "Returns string type for a message object of type '<turn_signal_cmd>"
  "itri_msgs/turn_signal_cmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'turn_signal_cmd)))
  "Returns string type for a message object of type 'turn_signal_cmd"
  "itri_msgs/turn_signal_cmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<turn_signal_cmd>)))
  "Returns md5sum for a message object of type '<turn_signal_cmd>"
  "2c84172b1f795dd07d42fd3f7cec332e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'turn_signal_cmd)))
  "Returns md5sum for a message object of type 'turn_signal_cmd"
  "2c84172b1f795dd07d42fd3f7cec332e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<turn_signal_cmd>)))
  "Returns full string definition for message of type '<turn_signal_cmd>"
  (cl:format cl:nil "Header header~%~%uint8 NONE = 0~%uint8 LEFT = 1~%uint8 RIGHT = 2~%~%uint8 turn_signal~%string source~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'turn_signal_cmd)))
  "Returns full string definition for message of type 'turn_signal_cmd"
  (cl:format cl:nil "Header header~%~%uint8 NONE = 0~%uint8 LEFT = 1~%uint8 RIGHT = 2~%~%uint8 turn_signal~%string source~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <turn_signal_cmd>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4 (cl:length (cl:slot-value msg 'source))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <turn_signal_cmd>))
  "Converts a ROS message object to a list"
  (cl:list 'turn_signal_cmd
    (cl:cons ':header (header msg))
    (cl:cons ':turn_signal (turn_signal msg))
    (cl:cons ':source (source msg))
))
