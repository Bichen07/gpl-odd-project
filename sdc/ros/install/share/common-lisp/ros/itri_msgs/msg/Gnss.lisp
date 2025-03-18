; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude Gnss.msg.html

(cl:defclass <Gnss> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (gps_state
    :reader gps_state
    :initarg :gps_state
    :type cl:fixnum
    :initform 0)
   (heading_info
    :reader heading_info
    :initarg :heading_info
    :type cl:boolean
    :initform cl:nil)
   (gpgga_is_exit
    :reader gpgga_is_exit
    :initarg :gpgga_is_exit
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Gnss (<Gnss>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Gnss>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Gnss)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<Gnss> is deprecated: use itri_msgs-msg:Gnss instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'gps_state-val :lambda-list '(m))
(cl:defmethod gps_state-val ((m <Gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gps_state-val is deprecated.  Use itri_msgs-msg:gps_state instead.")
  (gps_state m))

(cl:ensure-generic-function 'heading_info-val :lambda-list '(m))
(cl:defmethod heading_info-val ((m <Gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:heading_info-val is deprecated.  Use itri_msgs-msg:heading_info instead.")
  (heading_info m))

(cl:ensure-generic-function 'gpgga_is_exit-val :lambda-list '(m))
(cl:defmethod gpgga_is_exit-val ((m <Gnss>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:gpgga_is_exit-val is deprecated.  Use itri_msgs-msg:gpgga_is_exit instead.")
  (gpgga_is_exit m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<Gnss>)))
    "Constants for message type '<Gnss>"
  '((:INVALID . 0)
    (:GPS . 1)
    (:DGPS . 2)
    (:RTK_FIXED . 4)
    (:RTK_FLOAT . 5))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'Gnss)))
    "Constants for message type 'Gnss"
  '((:INVALID . 0)
    (:GPS . 1)
    (:DGPS . 2)
    (:RTK_FIXED . 4)
    (:RTK_FLOAT . 5))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Gnss>) ostream)
  "Serializes a message object of type '<Gnss>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'heading_info) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'gpgga_is_exit) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Gnss>) istream)
  "Deserializes a message object of type '<Gnss>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'gps_state)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading_info) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'gpgga_is_exit) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Gnss>)))
  "Returns string type for a message object of type '<Gnss>"
  "itri_msgs/Gnss")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Gnss)))
  "Returns string type for a message object of type 'Gnss"
  "itri_msgs/Gnss")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Gnss>)))
  "Returns md5sum for a message object of type '<Gnss>"
  "61f647323695d7fb42c71d38c42a68c5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Gnss)))
  "Returns md5sum for a message object of type 'Gnss"
  "61f647323695d7fb42c71d38c42a68c5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Gnss>)))
  "Returns full string definition for message of type '<Gnss>"
  (cl:format cl:nil "uint8 INVALID=0~%uint8 GPS=1~%uint8 DGPS=2~%uint8 RTK_FIXED=4~%uint8 RTK_FLOAT=5~%~%Header header~%geometry_msgs/Pose pose~%uint8 gps_state~%bool heading_info~%bool gpgga_is_exit~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Gnss)))
  "Returns full string definition for message of type 'Gnss"
  (cl:format cl:nil "uint8 INVALID=0~%uint8 GPS=1~%uint8 DGPS=2~%uint8 RTK_FIXED=4~%uint8 RTK_FLOAT=5~%~%Header header~%geometry_msgs/Pose pose~%uint8 gps_state~%bool heading_info~%bool gpgga_is_exit~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Gnss>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Gnss>))
  "Converts a ROS message object to a list"
  (cl:list 'Gnss
    (cl:cons ':header (header msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':gps_state (gps_state msg))
    (cl:cons ':heading_info (heading_info msg))
    (cl:cons ':gpgga_is_exit (gpgga_is_exit msg))
))
