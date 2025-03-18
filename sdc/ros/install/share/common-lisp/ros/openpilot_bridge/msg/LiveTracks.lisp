; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LiveTracks.msg.html

(cl:defclass <LiveTracks> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (status
    :reader status
    :initarg :status
    :type cl:float
    :initform 0.0)
   (yRel
    :reader yRel
    :initarg :yRel
    :type cl:float
    :initform 0.0)
   (currentTime
    :reader currentTime
    :initarg :currentTime
    :type cl:float
    :initform 0.0)
   (trackId
    :reader trackId
    :initarg :trackId
    :type cl:integer
    :initform 0)
   (aRel
    :reader aRel
    :initarg :aRel
    :type cl:float
    :initform 0.0)
   (vRel
    :reader vRel
    :initarg :vRel
    :type cl:float
    :initform 0.0)
   (dRel
    :reader dRel
    :initarg :dRel
    :type cl:float
    :initform 0.0)
   (timeStamp
    :reader timeStamp
    :initarg :timeStamp
    :type cl:float
    :initform 0.0)
   (stationary
    :reader stationary
    :initarg :stationary
    :type cl:boolean
    :initform cl:nil)
   (oncoming
    :reader oncoming
    :initarg :oncoming
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass LiveTracks (<LiveTracks>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LiveTracks>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LiveTracks)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LiveTracks> is deprecated: use openpilot_bridge-msg:LiveTracks instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:status-val is deprecated.  Use openpilot_bridge-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'yRel-val :lambda-list '(m))
(cl:defmethod yRel-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yRel-val is deprecated.  Use openpilot_bridge-msg:yRel instead.")
  (yRel m))

(cl:ensure-generic-function 'currentTime-val :lambda-list '(m))
(cl:defmethod currentTime-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:currentTime-val is deprecated.  Use openpilot_bridge-msg:currentTime instead.")
  (currentTime m))

(cl:ensure-generic-function 'trackId-val :lambda-list '(m))
(cl:defmethod trackId-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:trackId-val is deprecated.  Use openpilot_bridge-msg:trackId instead.")
  (trackId m))

(cl:ensure-generic-function 'aRel-val :lambda-list '(m))
(cl:defmethod aRel-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aRel-val is deprecated.  Use openpilot_bridge-msg:aRel instead.")
  (aRel m))

(cl:ensure-generic-function 'vRel-val :lambda-list '(m))
(cl:defmethod vRel-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vRel-val is deprecated.  Use openpilot_bridge-msg:vRel instead.")
  (vRel m))

(cl:ensure-generic-function 'dRel-val :lambda-list '(m))
(cl:defmethod dRel-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dRel-val is deprecated.  Use openpilot_bridge-msg:dRel instead.")
  (dRel m))

(cl:ensure-generic-function 'timeStamp-val :lambda-list '(m))
(cl:defmethod timeStamp-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:timeStamp-val is deprecated.  Use openpilot_bridge-msg:timeStamp instead.")
  (timeStamp m))

(cl:ensure-generic-function 'stationary-val :lambda-list '(m))
(cl:defmethod stationary-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:stationary-val is deprecated.  Use openpilot_bridge-msg:stationary instead.")
  (stationary m))

(cl:ensure-generic-function 'oncoming-val :lambda-list '(m))
(cl:defmethod oncoming-val ((m <LiveTracks>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:oncoming-val is deprecated.  Use openpilot_bridge-msg:oncoming instead.")
  (oncoming m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LiveTracks>) ostream)
  "Serializes a message object of type '<LiveTracks>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'status))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'currentTime))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'trackId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'aRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'timeStamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'stationary) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'oncoming) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LiveTracks>) istream)
  "Deserializes a message object of type '<LiveTracks>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'status) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'currentTime) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'trackId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'aRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timeStamp) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'stationary) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'oncoming) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LiveTracks>)))
  "Returns string type for a message object of type '<LiveTracks>"
  "openpilot_bridge/LiveTracks")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LiveTracks)))
  "Returns string type for a message object of type 'LiveTracks"
  "openpilot_bridge/LiveTracks")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LiveTracks>)))
  "Returns md5sum for a message object of type '<LiveTracks>"
  "bc07fabc68ac3d8a8dc415053006b7ba")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LiveTracks)))
  "Returns md5sum for a message object of type 'LiveTracks"
  "bc07fabc68ac3d8a8dc415053006b7ba")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LiveTracks>)))
  "Returns full string definition for message of type '<LiveTracks>"
  (cl:format cl:nil "Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LiveTracks)))
  "Returns full string definition for message of type 'LiveTracks"
  (cl:format cl:nil "Header header~%~%float32 status~%float32 yRel~%float32 currentTime~%int32 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 timeStamp~%bool stationary~%bool oncoming~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LiveTracks>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LiveTracks>))
  "Converts a ROS message object to a list"
  (cl:list 'LiveTracks
    (cl:cons ':header (header msg))
    (cl:cons ':status (status msg))
    (cl:cons ':yRel (yRel msg))
    (cl:cons ':currentTime (currentTime msg))
    (cl:cons ':trackId (trackId msg))
    (cl:cons ':aRel (aRel msg))
    (cl:cons ':vRel (vRel msg))
    (cl:cons ':dRel (dRel msg))
    (cl:cons ':timeStamp (timeStamp msg))
    (cl:cons ':stationary (stationary msg))
    (cl:cons ':oncoming (oncoming msg))
))
