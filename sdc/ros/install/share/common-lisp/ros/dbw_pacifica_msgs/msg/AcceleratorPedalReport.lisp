; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude AcceleratorPedalReport.msg.html

(cl:defclass <AcceleratorPedalReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (pedal_input
    :reader pedal_input
    :initarg :pedal_input
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
   (ignore_driver
    :reader ignore_driver
    :initarg :ignore_driver
    :type cl:boolean
    :initform cl:nil)
   (driver_activity
    :reader driver_activity
    :initarg :driver_activity
    :type cl:boolean
    :initform cl:nil)
   (fault_accel_pedal_system
    :reader fault_accel_pedal_system
    :initarg :fault_accel_pedal_system
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
   (torque_actual
    :reader torque_actual
    :initarg :torque_actual
    :type cl:float
    :initform 0.0)
   (control_type
    :reader control_type
    :initarg :control_type
    :type dbw_pacifica_msgs-msg:ActuatorControlMode
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:ActuatorControlMode)))
)

(cl:defclass AcceleratorPedalReport (<AcceleratorPedalReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AcceleratorPedalReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AcceleratorPedalReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<AcceleratorPedalReport> is deprecated: use dbw_pacifica_msgs-msg:AcceleratorPedalReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pedal_input-val :lambda-list '(m))
(cl:defmethod pedal_input-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_input-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_input instead.")
  (pedal_input m))

(cl:ensure-generic-function 'pedal_output-val :lambda-list '(m))
(cl:defmethod pedal_output-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:pedal_output-val is deprecated.  Use dbw_pacifica_msgs-msg:pedal_output instead.")
  (pedal_output m))

(cl:ensure-generic-function 'enabled-val :lambda-list '(m))
(cl:defmethod enabled-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:enabled-val is deprecated.  Use dbw_pacifica_msgs-msg:enabled instead.")
  (enabled m))

(cl:ensure-generic-function 'ignore_driver-val :lambda-list '(m))
(cl:defmethod ignore_driver-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ignore_driver-val is deprecated.  Use dbw_pacifica_msgs-msg:ignore_driver instead.")
  (ignore_driver m))

(cl:ensure-generic-function 'driver_activity-val :lambda-list '(m))
(cl:defmethod driver_activity-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:driver_activity-val is deprecated.  Use dbw_pacifica_msgs-msg:driver_activity instead.")
  (driver_activity m))

(cl:ensure-generic-function 'fault_accel_pedal_system-val :lambda-list '(m))
(cl:defmethod fault_accel_pedal_system-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_accel_pedal_system-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_accel_pedal_system instead.")
  (fault_accel_pedal_system m))

(cl:ensure-generic-function 'fault_ch1-val :lambda-list '(m))
(cl:defmethod fault_ch1-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_ch1-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_ch1 instead.")
  (fault_ch1 m))

(cl:ensure-generic-function 'fault_ch2-val :lambda-list '(m))
(cl:defmethod fault_ch2-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:fault_ch2-val is deprecated.  Use dbw_pacifica_msgs-msg:fault_ch2 instead.")
  (fault_ch2 m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'torque_actual-val :lambda-list '(m))
(cl:defmethod torque_actual-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:torque_actual-val is deprecated.  Use dbw_pacifica_msgs-msg:torque_actual instead.")
  (torque_actual m))

(cl:ensure-generic-function 'control_type-val :lambda-list '(m))
(cl:defmethod control_type-val ((m <AcceleratorPedalReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:control_type-val is deprecated.  Use dbw_pacifica_msgs-msg:control_type instead.")
  (control_type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AcceleratorPedalReport>) ostream)
  "Serializes a message object of type '<AcceleratorPedalReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pedal_input))))
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ignore_driver) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'driver_activity) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_accel_pedal_system) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_ch1) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fault_ch2) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'torque_actual))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'control_type) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AcceleratorPedalReport>) istream)
  "Deserializes a message object of type '<AcceleratorPedalReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_input) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pedal_output) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'enabled) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'ignore_driver) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'driver_activity) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_accel_pedal_system) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_ch1) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'fault_ch2) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque_actual) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'control_type) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AcceleratorPedalReport>)))
  "Returns string type for a message object of type '<AcceleratorPedalReport>"
  "dbw_pacifica_msgs/AcceleratorPedalReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AcceleratorPedalReport)))
  "Returns string type for a message object of type 'AcceleratorPedalReport"
  "dbw_pacifica_msgs/AcceleratorPedalReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AcceleratorPedalReport>)))
  "Returns md5sum for a message object of type '<AcceleratorPedalReport>"
  "79e5f58f94a8fa77ed7d602d29d0230c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AcceleratorPedalReport)))
  "Returns md5sum for a message object of type 'AcceleratorPedalReport"
  "79e5f58f94a8fa77ed7d602d29d0230c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AcceleratorPedalReport>)))
  "Returns full string definition for message of type '<AcceleratorPedalReport>"
  (cl:format cl:nil "Header header~%~%# Accelerator pedal~%# 0 to 100%~%float32 pedal_input~%float32 pedal_output~%~%# Status~%bool enabled~%bool ignore_driver~%bool driver_activity   # Driver activity~%~%bool fault_accel_pedal_system~%~%# Faults~%bool fault_ch1~%bool fault_ch2~%~%uint8 rolling_counter~%~%float32 torque_actual # 0 to 100%~%~%ActuatorControlMode control_type~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AcceleratorPedalReport)))
  "Returns full string definition for message of type 'AcceleratorPedalReport"
  (cl:format cl:nil "Header header~%~%# Accelerator pedal~%# 0 to 100%~%float32 pedal_input~%float32 pedal_output~%~%# Status~%bool enabled~%bool ignore_driver~%bool driver_activity   # Driver activity~%~%bool fault_accel_pedal_system~%~%# Faults~%bool fault_ch1~%bool fault_ch2~%~%uint8 rolling_counter~%~%float32 torque_actual # 0 to 100%~%~%ActuatorControlMode control_type~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/ActuatorControlMode~%uint8 value~%~%uint8 open_loop = 0~%uint8 closed_loop_actuator = 1~%uint8 closed_loop_vehicle = 2~%uint8 none = 255~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AcceleratorPedalReport>))
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
     1
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'control_type))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AcceleratorPedalReport>))
  "Converts a ROS message object to a list"
  (cl:list 'AcceleratorPedalReport
    (cl:cons ':header (header msg))
    (cl:cons ':pedal_input (pedal_input msg))
    (cl:cons ':pedal_output (pedal_output msg))
    (cl:cons ':enabled (enabled msg))
    (cl:cons ':ignore_driver (ignore_driver msg))
    (cl:cons ':driver_activity (driver_activity msg))
    (cl:cons ':fault_accel_pedal_system (fault_accel_pedal_system msg))
    (cl:cons ':fault_ch1 (fault_ch1 msg))
    (cl:cons ':fault_ch2 (fault_ch2 msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':torque_actual (torque_actual msg))
    (cl:cons ':control_type (control_type msg))
))
