; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude RadarPoint.msg.html

(cl:defclass <RadarPoint> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (yRel
    :reader yRel
    :initarg :yRel
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
   (yvRel
    :reader yvRel
    :initarg :yvRel
    :type cl:float
    :initform 0.0)
   (measured
    :reader measured
    :initarg :measured
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass RadarPoint (<RadarPoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RadarPoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RadarPoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<RadarPoint> is deprecated: use openpilot_bridge-msg:RadarPoint instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'yRel-val :lambda-list '(m))
(cl:defmethod yRel-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yRel-val is deprecated.  Use openpilot_bridge-msg:yRel instead.")
  (yRel m))

(cl:ensure-generic-function 'trackId-val :lambda-list '(m))
(cl:defmethod trackId-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:trackId-val is deprecated.  Use openpilot_bridge-msg:trackId instead.")
  (trackId m))

(cl:ensure-generic-function 'aRel-val :lambda-list '(m))
(cl:defmethod aRel-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:aRel-val is deprecated.  Use openpilot_bridge-msg:aRel instead.")
  (aRel m))

(cl:ensure-generic-function 'vRel-val :lambda-list '(m))
(cl:defmethod vRel-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vRel-val is deprecated.  Use openpilot_bridge-msg:vRel instead.")
  (vRel m))

(cl:ensure-generic-function 'dRel-val :lambda-list '(m))
(cl:defmethod dRel-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:dRel-val is deprecated.  Use openpilot_bridge-msg:dRel instead.")
  (dRel m))

(cl:ensure-generic-function 'yvRel-val :lambda-list '(m))
(cl:defmethod yvRel-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:yvRel-val is deprecated.  Use openpilot_bridge-msg:yvRel instead.")
  (yvRel m))

(cl:ensure-generic-function 'measured-val :lambda-list '(m))
(cl:defmethod measured-val ((m <RadarPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:measured-val is deprecated.  Use openpilot_bridge-msg:measured instead.")
  (measured m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RadarPoint>) ostream)
  "Serializes a message object of type '<RadarPoint>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'trackId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yvRel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'measured) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RadarPoint>) istream)
  "Deserializes a message object of type '<RadarPoint>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'trackId) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
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
    (cl:setf (cl:slot-value msg 'yvRel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'measured) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RadarPoint>)))
  "Returns string type for a message object of type '<RadarPoint>"
  "openpilot_bridge/RadarPoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RadarPoint)))
  "Returns string type for a message object of type 'RadarPoint"
  "openpilot_bridge/RadarPoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RadarPoint>)))
  "Returns md5sum for a message object of type '<RadarPoint>"
  "3ce9f9a91082e3c1c6436dc94453ce9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RadarPoint)))
  "Returns md5sum for a message object of type 'RadarPoint"
  "3ce9f9a91082e3c1c6436dc94453ce9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RadarPoint>)))
  "Returns full string definition for message of type '<RadarPoint>"
  (cl:format cl:nil "Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RadarPoint)))
  "Returns full string definition for message of type 'RadarPoint"
  (cl:format cl:nil "Header header~%~%float32 yRel~%int64 trackId~%float32 aRel~%float32 vRel~%float32 dRel~%float32 yvRel~%bool measured~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RadarPoint>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     8
     4
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RadarPoint>))
  "Converts a ROS message object to a list"
  (cl:list 'RadarPoint
    (cl:cons ':header (header msg))
    (cl:cons ':yRel (yRel msg))
    (cl:cons ':trackId (trackId msg))
    (cl:cons ':aRel (aRel msg))
    (cl:cons ':vRel (vRel msg))
    (cl:cons ':dRel (dRel msg))
    (cl:cons ':yvRel (yvRel msg))
    (cl:cons ':measured (measured msg))
))
