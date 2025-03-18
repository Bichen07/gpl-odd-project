; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude FaultActionsReport.msg.html

(cl:defclass <FaultActionsReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (auto_disable_no_brakes
    :reader auto_disable_no_brakes
    :initarg :auto_disable_no_brakes
    :type cl:boolean
    :initform cl:nil)
   (auto_disable_apply_brakes
    :reader auto_disable_apply_brakes
    :initarg :auto_disable_apply_brakes
    :type cl:boolean
    :initform cl:nil)
   (dbw_can_gateway_disable
    :reader dbw_can_gateway_disable
    :initarg :dbw_can_gateway_disable
    :type cl:boolean
    :initform cl:nil)
   (inverter_cnt_control_disable
    :reader inverter_cnt_control_disable
    :initarg :inverter_cnt_control_disable
    :type cl:boolean
    :initform cl:nil)
   (prevent_enter_auto_mode
    :reader prevent_enter_auto_mode
    :initarg :prevent_enter_auto_mode
    :type cl:boolean
    :initform cl:nil)
   (warn_driver_only
    :reader warn_driver_only
    :initarg :warn_driver_only
    :type cl:boolean
    :initform cl:nil)
   (chime_fcw_beeps
    :reader chime_fcw_beeps
    :initarg :chime_fcw_beeps
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass FaultActionsReport (<FaultActionsReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FaultActionsReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FaultActionsReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<FaultActionsReport> is deprecated: use dbw_pacifica_msgs-msg:FaultActionsReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'auto_disable_no_brakes-val :lambda-list '(m))
(cl:defmethod auto_disable_no_brakes-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:auto_disable_no_brakes-val is deprecated.  Use dbw_pacifica_msgs-msg:auto_disable_no_brakes instead.")
  (auto_disable_no_brakes m))

(cl:ensure-generic-function 'auto_disable_apply_brakes-val :lambda-list '(m))
(cl:defmethod auto_disable_apply_brakes-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:auto_disable_apply_brakes-val is deprecated.  Use dbw_pacifica_msgs-msg:auto_disable_apply_brakes instead.")
  (auto_disable_apply_brakes m))

(cl:ensure-generic-function 'dbw_can_gateway_disable-val :lambda-list '(m))
(cl:defmethod dbw_can_gateway_disable-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:dbw_can_gateway_disable-val is deprecated.  Use dbw_pacifica_msgs-msg:dbw_can_gateway_disable instead.")
  (dbw_can_gateway_disable m))

(cl:ensure-generic-function 'inverter_cnt_control_disable-val :lambda-list '(m))
(cl:defmethod inverter_cnt_control_disable-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:inverter_cnt_control_disable-val is deprecated.  Use dbw_pacifica_msgs-msg:inverter_cnt_control_disable instead.")
  (inverter_cnt_control_disable m))

(cl:ensure-generic-function 'prevent_enter_auto_mode-val :lambda-list '(m))
(cl:defmethod prevent_enter_auto_mode-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:prevent_enter_auto_mode-val is deprecated.  Use dbw_pacifica_msgs-msg:prevent_enter_auto_mode instead.")
  (prevent_enter_auto_mode m))

(cl:ensure-generic-function 'warn_driver_only-val :lambda-list '(m))
(cl:defmethod warn_driver_only-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:warn_driver_only-val is deprecated.  Use dbw_pacifica_msgs-msg:warn_driver_only instead.")
  (warn_driver_only m))

(cl:ensure-generic-function 'chime_fcw_beeps-val :lambda-list '(m))
(cl:defmethod chime_fcw_beeps-val ((m <FaultActionsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:chime_fcw_beeps-val is deprecated.  Use dbw_pacifica_msgs-msg:chime_fcw_beeps instead.")
  (chime_fcw_beeps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FaultActionsReport>) ostream)
  "Serializes a message object of type '<FaultActionsReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'auto_disable_no_brakes) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'auto_disable_apply_brakes) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'dbw_can_gateway_disable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'inverter_cnt_control_disable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'prevent_enter_auto_mode) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'warn_driver_only) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'chime_fcw_beeps) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FaultActionsReport>) istream)
  "Deserializes a message object of type '<FaultActionsReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'auto_disable_no_brakes) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'auto_disable_apply_brakes) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'dbw_can_gateway_disable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'inverter_cnt_control_disable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'prevent_enter_auto_mode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'warn_driver_only) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'chime_fcw_beeps) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FaultActionsReport>)))
  "Returns string type for a message object of type '<FaultActionsReport>"
  "dbw_pacifica_msgs/FaultActionsReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FaultActionsReport)))
  "Returns string type for a message object of type 'FaultActionsReport"
  "dbw_pacifica_msgs/FaultActionsReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FaultActionsReport>)))
  "Returns md5sum for a message object of type '<FaultActionsReport>"
  "c21ae693be0418da6826534ee549449c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FaultActionsReport)))
  "Returns md5sum for a message object of type 'FaultActionsReport"
  "c21ae693be0418da6826534ee549449c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FaultActionsReport>)))
  "Returns full string definition for message of type '<FaultActionsReport>"
  (cl:format cl:nil "Header header~%~%bool auto_disable_no_brakes~%bool auto_disable_apply_brakes~%bool dbw_can_gateway_disable~%bool inverter_cnt_control_disable~%bool prevent_enter_auto_mode~%bool warn_driver_only~%bool chime_fcw_beeps~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FaultActionsReport)))
  "Returns full string definition for message of type 'FaultActionsReport"
  (cl:format cl:nil "Header header~%~%bool auto_disable_no_brakes~%bool auto_disable_apply_brakes~%bool dbw_can_gateway_disable~%bool inverter_cnt_control_disable~%bool prevent_enter_auto_mode~%bool warn_driver_only~%bool chime_fcw_beeps~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FaultActionsReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FaultActionsReport>))
  "Converts a ROS message object to a list"
  (cl:list 'FaultActionsReport
    (cl:cons ':header (header msg))
    (cl:cons ':auto_disable_no_brakes (auto_disable_no_brakes msg))
    (cl:cons ':auto_disable_apply_brakes (auto_disable_apply_brakes msg))
    (cl:cons ':dbw_can_gateway_disable (dbw_can_gateway_disable msg))
    (cl:cons ':inverter_cnt_control_disable (inverter_cnt_control_disable msg))
    (cl:cons ':prevent_enter_auto_mode (prevent_enter_auto_mode msg))
    (cl:cons ':warn_driver_only (warn_driver_only msg))
    (cl:cons ':chime_fcw_beeps (chime_fcw_beeps msg))
))
