; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EsrStatus.msg.html

(cl:defclass <EsrStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (esr_curvature
    :reader esr_curvature
    :initarg :esr_curvature
    :type cl:fixnum
    :initform 0)
   (esr_yaw_rate
    :reader esr_yaw_rate
    :initarg :esr_yaw_rate
    :type cl:float
    :initform 0.0)
   (esr_vehicle_speed
    :reader esr_vehicle_speed
    :initarg :esr_vehicle_speed
    :type cl:float
    :initform 0.0)
   (esr_max_track_targets
    :reader esr_max_track_targets
    :initarg :esr_max_track_targets
    :type cl:fixnum
    :initform 0)
   (esr_power_mode
    :reader esr_power_mode
    :initarg :esr_power_mode
    :type cl:fixnum
    :initform 0)
   (esr_mr_lr_mode
    :reader esr_mr_lr_mode
    :initarg :esr_mr_lr_mode
    :type cl:fixnum
    :initform 0)
   (esr_grouping_mode
    :reader esr_grouping_mode
    :initarg :esr_grouping_mode
    :type cl:fixnum
    :initform 0)
   (esr_temperature
    :reader esr_temperature
    :initarg :esr_temperature
    :type cl:fixnum
    :initform 0)
   (esr_scan_id
    :reader esr_scan_id
    :initarg :esr_scan_id
    :type cl:fixnum
    :initform 0)
   (esr_raw_data_mode
    :reader esr_raw_data_mode
    :initarg :esr_raw_data_mode
    :type cl:boolean
    :initform cl:nil)
   (esr_partial_blockage
    :reader esr_partial_blockage
    :initarg :esr_partial_blockage
    :type cl:boolean
    :initform cl:nil)
   (esr_side_lobe_blockage
    :reader esr_side_lobe_blockage
    :initarg :esr_side_lobe_blockage
    :type cl:boolean
    :initform cl:nil)
   (esr_found_target
    :reader esr_found_target
    :initarg :esr_found_target
    :type cl:boolean
    :initform cl:nil)
   (esr_comm_error
    :reader esr_comm_error
    :initarg :esr_comm_error
    :type cl:boolean
    :initform cl:nil)
   (esr_overheat_error
    :reader esr_overheat_error
    :initarg :esr_overheat_error
    :type cl:boolean
    :initform cl:nil)
   (esr_range_perf_error
    :reader esr_range_perf_error
    :initarg :esr_range_perf_error
    :type cl:boolean
    :initform cl:nil)
   (esr_internal_error
    :reader esr_internal_error
    :initarg :esr_internal_error
    :type cl:boolean
    :initform cl:nil)
   (esr_xcvr_operational
    :reader esr_xcvr_operational
    :initarg :esr_xcvr_operational
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass EsrStatus (<EsrStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsrStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsrStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EsrStatus> is deprecated: use itri_msgs-msg:EsrStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'esr_curvature-val :lambda-list '(m))
(cl:defmethod esr_curvature-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_curvature-val is deprecated.  Use itri_msgs-msg:esr_curvature instead.")
  (esr_curvature m))

(cl:ensure-generic-function 'esr_yaw_rate-val :lambda-list '(m))
(cl:defmethod esr_yaw_rate-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_yaw_rate-val is deprecated.  Use itri_msgs-msg:esr_yaw_rate instead.")
  (esr_yaw_rate m))

(cl:ensure-generic-function 'esr_vehicle_speed-val :lambda-list '(m))
(cl:defmethod esr_vehicle_speed-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_vehicle_speed-val is deprecated.  Use itri_msgs-msg:esr_vehicle_speed instead.")
  (esr_vehicle_speed m))

(cl:ensure-generic-function 'esr_max_track_targets-val :lambda-list '(m))
(cl:defmethod esr_max_track_targets-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_max_track_targets-val is deprecated.  Use itri_msgs-msg:esr_max_track_targets instead.")
  (esr_max_track_targets m))

(cl:ensure-generic-function 'esr_power_mode-val :lambda-list '(m))
(cl:defmethod esr_power_mode-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_power_mode-val is deprecated.  Use itri_msgs-msg:esr_power_mode instead.")
  (esr_power_mode m))

(cl:ensure-generic-function 'esr_mr_lr_mode-val :lambda-list '(m))
(cl:defmethod esr_mr_lr_mode-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_mr_lr_mode-val is deprecated.  Use itri_msgs-msg:esr_mr_lr_mode instead.")
  (esr_mr_lr_mode m))

(cl:ensure-generic-function 'esr_grouping_mode-val :lambda-list '(m))
(cl:defmethod esr_grouping_mode-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_grouping_mode-val is deprecated.  Use itri_msgs-msg:esr_grouping_mode instead.")
  (esr_grouping_mode m))

(cl:ensure-generic-function 'esr_temperature-val :lambda-list '(m))
(cl:defmethod esr_temperature-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_temperature-val is deprecated.  Use itri_msgs-msg:esr_temperature instead.")
  (esr_temperature m))

(cl:ensure-generic-function 'esr_scan_id-val :lambda-list '(m))
(cl:defmethod esr_scan_id-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_scan_id-val is deprecated.  Use itri_msgs-msg:esr_scan_id instead.")
  (esr_scan_id m))

(cl:ensure-generic-function 'esr_raw_data_mode-val :lambda-list '(m))
(cl:defmethod esr_raw_data_mode-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_raw_data_mode-val is deprecated.  Use itri_msgs-msg:esr_raw_data_mode instead.")
  (esr_raw_data_mode m))

(cl:ensure-generic-function 'esr_partial_blockage-val :lambda-list '(m))
(cl:defmethod esr_partial_blockage-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_partial_blockage-val is deprecated.  Use itri_msgs-msg:esr_partial_blockage instead.")
  (esr_partial_blockage m))

(cl:ensure-generic-function 'esr_side_lobe_blockage-val :lambda-list '(m))
(cl:defmethod esr_side_lobe_blockage-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_side_lobe_blockage-val is deprecated.  Use itri_msgs-msg:esr_side_lobe_blockage instead.")
  (esr_side_lobe_blockage m))

(cl:ensure-generic-function 'esr_found_target-val :lambda-list '(m))
(cl:defmethod esr_found_target-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_found_target-val is deprecated.  Use itri_msgs-msg:esr_found_target instead.")
  (esr_found_target m))

(cl:ensure-generic-function 'esr_comm_error-val :lambda-list '(m))
(cl:defmethod esr_comm_error-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_comm_error-val is deprecated.  Use itri_msgs-msg:esr_comm_error instead.")
  (esr_comm_error m))

(cl:ensure-generic-function 'esr_overheat_error-val :lambda-list '(m))
(cl:defmethod esr_overheat_error-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_overheat_error-val is deprecated.  Use itri_msgs-msg:esr_overheat_error instead.")
  (esr_overheat_error m))

(cl:ensure-generic-function 'esr_range_perf_error-val :lambda-list '(m))
(cl:defmethod esr_range_perf_error-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_range_perf_error-val is deprecated.  Use itri_msgs-msg:esr_range_perf_error instead.")
  (esr_range_perf_error m))

(cl:ensure-generic-function 'esr_internal_error-val :lambda-list '(m))
(cl:defmethod esr_internal_error-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_internal_error-val is deprecated.  Use itri_msgs-msg:esr_internal_error instead.")
  (esr_internal_error m))

(cl:ensure-generic-function 'esr_xcvr_operational-val :lambda-list '(m))
(cl:defmethod esr_xcvr_operational-val ((m <EsrStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:esr_xcvr_operational-val is deprecated.  Use itri_msgs-msg:esr_xcvr_operational instead.")
  (esr_xcvr_operational m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsrStatus>) ostream)
  "Serializes a message object of type '<EsrStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'esr_curvature)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'esr_yaw_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'esr_vehicle_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_max_track_targets)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_power_mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_mr_lr_mode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_grouping_mode)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'esr_temperature)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_scan_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_raw_data_mode) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_partial_blockage) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_side_lobe_blockage) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_found_target) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_comm_error) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_overheat_error) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_range_perf_error) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_internal_error) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'esr_xcvr_operational) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsrStatus>) istream)
  "Deserializes a message object of type '<EsrStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'esr_curvature) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'esr_yaw_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'esr_vehicle_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_max_track_targets)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_power_mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_mr_lr_mode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_grouping_mode)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'esr_temperature) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'esr_scan_id)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'esr_raw_data_mode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_partial_blockage) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_side_lobe_blockage) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_found_target) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_comm_error) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_overheat_error) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_range_perf_error) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_internal_error) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'esr_xcvr_operational) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsrStatus>)))
  "Returns string type for a message object of type '<EsrStatus>"
  "itri_msgs/EsrStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsrStatus)))
  "Returns string type for a message object of type 'EsrStatus"
  "itri_msgs/EsrStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsrStatus>)))
  "Returns md5sum for a message object of type '<EsrStatus>"
  "6576074bb36351e24411f4c33b02aeac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsrStatus)))
  "Returns md5sum for a message object of type 'EsrStatus"
  "6576074bb36351e24411f4c33b02aeac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsrStatus>)))
  "Returns full string definition for message of type '<EsrStatus>"
  (cl:format cl:nil "Header header~%int16 esr_curvature~%float32 esr_yaw_rate~%float32 esr_vehicle_speed~%uint8 esr_max_track_targets~%uint8 esr_power_mode~%uint8 esr_mr_lr_mode~%uint8 esr_grouping_mode~%int8 esr_temperature~%uint8 esr_scan_id~%bool esr_raw_data_mode~%bool esr_partial_blockage~%bool esr_side_lobe_blockage~%bool esr_found_target~%bool esr_comm_error~%bool esr_overheat_error~%bool esr_range_perf_error~%bool esr_internal_error~%bool esr_xcvr_operational~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsrStatus)))
  "Returns full string definition for message of type 'EsrStatus"
  (cl:format cl:nil "Header header~%int16 esr_curvature~%float32 esr_yaw_rate~%float32 esr_vehicle_speed~%uint8 esr_max_track_targets~%uint8 esr_power_mode~%uint8 esr_mr_lr_mode~%uint8 esr_grouping_mode~%int8 esr_temperature~%uint8 esr_scan_id~%bool esr_raw_data_mode~%bool esr_partial_blockage~%bool esr_side_lobe_blockage~%bool esr_found_target~%bool esr_comm_error~%bool esr_overheat_error~%bool esr_range_perf_error~%bool esr_internal_error~%bool esr_xcvr_operational~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsrStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     2
     4
     4
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsrStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'EsrStatus
    (cl:cons ':header (header msg))
    (cl:cons ':esr_curvature (esr_curvature msg))
    (cl:cons ':esr_yaw_rate (esr_yaw_rate msg))
    (cl:cons ':esr_vehicle_speed (esr_vehicle_speed msg))
    (cl:cons ':esr_max_track_targets (esr_max_track_targets msg))
    (cl:cons ':esr_power_mode (esr_power_mode msg))
    (cl:cons ':esr_mr_lr_mode (esr_mr_lr_mode msg))
    (cl:cons ':esr_grouping_mode (esr_grouping_mode msg))
    (cl:cons ':esr_temperature (esr_temperature msg))
    (cl:cons ':esr_scan_id (esr_scan_id msg))
    (cl:cons ':esr_raw_data_mode (esr_raw_data_mode msg))
    (cl:cons ':esr_partial_blockage (esr_partial_blockage msg))
    (cl:cons ':esr_side_lobe_blockage (esr_side_lobe_blockage msg))
    (cl:cons ':esr_found_target (esr_found_target msg))
    (cl:cons ':esr_comm_error (esr_comm_error msg))
    (cl:cons ':esr_overheat_error (esr_overheat_error msg))
    (cl:cons ':esr_range_perf_error (esr_range_perf_error msg))
    (cl:cons ':esr_internal_error (esr_internal_error msg))
    (cl:cons ':esr_xcvr_operational (esr_xcvr_operational msg))
))
