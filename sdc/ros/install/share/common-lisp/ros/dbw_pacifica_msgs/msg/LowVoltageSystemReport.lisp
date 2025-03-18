; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude LowVoltageSystemReport.msg.html

(cl:defclass <LowVoltageSystemReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (dbw_battery_volts
    :reader dbw_battery_volts
    :initarg :dbw_battery_volts
    :type cl:float
    :initform 0.0)
   (vehicle_battery_volts
    :reader vehicle_battery_volts
    :initarg :vehicle_battery_volts
    :type cl:float
    :initform 0.0)
   (vehicle_battery_current
    :reader vehicle_battery_current
    :initarg :vehicle_battery_current
    :type cl:float
    :initform 0.0)
   (vehicle_alternator_current
    :reader vehicle_alternator_current
    :initarg :vehicle_alternator_current
    :type cl:float
    :initform 0.0)
   (dcdc_current
    :reader dcdc_current
    :initarg :dcdc_current
    :type cl:float
    :initform 0.0)
   (alternator_current
    :reader alternator_current
    :initarg :alternator_current
    :type cl:float
    :initform 0.0)
   (aux_battery_contactor
    :reader aux_battery_contactor
    :initarg :aux_battery_contactor
    :type cl:boolean
    :initform cl:nil)
   (aux_inverter_contactor
    :reader aux_inverter_contactor
    :initarg :aux_inverter_contactor
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass LowVoltageSystemReport (<LowVoltageSystemReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LowVoltageSystemReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LowVoltageSystemReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<LowVoltageSystemReport> is deprecated: use dbw_pacifica_msgs-msg:LowVoltageSystemReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'dbw_battery_volts-val :lambda-list '(m))
(cl:defmethod dbw_battery_volts-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:dbw_battery_volts-val is deprecated.  Use dbw_pacifica_msgs-msg:dbw_battery_volts instead.")
  (dbw_battery_volts m))

(cl:ensure-generic-function 'vehicle_battery_volts-val :lambda-list '(m))
(cl:defmethod vehicle_battery_volts-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_battery_volts-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_battery_volts instead.")
  (vehicle_battery_volts m))

(cl:ensure-generic-function 'vehicle_battery_current-val :lambda-list '(m))
(cl:defmethod vehicle_battery_current-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_battery_current-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_battery_current instead.")
  (vehicle_battery_current m))

(cl:ensure-generic-function 'vehicle_alternator_current-val :lambda-list '(m))
(cl:defmethod vehicle_alternator_current-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:vehicle_alternator_current-val is deprecated.  Use dbw_pacifica_msgs-msg:vehicle_alternator_current instead.")
  (vehicle_alternator_current m))

(cl:ensure-generic-function 'dcdc_current-val :lambda-list '(m))
(cl:defmethod dcdc_current-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:dcdc_current-val is deprecated.  Use dbw_pacifica_msgs-msg:dcdc_current instead.")
  (dcdc_current m))

(cl:ensure-generic-function 'alternator_current-val :lambda-list '(m))
(cl:defmethod alternator_current-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:alternator_current-val is deprecated.  Use dbw_pacifica_msgs-msg:alternator_current instead.")
  (alternator_current m))

(cl:ensure-generic-function 'aux_battery_contactor-val :lambda-list '(m))
(cl:defmethod aux_battery_contactor-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:aux_battery_contactor-val is deprecated.  Use dbw_pacifica_msgs-msg:aux_battery_contactor instead.")
  (aux_battery_contactor m))

(cl:ensure-generic-function 'aux_inverter_contactor-val :lambda-list '(m))
(cl:defmethod aux_inverter_contactor-val ((m <LowVoltageSystemReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:aux_inverter_contactor-val is deprecated.  Use dbw_pacifica_msgs-msg:aux_inverter_contactor instead.")
  (aux_inverter_contactor m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LowVoltageSystemReport>) ostream)
  "Serializes a message object of type '<LowVoltageSystemReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dbw_battery_volts))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_battery_volts))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_battery_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vehicle_alternator_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dcdc_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'alternator_current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'aux_battery_contactor) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'aux_inverter_contactor) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LowVoltageSystemReport>) istream)
  "Deserializes a message object of type '<LowVoltageSystemReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dbw_battery_volts) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_battery_volts) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_battery_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_alternator_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dcdc_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'alternator_current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'aux_battery_contactor) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'aux_inverter_contactor) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LowVoltageSystemReport>)))
  "Returns string type for a message object of type '<LowVoltageSystemReport>"
  "dbw_pacifica_msgs/LowVoltageSystemReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LowVoltageSystemReport)))
  "Returns string type for a message object of type 'LowVoltageSystemReport"
  "dbw_pacifica_msgs/LowVoltageSystemReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LowVoltageSystemReport>)))
  "Returns md5sum for a message object of type '<LowVoltageSystemReport>"
  "c352ea40227e6ba399244c0eeed0064c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LowVoltageSystemReport)))
  "Returns md5sum for a message object of type 'LowVoltageSystemReport"
  "c352ea40227e6ba399244c0eeed0064c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LowVoltageSystemReport>)))
  "Returns full string definition for message of type '<LowVoltageSystemReport>"
  (cl:format cl:nil "Header header~%~%float32 dbw_battery_volts # Volts~%float32 vehicle_battery_volts # Volts ~%float32 vehicle_battery_current # Amps~%float32 vehicle_alternator_current #Amps~%~%float32 dcdc_current # Amps~%float32 alternator_current # Amps~%~%bool aux_battery_contactor # On/Off~%bool aux_inverter_contactor # On/Off~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LowVoltageSystemReport)))
  "Returns full string definition for message of type 'LowVoltageSystemReport"
  (cl:format cl:nil "Header header~%~%float32 dbw_battery_volts # Volts~%float32 vehicle_battery_volts # Volts ~%float32 vehicle_battery_current # Amps~%float32 vehicle_alternator_current #Amps~%~%float32 dcdc_current # Amps~%float32 alternator_current # Amps~%~%bool aux_battery_contactor # On/Off~%bool aux_inverter_contactor # On/Off~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LowVoltageSystemReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LowVoltageSystemReport>))
  "Converts a ROS message object to a list"
  (cl:list 'LowVoltageSystemReport
    (cl:cons ':header (header msg))
    (cl:cons ':dbw_battery_volts (dbw_battery_volts msg))
    (cl:cons ':vehicle_battery_volts (vehicle_battery_volts msg))
    (cl:cons ':vehicle_battery_current (vehicle_battery_current msg))
    (cl:cons ':vehicle_alternator_current (vehicle_alternator_current msg))
    (cl:cons ':dcdc_current (dcdc_current msg))
    (cl:cons ':alternator_current (alternator_current msg))
    (cl:cons ':aux_battery_contactor (aux_battery_contactor msg))
    (cl:cons ':aux_inverter_contactor (aux_inverter_contactor msg))
))
