; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude GearReport.msg.html

(cl:defclass <GearReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (state
    :reader state
    :initarg :state
    :type dbw_pacifica_msgs-msg:Gear
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Gear))
   (reject
    :reader reject
    :initarg :reject
    :type cl:boolean
    :initform cl:nil)
   (driver_activity
    :reader driver_activity
    :initarg :driver_activity
    :type cl:boolean
    :initform cl:nil)
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil)
   (gear_select_system_fault
    :reader gear_select_system_fault
    :initarg :gear_select_system_fault
    :type cl:boolean
    :initform cl:nil)
   (trans_cur_gear
    :reader trans_cur_gear
    :initarg :trans_cur_gear
    :type cl:fixnum
    :initform 0))
)

(cl:defclass GearReport (<GearReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GearReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GearReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<GearReport> is deprecated: use dbw_pacifica_msgs-msg:GearReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:state-val is deprecated.  Use dbw_pacifica_msgs-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'reject-val :lambda-list '(m))
(cl:defmethod reject-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:reject-val is deprecated.  Use dbw_pacifica_msgs-msg:reject instead.")
  (reject m))

(cl:ensure-generic-function 'driver_activity-val :lambda-list '(m))
(cl:defmethod driver_activity-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:driver_activity-val is deprecated.  Use dbw_pacifica_msgs-msg:driver_activity instead.")
  (driver_activity m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enabled-val is deprecated.  Use dbw_pacifica_msgs-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'gear_select_system_fault-val :lambda-list '(m))
(cl:defmethod gear_select_system_fault-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:gear_select_system_fault-val is deprecated.  Use dbw_pacifica_msgs-msg:gear_select_system_fault instead.")
  (gear_select_system_fault m))

(cl:ensure-generic-function 'trans_cur_gear-val :lambda-list '(m))
(cl:defmethod trans_cur_gear-val ((m <GearReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:trans_cur_gear-val is deprecated.  Use dbw_pacifica_msgs-msg:trans_cur_gear instead.")
  (trans_cur_gear m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GearReport>) ostream)
  "Serializes a message object of type '<GearReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'state) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'reject) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'driver_activity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gear_select_system_fault) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trans_cur_gear)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GearReport>) istream)
  "Deserializes a message object of type '<GearReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'state) istream)
    (cl:setf (cl:slot-value msg 'reject) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'driver_activity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gear_select_system_fault) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'trans_cur_gear)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GearReport>)))
  "Returns string type for a message object of type '<GearReport>"
  "dbw_pacifica_msgs/GearReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GearReport)))
  "Returns string type for a message object of type 'GearReport"
  "dbw_pacifica_msgs/GearReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GearReport>)))
  "Returns md5sum for a message object of type '<GearReport>"
  "82edf69509597cc6f96e7ba84e5d0077")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GearReport)))
  "Returns md5sum for a message object of type 'GearReport"
  "82edf69509597cc6f96e7ba84e5d0077")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GearReport>)))
  "Returns full string definition for message of type '<GearReport>"
  (cl:format cl:nil "Header header~%~%# Current gear enumeration~%Gear state~%~%# Gear reject flag~%bool reject~%~%# Status~%bool driver_activity~%bool enabled~%~%# Faults~%bool gear_select_system_fault~%~%#TransCurGear~%uint8 trans_cur_gear~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/Gear~%uint8 gear~%~%uint8 NONE=0~%uint8 PARK=1~%uint8 REVERSE=2~%uint8 NEUTRAL=3~%uint8 DRIVE=4~%uint8 LOW=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GearReport)))
  "Returns full string definition for message of type 'GearReport"
  (cl:format cl:nil "Header header~%~%# Current gear enumeration~%Gear state~%~%# Gear reject flag~%bool reject~%~%# Status~%bool driver_activity~%bool enabled~%~%# Faults~%bool gear_select_system_fault~%~%#TransCurGear~%uint8 trans_cur_gear~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/Gear~%uint8 gear~%~%uint8 NONE=0~%uint8 PARK=1~%uint8 REVERSE=2~%uint8 NEUTRAL=3~%uint8 DRIVE=4~%uint8 LOW=5~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GearReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'state))
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GearReport>))
  "Converts a ROS message object to a list"
  (cl:list 'GearReport
    (cl:cons ':header (header msg))
    (cl:cons ':state (state msg))
    (cl:cons ':reject (reject msg))
    (cl:cons ':driver_activity (driver_activity msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':gear_select_system_fault (gear_select_system_fault msg))
    (cl:cons ':trans_cur_gear (trans_cur_gear msg))
))
