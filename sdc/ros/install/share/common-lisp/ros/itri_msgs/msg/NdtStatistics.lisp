; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude NdtStatistics.msg.html

(cl:defclass <NdtStatistics> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (execution_time
    :reader execution_time
    :initarg :execution_time
    :type cl:float
    :initform 0.0)
   (fitness_score
    :reader fitness_score
    :initarg :fitness_score
    :type cl:float
    :initform 0.0)
   (fitness_score_valid
    :reader fitness_score_valid
    :initarg :fitness_score_valid
    :type cl:float
    :initform 0.0)
   (invalid_points_number
    :reader invalid_points_number
    :initarg :invalid_points_number
    :type cl:integer
    :initform 0)
   (iteration
    :reader iteration
    :initarg :iteration
    :type cl:integer
    :initform 0)
   (map_coverage
    :reader map_coverage
    :initarg :map_coverage
    :type cl:float
    :initform 0.0)
   (matching_score
    :reader matching_score
    :initarg :matching_score
    :type cl:float
    :initform 0.0)
   (matching_score_valid
    :reader matching_score_valid
    :initarg :matching_score_valid
    :type cl:float
    :initform 0.0)
   (regulate_matching_score
    :reader regulate_matching_score
    :initarg :regulate_matching_score
    :type cl:float
    :initform 0.0)
   (scan_valid_ratio
    :reader scan_valid_ratio
    :initarg :scan_valid_ratio
    :type cl:integer
    :initform 0)
   (source_points_number
    :reader source_points_number
    :initarg :source_points_number
    :type cl:integer
    :initform 0)
   (valid_points_number
    :reader valid_points_number
    :initarg :valid_points_number
    :type cl:integer
    :initform 0))
)

(cl:defclass NdtStatistics (<NdtStatistics>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NdtStatistics>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NdtStatistics)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<NdtStatistics> is deprecated: use itri_msgs-msg:NdtStatistics instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'execution_time-val :lambda-list '(m))
(cl:defmethod execution_time-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:execution_time-val is deprecated.  Use itri_msgs-msg:execution_time instead.")
  (execution_time m))

(cl:ensure-generic-function 'fitness_score-val :lambda-list '(m))
(cl:defmethod fitness_score-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:fitness_score-val is deprecated.  Use itri_msgs-msg:fitness_score instead.")
  (fitness_score m))

(cl:ensure-generic-function 'fitness_score_valid-val :lambda-list '(m))
(cl:defmethod fitness_score_valid-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:fitness_score_valid-val is deprecated.  Use itri_msgs-msg:fitness_score_valid instead.")
  (fitness_score_valid m))

(cl:ensure-generic-function 'invalid_points_number-val :lambda-list '(m))
(cl:defmethod invalid_points_number-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:invalid_points_number-val is deprecated.  Use itri_msgs-msg:invalid_points_number instead.")
  (invalid_points_number m))

(cl:ensure-generic-function 'iteration-val :lambda-list '(m))
(cl:defmethod iteration-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:iteration-val is deprecated.  Use itri_msgs-msg:iteration instead.")
  (iteration m))

(cl:ensure-generic-function 'map_coverage-val :lambda-list '(m))
(cl:defmethod map_coverage-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:map_coverage-val is deprecated.  Use itri_msgs-msg:map_coverage instead.")
  (map_coverage m))

(cl:ensure-generic-function 'matching_score-val :lambda-list '(m))
(cl:defmethod matching_score-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:matching_score-val is deprecated.  Use itri_msgs-msg:matching_score instead.")
  (matching_score m))

(cl:ensure-generic-function 'matching_score_valid-val :lambda-list '(m))
(cl:defmethod matching_score_valid-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:matching_score_valid-val is deprecated.  Use itri_msgs-msg:matching_score_valid instead.")
  (matching_score_valid m))

(cl:ensure-generic-function 'regulate_matching_score-val :lambda-list '(m))
(cl:defmethod regulate_matching_score-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:regulate_matching_score-val is deprecated.  Use itri_msgs-msg:regulate_matching_score instead.")
  (regulate_matching_score m))

(cl:ensure-generic-function 'scan_valid_ratio-val :lambda-list '(m))
(cl:defmethod scan_valid_ratio-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:scan_valid_ratio-val is deprecated.  Use itri_msgs-msg:scan_valid_ratio instead.")
  (scan_valid_ratio m))

(cl:ensure-generic-function 'source_points_number-val :lambda-list '(m))
(cl:defmethod source_points_number-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:source_points_number-val is deprecated.  Use itri_msgs-msg:source_points_number instead.")
  (source_points_number m))

(cl:ensure-generic-function 'valid_points_number-val :lambda-list '(m))
(cl:defmethod valid_points_number-val ((m <NdtStatistics>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:valid_points_number-val is deprecated.  Use itri_msgs-msg:valid_points_number instead.")
  (valid_points_number m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NdtStatistics>) ostream)
  "Serializes a message object of type '<NdtStatistics>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'execution_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fitness_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fitness_score_valid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'invalid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'invalid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'invalid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'invalid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'iteration)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'iteration)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'iteration)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'iteration)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'map_coverage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'matching_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'matching_score_valid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'regulate_matching_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'scan_valid_ratio)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'scan_valid_ratio)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'scan_valid_ratio)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'scan_valid_ratio)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'valid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'valid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'valid_points_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'valid_points_number)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NdtStatistics>) istream)
  "Deserializes a message object of type '<NdtStatistics>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'execution_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fitness_score) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fitness_score_valid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'invalid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'invalid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'invalid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'invalid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'iteration)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'iteration)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'iteration)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'iteration)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'map_coverage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'matching_score) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'matching_score_valid) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'regulate_matching_score) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'scan_valid_ratio)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'scan_valid_ratio)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'scan_valid_ratio)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'scan_valid_ratio)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'source_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'source_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'source_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'source_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'valid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'valid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'valid_points_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'valid_points_number)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NdtStatistics>)))
  "Returns string type for a message object of type '<NdtStatistics>"
  "itri_msgs/NdtStatistics")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NdtStatistics)))
  "Returns string type for a message object of type 'NdtStatistics"
  "itri_msgs/NdtStatistics")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NdtStatistics>)))
  "Returns md5sum for a message object of type '<NdtStatistics>"
  "b21481a49aaae81584b34de5ce8cef65")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NdtStatistics)))
  "Returns md5sum for a message object of type 'NdtStatistics"
  "b21481a49aaae81584b34de5ce8cef65")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NdtStatistics>)))
  "Returns full string definition for message of type '<NdtStatistics>"
  (cl:format cl:nil "Header header~%~%float32 execution_time~%float32 fitness_score~%float32 fitness_score_valid~%uint32 invalid_points_number~%uint32 iteration~%float32 map_coverage~%float32 matching_score~%float32 matching_score_valid~%float32 regulate_matching_score~%uint32 scan_valid_ratio~%uint32 source_points_number~%uint32 valid_points_number~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NdtStatistics)))
  "Returns full string definition for message of type 'NdtStatistics"
  (cl:format cl:nil "Header header~%~%float32 execution_time~%float32 fitness_score~%float32 fitness_score_valid~%uint32 invalid_points_number~%uint32 iteration~%float32 map_coverage~%float32 matching_score~%float32 matching_score_valid~%float32 regulate_matching_score~%uint32 scan_valid_ratio~%uint32 source_points_number~%uint32 valid_points_number~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NdtStatistics>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NdtStatistics>))
  "Converts a ROS message object to a list"
  (cl:list 'NdtStatistics
    (cl:cons ':header (header msg))
    (cl:cons ':execution_time (execution_time msg))
    (cl:cons ':fitness_score (fitness_score msg))
    (cl:cons ':fitness_score_valid (fitness_score_valid msg))
    (cl:cons ':invalid_points_number (invalid_points_number msg))
    (cl:cons ':iteration (iteration msg))
    (cl:cons ':map_coverage (map_coverage msg))
    (cl:cons ':matching_score (matching_score msg))
    (cl:cons ':matching_score_valid (matching_score_valid msg))
    (cl:cons ':regulate_matching_score (regulate_matching_score msg))
    (cl:cons ':scan_valid_ratio (scan_valid_ratio msg))
    (cl:cons ':source_points_number (source_points_number msg))
    (cl:cons ':valid_points_number (valid_points_number msg))
))
