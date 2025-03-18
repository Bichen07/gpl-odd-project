; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude MiscReport.msg.html

(cl:defclass <MiscReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (fuel_level
    :reader fuel_level
    :initarg :fuel_level
    :type cl:float
    :initform 0.0)
   (drive_by_wire_enabled
    :reader drive_by_wire_enabled
    :initarg :drive_by_wire_enabled
    :type cl:boolean
    :initform cl:nil)
   (vehicle_speed
    :reader vehicle_speed
    :initarg :vehicle_speed
    :type cl:float
    :initform 0.0)
   (software_build_number
    :reader software_build_number
    :initarg :software_build_number
    :type cl:fixnum
    :initform 0)
   (general_actuator_fault
    :reader general_actuator_fault
    :initarg :general_actuator_fault
    :type cl:boolean
    :initform cl:nil)
   (by_wire_ready
    :reader by_wire_ready
    :initarg :by_wire_ready
    :type cl:boolean
    :initform cl:nil)
   (general_driver_activity
    :reader general_driver_activity
    :initarg :general_driver_activity
    :type cl:boolean
    :initform cl:nil)
   (comms_fault
    :reader comms_fault
    :initarg :comms_fault
    :type cl:boolean
    :initform cl:nil)
   (ambient_temp
    :reader ambient_temp
    :initarg :ambient_temp
    :type cl:float
    :initform 0.0)
   (vehicle_ready_to_drive
    :reader vehicle_ready_to_drive
    :initarg :vehicle_ready_to_drive
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass MiscReport (<MiscReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MiscReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MiscReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<MiscReport> is deprecated: use dbw_pacifica_msgs-msg:MiscReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'fuel_level-val :lambda-list '(m))
(cl:defmethod fuel_level-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fuel_level-val is deprecated.  Use dbw_pacifica_msgs-msg:fuel_level instead.")
  (fuel_level m))

(cl:ensure-generic-function 'drive_by_wire_enabled-val :lambda-list '(m))
(cl:defmethod drive_by_wire_enabled-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:drive_by_wire_enabled-val is deprecated.  Use dbw_pacifica_msgs-msg:drive_by_wire_enabled instead.")
  (drive_by_wire_enabled m))

(cl:ensure-generic-function 'vehicle_speed-val :lambda-list '(m))
(cl:defmethod vehicle_speed-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_speed-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_speed instead.")
  (vehicle_speed m))

(cl:ensure-generic-function 'software_build_number-val :lambda-list '(m))
(cl:defmethod software_build_number-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:software_build_number-val is deprecated.  Use dbw_pacifica_msgs-msg:software_build_number instead.")
  (software_build_number m))

(cl:ensure-generic-function 'general_actuator_fault-val :lambda-list '(m))
(cl:defmethod general_actuator_fault-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:general_actuator_fault-val is deprecated.  Use dbw_pacifica_msgs-msg:general_actuator_fault instead.")
  (general_actuator_fault m))

(cl:ensure-generic-function 'by_wire_ready-val :lambda-list '(m))
(cl:defmethod by_wire_ready-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:by_wire_ready-val is deprecated.  Use dbw_pacifica_msgs-msg:by_wire_ready instead.")
  (by_wire_ready m))

(cl:ensure-generic-function 'general_driver_activity-val :lambda-list '(m))
(cl:defmethod general_driver_activity-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:general_driver_activity-val is deprecated.  Use dbw_pacifica_msgs-msg:general_driver_activity instead.")
  (general_driver_activity m))

(cl:ensure-generic-function 'comms_fault-val :lambda-list '(m))
(cl:defmethod comms_fault-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:comms_fault-val is deprecated.  Use dbw_pacifica_msgs-msg:comms_fault instead.")
  (comms_fault m))

(cl:ensure-generic-function 'ambient_temp-val :lambda-list '(m))
(cl:defmethod ambient_temp-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ambient_temp-val is deprecated.  Use dbw_pacifica_msgs-msg:ambient_temp instead.")
  (ambient_temp m))

(cl:ensure-generic-function 'vehicle_ready_to_drive-val :lambda-list '(m))
(cl:defmethod vehicle_ready_to_drive-val ((m <MiscReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_ready_to_drive-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_ready_to_drive instead.")
  (vehicle_ready_to_drive m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MiscReport>) ostream)
  "Serializes a message object of type '<MiscReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fuel_level))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'drive_by_wire_enabled) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'software_build_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'software_build_number)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'general_actuator_fault) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'by_wire_ready) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'general_driver_activity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'comms_fault) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ambient_temp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'vehicle_ready_to_drive) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MiscReport>) istream)
  "Deserializes a message object of type '<MiscReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fuel_level) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'drive_by_wire_enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'software_build_number)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'software_build_number)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'general_actuator_fault) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'by_wire_ready) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'general_driver_activity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'comms_fault) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ambient_temp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'vehicle_ready_to_drive) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MiscReport>)))
  "Returns string type for a message object of type '<MiscReport>"
  "dbw_pacifica_msgs/MiscReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MiscReport)))
  "Returns string type for a message object of type 'MiscReport"
  "dbw_pacifica_msgs/MiscReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MiscReport>)))
  "Returns md5sum for a message object of type '<MiscReport>"
  "07d2b659403a0cbd241b5457fee2e270")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MiscReport)))
  "Returns md5sum for a message object of type 'MiscReport"
  "07d2b659403a0cbd241b5457fee2e270")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MiscReport>)))
  "Returns full string definition for message of type '<MiscReport>"
  (cl:format cl:nil "Header header~%~%float32 fuel_level          # %~%bool drive_by_wire_enabled~%float32 vehicle_speed       # km/h~%uint16 software_build_number~%bool general_actuator_fault~%bool by_wire_ready~%bool general_driver_activity~%bool comms_fault~%float32 ambient_temp # degrees-C~%bool vehicle_ready_to_drive~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MiscReport)))
  "Returns full string definition for message of type 'MiscReport"
  (cl:format cl:nil "Header header~%~%float32 fuel_level          # %~%bool drive_by_wire_enabled~%float32 vehicle_speed       # km/h~%uint16 software_build_number~%bool general_actuator_fault~%bool by_wire_ready~%bool general_driver_activity~%bool comms_fault~%float32 ambient_temp # degrees-C~%bool vehicle_ready_to_drive~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MiscReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     1
     4
     2
     1
     1
     1
     1
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MiscReport>))
  "Converts a ROS message object to a list"
  (cl:list 'MiscReport
    (cl:cons ':header (header msg))
    (cl:cons ':fuel_level (fuel_level msg))
    (cl:cons ':drive_by_wire_enabled (drive_by_wire_enabled msg))
    (cl:cons ':vehicle_speed (vehicle_speed msg))
    (cl:cons ':software_build_number (software_build_number msg))
    (cl:cons ':general_actuator_fault (general_actuator_fault msg))
    (cl:cons ':by_wire_ready (by_wire_ready msg))
    (cl:cons ':general_driver_activity (general_driver_activity msg))
    (cl:cons ':comms_fault (comms_fault msg))
    (cl:cons ':ambient_temp (ambient_temp msg))
    (cl:cons ':vehicle_ready_to_drive (vehicle_ready_to_drive msg))
))
