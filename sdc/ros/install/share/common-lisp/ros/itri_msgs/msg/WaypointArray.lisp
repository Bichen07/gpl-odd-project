; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude WaypointArray.msg.html

(cl:defclass <WaypointArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (direction
    :reader direction
    :initarg :direction
    :type cl:fixnum
    :initform 0)
   (type
    :reader type
    :initarg :type
    :type cl:fixnum
    :initform 0)
   (waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector itri_msgs-msg:Waypoint)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:Waypoint :initial-element (cl:make-instance 'itri_msgs-msg:Waypoint)))
   (updateId
    :reader updateId
    :initarg :updateId
    :type cl:fixnum
    :initform 0)
   (prob
    :reader prob
    :initarg :prob
    :type cl:float
    :initform 0.0))
)

(cl:defclass WaypointArray (<WaypointArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WaypointArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WaypointArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<WaypointArray> is deprecated: use itri_msgs-msg:WaypointArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'direction-val :lambda-list '(m))
(cl:defmethod direction-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:direction-val is deprecated.  Use itri_msgs-msg:direction instead.")
  (direction m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:type-val is deprecated.  Use itri_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:waypoints-val is deprecated.  Use itri_msgs-msg:waypoints instead.")
  (waypoints m))

(cl:ensure-generic-function 'updateId-val :lambda-list '(m))
(cl:defmethod updateId-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:updateId-val is deprecated.  Use itri_msgs-msg:updateId instead.")
  (updateId m))

(cl:ensure-generic-function 'prob-val :lambda-list '(m))
(cl:defmethod prob-val ((m <WaypointArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:prob-val is deprecated.  Use itri_msgs-msg:prob instead.")
  (prob m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<WaypointArray>)))
    "Constants for message type '<WaypointArray>"
  '((:FORWARD . 0)
    (:BACKWARD . 1)
    (:REGULAR . 0)
    (:RRT . 1)
    (:NONE . 2))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'WaypointArray)))
    "Constants for message type 'WaypointArray"
  '((:FORWARD . 0)
    (:BACKWARD . 1)
    (:REGULAR . 0)
    (:RRT . 1)
    (:NONE . 2))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WaypointArray>) ostream)
  "Serializes a message object of type '<WaypointArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direction)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'waypoints))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'updateId)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'prob))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WaypointArray>) istream)
  "Deserializes a message object of type '<WaypointArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'direction)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'type)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:Waypoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'updateId)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'prob) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WaypointArray>)))
  "Returns string type for a message object of type '<WaypointArray>"
  "itri_msgs/WaypointArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WaypointArray)))
  "Returns string type for a message object of type 'WaypointArray"
  "itri_msgs/WaypointArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WaypointArray>)))
  "Returns md5sum for a message object of type '<WaypointArray>"
  "59bb88c37fb9ca7353ec25612718a484")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WaypointArray)))
  "Returns md5sum for a message object of type 'WaypointArray"
  "59bb88c37fb9ca7353ec25612718a484")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WaypointArray>)))
  "Returns full string definition for message of type '<WaypointArray>"
  (cl:format cl:nil "Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WaypointArray)))
  "Returns full string definition for message of type 'WaypointArray"
  (cl:format cl:nil "Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WaypointArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WaypointArray>))
  "Converts a ROS message object to a list"
  (cl:list 'WaypointArray
    (cl:cons ':header (header msg))
    (cl:cons ':direction (direction msg))
    (cl:cons ':type (type msg))
    (cl:cons ':waypoints (waypoints msg))
    (cl:cons ':updateId (updateId msg))
    (cl:cons ':prob (prob msg))
))
