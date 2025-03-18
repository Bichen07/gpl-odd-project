; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude Ars40xObjects.msg.html

(cl:defclass <Ars40xObjects> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objs
    :reader objs
    :initarg :objs
    :type (cl:vector itri_msgs-msg:Ars40xObject)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:Ars40xObject :initial-element (cl:make-instance 'itri_msgs-msg:Ars40xObject))))
)

(cl:defclass Ars40xObjects (<Ars40xObjects>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ars40xObjects>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ars40xObjects)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<Ars40xObjects> is deprecated: use itri_msgs-msg:Ars40xObjects instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Ars40xObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objs-val :lambda-list '(m))
(cl:defmethod objs-val ((m <Ars40xObjects>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:objs-val is deprecated.  Use itri_msgs-msg:objs instead.")
  (objs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ars40xObjects>) ostream)
  "Serializes a message object of type '<Ars40xObjects>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ars40xObjects>) istream)
  "Deserializes a message object of type '<Ars40xObjects>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:Ars40xObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ars40xObjects>)))
  "Returns string type for a message object of type '<Ars40xObjects>"
  "itri_msgs/Ars40xObjects")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ars40xObjects)))
  "Returns string type for a message object of type 'Ars40xObjects"
  "itri_msgs/Ars40xObjects")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ars40xObjects>)))
  "Returns md5sum for a message object of type '<Ars40xObjects>"
  "4164e9c06a4bd1d54578ef1b78fe9ad7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ars40xObjects)))
  "Returns md5sum for a message object of type 'Ars40xObjects"
  "4164e9c06a4bd1d54578ef1b78fe9ad7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ars40xObjects>)))
  "Returns full string definition for message of type '<Ars40xObjects>"
  (cl:format cl:nil "Header header~%Ars40xObject[] objs~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/Ars40xObject~%# while persists in consecutive messages - it is the same object, if disappears and appears again - new one~%uint8 id~%~%float32 width~%float32 length~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%geometry_msgs/Accel acceleration~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 POINT = 0~%uint8 CAR = 1~%uint8 TRUCK = 2~%uint8 MOTORCYCLE = 4~%uint8 BICYCLE = 5~%uint8 WIDE = 6~%uint8 Class~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 DELETED = 0~%uint8 NEW_CREATED = 1~%uint8 MEASURED = 2~%uint8 PREDICTED = 3~%uint8 DELETED_FOR_MERGE = 4~%uint8 NEW_FROM_MERGE = 5~%uint8 measurment~%~%# probability of existence, percentage~%float32 probability~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Accel~%# This expresses acceleration in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ars40xObjects)))
  "Returns full string definition for message of type 'Ars40xObjects"
  (cl:format cl:nil "Header header~%Ars40xObject[] objs~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/Ars40xObject~%# while persists in consecutive messages - it is the same object, if disappears and appears again - new one~%uint8 id~%~%float32 width~%float32 length~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%geometry_msgs/Accel acceleration~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 POINT = 0~%uint8 CAR = 1~%uint8 TRUCK = 2~%uint8 MOTORCYCLE = 4~%uint8 BICYCLE = 5~%uint8 WIDE = 6~%uint8 Class~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 DELETED = 0~%uint8 NEW_CREATED = 1~%uint8 MEASURED = 2~%uint8 PREDICTED = 3~%uint8 DELETED_FOR_MERGE = 4~%uint8 NEW_FROM_MERGE = 5~%uint8 measurment~%~%# probability of existence, percentage~%float32 probability~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Accel~%# This expresses acceleration in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ars40xObjects>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ars40xObjects>))
  "Converts a ROS message object to a list"
  (cl:list 'Ars40xObjects
    (cl:cons ':header (header msg))
    (cl:cons ':objs (objs msg))
))
