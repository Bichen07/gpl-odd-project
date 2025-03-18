; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude GPSPlannerPoints.msg.html

(cl:defclass <GPSPlannerPoints> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (accelTarget
    :reader accelTarget
    :initarg :accelTarget
    :type cl:float
    :initform 0.0)
   (pointsDEPRECATED
    :reader pointsDEPRECATED
    :initarg :pointsDEPRECATED
    :type (cl:vector openpilot_bridge-msg:ECEFPointDEPRECATED)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:ECEFPointDEPRECATED :initial-element (cl:make-instance 'openpilot_bridge-msg:ECEFPointDEPRECATED)))
   (trackName
    :reader trackName
    :initarg :trackName
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (curPos
    :reader curPos
    :initarg :curPos
    :type openpilot_bridge-msg:ECEFPoint
    :initform (cl:make-instance 'openpilot_bridge-msg:ECEFPoint))
   (valid
    :reader valid
    :initarg :valid
    :type cl:boolean
    :initform cl:nil)
   (speedLimit
    :reader speedLimit
    :initarg :speedLimit
    :type cl:float
    :initform 0.0)
   (curPosDEPRECATED
    :reader curPosDEPRECATED
    :initarg :curPosDEPRECATED
    :type openpilot_bridge-msg:ECEFPointDEPRECATED
    :initform (cl:make-instance 'openpilot_bridge-msg:ECEFPointDEPRECATED))
   (points
    :reader points
    :initarg :points
    :type (cl:vector openpilot_bridge-msg:ECEFPoint)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:ECEFPoint :initial-element (cl:make-instance 'openpilot_bridge-msg:ECEFPoint))))
)

(cl:defclass GPSPlannerPoints (<GPSPlannerPoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GPSPlannerPoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GPSPlannerPoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<GPSPlannerPoints> is deprecated: use openpilot_bridge-msg:GPSPlannerPoints instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'accelTarget-val :lambda-list '(m))
(cl:defmethod accelTarget-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:accelTarget-val is deprecated.  Use openpilot_bridge-msg:accelTarget instead.")
  (accelTarget m))

(cl:ensure-generic-function 'pointsDEPRECATED-val :lambda-list '(m))
(cl:defmethod pointsDEPRECATED-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:pointsDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:pointsDEPRECATED instead.")
  (pointsDEPRECATED m))

(cl:ensure-generic-function 'trackName-val :lambda-list '(m))
(cl:defmethod trackName-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:trackName-val is deprecated.  Use openpilot_bridge-msg:trackName instead.")
  (trackName m))

(cl:ensure-generic-function 'curPos-val :lambda-list '(m))
(cl:defmethod curPos-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curPos-val is deprecated.  Use openpilot_bridge-msg:curPos instead.")
  (curPos m))

(cl:ensure-generic-function 'valid-val :lambda-list '(m))
(cl:defmethod valid-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:valid-val is deprecated.  Use openpilot_bridge-msg:valid instead.")
  (valid m))

(cl:ensure-generic-function 'speedLimit-val :lambda-list '(m))
(cl:defmethod speedLimit-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:speedLimit-val is deprecated.  Use openpilot_bridge-msg:speedLimit instead.")
  (speedLimit m))

(cl:ensure-generic-function 'curPosDEPRECATED-val :lambda-list '(m))
(cl:defmethod curPosDEPRECATED-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curPosDEPRECATED-val is deprecated.  Use openpilot_bridge-msg:curPosDEPRECATED instead.")
  (curPosDEPRECATED m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <GPSPlannerPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:points-val is deprecated.  Use openpilot_bridge-msg:points instead.")
  (points m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GPSPlannerPoints>) ostream)
  "Serializes a message object of type '<GPSPlannerPoints>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'accelTarget))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pointsDEPRECATED))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pointsDEPRECATED))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'trackName))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'trackName))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'curPos) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'valid) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speedLimit))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'curPosDEPRECATED) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GPSPlannerPoints>) istream)
  "Deserializes a message object of type '<GPSPlannerPoints>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'accelTarget) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pointsDEPRECATED) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pointsDEPRECATED)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:ECEFPointDEPRECATED))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'trackName) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'trackName)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'curPos) istream)
    (cl:setf (cl:slot-value msg 'valid) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speedLimit) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'curPosDEPRECATED) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:ECEFPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GPSPlannerPoints>)))
  "Returns string type for a message object of type '<GPSPlannerPoints>"
  "openpilot_bridge/GPSPlannerPoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GPSPlannerPoints)))
  "Returns string type for a message object of type 'GPSPlannerPoints"
  "openpilot_bridge/GPSPlannerPoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GPSPlannerPoints>)))
  "Returns md5sum for a message object of type '<GPSPlannerPoints>"
  "2dad0805756f4e9be824594497faa155")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GPSPlannerPoints)))
  "Returns md5sum for a message object of type 'GPSPlannerPoints"
  "2dad0805756f4e9be824594497faa155")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GPSPlannerPoints>)))
  "Returns full string definition for message of type '<GPSPlannerPoints>"
  (cl:format cl:nil "Header header~%~%float32 accelTarget~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%ECEFPoint curPos~%bool valid~%float32 speedLimit~%ECEFPointDEPRECATED curPosDEPRECATED~%ECEFPoint[] points~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GPSPlannerPoints)))
  "Returns full string definition for message of type 'GPSPlannerPoints"
  (cl:format cl:nil "Header header~%~%float32 accelTarget~%ECEFPointDEPRECATED[] pointsDEPRECATED~%string[] trackName~%ECEFPoint curPos~%bool valid~%float32 speedLimit~%ECEFPointDEPRECATED curPosDEPRECATED~%ECEFPoint[] points~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/ECEFPointDEPRECATED~%Header header~%~%float32 y~%float32 x~%float32 z~%~%================================================================================~%MSG: openpilot_bridge/ECEFPoint~%Header header~%~%float32 y~%float32 x~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GPSPlannerPoints>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pointsDEPRECATED) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'trackName) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'curPos))
     1
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'curPosDEPRECATED))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GPSPlannerPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'GPSPlannerPoints
    (cl:cons ':header (header msg))
    (cl:cons ':accelTarget (accelTarget msg))
    (cl:cons ':pointsDEPRECATED (pointsDEPRECATED msg))
    (cl:cons ':trackName (trackName msg))
    (cl:cons ':curPos (curPos msg))
    (cl:cons ':valid (valid msg))
    (cl:cons ':speedLimit (speedLimit msg))
    (cl:cons ':curPosDEPRECATED (curPosDEPRECATED msg))
    (cl:cons ':points (points msg))
))
