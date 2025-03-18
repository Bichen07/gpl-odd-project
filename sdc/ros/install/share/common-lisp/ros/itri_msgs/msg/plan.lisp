; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude plan.msg.html

(cl:defclass <plan> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (bias
    :reader bias
    :initarg :bias
    :type cl:float
    :initform 0.0)
   (bias_rate
    :reader bias_rate
    :initarg :bias_rate
    :type cl:float
    :initform 0.0)
   (safe_distance
    :reader safe_distance
    :initarg :safe_distance
    :type cl:float
    :initform 0.0)
   (parking_start
    :reader parking_start
    :initarg :parking_start
    :type cl:boolean
    :initform cl:nil)
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0))
)

(cl:defclass plan (<plan>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <plan>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'plan)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<plan> is deprecated: use itri_msgs-msg:plan instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'bias-val :lambda-list '(m))
(cl:defmethod bias-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:bias-val is deprecated.  Use itri_msgs-msg:bias instead.")
  (bias m))

(cl:ensure-generic-function 'bias_rate-val :lambda-list '(m))
(cl:defmethod bias_rate-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:bias_rate-val is deprecated.  Use itri_msgs-msg:bias_rate instead.")
  (bias_rate m))

(cl:ensure-generic-function 'safe_distance-val :lambda-list '(m))
(cl:defmethod safe_distance-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:safe_distance-val is deprecated.  Use itri_msgs-msg:safe_distance instead.")
  (safe_distance m))

(cl:ensure-generic-function 'parking_start-val :lambda-list '(m))
(cl:defmethod parking_start-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parking_start-val is deprecated.  Use itri_msgs-msg:parking_start instead.")
  (parking_start m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <plan>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:type-val is deprecated.  Use itri_msgs-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<plan>)))
    "Constants for message type '<plan>"
  '((:OA . 0)
    (:BUS . 1)
    (:PARKING . 2)
    (:LC . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'plan)))
    "Constants for message type 'plan"
  '((:OA . 0)
    (:BUS . 1)
    (:PARKING . 2)
    (:LC . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <plan>) ostream)
  "Serializes a message object of type '<plan>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bias))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bias_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'safe_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'parking_start) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <plan>) istream)
  "Deserializes a message object of type '<plan>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bias) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bias_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'safe_distance) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'parking_start) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<plan>)))
  "Returns string type for a message object of type '<plan>"
  "itri_msgs/plan")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'plan)))
  "Returns string type for a message object of type 'plan"
  "itri_msgs/plan")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<plan>)))
  "Returns md5sum for a message object of type '<plan>"
  "4efb8b16e81fe1d48cfd91a5f58116e1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'plan)))
  "Returns md5sum for a message object of type 'plan"
  "4efb8b16e81fe1d48cfd91a5f58116e1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<plan>)))
  "Returns full string definition for message of type '<plan>"
  (cl:format cl:nil "Header header~%float32 bias~%float32 bias_rate~%float32 safe_distance~%bool parking_start~%~%uint8 OA = 0~%uint8 BUS = 1~%uint8 PARKING = 2~%uint8 LC = 3~%uint8 type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'plan)))
  "Returns full string definition for message of type 'plan"
  (cl:format cl:nil "Header header~%float32 bias~%float32 bias_rate~%float32 safe_distance~%bool parking_start~%~%uint8 OA = 0~%uint8 BUS = 1~%uint8 PARKING = 2~%uint8 LC = 3~%uint8 type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <plan>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <plan>))
  "Converts a ROS message object to a list"
  (cl:list 'plan
    (cl:cons ':header (header msg))
    (cl:cons ':bias (bias msg))
    (cl:cons ':bias_rate (bias_rate msg))
    (cl:cons ':safe_distance (safe_distance msg))
    (cl:cons ':parking_start (parking_start msg))
    (cl:cons ':type (type msg))
))
