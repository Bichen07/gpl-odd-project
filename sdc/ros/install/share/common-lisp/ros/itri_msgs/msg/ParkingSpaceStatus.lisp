; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ParkingSpaceStatus.msg.html

(cl:defclass <ParkingSpaceStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (array
    :reader array
    :initarg :array
    :type itri_msgs-msg:WaypointArray
    :initform (cl:make-instance 'itri_msgs-msg:WaypointArray)))
)

(cl:defclass ParkingSpaceStatus (<ParkingSpaceStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingSpaceStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingSpaceStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ParkingSpaceStatus> is deprecated: use itri_msgs-msg:ParkingSpaceStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ParkingSpaceStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ParkingSpaceStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ParkingSpaceStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:type-val is deprecated.  Use itri_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <ParkingSpaceStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:status-val is deprecated.  Use itri_msgs-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'array-val :lambda-list '(m))
(cl:defmethod array-val ((m <ParkingSpaceStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:array-val is deprecated.  Use itri_msgs-msg:array instead.")
  (array m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingSpaceStatus>) ostream)
  "Serializes a message object of type '<ParkingSpaceStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'array) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingSpaceStatus>) istream)
  "Deserializes a message object of type '<ParkingSpaceStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'array) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingSpaceStatus>)))
  "Returns string type for a message object of type '<ParkingSpaceStatus>"
  "itri_msgs/ParkingSpaceStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingSpaceStatus)))
  "Returns string type for a message object of type 'ParkingSpaceStatus"
  "itri_msgs/ParkingSpaceStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingSpaceStatus>)))
  "Returns md5sum for a message object of type '<ParkingSpaceStatus>"
  "80fd54c49f4ba8417b790d526b4c3d1e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingSpaceStatus)))
  "Returns md5sum for a message object of type 'ParkingSpaceStatus"
  "80fd54c49f4ba8417b790d526b4c3d1e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingSpaceStatus>)))
  "Returns full string definition for message of type '<ParkingSpaceStatus>"
  (cl:format cl:nil "Header header~%~%int32 id~%int32 type~%int32 status~%WaypointArray array~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingSpaceStatus)))
  "Returns full string definition for message of type 'ParkingSpaceStatus"
  (cl:format cl:nil "Header header~%~%int32 id~%int32 type~%int32 status~%WaypointArray array~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingSpaceStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'array))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingSpaceStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingSpaceStatus
    (cl:cons ':header (header msg))
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':status (status msg))
    (cl:cons ':array (array msg))
))
