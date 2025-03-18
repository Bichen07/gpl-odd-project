; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude IonoData.msg.html

(cl:defclass <IonoData> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (healthValid
    :reader healthValid
    :initarg :healthValid
    :type cl:boolean
    :initform cl:nil)
   (ionoAlpha
    :reader ionoAlpha
    :initarg :ionoAlpha
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (tow
    :reader tow
    :initarg :tow
    :type cl:float
    :initform 0.0)
   (gpsWeek
    :reader gpsWeek
    :initarg :gpsWeek
    :type cl:float
    :initform 0.0)
   (ionoBeta
    :reader ionoBeta
    :initarg :ionoBeta
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (svHealth
    :reader svHealth
    :initarg :svHealth
    :type cl:integer
    :initform 0)
   (ionoCoeffsValid
    :reader ionoCoeffsValid
    :initarg :ionoCoeffsValid
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass IonoData (<IonoData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IonoData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IonoData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<IonoData> is deprecated: use openpilot_bridge-msg:IonoData instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'healthValid-val :lambda-list '(m))
(cl:defmethod healthValid-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:healthValid-val is deprecated.  Use openpilot_bridge-msg:healthValid instead.")
  (healthValid m))

(cl:ensure-generic-function 'ionoAlpha-val :lambda-list '(m))
(cl:defmethod ionoAlpha-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoAlpha-val is deprecated.  Use openpilot_bridge-msg:ionoAlpha instead.")
  (ionoAlpha m))

(cl:ensure-generic-function 'tow-val :lambda-list '(m))
(cl:defmethod tow-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:tow-val is deprecated.  Use openpilot_bridge-msg:tow instead.")
  (tow m))

(cl:ensure-generic-function 'gpsWeek-val :lambda-list '(m))
(cl:defmethod gpsWeek-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:gpsWeek-val is deprecated.  Use openpilot_bridge-msg:gpsWeek instead.")
  (gpsWeek m))

(cl:ensure-generic-function 'ionoBeta-val :lambda-list '(m))
(cl:defmethod ionoBeta-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoBeta-val is deprecated.  Use openpilot_bridge-msg:ionoBeta instead.")
  (ionoBeta m))

(cl:ensure-generic-function 'svHealth-val :lambda-list '(m))
(cl:defmethod svHealth-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:svHealth-val is deprecated.  Use openpilot_bridge-msg:svHealth instead.")
  (svHealth m))

(cl:ensure-generic-function 'ionoCoeffsValid-val :lambda-list '(m))
(cl:defmethod ionoCoeffsValid-val ((m <IonoData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ionoCoeffsValid-val is deprecated.  Use openpilot_bridge-msg:ionoCoeffsValid instead.")
  (ionoCoeffsValid m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IonoData>) ostream)
  "Serializes a message object of type '<IonoData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'healthValid) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ionoAlpha))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'ionoAlpha))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tow))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'gpsWeek))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ionoBeta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'ionoBeta))
  (cl:let* ((signed (cl:slot-value msg 'svHealth)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'ionoCoeffsValid) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IonoData>) istream)
  "Deserializes a message object of type '<IonoData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'healthValid) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ionoAlpha) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ionoAlpha)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tow) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'gpsWeek) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ionoBeta) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ionoBeta)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'svHealth) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:setf (cl:slot-value msg 'ionoCoeffsValid) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IonoData>)))
  "Returns string type for a message object of type '<IonoData>"
  "openpilot_bridge/IonoData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IonoData)))
  "Returns string type for a message object of type 'IonoData"
  "openpilot_bridge/IonoData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IonoData>)))
  "Returns md5sum for a message object of type '<IonoData>"
  "f905caa2eac71ee3a1208f47a49eafc0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IonoData)))
  "Returns md5sum for a message object of type 'IonoData"
  "f905caa2eac71ee3a1208f47a49eafc0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IonoData>)))
  "Returns full string definition for message of type '<IonoData>"
  (cl:format cl:nil "Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IonoData)))
  "Returns full string definition for message of type 'IonoData"
  (cl:format cl:nil "Header header~%~%bool healthValid~%float32[] ionoAlpha~%float32 tow~%float32 gpsWeek~%float32[] ionoBeta~%int64 svHealth~%bool ionoCoeffsValid~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IonoData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ionoAlpha) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ionoBeta) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IonoData>))
  "Converts a ROS message object to a list"
  (cl:list 'IonoData
    (cl:cons ':header (header msg))
    (cl:cons ':healthValid (healthValid msg))
    (cl:cons ':ionoAlpha (ionoAlpha msg))
    (cl:cons ':tow (tow msg))
    (cl:cons ':gpsWeek (gpsWeek msg))
    (cl:cons ':ionoBeta (ionoBeta msg))
    (cl:cons ':svHealth (svHealth msg))
    (cl:cons ':ionoCoeffsValid (ionoCoeffsValid msg))
))
