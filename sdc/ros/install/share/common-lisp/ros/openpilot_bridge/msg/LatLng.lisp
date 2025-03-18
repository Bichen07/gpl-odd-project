; Auto-generated. Do not edit!


(cl:in-package openpilot_bridge-msg)


;//! \htmlinclude LatLng.msg.html

(cl:defclass <LatLng> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (lat
    :reader lat
    :initarg :lat
    :type cl:float
    :initform 0.0)
   (lng
    :reader lng
    :initarg :lng
    :type cl:float
    :initform 0.0))
)

(cl:defclass LatLng (<LatLng>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LatLng>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LatLng)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name openpilot_bridge-msg:<LatLng> is deprecated: use openpilot_bridge-msg:LatLng instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LatLng>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:header-val is deprecated.  Use openpilot_bridge-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'lat-val :lambda-list '(m))
(cl:defmethod lat-val ((m <LatLng>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lat-val is deprecated.  Use openpilot_bridge-msg:lat instead.")
  (lat m))

(cl:ensure-generic-function 'lng-val :lambda-list '(m))
(cl:defmethod lng-val ((m <LatLng>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader openpilot_bridge-msg:lng-val is deprecated.  Use openpilot_bridge-msg:lng instead.")
  (lng m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LatLng>) ostream)
  "Serializes a message object of type '<LatLng>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'lat))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'lng))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LatLng>) istream)
  "Deserializes a message object of type '<LatLng>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lat) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'lng) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LatLng>)))
  "Returns string type for a message object of type '<LatLng>"
  "openpilot_bridge/LatLng")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LatLng)))
  "Returns string type for a message object of type 'LatLng"
  "openpilot_bridge/LatLng")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LatLng>)))
  "Returns md5sum for a message object of type '<LatLng>"
  "f7d1aaaa4fcd34d84f82ef94e7c9fe9d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LatLng)))
  "Returns md5sum for a message object of type 'LatLng"
  "f7d1aaaa4fcd34d84f82ef94e7c9fe9d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LatLng>)))
  "Returns full string definition for message of type '<LatLng>"
  (cl:format cl:nil "Header header~%~%float32 lat~%float32 lng~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LatLng)))
  "Returns full string definition for message of type 'LatLng"
  (cl:format cl:nil "Header header~%~%float32 lat~%float32 lng~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LatLng>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LatLng>))
  "Converts a ROS message object to a list"
  (cl:list 'LatLng
    (cl:cons ':header (header msg))
    (cl:cons ':lat (lat msg))
    (cl:cons ':lng (lng msg))
))
