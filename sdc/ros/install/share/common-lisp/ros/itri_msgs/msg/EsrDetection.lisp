; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude EsrDetection.msg.html

(cl:defclass <EsrDetection> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (path_id_acc_stat
    :reader path_id_acc_stat
    :initarg :path_id_acc_stat
    :type cl:fixnum
    :initform 0)
   (path_id_acc
    :reader path_id_acc
    :initarg :path_id_acc
    :type cl:fixnum
    :initform 0)
   (path_id_cmbb_move
    :reader path_id_cmbb_move
    :initarg :path_id_cmbb_move
    :type cl:fixnum
    :initform 0)
   (path_id_cmbb_stat
    :reader path_id_cmbb_stat
    :initarg :path_id_cmbb_stat
    :type cl:fixnum
    :initform 0)
   (path_id_fcw_move
    :reader path_id_fcw_move
    :initarg :path_id_fcw_move
    :type cl:fixnum
    :initform 0)
   (path_id_fcw_stat
    :reader path_id_fcw_stat
    :initarg :path_id_fcw_stat
    :type cl:fixnum
    :initform 0)
   (water_spray_target_id
    :reader water_spray_target_id
    :initarg :water_spray_target_id
    :type cl:fixnum
    :initform 0)
   (filtered_xohp_acc_cipv
    :reader filtered_xohp_acc_cipv
    :initarg :filtered_xohp_acc_cipv
    :type cl:float
    :initform 0.0)
   (path_id_acc_2
    :reader path_id_acc_2
    :initarg :path_id_acc_2
    :type cl:fixnum
    :initform 0)
   (path_id_acc_3
    :reader path_id_acc_3
    :initarg :path_id_acc_3
    :type cl:fixnum
    :initform 0)
   (lr_only_grating_lobe_det
    :reader lr_only_grating_lobe_det
    :initarg :lr_only_grating_lobe_det
    :type cl:boolean
    :initform cl:nil)
   (truck_target_det
    :reader truck_target_det
    :initarg :truck_target_det
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass EsrDetection (<EsrDetection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EsrDetection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EsrDetection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<EsrDetection> is deprecated: use itri_msgs-msg:EsrDetection instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'path_id_acc_stat-val :lambda-list '(m))
(cl:defmethod path_id_acc_stat-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_acc_stat-val is deprecated.  Use itri_msgs-msg:path_id_acc_stat instead.")
  (path_id_acc_stat m))

(cl:ensure-generic-function 'path_id_acc-val :lambda-list '(m))
(cl:defmethod path_id_acc-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_acc-val is deprecated.  Use itri_msgs-msg:path_id_acc instead.")
  (path_id_acc m))

(cl:ensure-generic-function 'path_id_cmbb_move-val :lambda-list '(m))
(cl:defmethod path_id_cmbb_move-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_cmbb_move-val is deprecated.  Use itri_msgs-msg:path_id_cmbb_move instead.")
  (path_id_cmbb_move m))

(cl:ensure-generic-function 'path_id_cmbb_stat-val :lambda-list '(m))
(cl:defmethod path_id_cmbb_stat-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_cmbb_stat-val is deprecated.  Use itri_msgs-msg:path_id_cmbb_stat instead.")
  (path_id_cmbb_stat m))

(cl:ensure-generic-function 'path_id_fcw_move-val :lambda-list '(m))
(cl:defmethod path_id_fcw_move-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_fcw_move-val is deprecated.  Use itri_msgs-msg:path_id_fcw_move instead.")
  (path_id_fcw_move m))

(cl:ensure-generic-function 'path_id_fcw_stat-val :lambda-list '(m))
(cl:defmethod path_id_fcw_stat-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_fcw_stat-val is deprecated.  Use itri_msgs-msg:path_id_fcw_stat instead.")
  (path_id_fcw_stat m))

(cl:ensure-generic-function 'water_spray_target_id-val :lambda-list '(m))
(cl:defmethod water_spray_target_id-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:water_spray_target_id-val is deprecated.  Use itri_msgs-msg:water_spray_target_id instead.")
  (water_spray_target_id m))

(cl:ensure-generic-function 'filtered_xohp_acc_cipv-val :lambda-list '(m))
(cl:defmethod filtered_xohp_acc_cipv-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:filtered_xohp_acc_cipv-val is deprecated.  Use itri_msgs-msg:filtered_xohp_acc_cipv instead.")
  (filtered_xohp_acc_cipv m))

(cl:ensure-generic-function 'path_id_acc_2-val :lambda-list '(m))
(cl:defmethod path_id_acc_2-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_acc_2-val is deprecated.  Use itri_msgs-msg:path_id_acc_2 instead.")
  (path_id_acc_2 m))

(cl:ensure-generic-function 'path_id_acc_3-val :lambda-list '(m))
(cl:defmethod path_id_acc_3-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:path_id_acc_3-val is deprecated.  Use itri_msgs-msg:path_id_acc_3 instead.")
  (path_id_acc_3 m))

(cl:ensure-generic-function 'lr_only_grating_lobe_det-val :lambda-list '(m))
(cl:defmethod lr_only_grating_lobe_det-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:lr_only_grating_lobe_det-val is deprecated.  Use itri_msgs-msg:lr_only_grating_lobe_det instead.")
  (lr_only_grating_lobe_det m))

(cl:ensure-generic-function 'truck_target_det-val :lambda-list '(m))
(cl:defmethod truck_target_det-val ((m <EsrDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:truck_target_det-val is deprecated.  Use itri_msgs-msg:truck_target_det instead.")
  (truck_target_det m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EsrDetection>) ostream)
  "Serializes a message object of type '<EsrDetection>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_stat)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_cmbb_move)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_cmbb_stat)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_fcw_move)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_fcw_stat)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'water_spray_target_id)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'filtered_xohp_acc_cipv))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_3)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lr_only_grating_lobe_det) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'truck_target_det) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EsrDetection>) istream)
  "Deserializes a message object of type '<EsrDetection>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_stat)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_cmbb_move)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_cmbb_stat)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_fcw_move)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_fcw_stat)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'water_spray_target_id)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'filtered_xohp_acc_cipv) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'path_id_acc_3)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lr_only_grating_lobe_det) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'truck_target_det) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EsrDetection>)))
  "Returns string type for a message object of type '<EsrDetection>"
  "itri_msgs/EsrDetection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EsrDetection)))
  "Returns string type for a message object of type 'EsrDetection"
  "itri_msgs/EsrDetection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EsrDetection>)))
  "Returns md5sum for a message object of type '<EsrDetection>"
  "3accabc22902f1ec54cb36c33644a9c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EsrDetection)))
  "Returns md5sum for a message object of type 'EsrDetection"
  "3accabc22902f1ec54cb36c33644a9c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EsrDetection>)))
  "Returns full string definition for message of type '<EsrDetection>"
  (cl:format cl:nil "Header header~%uint8 path_id_acc_stat~%uint8 path_id_acc~%uint8 path_id_cmbb_move~%uint8 path_id_cmbb_stat~%uint8 path_id_fcw_move~%uint8 path_id_fcw_stat~%uint8 water_spray_target_id~%float32 filtered_xohp_acc_cipv~%uint8 path_id_acc_2~%uint8 path_id_acc_3~%bool lr_only_grating_lobe_det~%bool truck_target_det~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EsrDetection)))
  "Returns full string definition for message of type 'EsrDetection"
  (cl:format cl:nil "Header header~%uint8 path_id_acc_stat~%uint8 path_id_acc~%uint8 path_id_cmbb_move~%uint8 path_id_cmbb_stat~%uint8 path_id_fcw_move~%uint8 path_id_fcw_stat~%uint8 water_spray_target_id~%float32 filtered_xohp_acc_cipv~%uint8 path_id_acc_2~%uint8 path_id_acc_3~%bool lr_only_grating_lobe_det~%bool truck_target_det~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EsrDetection>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     1
     1
     1
     4
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EsrDetection>))
  "Converts a ROS message object to a list"
  (cl:list 'EsrDetection
    (cl:cons ':header (header msg))
    (cl:cons ':path_id_acc_stat (path_id_acc_stat msg))
    (cl:cons ':path_id_acc (path_id_acc msg))
    (cl:cons ':path_id_cmbb_move (path_id_cmbb_move msg))
    (cl:cons ':path_id_cmbb_stat (path_id_cmbb_stat msg))
    (cl:cons ':path_id_fcw_move (path_id_fcw_move msg))
    (cl:cons ':path_id_fcw_stat (path_id_fcw_stat msg))
    (cl:cons ':water_spray_target_id (water_spray_target_id msg))
    (cl:cons ':filtered_xohp_acc_cipv (filtered_xohp_acc_cipv msg))
    (cl:cons ':path_id_acc_2 (path_id_acc_2 msg))
    (cl:cons ':path_id_acc_3 (path_id_acc_3 msg))
    (cl:cons ':lr_only_grating_lobe_det (lr_only_grating_lobe_det msg))
    (cl:cons ':truck_target_det (truck_target_det msg))
))
