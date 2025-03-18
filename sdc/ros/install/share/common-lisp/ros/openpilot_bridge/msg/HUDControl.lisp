; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude HUDControl.msg.html

(cl:defclass <HUDControl> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (leadVisible
    :reader leadVisible
    :initarg :leadVisible
    :type cl:boolean
    :initform cl:nil)
   (setSpeed
    :reader setSpeed
    :initarg :setSpeed
    :type cl:float
    :initform 0.0)
   (leftLaneDepart
    :reader leftLaneDepart
    :initarg :leftLaneDepart
    :type cl:boolean
    :initform cl:nil)
   (lanesVisible
    :reader lanesVisible
    :initarg :lanesVisible
    :type cl:boolean
    :initform cl:nil)
   (leftLaneVisible
    :reader leftLaneVisible
    :initarg :leftLaneVisible
    :type cl:boolean
    :initform cl:nil)
   (visualAlert
    :reader visualAlert
    :initarg :visualAlert
    :type cl:integer
    :initform 0)
   (audibleAlert
    :reader audibleAlert
    :initarg :audibleAlert
    :type cl:integer
    :initform 0)
   (speedVisible
    :reader speedVisible
    :initarg :speedVisible
    :type cl:boolean
    :initform cl:nil)
   (rightLaneVisible
    :reader rightLaneVisible
    :initarg :rightLaneVisible
    :type cl:boolean
    :initform cl:nil)
   (rightLaneDepart
    :reader rightLaneDepart
    :initarg :rightLaneDepart
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass HUDControl (<HUDControl>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HUDControl>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HUDControl)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<HUDControl> is deprecated: use openpilot_bridge-msg:HUDControl instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'leadVisible-val :lambda-list '(m))
(cl:defmethod leadVisible-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leadVisible-val is deprecated.  Use openpilot_bridge-msg:leadVisible instead.")
  (leadVisible m))

(cl:ensure-generic-function 'setSpeed-val :lambda-list '(m))
(cl:defmethod setSpeed-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:setSpeed-val is deprecated.  Use openpilot_bridge-msg:setSpeed instead.")
  (setSpeed m))

(cl:ensure-generic-function 'leftLaneDepart-val :lambda-list '(m))
(cl:defmethod leftLaneDepart-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftLaneDepart-val is deprecated.  Use openpilot_bridge-msg:leftLaneDepart instead.")
  (leftLaneDepart m))

(cl:ensure-generic-function 'lanesVisible-val :lambda-list '(m))
(cl:defmethod lanesVisible-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lanesVisible-val is deprecated.  Use openpilot_bridge-msg:lanesVisible instead.")
  (lanesVisible m))

(cl:ensure-generic-function 'leftLaneVisible-val :lambda-list '(m))
(cl:defmethod leftLaneVisible-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:leftLaneVisible-val is deprecated.  Use openpilot_bridge-msg:leftLaneVisible instead.")
  (leftLaneVisible m))

(cl:ensure-generic-function 'visualAlert-val :lambda-list '(m))
(cl:defmethod visualAlert-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:visualAlert-val is deprecated.  Use openpilot_bridge-msg:visualAlert instead.")
  (visualAlert m))

(cl:ensure-generic-function 'audibleAlert-val :lambda-list '(m))
(cl:defmethod audibleAlert-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:audibleAlert-val is deprecated.  Use openpilot_bridge-msg:audibleAlert instead.")
  (audibleAlert m))

(cl:ensure-generic-function 'speedVisible-val :lambda-list '(m))
(cl:defmethod speedVisible-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedVisible-val is deprecated.  Use openpilot_bridge-msg:speedVisible instead.")
  (speedVisible m))

(cl:ensure-generic-function 'rightLaneVisible-val :lambda-list '(m))
(cl:defmethod rightLaneVisible-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightLaneVisible-val is deprecated.  Use openpilot_bridge-msg:rightLaneVisible instead.")
  (rightLaneVisible m))

(cl:ensure-generic-function 'rightLaneDepart-val :lambda-list '(m))
(cl:defmethod rightLaneDepart-val ((m <HUDControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rightLaneDepart-val is deprecated.  Use openpilot_bridge-msg:rightLaneDepart instead.")
  (rightLaneDepart m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HUDControl>) ostream)
  "Serializes a message object of type '<HUDControl>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'leadVisible) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'setSpeed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'leftLaneDepart) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'lanesVisible) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'leftLaneVisible) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'visualAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'visualAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'visualAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'visualAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'audibleAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'audibleAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'audibleAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'audibleAlert)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'speedVisible) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rightLaneVisible) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rightLaneDepart) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HUDControl>) istream)
  "Deserializes a message object of type '<HUDControl>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'leadVisible) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'setSpeed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'leftLaneDepart) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'lanesVisible) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'leftLaneVisible) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'visualAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'visualAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'visualAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'visualAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'audibleAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'audibleAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'audibleAlert)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'audibleAlert)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedVisible) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rightLaneVisible) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'rightLaneDepart) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HUDControl>)))
  "Returns string type for a message object of type '<HUDControl>"
  "openpilot_bridge/HUDControl")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HUDControl)))
  "Returns string type for a message object of type 'HUDControl"
  "openpilot_bridge/HUDControl")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HUDControl>)))
  "Returns md5sum for a message object of type '<HUDControl>"
  "fae5883e88a08288a6e7673c35bc1b32")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HUDControl)))
  "Returns md5sum for a message object of type 'HUDControl"
  "fae5883e88a08288a6e7673c35bc1b32")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HUDControl>)))
  "Returns full string definition for message of type '<HUDControl>"
  (cl:format cl:nil "Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HUDControl)))
  "Returns full string definition for message of type 'HUDControl"
  (cl:format cl:nil "Header header~%~%bool leadVisible~%float32 setSpeed~%bool leftLaneDepart~%bool lanesVisible~%bool leftLaneVisible~%uint32 visualAlert # enum const: VisualAlert~%uint32 audibleAlert # enum const: AudibleAlert~%bool speedVisible~%bool rightLaneVisible~%bool rightLaneDepart~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HUDControl>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4
     1
     1
     1
     4
     4
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HUDControl>))
  "Converts a ROS message object to a list"
  (cl:list 'HUDControl
    (cl:cons ':header (header msg))
    (cl:cons ':leadVisible (leadVisible msg))
    (cl:cons ':setSpeed (setSpeed msg))
    (cl:cons ':leftLaneDepart (leftLaneDepart msg))
    (cl:cons ':lanesVisible (lanesVisible msg))
    (cl:cons ':leftLaneVisible (leftLaneVisible msg))
    (cl:cons ':visualAlert (visualAlert msg))
    (cl:cons ':audibleAlert (audibleAlert msg))
    (cl:cons ':speedVisible (speedVisible msg))
    (cl:cons ':rightLaneVisible (rightLaneVisible msg))
    (cl:cons ':rightLaneDepart (rightLaneDepart msg))
))
