; Auto-generated. Do not edit!


(cl:in-package dbw_pacifica_msgs-msg)


;//! \htmlinclude ActuatorsReport.msg.html

(cl:defclass <ActuatorsReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (turn_signal_state
    :reader turn_signal_state
    :initarg :turn_signal_state
    :type dbw_pacifica_msgs-msg:TurnSignal
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:TurnSignal))
   (high_beam_headlights_state
    :reader high_beam_headlights_state
    :initarg :high_beam_headlights_state
    :type dbw_pacifica_msgs-msg:HighBeam
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:HighBeam))
   (low_beam_headlights_state
    :reader low_beam_headlights_state
    :initarg :low_beam_headlights_state
    :type dbw_pacifica_msgs-msg:LowBeam
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:LowBeam))
   (front_wiper_state
    :reader front_wiper_state
    :initarg :front_wiper_state
    :type dbw_pacifica_msgs-msg:WiperFront
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:WiperFront))
   (rear_wiper_state
    :reader rear_wiper_state
    :initarg :rear_wiper_state
    :type dbw_pacifica_msgs-msg:WiperRear
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:WiperRear))
   (rolling_counter
    :reader rolling_counter
    :initarg :rolling_counter
    :type cl:fixnum
    :initform 0)
   (ignition_state
    :reader ignition_state
    :initarg :ignition_state
    :type dbw_pacifica_msgs-msg:Ignition
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Ignition))
   (rear_left_door_state
    :reader rear_left_door_state
    :initarg :rear_left_door_state
    :type dbw_pacifica_msgs-msg:Door
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Door))
   (rear_right_door_state
    :reader rear_right_door_state
    :initarg :rear_right_door_state
    :type dbw_pacifica_msgs-msg:Door
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Door))
   (liftgate_state
    :reader liftgate_state
    :initarg :liftgate_state
    :type dbw_pacifica_msgs-msg:Door
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Door))
   (door_lock_state
    :reader door_lock_state
    :initarg :door_lock_state
    :type dbw_pacifica_msgs-msg:DoorLock
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:DoorLock)))
)

(cl:defclass ActuatorsReport (<ActuatorsReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ActuatorsReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ActuatorsReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dbw_pacifica_msgs-msg:<ActuatorsReport> is deprecated: use dbw_pacifica_msgs-msg:ActuatorsReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:header-val is deprecated.  Use dbw_pacifica_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'turn_signal_state-val :lambda-list '(m))
(cl:defmethod turn_signal_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:turn_signal_state-val is deprecated.  Use dbw_pacifica_msgs-msg:turn_signal_state instead.")
  (turn_signal_state m))

(cl:ensure-generic-function 'high_beam_headlights_state-val :lambda-list '(m))
(cl:defmethod high_beam_headlights_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:high_beam_headlights_state-val is deprecated.  Use dbw_pacifica_msgs-msg:high_beam_headlights_state instead.")
  (high_beam_headlights_state m))

(cl:ensure-generic-function 'low_beam_headlights_state-val :lambda-list '(m))
(cl:defmethod low_beam_headlights_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:low_beam_headlights_state-val is deprecated.  Use dbw_pacifica_msgs-msg:low_beam_headlights_state instead.")
  (low_beam_headlights_state m))

(cl:ensure-generic-function 'front_wiper_state-val :lambda-list '(m))
(cl:defmethod front_wiper_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:front_wiper_state-val is deprecated.  Use dbw_pacifica_msgs-msg:front_wiper_state instead.")
  (front_wiper_state m))

(cl:ensure-generic-function 'rear_wiper_state-val :lambda-list '(m))
(cl:defmethod rear_wiper_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_wiper_state-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_wiper_state instead.")
  (rear_wiper_state m))

(cl:ensure-generic-function 'rolling_counter-val :lambda-list '(m))
(cl:defmethod rolling_counter-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rolling_counter-val is deprecated.  Use dbw_pacifica_msgs-msg:rolling_counter instead.")
  (rolling_counter m))

(cl:ensure-generic-function 'ignition_state-val :lambda-list '(m))
(cl:defmethod ignition_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:ignition_state-val is deprecated.  Use dbw_pacifica_msgs-msg:ignition_state instead.")
  (ignition_state m))

(cl:ensure-generic-function 'rear_left_door_state-val :lambda-list '(m))
(cl:defmethod rear_left_door_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_left_door_state-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_left_door_state instead.")
  (rear_left_door_state m))

(cl:ensure-generic-function 'rear_right_door_state-val :lambda-list '(m))
(cl:defmethod rear_right_door_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:rear_right_door_state-val is deprecated.  Use dbw_pacifica_msgs-msg:rear_right_door_state instead.")
  (rear_right_door_state m))

(cl:ensure-generic-function 'liftgate_state-val :lambda-list '(m))
(cl:defmethod liftgate_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:liftgate_state-val is deprecated.  Use dbw_pacifica_msgs-msg:liftgate_state instead.")
  (liftgate_state m))

(cl:ensure-generic-function 'door_lock_state-val :lambda-list '(m))
(cl:defmethod door_lock_state-val ((m <ActuatorsReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dbw_pacifica_msgs-msg:door_lock_state-val is deprecated.  Use dbw_pacifica_msgs-msg:door_lock_state instead.")
  (door_lock_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ActuatorsReport>) ostream)
  "Serializes a message object of type '<ActuatorsReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'turn_signal_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'high_beam_headlights_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'low_beam_headlights_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'front_wiper_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_wiper_state) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ignition_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_left_door_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rear_right_door_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'liftgate_state) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'door_lock_state) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ActuatorsReport>) istream)
  "Deserializes a message object of type '<ActuatorsReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'turn_signal_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'high_beam_headlights_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'low_beam_headlights_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'front_wiper_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_wiper_state) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'rolling_counter)) (cl:read-byte istream))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ignition_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_left_door_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rear_right_door_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'liftgate_state) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'door_lock_state) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ActuatorsReport>)))
  "Returns string type for a message object of type '<ActuatorsReport>"
  "dbw_pacifica_msgs/ActuatorsReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ActuatorsReport)))
  "Returns string type for a message object of type 'ActuatorsReport"
  "dbw_pacifica_msgs/ActuatorsReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ActuatorsReport>)))
  "Returns md5sum for a message object of type '<ActuatorsReport>"
  "d66d15b164e1cf2d467650778182b722")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ActuatorsReport)))
  "Returns md5sum for a message object of type 'ActuatorsReport"
  "d66d15b164e1cf2d467650778182b722")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ActuatorsReport>)))
  "Returns full string definition for message of type '<ActuatorsReport>"
  (cl:format cl:nil "Header header~%~%# Turn Signal enumeration~%TurnSignal turn_signal_state~%~%# High beams~%HighBeam high_beam_headlights_state~%~%# Low beams~%LowBeam low_beam_headlights_state~%~%# Windshield Wipers enumeration~%WiperFront front_wiper_state~%WiperRear rear_wiper_state~%~%# Watchdog counter~%uint8 rolling_counter~%~%# Ignition~%Ignition ignition_state~%~%# HornState~%#HornState~%~%# Door status~%Door rear_left_door_state~%Door rear_right_door_state~%Door liftgate_state~%~%#Door lock~%DoorLock door_lock_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/TurnSignal~%uint8 value~%~%uint8 NONE=0~%uint8 LEFT=1~%uint8 RIGHT=2~%~%================================================================================~%MSG: dbw_pacifica_msgs/HighBeam~%uint8 status~%~%uint8 OFF = 0~%uint8 ON = 1~%uint8 FLASH = 2~%~%================================================================================~%MSG: dbw_pacifica_msgs/LowBeam~%uint8 status~%~%uint8 OFF = 0~%uint8 ON = 1~%uint8 FLASH = 2~%~%================================================================================~%MSG: dbw_pacifica_msgs/WiperFront~%uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 INTERVAL_2 = 2~%uint8 INTERVAL_3 = 3~%uint8 INTERVAL_4 = 4~%uint8 INTERVAL_5 = 5~%uint8 INTERVAL_6 = 6~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%================================================================================~%MSG: dbw_pacifica_msgs/WiperRear~%uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%================================================================================~%MSG: dbw_pacifica_msgs/Ignition~%uint8 status~%~%uint8 NO_REQUEST = 0~%uint8 FORCE_OFF = 0~%uint8 ACCESSORY = 0~%uint8 RUN = 0~%uint8 CRANK = 0~%================================================================================~%MSG: dbw_pacifica_msgs/Door~%uint8 value~%~%uint8 NO_REQUEST=0~%uint8 CLOSE_DOOR=1~%uint8 OPEN_DOOR=2~%~%================================================================================~%MSG: dbw_pacifica_msgs/DoorLock~%uint8 value~%~%uint8 NOREQUEST=0~%uint8 UNLOCK=1~%uint8 LOCK=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ActuatorsReport)))
  "Returns full string definition for message of type 'ActuatorsReport"
  (cl:format cl:nil "Header header~%~%# Turn Signal enumeration~%TurnSignal turn_signal_state~%~%# High beams~%HighBeam high_beam_headlights_state~%~%# Low beams~%LowBeam low_beam_headlights_state~%~%# Windshield Wipers enumeration~%WiperFront front_wiper_state~%WiperRear rear_wiper_state~%~%# Watchdog counter~%uint8 rolling_counter~%~%# Ignition~%Ignition ignition_state~%~%# HornState~%#HornState~%~%# Door status~%Door rear_left_door_state~%Door rear_right_door_state~%Door liftgate_state~%~%#Door lock~%DoorLock door_lock_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: dbw_pacifica_msgs/TurnSignal~%uint8 value~%~%uint8 NONE=0~%uint8 LEFT=1~%uint8 RIGHT=2~%~%================================================================================~%MSG: dbw_pacifica_msgs/HighBeam~%uint8 status~%~%uint8 OFF = 0~%uint8 ON = 1~%uint8 FLASH = 2~%~%================================================================================~%MSG: dbw_pacifica_msgs/LowBeam~%uint8 status~%~%uint8 OFF = 0~%uint8 ON = 1~%uint8 FLASH = 2~%~%================================================================================~%MSG: dbw_pacifica_msgs/WiperFront~%uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 INTERVAL_2 = 2~%uint8 INTERVAL_3 = 3~%uint8 INTERVAL_4 = 4~%uint8 INTERVAL_5 = 5~%uint8 INTERVAL_6 = 6~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%================================================================================~%MSG: dbw_pacifica_msgs/WiperRear~%uint8 status~%~%uint8 OFF = 0~%uint8 INTERVAL_1 = 1~%uint8 CONSTANT_LOW = 11~%uint8 CONSTANT_HIGH = 12~%uint8 WASH_BRIEF = 13~%uint8 WASH_CONTINUOUS = 14~%~%================================================================================~%MSG: dbw_pacifica_msgs/Ignition~%uint8 status~%~%uint8 NO_REQUEST = 0~%uint8 FORCE_OFF = 0~%uint8 ACCESSORY = 0~%uint8 RUN = 0~%uint8 CRANK = 0~%================================================================================~%MSG: dbw_pacifica_msgs/Door~%uint8 value~%~%uint8 NO_REQUEST=0~%uint8 CLOSE_DOOR=1~%uint8 OPEN_DOOR=2~%~%================================================================================~%MSG: dbw_pacifica_msgs/DoorLock~%uint8 value~%~%uint8 NOREQUEST=0~%uint8 UNLOCK=1~%uint8 LOCK=2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ActuatorsReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'turn_signal_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'high_beam_headlights_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'low_beam_headlights_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'front_wiper_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_wiper_state))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ignition_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_left_door_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rear_right_door_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'liftgate_state))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'door_lock_state))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ActuatorsReport>))
  "Converts a ROS message object to a list"
  (cl:list 'ActuatorsReport
    (cl:cons ':header (header msg))
    (cl:cons ':turn_signal_state (turn_signal_state msg))
    (cl:cons ':high_beam_headlights_state (high_beam_headlights_state msg))
    (cl:cons ':low_beam_headlights_state (low_beam_headlights_state msg))
    (cl:cons ':front_wiper_state (front_wiper_state msg))
    (cl:cons ':rear_wiper_state (rear_wiper_state msg))
    (cl:cons ':rolling_counter (rolling_counter msg))
    (cl:cons ':ignition_state (ignition_state msg))
    (cl:cons ':rear_left_door_state (rear_left_door_state msg))
    (cl:cons ':rear_right_door_state (rear_right_door_state msg))
    (cl:cons ':liftgate_state (liftgate_state msg))
    (cl:cons ':door_lock_state (door_lock_state msg))
))
