; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude DetectedObjectCovarianceArray.msg.html

(cl:defclass <DetectedObjectCovarianceArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (covariance
    :reader covariance
    :initarg :covariance
    :type (cl:vector itri_msgs-msg:DetectedObjectCovariance)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:DetectedObjectCovariance :initial-element (cl:make-instance 'itri_msgs-msg:DetectedObjectCovariance))))
)

(cl:defclass DetectedObjectCovarianceArray (<DetectedObjectCovarianceArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedObjectCovarianceArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedObjectCovarianceArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<DetectedObjectCovarianceArray> is deprecated: use itri_msgs-msg:DetectedObjectCovarianceArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DetectedObjectCovarianceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'covariance-val :lambda-list '(m))
(cl:defmethod covariance-val ((m <DetectedObjectCovarianceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:covariance-val is deprecated.  Use itri_msgs-msg:covariance instead.")
  (covariance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedObjectCovarianceArray>) ostream)
  "Serializes a message object of type '<DetectedObjectCovarianceArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'covariance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'covariance))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedObjectCovarianceArray>) istream)
  "Deserializes a message object of type '<DetectedObjectCovarianceArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'covariance) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'covariance)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:DetectedObjectCovariance))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedObjectCovarianceArray>)))
  "Returns string type for a message object of type '<DetectedObjectCovarianceArray>"
  "itri_msgs/DetectedObjectCovarianceArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedObjectCovarianceArray)))
  "Returns string type for a message object of type 'DetectedObjectCovarianceArray"
  "itri_msgs/DetectedObjectCovarianceArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedObjectCovarianceArray>)))
  "Returns md5sum for a message object of type '<DetectedObjectCovarianceArray>"
  "84d2a2edd4fea20863397b757e83f10d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedObjectCovarianceArray)))
  "Returns md5sum for a message object of type 'DetectedObjectCovarianceArray"
  "84d2a2edd4fea20863397b757e83f10d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedObjectCovarianceArray>)))
  "Returns full string definition for message of type '<DetectedObjectCovarianceArray>"
  (cl:format cl:nil "std_msgs/Header header~%DetectedObjectCovariance[] covariance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/DetectedObjectCovariance~%std_msgs/Header header~%~%uint32 id~%float32 valueX~%float32 valueY~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedObjectCovarianceArray)))
  "Returns full string definition for message of type 'DetectedObjectCovarianceArray"
  (cl:format cl:nil "std_msgs/Header header~%DetectedObjectCovariance[] covariance~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/DetectedObjectCovariance~%std_msgs/Header header~%~%uint32 id~%float32 valueX~%float32 valueY~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedObjectCovarianceArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'covariance) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedObjectCovarianceArray>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedObjectCovarianceArray
    (cl:cons ':header (header msg))
    (cl:cons ':covariance (covariance msg))
))
