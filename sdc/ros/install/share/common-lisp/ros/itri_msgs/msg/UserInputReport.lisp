; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude UserInputReport.msg.html

(cl:defclass <UserInputReport> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (cruise_engage_button
    :reader cruise_engage_button
    :initarg :cruise_engage_button
    :type cl:boolean
    :initform cl:nil)
   (cruise_resume_button
    :reader cruise_resume_button
    :initarg :cruise_resume_button
    :type cl:boolean
    :initform cl:nil)
   (doorCmd
    :reader doorCmd
    :initarg :doorCmd
    :type itri_msgs-msg:OpenDoorCmd
    :initform (cl:make-instance 'itri_msgs-msg:OpenDoorCmd))
   (gearCmd
    :reader gearCmd
    :initarg :gearCmd
    :type dbw_pacifica_msgs-msg:Gear
    :initform (cl:make-instance 'dbw_pacifica_msgs-msg:Gear))
   (hornReq
    :reader hornReq
    :initarg :hornReq
    :type cl:boolean
    :initform cl:nil)
   (turnSignalCmd
    :reader turnSignalCmd
    :initarg :turnSignalCmd
    :type itri_msgs-msg:turn_signal_cmd
    :initform (cl:make-instance 'itri_msgs-msg:turn_signal_cmd)))
)

(cl:defclass UserInputReport (<UserInputReport>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UserInputReport>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UserInputReport)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<UserInputReport> is deprecated: use itri_msgs-msg:UserInputReport instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'cruise_engage_button-val :lambda-list '(m))
(cl:defmethod cruise_engage_button-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:cruise_engage_button-val is deprecated.  Use itri_msgs-msg:cruise_engage_button instead.")
  (cruise_engage_button m))

(cl:ensure-generic-function 'cruise_resume_button-val :lambda-list '(m))
(cl:defmethod cruise_resume_button-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:cruise_resume_button-val is deprecated.  Use itri_msgs-msg:cruise_resume_button instead.")
  (cruise_resume_button m))

(cl:ensure-generic-function 'doorCmd-val :lambda-list '(m))
(cl:defmethod doorCmd-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:doorCmd-val is deprecated.  Use itri_msgs-msg:doorCmd instead.")
  (doorCmd m))

(cl:ensure-generic-function 'gearCmd-val :lambda-list '(m))
(cl:defmethod gearCmd-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gearCmd-val is deprecated.  Use itri_msgs-msg:gearCmd instead.")
  (gearCmd m))

(cl:ensure-generic-function 'hornReq-val :lambda-list '(m))
(cl:defmethod hornReq-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:hornReq-val is deprecated.  Use itri_msgs-msg:hornReq instead.")
  (hornReq m))

(cl:ensure-generic-function 'turnSignalCmd-val :lambda-list '(m))
(cl:defmethod turnSignalCmd-val ((m <UserInputReport>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:turnSignalCmd-val is deprecated.  Use itri_msgs-msg:turnSignalCmd instead.")
  (turnSignalCmd m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UserInputReport>) ostream)
  "Serializes a message object of type '<UserInputReport>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cruise_engage_button) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'cruise_resume_button) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'doorCmd) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'gearCmd) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'hornReq) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'turnSignalCmd) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UserInputReport>) istream)
  "Deserializes a message object of type '<UserInputReport>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'cruise_engage_button) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'cruise_resume_button) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'doorCmd) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'gearCmd) istream)
    (cl:setf (cl:slot-value msg 'hornReq) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'turnSignalCmd) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UserInputReport>)))
  "Returns string type for a message object of type '<UserInputReport>"
  "itri_msgs/UserInputReport")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UserInputReport)))
  "Returns string type for a message object of type 'UserInputReport"
  "itri_msgs/UserInputReport")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UserInputReport>)))
  "Returns md5sum for a message object of type '<UserInputReport>"
  "a2e7897758032adfc464805e43cb89c4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UserInputReport)))
  "Returns md5sum for a message object of type 'UserInputReport"
  "a2e7897758032adfc464805e43cb89c4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UserInputReport>)))
  "Returns full string definition for message of type '<UserInputReport>"
  (cl:format cl:nil "Header header~%~%# Engage DBW~%bool cruise_engage_button~%~%# Start Self Driving when the DBW system engage~%bool cruise_resume_button~%~%# Door control~%OpenDoorCmd doorCmd~%~%# Gear control~%dbw_pacifica_msgs/Gear gearCmd~%~%# Horn control~%bool hornReq~%~%# Blinker~%turn_signal_cmd turnSignalCmd~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/OpenDoorCmd~%Header header~%~%uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 left_door~%uint8 right_door~%uint8 lift_gate~%~%================================================================================~%MSG: dbw_pacifica_msgs/Gear~%uint8 gear~%~%uint8 NONE=0~%uint8 PARK=1~%uint8 REVERSE=2~%uint8 NEUTRAL=3~%uint8 DRIVE=4~%uint8 LOW=5~%~%================================================================================~%MSG: itri_msgs/turn_signal_cmd~%Header header~%~%uint8 NONE = 0~%uint8 LEFT = 1~%uint8 RIGHT = 2~%~%uint8 turn_signal~%string source~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UserInputReport)))
  "Returns full string definition for message of type 'UserInputReport"
  (cl:format cl:nil "Header header~%~%# Engage DBW~%bool cruise_engage_button~%~%# Start Self Driving when the DBW system engage~%bool cruise_resume_button~%~%# Door control~%OpenDoorCmd doorCmd~%~%# Gear control~%dbw_pacifica_msgs/Gear gearCmd~%~%# Horn control~%bool hornReq~%~%# Blinker~%turn_signal_cmd turnSignalCmd~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/OpenDoorCmd~%Header header~%~%uint8 CLOSE = 0~%uint8 OPEN = 1~%~%uint8 left_door~%uint8 right_door~%uint8 lift_gate~%~%================================================================================~%MSG: dbw_pacifica_msgs/Gear~%uint8 gear~%~%uint8 NONE=0~%uint8 PARK=1~%uint8 REVERSE=2~%uint8 NEUTRAL=3~%uint8 DRIVE=4~%uint8 LOW=5~%~%================================================================================~%MSG: itri_msgs/turn_signal_cmd~%Header header~%~%uint8 NONE = 0~%uint8 LEFT = 1~%uint8 RIGHT = 2~%~%uint8 turn_signal~%string source~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UserInputReport>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'doorCmd))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'gearCmd))
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'turnSignalCmd))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UserInputReport>))
  "Converts a ROS message object to a list"
  (cl:list 'UserInputReport
    (cl:cons ':header (header msg))
    (cl:cons ':cruise_engage_button (cruise_engage_button msg))
    (cl:cons ':cruise_resume_button (cruise_resume_button msg))
    (cl:cons ':doorCmd (doorCmd msg))
    (cl:cons ':gearCmd (gearCmd msg))
    (cl:cons ':hornReq (hornReq msg))
    (cl:cons ':turnSignalCmd (turnSignalCmd msg))
))
