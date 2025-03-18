; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude AndroidCaptureResult.msg.html

(cl:defclass <AndroidCaptureResult> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (exposureTime
    :reader exposureTime
    :initarg :exposureTime
    :type cl:integer
    :initform 0)
   (displayRotation
    :reader displayRotation
    :initarg :displayRotation
    :type cl:integer
    :initform 0)
   (colorCorrectionGains
    :reader colorCorrectionGains
    :initarg :colorCorrectionGains
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (sensitivity
    :reader sensitivity
    :initarg :sensitivity
    :type cl:integer
    :initform 0)
   (rollingShutterSkew
    :reader rollingShutterSkew
    :initarg :rollingShutterSkew
    :type cl:integer
    :initform 0)
   (colorCorrectionTransform
    :reader colorCorrectionTransform
    :initarg :colorCorrectionTransform
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (frameDuration
    :reader frameDuration
    :initarg :frameDuration
    :type cl:integer
    :initform 0))
)

(cl:defclass AndroidCaptureResult (<AndroidCaptureResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AndroidCaptureResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AndroidCaptureResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<AndroidCaptureResult> is deprecated: use openpilot_bridge-msg:AndroidCaptureResult instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'exposureTime-val :lambda-list '(m))
(cl:defmethod exposureTime-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:exposureTime-val is deprecated.  Use openpilot_bridge-msg:exposureTime instead.")
  (exposureTime m))

(cl:ensure-generic-function 'displayRotation-val :lambda-list '(m))
(cl:defmethod displayRotation-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:displayRotation-val is deprecated.  Use openpilot_bridge-msg:displayRotation instead.")
  (displayRotation m))

(cl:ensure-generic-function 'colorCorrectionGains-val :lambda-list '(m))
(cl:defmethod colorCorrectionGains-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:colorCorrectionGains-val is deprecated.  Use openpilot_bridge-msg:colorCorrectionGains instead.")
  (colorCorrectionGains m))

(cl:ensure-generic-function 'sensitivity-val :lambda-list '(m))
(cl:defmethod sensitivity-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:sensitivity-val is deprecated.  Use openpilot_bridge-msg:sensitivity instead.")
  (sensitivity m))

(cl:ensure-generic-function 'rollingShutterSkew-val :lambda-list '(m))
(cl:defmethod rollingShutterSkew-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rollingShutterSkew-val is deprecated.  Use openpilot_bridge-msg:rollingShutterSkew instead.")
  (rollingShutterSkew m))

(cl:ensure-generic-function 'colorCorrectionTransform-val :lambda-list '(m))
(cl:defmethod colorCorrectionTransform-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:colorCorrectionTransform-val is deprecated.  Use openpilot_bridge-msg:colorCorrectionTransform instead.")
  (colorCorrectionTransform m))

(cl:ensure-generic-function 'frameDuration-val :lambda-list '(m))
(cl:defmethod frameDuration-val ((m <AndroidCaptureResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:frameDuration-val is deprecated.  Use openpilot_bridge-msg:frameDuration instead.")
  (frameDuration m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AndroidCaptureResult>) ostream)
  "Serializes a message object of type '<AndroidCaptureResult>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'exposureTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'displayRotation)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'colorCorrectionGains))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'colorCorrectionGains))
  (cl:let* ((signed (cl:slot-value msg 'sensitivity)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'rollingShutterSkew)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'colorCorrectionTransform))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'colorCorrectionTransform))
  (cl:let* ((signed (cl:slot-value msg 'frameDuration)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AndroidCaptureResult>) istream)
  "Deserializes a message object of type '<AndroidCaptureResult>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'exposureTime) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'displayRotation) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'colorCorrectionGains) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'colorCorrectionGains)))
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
      (cl:setf (cl:slot-value msg 'sensitivity) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rollingShutterSkew) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'colorCorrectionTransform) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'colorCorrectionTransform)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frameDuration) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AndroidCaptureResult>)))
  "Returns string type for a message object of type '<AndroidCaptureResult>"
  "openpilot_bridge/AndroidCaptureResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AndroidCaptureResult)))
  "Returns string type for a message object of type 'AndroidCaptureResult"
  "openpilot_bridge/AndroidCaptureResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AndroidCaptureResult>)))
  "Returns md5sum for a message object of type '<AndroidCaptureResult>"
  "896962cc0ef44d3d658a8c60bd9f9307")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AndroidCaptureResult)))
  "Returns md5sum for a message object of type 'AndroidCaptureResult"
  "896962cc0ef44d3d658a8c60bd9f9307")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AndroidCaptureResult>)))
  "Returns full string definition for message of type '<AndroidCaptureResult>"
  (cl:format cl:nil "Header header~%~%int32 exposureTime~%int32 displayRotation~%float32[] colorCorrectionGains~%int32 sensitivity~%int64 rollingShutterSkew~%int32[] colorCorrectionTransform~%int32 frameDuration~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AndroidCaptureResult)))
  "Returns full string definition for message of type 'AndroidCaptureResult"
  (cl:format cl:nil "Header header~%~%int32 exposureTime~%int32 displayRotation~%float32[] colorCorrectionGains~%int32 sensitivity~%int64 rollingShutterSkew~%int32[] colorCorrectionTransform~%int32 frameDuration~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AndroidCaptureResult>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'colorCorrectionGains) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'colorCorrectionTransform) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AndroidCaptureResult>))
  "Converts a ROS message object to a list"
  (cl:list 'AndroidCaptureResult
    (cl:cons ':header (header msg))
    (cl:cons ':exposureTime (exposureTime msg))
    (cl:cons ':displayRotation (displayRotation msg))
    (cl:cons ':colorCorrectionGains (colorCorrectionGains msg))
    (cl:cons ':sensitivity (sensitivity msg))
    (cl:cons ':rollingShutterSkew (rollingShutterSkew msg))
    (cl:cons ':colorCorrectionTransform (colorCorrectionTransform msg))
    (cl:cons ':frameDuration (frameDuration msg))
))
