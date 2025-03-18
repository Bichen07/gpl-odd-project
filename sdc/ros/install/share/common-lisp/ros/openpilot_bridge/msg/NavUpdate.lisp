; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude NavUpdate.msg.html

(cl:defclass <NavUpdate> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (isNavigating
    :reader isNavigating
    :initarg :isNavigating
    :type cl:boolean
    :initform cl:nil)
   (segments
    :reader segments
    :initarg :segments
    :type (cl:vector openpilot_bridge-msg:Segment)
   :initform (cl:make-array 0 :element-type 'openpilot_bridge-msg:Segment :initial-element (cl:make-instance 'openpilot_bridge-msg:Segment)))
   (curSegment
    :reader curSegment
    :initarg :curSegment
    :type cl:integer
    :initform 0))
)

(cl:defclass NavUpdate (<NavUpdate>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavUpdate>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavUpdate)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<NavUpdate> is deprecated: use openpilot_bridge-msg:NavUpdate instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <NavUpdate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'isNavigating-val :lambda-list '(m))
(cl:defmethod isNavigating-val ((m <NavUpdate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:isNavigating-val is deprecated.  Use openpilot_bridge-msg:isNavigating instead.")
  (isNavigating m))

(cl:ensure-generic-function 'segments-val :lambda-list '(m))
(cl:defmethod segments-val ((m <NavUpdate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:segments-val is deprecated.  Use openpilot_bridge-msg:segments instead.")
  (segments m))

(cl:ensure-generic-function 'curSegment-val :lambda-list '(m))
(cl:defmethod curSegment-val ((m <NavUpdate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:curSegment-val is deprecated.  Use openpilot_bridge-msg:curSegment instead.")
  (curSegment m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavUpdate>) ostream)
  "Serializes a message object of type '<NavUpdate>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isNavigating) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'segments))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'segments))
  (cl:let* ((signed (cl:slot-value msg 'curSegment)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavUpdate>) istream)
  "Deserializes a message object of type '<NavUpdate>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:slot-value msg 'isNavigating) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'segments) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'segments)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'openpilot_bridge-msg:Segment))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'curSegment) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavUpdate>)))
  "Returns string type for a message object of type '<NavUpdate>"
  "openpilot_bridge/NavUpdate")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavUpdate)))
  "Returns string type for a message object of type 'NavUpdate"
  "openpilot_bridge/NavUpdate")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavUpdate>)))
  "Returns md5sum for a message object of type '<NavUpdate>"
  "4056f0b47c0dc06ca95711174632cd20")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavUpdate)))
  "Returns md5sum for a message object of type 'NavUpdate"
  "4056f0b47c0dc06ca95711174632cd20")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavUpdate>)))
  "Returns full string definition for message of type '<NavUpdate>"
  (cl:format cl:nil "Header header~%~%bool isNavigating~%Segment[] segments~%int32 curSegment~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Segment~%Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavUpdate)))
  "Returns full string definition for message of type 'NavUpdate"
  (cl:format cl:nil "Header header~%~%bool isNavigating~%Segment[] segments~%int32 curSegment~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: openpilot_bridge/Segment~%Header header~%~%int32 distance~%int32 updateTime~%LatLng from~%uint32 instruction # enum const: Instruction~%LatLng[] parts~%LatLng to~%int32 crossTime~%int32 exitNo~%~%================================================================================~%MSG: openpilot_bridge/LatLng~%Header header~%~%float32 lat~%float32 lng~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavUpdate>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'segments) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavUpdate>))
  "Converts a ROS message object to a list"
  (cl:list 'NavUpdate
    (cl:cons ':header (header msg))
    (cl:cons ':isNavigating (isNavigating msg))
    (cl:cons ':segments (segments msg))
    (cl:cons ':curSegment (curSegment msg))
))
