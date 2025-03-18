; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude OpenPilotLine.msg.html

(cl:defclass <OpenPilotLine> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (probability
    :reader probability
    :initarg :probability
    :type cl:fixnum
    :initform 0)
   (coefficient
    :reader coefficient
    :initarg :coefficient
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass OpenPilotLine (<OpenPilotLine>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OpenPilotLine>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OpenPilotLine)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<OpenPilotLine> is deprecated: use itri_msgs-msg:OpenPilotLine instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <OpenPilotLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'probability-val :lambda-list '(m))
(cl:defmethod probability-val ((m <OpenPilotLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:probability-val is deprecated.  Use itri_msgs-msg:probability instead.")
  (probability m))

(cl:ensure-generic-function 'coefficient-val :lambda-list '(m))
(cl:defmethod coefficient-val ((m <OpenPilotLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:coefficient-val is deprecated.  Use itri_msgs-msg:coefficient instead.")
  (coefficient m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OpenPilotLine>) ostream)
  "Serializes a message object of type '<OpenPilotLine>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'probability)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'coefficient))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'coefficient))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OpenPilotLine>) istream)
  "Deserializes a message object of type '<OpenPilotLine>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'probability)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'coefficient) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'coefficient)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OpenPilotLine>)))
  "Returns string type for a message object of type '<OpenPilotLine>"
  "itri_msgs/OpenPilotLine")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OpenPilotLine)))
  "Returns string type for a message object of type 'OpenPilotLine"
  "itri_msgs/OpenPilotLine")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OpenPilotLine>)))
  "Returns md5sum for a message object of type '<OpenPilotLine>"
  "97d974b7382eef820389ec52864575e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OpenPilotLine)))
  "Returns md5sum for a message object of type 'OpenPilotLine"
  "97d974b7382eef820389ec52864575e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OpenPilotLine>)))
  "Returns full string definition for message of type '<OpenPilotLine>"
  (cl:format cl:nil "std_msgs/Header header~%~%uint8 probability~%float32[] coefficient~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OpenPilotLine)))
  "Returns full string definition for message of type 'OpenPilotLine"
  (cl:format cl:nil "std_msgs/Header header~%~%uint8 probability~%float32[] coefficient~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OpenPilotLine>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'coefficient) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OpenPilotLine>))
  "Converts a ROS message object to a list"
  (cl:list 'OpenPilotLine
    (cl:cons ':header (header msg))
    (cl:cons ':probability (probability msg))
    (cl:cons ':coefficient (coefficient msg))
))
