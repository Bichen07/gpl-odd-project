; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude DetectedObjectCovariance.msg.html

(cl:defclass <DetectedObjectCovariance> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (valueX
    :reader valueX
    :initarg :valueX
    :type cl:float
    :initform 0.0)
   (valueY
    :reader valueY
    :initarg :valueY
    :type cl:float
    :initform 0.0))
)

(cl:defclass DetectedObjectCovariance (<DetectedObjectCovariance>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedObjectCovariance>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedObjectCovariance)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<DetectedObjectCovariance> is deprecated: use itri_msgs-msg:DetectedObjectCovariance instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DetectedObjectCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <DetectedObjectCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'valueX-val :lambda-list '(m))
(cl:defmethod valueX-val ((m <DetectedObjectCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:valueX-val is deprecated.  Use itri_msgs-msg:valueX instead.")
  (valueX m))

(cl:ensure-generic-function 'valueY-val :lambda-list '(m))
(cl:defmethod valueY-val ((m <DetectedObjectCovariance>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:valueY-val is deprecated.  Use itri_msgs-msg:valueY instead.")
  (valueY m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedObjectCovariance>) ostream)
  "Serializes a message object of type '<DetectedObjectCovariance>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'valueX))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'valueY))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedObjectCovariance>) istream)
  "Deserializes a message object of type '<DetectedObjectCovariance>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'valueX) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'valueY) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedObjectCovariance>)))
  "Returns string type for a message object of type '<DetectedObjectCovariance>"
  "itri_msgs/DetectedObjectCovariance")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedObjectCovariance)))
  "Returns string type for a message object of type 'DetectedObjectCovariance"
  "itri_msgs/DetectedObjectCovariance")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedObjectCovariance>)))
  "Returns md5sum for a message object of type '<DetectedObjectCovariance>"
  "a28f36689e9da040bab82e53c9916f8c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedObjectCovariance)))
  "Returns md5sum for a message object of type 'DetectedObjectCovariance"
  "a28f36689e9da040bab82e53c9916f8c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedObjectCovariance>)))
  "Returns full string definition for message of type '<DetectedObjectCovariance>"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 id~%float32 valueX~%float32 valueY~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedObjectCovariance)))
  "Returns full string definition for message of type 'DetectedObjectCovariance"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 id~%float32 valueX~%float32 valueY~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedObjectCovariance>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedObjectCovariance>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedObjectCovariance
    (cl:cons ':header (header msg))
    (cl:cons ':id (id msg))
    (cl:cons ':valueX (valueX msg))
    (cl:cons ':valueY (valueY msg))
))
