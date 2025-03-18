; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ParkingStatus.msg.html

(cl:defclass <ParkingStatus> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (parking_space
    :reader parking_space
    :initarg :parking_space
    :type itri_msgs-msg:ParkingSpace
    :initform (cl:make-instance 'itri_msgs-msg:ParkingSpace))
   (phase
    :reader phase
    :initarg :phase
    :type cl:integer
    :initform 0))
)

(cl:defclass ParkingStatus (<ParkingStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ParkingStatus> is deprecated: use itri_msgs-msg:ParkingStatus instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ParkingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'parking_space-val :lambda-list '(m))
(cl:defmethod parking_space-val ((m <ParkingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:parking_space-val is deprecated.  Use itri_msgs-msg:parking_space instead.")
  (parking_space m))

(cl:ensure-generic-function 'phase-val :lambda-list '(m))
(cl:defmethod phase-val ((m <ParkingStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:phase-val is deprecated.  Use itri_msgs-msg:phase instead.")
  (phase m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingStatus>) ostream)
  "Serializes a message object of type '<ParkingStatus>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'parking_space) ostream)
  (cl:let* ((signed (cl:slot-value msg 'phase)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingStatus>) istream)
  "Deserializes a message object of type '<ParkingStatus>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'parking_space) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'phase) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingStatus>)))
  "Returns string type for a message object of type '<ParkingStatus>"
  "itri_msgs/ParkingStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingStatus)))
  "Returns string type for a message object of type 'ParkingStatus"
  "itri_msgs/ParkingStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingStatus>)))
  "Returns md5sum for a message object of type '<ParkingStatus>"
  "2c35161911edba697231b25bf8199cb1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingStatus)))
  "Returns md5sum for a message object of type 'ParkingStatus"
  "2c35161911edba697231b25bf8199cb1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingStatus>)))
  "Returns full string definition for message of type '<ParkingStatus>"
  (cl:format cl:nil "Header header~%~%ParkingSpace parking_space~%int32 phase~%~%# Type of phase:~%# INITIAL   = 0~%# PHASE1    = 1~%# PHASE2    = 2~%# PHASE3    = 3~%# FINISH    = 4~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/ParkingSpace~%Header header~%~%int32 id~%int32 type~%WaypointArray array~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingStatus)))
  "Returns full string definition for message of type 'ParkingStatus"
  (cl:format cl:nil "Header header~%~%ParkingSpace parking_space~%int32 phase~%~%# Type of phase:~%# INITIAL   = 0~%# PHASE1    = 1~%# PHASE2    = 2~%# PHASE3    = 3~%# FINISH    = 4~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/ParkingSpace~%Header header~%~%int32 id~%int32 type~%WaypointArray array~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingStatus>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'parking_space))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingStatus
    (cl:cons ':header (header msg))
    (cl:cons ':parking_space (parking_space msg))
    (cl:cons ':phase (phase msg))
))
