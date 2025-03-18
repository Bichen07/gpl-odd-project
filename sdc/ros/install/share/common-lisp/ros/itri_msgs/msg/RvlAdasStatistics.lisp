; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude RvlAdasStatistics.msg.html

(cl:defclass <RvlAdasStatistics> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (preProcessingTime
    :reader preProcessingTime
    :initarg :preProcessingTime
    :type cl:float
    :initform 0.0)
   (infernceTime
    :reader infernceTime
    :initarg :infernceTime
    :type cl:float
    :initform 0.0)
   (postProcessingTime
    :reader postProcessingTime
    :initarg :postProcessingTime
    :type cl:float
    :initform 0.0))
)

(cl:defclass RvlAdasStatistics (<RvlAdasStatistics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RvlAdasStatistics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RvlAdasStatistics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<RvlAdasStatistics> is deprecated: use itri_msgs-msg:RvlAdasStatistics instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RvlAdasStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'preProcessingTime-val :lambda-list '(m))
(cl:defmethod preProcessingTime-val ((m <RvlAdasStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:preProcessingTime-val is deprecated.  Use itri_msgs-msg:preProcessingTime instead.")
  (preProcessingTime m))

(cl:ensure-generic-function 'infernceTime-val :lambda-list '(m))
(cl:defmethod infernceTime-val ((m <RvlAdasStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:infernceTime-val is deprecated.  Use itri_msgs-msg:infernceTime instead.")
  (infernceTime m))

(cl:ensure-generic-function 'postProcessingTime-val :lambda-list '(m))
(cl:defmethod postProcessingTime-val ((m <RvlAdasStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:postProcessingTime-val is deprecated.  Use itri_msgs-msg:postProcessingTime instead.")
  (postProcessingTime m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RvlAdasStatistics>) ostream)
  "Serializes a message object of type '<RvlAdasStatistics>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'preProcessingTime))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'infernceTime))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'postProcessingTime))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RvlAdasStatistics>) istream)
  "Deserializes a message object of type '<RvlAdasStatistics>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'preProcessingTime) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'infernceTime) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'postProcessingTime) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RvlAdasStatistics>)))
  "Returns string type for a message object of type '<RvlAdasStatistics>"
  "itri_msgs/RvlAdasStatistics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RvlAdasStatistics)))
  "Returns string type for a message object of type 'RvlAdasStatistics"
  "itri_msgs/RvlAdasStatistics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RvlAdasStatistics>)))
  "Returns md5sum for a message object of type '<RvlAdasStatistics>"
  "f80e671674f1651c37ef74d50d290b0c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RvlAdasStatistics)))
  "Returns md5sum for a message object of type 'RvlAdasStatistics"
  "f80e671674f1651c37ef74d50d290b0c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RvlAdasStatistics>)))
  "Returns full string definition for message of type '<RvlAdasStatistics>"
  (cl:format cl:nil "Header header~%float32 preProcessingTime~%float32 infernceTime~%float32 postProcessingTime~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RvlAdasStatistics)))
  "Returns full string definition for message of type 'RvlAdasStatistics"
  (cl:format cl:nil "Header header~%float32 preProcessingTime~%float32 infernceTime~%float32 postProcessingTime~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RvlAdasStatistics>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RvlAdasStatistics>))
  "Converts a ROS message object to a list"
  (cl:list 'RvlAdasStatistics
    (cl:cons ':header (header msg))
    (cl:cons ':preProcessingTime (preProcessingTime msg))
    (cl:cons ':infernceTime (infernceTime msg))
    (cl:cons ':postProcessingTime (postProcessingTime msg))
))
