; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude VoxelGridFilterInfo.msg.html

(cl:defclass <VoxelGridFilterInfo> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (filter_name
    :reader filter_name
    :initarg :filter_name
    :type cl:string
    :initform "")
   (measurement_range
    :reader measurement_range
    :initarg :measurement_range
    :type cl:float
    :initform 0.0)
   (original_points_size
    :reader original_points_size
    :initarg :original_points_size
    :type cl:integer
    :initform 0)
   (filtered_points_size
    :reader filtered_points_size
    :initarg :filtered_points_size
    :type cl:integer
    :initform 0)
   (execution_time
    :reader execution_time
    :initarg :execution_time
    :type cl:float
    :initform 0.0))
)

(cl:defclass VoxelGridFilterInfo (<VoxelGridFilterInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VoxelGridFilterInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VoxelGridFilterInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<VoxelGridFilterInfo> is deprecated: use itri_msgs-msg:VoxelGridFilterInfo instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'filter_name-val :lambda-list '(m))
(cl:defmethod filter_name-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:filter_name-val is deprecated.  Use itri_msgs-msg:filter_name instead.")
  (filter_name m))

(cl:ensure-generic-function 'measurement_range-val :lambda-list '(m))
(cl:defmethod measurement_range-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:measurement_range-val is deprecated.  Use itri_msgs-msg:measurement_range instead.")
  (measurement_range m))

(cl:ensure-generic-function 'original_points_size-val :lambda-list '(m))
(cl:defmethod original_points_size-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:original_points_size-val is deprecated.  Use itri_msgs-msg:original_points_size instead.")
  (original_points_size m))

(cl:ensure-generic-function 'filtered_points_size-val :lambda-list '(m))
(cl:defmethod filtered_points_size-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:filtered_points_size-val is deprecated.  Use itri_msgs-msg:filtered_points_size instead.")
  (filtered_points_size m))

(cl:ensure-generic-function 'execution_time-val :lambda-list '(m))
(cl:defmethod execution_time-val ((m <VoxelGridFilterInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:execution_time-val is deprecated.  Use itri_msgs-msg:execution_time instead.")
  (execution_time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VoxelGridFilterInfo>) ostream)
  "Serializes a message object of type '<VoxelGridFilterInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'filter_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'filter_name))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'measurement_range))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'original_points_size)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'filtered_points_size)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VoxelGridFilterInfo>) istream)
  "Deserializes a message object of type '<VoxelGridFilterInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filter_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'filter_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'measurement_range) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'original_points_size) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filtered_points_size) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'execution_time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VoxelGridFilterInfo>)))
  "Returns string type for a message object of type '<VoxelGridFilterInfo>"
  "itri_msgs/VoxelGridFilterInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VoxelGridFilterInfo)))
  "Returns string type for a message object of type 'VoxelGridFilterInfo"
  "itri_msgs/VoxelGridFilterInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VoxelGridFilterInfo>)))
  "Returns md5sum for a message object of type '<VoxelGridFilterInfo>"
  "a1652d8ba147b439694fc6c6bce138b7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VoxelGridFilterInfo)))
  "Returns md5sum for a message object of type 'VoxelGridFilterInfo"
  "a1652d8ba147b439694fc6c6bce138b7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VoxelGridFilterInfo>)))
  "Returns full string definition for message of type '<VoxelGridFilterInfo>"
  (cl:format cl:nil "Header header~%string filter_name~%float32 measurement_range~%int32 original_points_size~%int32 filtered_points_size~%float32 execution_time~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VoxelGridFilterInfo)))
  "Returns full string definition for message of type 'VoxelGridFilterInfo"
  (cl:format cl:nil "Header header~%string filter_name~%float32 measurement_range~%int32 original_points_size~%int32 filtered_points_size~%float32 execution_time~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VoxelGridFilterInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:length (cl:slot-value msg 'filter_name))
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VoxelGridFilterInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'VoxelGridFilterInfo
    (cl:cons ':header (header msg))
    (cl:cons ':filter_name (filter_name msg))
    (cl:cons ':measurement_range (measurement_range msg))
    (cl:cons ':original_points_size (original_points_size msg))
    (cl:cons ':filtered_points_size (filtered_points_size msg))
    (cl:cons ':execution_time (execution_time msg))
))
