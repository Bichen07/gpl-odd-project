; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude LaneCenter.msg.html

(cl:defclass <LaneCenter> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (c0
    :reader c0
    :initarg :c0
    :type cl:float
    :initform 0.0)
   (c1
    :reader c1
    :initarg :c1
    :type cl:float
    :initform 0.0)
   (c2
    :reader c2
    :initarg :c2
    :type cl:float
    :initform 0.0)
   (confidentScore
    :reader confidentScore
    :initarg :confidentScore
    :type cl:fixnum
    :initform 0)
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0))
)

(cl:defclass LaneCenter (<LaneCenter>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneCenter>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneCenter)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<LaneCenter> is deprecated: use itri_msgs-msg:LaneCenter instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'c0-val :lambda-list '(m))
(cl:defmethod c0-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:c0-val is deprecated.  Use itri_msgs-msg:c0 instead.")
  (c0 m))

(cl:ensure-generic-function 'c1-val :lambda-list '(m))
(cl:defmethod c1-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:c1-val is deprecated.  Use itri_msgs-msg:c1 instead.")
  (c1 m))

(cl:ensure-generic-function 'c2-val :lambda-list '(m))
(cl:defmethod c2-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:c2-val is deprecated.  Use itri_msgs-msg:c2 instead.")
  (c2 m))

(cl:ensure-generic-function 'confidentScore-val :lambda-list '(m))
(cl:defmethod confidentScore-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:confidentScore-val is deprecated.  Use itri_msgs-msg:confidentScore instead.")
  (confidentScore m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <LaneCenter>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:distance-val is deprecated.  Use itri_msgs-msg:distance instead.")
  (distance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneCenter>) ostream)
  "Serializes a message object of type '<LaneCenter>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'c0))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'c1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'c2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'confidentScore)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'confidentScore)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneCenter>) istream)
  "Deserializes a message object of type '<LaneCenter>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'c0) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'c1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'c2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'confidentScore)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'confidentScore)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneCenter>)))
  "Returns string type for a message object of type '<LaneCenter>"
  "itri_msgs/LaneCenter")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneCenter)))
  "Returns string type for a message object of type 'LaneCenter"
  "itri_msgs/LaneCenter")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneCenter>)))
  "Returns md5sum for a message object of type '<LaneCenter>"
  "38aa69826866b610620ed64a00faddfa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneCenter)))
  "Returns md5sum for a message object of type 'LaneCenter"
  "38aa69826866b610620ed64a00faddfa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneCenter>)))
  "Returns full string definition for message of type '<LaneCenter>"
  (cl:format cl:nil "std_msgs/Header header~%float32 c0~%float32 c1~%float32 c2~%~%uint16 confidentScore~%float32 distance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneCenter)))
  "Returns full string definition for message of type 'LaneCenter"
  (cl:format cl:nil "std_msgs/Header header~%float32 c0~%float32 c1~%float32 c2~%~%uint16 confidentScore~%float32 distance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneCenter>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     2
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneCenter>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneCenter
    (cl:cons ':header (header msg))
    (cl:cons ':c0 (c0 msg))
    (cl:cons ':c1 (c1 msg))
    (cl:cons ':c2 (c2 msg))
    (cl:cons ':confidentScore (confidentScore msg))
    (cl:cons ':distance (distance msg))
))
