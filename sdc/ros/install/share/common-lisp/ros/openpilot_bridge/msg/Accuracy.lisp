; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Accuracy.msg.html

(cl:defclass <Accuracy> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (vNEDError
    :reader vNEDError
    :initarg :vNEDError
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (rollError
    :reader rollError
    :initarg :rollError
    :type cl:float
    :initform 0.0)
   (headingError
    :reader headingError
    :initarg :headingError
    :type cl:float
    :initform 0.0)
   (ellipsoidSemiMajorError
    :reader ellipsoidSemiMajorError
    :initarg :ellipsoidSemiMajorError
    :type cl:float
    :initform 0.0)
   (ellipsoidOrientationError
    :reader ellipsoidOrientationError
    :initarg :ellipsoidOrientationError
    :type cl:float
    :initform 0.0)
   (pNEDError
    :reader pNEDError
    :initarg :pNEDError
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (ellipsoidSemiMinorError
    :reader ellipsoidSemiMinorError
    :initarg :ellipsoidSemiMinorError
    :type cl:float
    :initform 0.0)
   (pitchError
    :reader pitchError
    :initarg :pitchError
    :type cl:float
    :initform 0.0))
)

(cl:defclass Accuracy (<Accuracy>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Accuracy>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Accuracy)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Accuracy> is deprecated: use openpilot_bridge-msg:Accuracy instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'vNEDError-val :lambda-list '(m))
(cl:defmethod vNEDError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:vNEDError-val is deprecated.  Use openpilot_bridge-msg:vNEDError instead.")
  (vNEDError m))

(cl:ensure-generic-function 'rollError-val :lambda-list '(m))
(cl:defmethod rollError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:rollError-val is deprecated.  Use openpilot_bridge-msg:rollError instead.")
  (rollError m))

(cl:ensure-generic-function 'headingError-val :lambda-list '(m))
(cl:defmethod headingError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:headingError-val is deprecated.  Use openpilot_bridge-msg:headingError instead.")
  (headingError m))

(cl:ensure-generic-function 'ellipsoidSemiMajorError-val :lambda-list '(m))
(cl:defmethod ellipsoidSemiMajorError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ellipsoidSemiMajorError-val is deprecated.  Use openpilot_bridge-msg:ellipsoidSemiMajorError instead.")
  (ellipsoidSemiMajorError m))

(cl:ensure-generic-function 'ellipsoidOrientationError-val :lambda-list '(m))
(cl:defmethod ellipsoidOrientationError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ellipsoidOrientationError-val is deprecated.  Use openpilot_bridge-msg:ellipsoidOrientationError instead.")
  (ellipsoidOrientationError m))

(cl:ensure-generic-function 'pNEDError-val :lambda-list '(m))
(cl:defmethod pNEDError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pNEDError-val is deprecated.  Use openpilot_bridge-msg:pNEDError instead.")
  (pNEDError m))

(cl:ensure-generic-function 'ellipsoidSemiMinorError-val :lambda-list '(m))
(cl:defmethod ellipsoidSemiMinorError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:ellipsoidSemiMinorError-val is deprecated.  Use openpilot_bridge-msg:ellipsoidSemiMinorError instead.")
  (ellipsoidSemiMinorError m))

(cl:ensure-generic-function 'pitchError-val :lambda-list '(m))
(cl:defmethod pitchError-val ((m <Accuracy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pitchError-val is deprecated.  Use openpilot_bridge-msg:pitchError instead.")
  (pitchError m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Accuracy>) ostream)
  "Serializes a message object of type '<Accuracy>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'vNEDError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'vNEDError))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'rollError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'headingError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ellipsoidSemiMajorError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ellipsoidOrientationError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pNEDError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'pNEDError))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ellipsoidSemiMinorError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pitchError))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Accuracy>) istream)
  "Deserializes a message object of type '<Accuracy>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'vNEDError) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'vNEDError)))
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
    (cl:setf (cl:slot-value msg 'rollError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'headingError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ellipsoidSemiMajorError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ellipsoidOrientationError) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pNEDError) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pNEDError)))
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
    (cl:setf (cl:slot-value msg 'ellipsoidSemiMinorError) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pitchError) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Accuracy>)))
  "Returns string type for a message object of type '<Accuracy>"
  "openpilot_bridge/Accuracy")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Accuracy)))
  "Returns string type for a message object of type 'Accuracy"
  "openpilot_bridge/Accuracy")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Accuracy>)))
  "Returns md5sum for a message object of type '<Accuracy>"
  "edfdee1e677d557df6dcfc54fda17a60")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Accuracy)))
  "Returns md5sum for a message object of type 'Accuracy"
  "edfdee1e677d557df6dcfc54fda17a60")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Accuracy>)))
  "Returns full string definition for message of type '<Accuracy>"
  (cl:format cl:nil "Header header~%~%float32[] vNEDError~%float32 rollError~%float32 headingError~%float32 ellipsoidSemiMajorError~%float32 ellipsoidOrientationError~%float32[] pNEDError~%float32 ellipsoidSemiMinorError~%float32 pitchError~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Accuracy)))
  "Returns full string definition for message of type 'Accuracy"
  (cl:format cl:nil "Header header~%~%float32[] vNEDError~%float32 rollError~%float32 headingError~%float32 ellipsoidSemiMajorError~%float32 ellipsoidOrientationError~%float32[] pNEDError~%float32 ellipsoidSemiMinorError~%float32 pitchError~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Accuracy>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'vNEDError) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pNEDError) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Accuracy>))
  "Converts a ROS message object to a list"
  (cl:list 'Accuracy
    (cl:cons ':header (header msg))
    (cl:cons ':vNEDError (vNEDError msg))
    (cl:cons ':rollError (rollError msg))
    (cl:cons ':headingError (headingError msg))
    (cl:cons ':ellipsoidSemiMajorError (ellipsoidSemiMajorError msg))
    (cl:cons ':ellipsoidOrientationError (ellipsoidOrientationError msg))
    (cl:cons ':pNEDError (pNEDError msg))
    (cl:cons ':ellipsoidSemiMinorError (ellipsoidSemiMinorError msg))
    (cl:cons ':pitchError (pitchError msg))
))
