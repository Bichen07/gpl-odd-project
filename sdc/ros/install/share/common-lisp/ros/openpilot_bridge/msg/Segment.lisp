; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude Segment.msg.html

(cl:defclass <Segment> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (distance
    :reader distance
    :initarg :distance
    :type cl:integer
    :initform 0)
   (updateTime
    :reader updateTime
    :initarg :updateTime
    :type cl:integer
    :initform 0)
   (from
    :reader from
    :initarg :from
    :type openpilot_bridge-msg:LatLng
    :initform (cl:make-instance 'openpilot_bridge-msg:LatLng))
   (instruction
    :reader instruction
    :initarg :instruction
    :type cl:integer
    :initform 0)
   (parts
    :reader parts
    :initarg :parts
    :type (cl:vector openpilot_bridge-msg:LatLng)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:LatLng :initial-element (cl:make-instance 'openpilot_bridge-msg:LatLng)))
   (to
    :reader to
    :initarg :to
    :type openpilot_bridge-msg:LatLng
    :initform (cl:make-instance 'openpilot_bridge-msg:LatLng))
   (crossTime
    :reader crossTime
    :initarg :crossTime
    :type cl:integer
    :initform 0)
   (exitNo
    :reader exitNo
    :initarg :exitNo
    :type cl:integer
    :initform 0))
)

(cl:defclass Segment (<Segment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Segment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Segment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<Segment> is deprecated: use openpilot_bridge-msg:Segment instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:distance-val is deprecated.  Use openpilot_bridge-msg:distance instead.")
  (distance m))

(cl:ensure-generic-function 'updateTime-val :lambda-list '(m))
(cl:defmethod updateTime-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:updateTime-val is deprecated.  Use openpilot_bridge-msg:updateTime instead.")
  (updateTime m))

(cl:ensure-generic-function 'from-val :lambda-list '(m))
(cl:defmethod from-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:from-val is deprecated.  Use openpilot_bridge-msg:from instead.")
  (from m))

(cl:ensure-generic-function 'instruction-val :lambda-list '(m))
(cl:defmethod instruction-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:instruction-val is deprecated.  Use openpilot_bridge-msg:instruction instead.")
  (instruction m))

(cl:ensure-generic-function 'parts-val :lambda-list '(m))
(cl:defmethod parts-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:parts-val is deprecated.  Use openpilot_bridge-msg:parts instead.")
  (parts m))

(cl:ensure-generic-function 'to-val :lambda-list '(m))
(cl:defmethod to-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:to-val is deprecated.  Use openpilot_bridge-msg:to instead.")
  (to m))

(cl:ensure-generic-function 'crossTime-val :lambda-list '(m))
(cl:defmethod crossTime-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:crossTime-val is deprecated.  Use openpilot_bridge-msg:crossTime instead.")
  (crossTime m))

(cl:ensure-generic-function 'exitNo-val :lambda-list '(m))
(cl:defmethod exitNo-val ((m <Segment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:exitNo-val is deprecated.  Use openpilot_bridge-msg:exitNo instead.")
  (exitNo m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Segment>) ostream)
  "Serializes a message object of type '<Segment>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'distance)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'updateTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'from) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'instruction)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'instruction)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'instruction)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'instruction)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parts))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'parts))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'to) ostream)
  (cl:let* ((signed (cl:slot-value msg 'crossTime)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'exitNo)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Segment>) istream)
  "Deserializes a message object of type '<Segment>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'distance) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'updateTime) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'from) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'instruction)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'instruction)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'instruction)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'instruction)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parts) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parts)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:LatLng))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'to) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'crossTime) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'exitNo) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Segment>)))
  "Returns string type for a message object of type '<Segment>"
  "openpilot_bridge/Segment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Segment)))
  "Returns string type for a message object of type 'Segment"
  "openpilot_bridge/Segment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Segment>)))
  "Returns md5sum for a message object of type '<Segment>"
  "dfbd5c3557c55dec73407d19d628c5ef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Segment)))
  "Returns md5sum for a message object of type 'Segment"
  "dfbd5c3557c55dec73407d19d628c5ef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Segment>)))
  "Returns full string definition for message of type '<Segment>"
  (cl:format cl:nil "Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Segment)))
  "Returns full string definition for message of type 'Segment"
  (cl:format cl:nil "Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Segment>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'from))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parts) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'to))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Segment>))
  "Converts a ROS message object to a list"
  (cl:list 'Segment
    (cl:cons ':header (header msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':updateTime (updateTime msg))
    (cl:cons ':from (from msg))
    (cl:cons ':instruction (instruction msg))
    (cl:cons ':parts (parts msg))
    (cl:cons ':to (to msg))
    (cl:cons ':crossTime (crossTime msg))
    (cl:cons ':exitNo (exitNo msg))
))
