; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude CarEvent.msg.html

(cl:defclass <CarEvent> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (enable
    :reader enable
    :initarg :enable
    :type cl:boolean
    :initform cl:nil)
   (noEntry
    :reader noEntry
    :initarg :noEntry
    :type cl:boolean
    :initform cl:nil)
   (name
    :reader name
    :initarg :name
    :type cl:integer
    :initform 0)
   (immediateDisable
    :reader immediateDisable
    :initarg :immediateDisable
    :type cl:boolean
    :initform cl:nil)
   (warning
    :reader warning
    :initarg :warning
    :type cl:boolean
    :initform cl:nil)
   (permanent
    :reader permanent
    :initarg :permanent
    :type cl:boolean
    :initform cl:nil)
   (softDisable
    :reader softDisable
    :initarg :softDisable
    :type cl:boolean
    :initform cl:nil)
   (userDisable
    :reader userDisable
    :initarg :userDisable
    :type cl:boolean
    :initform cl:nil)
   (preEnable
    :reader preEnable
    :initarg :preEnable
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass CarEvent (<CarEvent>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CarEvent>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CarEvent)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<CarEvent> is deprecated: use openpilot_bridge-msg:CarEvent instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'enable-val :lambda-list '(m))
(cl:defmethod enable-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:enable-val is deprecated.  Use openpilot_bridge-msg:enable instead.")
  (enable m))

(cl:ensure-generic-function 'noEntry-val :lambda-list '(m))
(cl:defmethod noEntry-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:noEntry-val is deprecated.  Use openpilot_bridge-msg:noEntry instead.")
  (noEntry m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:name-val is deprecated.  Use openpilot_bridge-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'immediateDisable-val :lambda-list '(m))
(cl:defmethod immediateDisable-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:immediateDisable-val is deprecated.  Use openpilot_bridge-msg:immediateDisable instead.")
  (immediateDisable m))

(cl:ensure-generic-function 'warning-val :lambda-list '(m))
(cl:defmethod warning-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:warning-val is deprecated.  Use openpilot_bridge-msg:warning instead.")
  (warning m))

(cl:ensure-generic-function 'permanent-val :lambda-list '(m))
(cl:defmethod permanent-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:permanent-val is deprecated.  Use openpilot_bridge-msg:permanent instead.")
  (permanent m))

(cl:ensure-generic-function 'softDisable-val :lambda-list '(m))
(cl:defmethod softDisable-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:softDisable-val is deprecated.  Use openpilot_bridge-msg:softDisable instead.")
  (softDisable m))

(cl:ensure-generic-function 'userDisable-val :lambda-list '(m))
(cl:defmethod userDisable-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:userDisable-val is deprecated.  Use openpilot_bridge-msg:userDisable instead.")
  (userDisable m))

(cl:ensure-generic-function 'preEnable-val :lambda-list '(m))
(cl:defmethod preEnable-val ((m <CarEvent>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:preEnable-val is deprecated.  Use openpilot_bridge-msg:preEnable instead.")
  (preEnable m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CarEvent>) ostream)
  "Serializes a message object of type '<CarEvent>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'enable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'noEntry) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'name)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'name)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'name)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'name)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'immediateDisable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'warning) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'permanent) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'softDisable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'userDisable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'preEnable) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CarEvent>) istream)
  "Deserializes a message object of type '<CarEvent>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'enable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'noEntry) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'name)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'name)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'name)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'name)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'immediateDisable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'warning) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'permanent) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'softDisable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'userDisable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'preEnable) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CarEvent>)))
  "Returns string type for a message object of type '<CarEvent>"
  "openpilot_bridge/CarEvent")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CarEvent)))
  "Returns string type for a message object of type 'CarEvent"
  "openpilot_bridge/CarEvent")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CarEvent>)))
  "Returns md5sum for a message object of type '<CarEvent>"
  "2f52d8ded2e13e6f9192006e63d11d91")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CarEvent)))
  "Returns md5sum for a message object of type 'CarEvent"
  "2f52d8ded2e13e6f9192006e63d11d91")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CarEvent>)))
  "Returns full string definition for message of type '<CarEvent>"
  (cl:format cl:nil "Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CarEvent)))
  "Returns full string definition for message of type 'CarEvent"
  (cl:format cl:nil "Header header~%~%bool enable~%bool noEntry~%uint32 name # enum const: EventName~%bool immediateDisable~%bool warning~%bool permanent~%bool softDisable~%bool userDisable~%bool preEnable~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CarEvent>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     4
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CarEvent>))
  "Converts a ROS message object to a list"
  (cl:list 'CarEvent
    (cl:cons ':header (header msg))
    (cl:cons ':enable (enable msg))
    (cl:cons ':noEntry (noEntry msg))
    (cl:cons ':name (name msg))
    (cl:cons ':immediateDisable (immediateDisable msg))
    (cl:cons ':warning (warning msg))
    (cl:cons ':permanent (permanent msg))
    (cl:cons ':softDisable (softDisable msg))
    (cl:cons ':userDisable (userDisable msg))
    (cl:cons ':preEnable (preEnable msg))
))
