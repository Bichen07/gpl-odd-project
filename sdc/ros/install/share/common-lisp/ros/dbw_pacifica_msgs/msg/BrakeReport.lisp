; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude BrakeReport.msg.html

(cl:defclass <BrakeReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (pedal_position
    :reader pedal_position
    :initarg :pedal_position
    :type cl:float
    :initform 0.0)
   (pedal_output
    :reader pedal_output
    :initarg :pedal_output
    :type cl:float
    :initform 0.0)
   (enabled
    :reader enabled
    :initarg :enabled
    :type cl:boolean
    :initform cl:nil)
   (driver_activity
    :reader driver_activity
    :initarg :driver_activity
    :type cl:boolean
    :initform cl:nil)
   (fault_brake_system
    :reader fault_brake_system
    :initarg :fault_brake_system
    :type cl:boolean
    :initform cl:nil)
   (fault_ch1
    :reader fault_ch1
    :initarg :fault_ch1
    :type cl:boolean
    :initform cl:nil)
   (fault_ch2
    :reader fault_ch2
    :initarg :fault_ch2
    :type cl:boolean
    :initform cl:nil)
   (rolling_counter
    :reader rolling_counter
    :initarg :rolling_counter
    :type cl:fixnum
    :initform 0)
   (brake_torque_actual
    :reader brake_torque_actual
    :initarg :brake_torque_actual
    :type cl:float
    :initform 0.0)
   (intervention_active
    :reader intervention_active
    :initarg :intervention_active
    :type cl:boolean
    :initform cl:nil)
   (intervention_ready
    :reader intervention_ready
    :initarg :intervention_ready
    :type cl:boolean
    :initform cl:nil)
   (parking_brake
    :reader parking_brake
    :initarg :parking_brake
    :type dbw_pacifica_msgs-msg:ParkingBrake
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ParkingBrake))
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode)))
)

(cl:defclass BrakeReport (<BrakeReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <BrakeReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'BrakeReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<BrakeReport> is deprecated: use dbw_pacifica_msgs-msg:BrakeReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pedal_position-val :lambda-list '(m))
(cl:defmethod pedal_position-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_position-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_position instead.")
  (pedal_position m))

(cl:ensure-generic-function 'pedal_output-val :lambda-list '(m))
(cl:defmethod pedal_output-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_output-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_output instead.")
  (pedal_output m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enabled-val is deprecated.  Use dbw_pacifica_msgs-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'driver_activity-val :lambda-list '(m))
(cl:defmethod driver_activity-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:driver_activity-val is deprecated.  Use dbw_pacifica_msgs-msg:driver_activity instead.")
  (driver_activity m))

(cl:ensure-generic-function 'fault_brake_system-val :lambda-list '(m))
(cl:defmethod fault_brake_system-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_brake_system-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_brake_system instead.")
  (fault_brake_system m))

(cl:ensure-generic-function 'fault_ch1-val :lambda-list '(m))
(cl:defmethod fault_ch1-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_ch1-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_ch1 instead.")
  (fault_ch1 m))

(cl:ensure-generic-function 'fault_ch2-val :lambda-list '(m))
(cl:defmethod fault_ch2-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_ch2-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_ch2 instead.")
  (fault_ch2 m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'brake_torque_actual-val :lambda-list '(m))
(cl:defmethod brake_torque_actual-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:brake_torque_actual-val is deprecated.  Use dbw_pacifica_msgs-msg:brake_torque_actual instead.")
  (brake_torque_actual m))

(cl:ensure-generic-function 'intervention_active-val :lambda-list '(m))
(cl:defmethod intervention_active-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:intervention_active-val is deprecated.  Use dbw_pacifica_msgs-msg:intervention_active instead.")
  (intervention_active m))

(cl:ensure-generic-function 'intervention_ready-val :lambda-list '(m))
(cl:defmethod intervention_ready-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:intervention_ready-val is deprecated.  Use dbw_pacifica_msgs-msg:intervention_ready instead.")
  (intervention_ready m))

(cl:ensure-generic-function 'parking_brake-val :lambda-list '(m))
(cl:defmethod parking_brake-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:parking_brake-val is deprecated.  Use dbw_pacifica_msgs-msg:parking_brake instead.")
  (parking_brake m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <BrakeReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <BrakeReport>) ostream)
  "Serializes a message object of type '<BrakeReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pedal_position))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pedal_output))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enabled) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'driver_activity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_brake_system) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_ch1) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_ch2) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_torque_actual))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'intervention_active) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'intervention_ready) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'parking_brake) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <BrakeReport>) istream)
  "Deserializes a message object of type '<BrakeReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_position) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_output) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'driver_activity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_brake_system) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_ch1) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_ch2) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_torque_actual) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'intervention_active) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'intervention_ready) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'parking_brake) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<BrakeReport>)))
  "Returns string type for a message object of type '<BrakeReport>"
  "dbw_pacifica_msgs/BrakeReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'BrakeReport)))
  "Returns string type for a message object of type 'BrakeReport"
  "dbw_pacifica_msgs/BrakeReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<BrakeReport>)))
  "Returns md5sum for a message object of type '<BrakeReport>"
  "c23e437775db686330778b5ba5b0b41b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'BrakeReport)))
  "Returns md5sum for a message object of type 'BrakeReport"
  "c23e437775db686330778b5ba5b0b41b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<BrakeReport>)))
  "Returns full string definition for message of type '<BrakeReport>"
  (cl:format cl:nil "Header header~%~%# Brake pedal (%)~%float32 pedal_position~%float32 pedal_output~%~%# Status~%bool enabled  # Enabled~%bool driver_activity   # Driver activity~%~%bool fault_brake_system~%~%# Faults~%bool fault_ch1~%bool fault_ch2~%~%uint8 rolling_counter~%~%float32 brake_torque_actual # 0 to 100%~%~%# Anti-lock Brakes and  Stability Control~%bool intervention_active~%bool intervention_ready~%~%# Parking Brake~%ParkingBrake parking_brake~%~%ActuatorControlMode control_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ParkingBrake~%uint8 status~%~%uint8 RESERVED=0~%uint8 OFF=1~%uint8 ON=2~%uint8 FAULT=3~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'BrakeReport)))
  "Returns full string definition for message of type 'BrakeReport"
  (cl:format cl:nil "Header header~%~%# Brake pedal (%)~%float32 pedal_position~%float32 pedal_output~%~%# Status~%bool enabled  # Enabled~%bool driver_activity   # Driver activity~%~%bool fault_brake_system~%~%# Faults~%bool fault_ch1~%bool fault_ch2~%~%uint8 rolling_counter~%~%float32 brake_torque_actual # 0 to 100%~%~%# Anti-lock Brakes and  Stability Control~%bool intervention_active~%bool intervention_ready~%~%# Parking Brake~%ParkingBrake parking_brake~%~%ActuatorControlMode control_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ParkingBrake~%uint8 status~%~%uint8 RESERVED=0~%uint8 OFF=1~%uint8 ON=2~%uint8 FAULT=3~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <BrakeReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     1
     1
     1
     1
     1
     1
     4
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'parking_brake))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <BrakeReport>))
  "Converts a ROS message object to a list"
  (cl:list 'BrakeReport
    (cl:cons ':header (header msg))
    (cl:cons ':pedal_position (pedal_position msg))
    (cl:cons ':pedal_output (pedal_output msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':driver_activity (driver_activity msg))
    (cl:cons ':fault_brake_system (fault_brake_system msg))
    (cl:cons ':fault_ch1 (fault_ch1 msg))
    (cl:cons ':fault_ch2 (fault_ch2 msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':brake_torque_actual (brake_torque_actual msg))
    (cl:cons ':intervention_active (intervention_active msg))
    (cl:cons ':intervention_ready (intervention_ready msg))
    (cl:cons ':parking_brake (parking_brake msg))
    (cl:cons ':control_type (control_type msg))
))
