; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude lane_waypoints_info.msg.html

(cl:defclass <lane_waypoints_info> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (point
    :reader point
    :initarg :point
    :type (cl:vector itri_msgs-msg:lane_info)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:lane_info :initial-element (cl:make-instance 'itri_msgs-msg:lane_info))))
)

(cl:defclass lane_waypoints_info (<lane_waypoints_info>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <lane_waypoints_info>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'lane_waypoints_info)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<lane_waypoints_info> is deprecated: use itri_msgs-msg:lane_waypoints_info instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <lane_waypoints_info>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <lane_waypoints_info>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:point-val is deprecated.  Use itri_msgs-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <lane_waypoints_info>) ostream)
  "Serializes a message object of type '<lane_waypoints_info>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'point))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'point))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <lane_waypoints_info>) istream)
  "Deserializes a message object of type '<lane_waypoints_info>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'point) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'point)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:lane_info))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<lane_waypoints_info>)))
  "Returns string type for a message object of type '<lane_waypoints_info>"
  "itri_msgs/lane_waypoints_info")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'lane_waypoints_info)))
  "Returns string type for a message object of type 'lane_waypoints_info"
  "itri_msgs/lane_waypoints_info")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<lane_waypoints_info>)))
  "Returns md5sum for a message object of type '<lane_waypoints_info>"
  "01267141f4f69eaeb661c3d3af07f166")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'lane_waypoints_info)))
  "Returns md5sum for a message object of type 'lane_waypoints_info"
  "01267141f4f69eaeb661c3d3af07f166")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<lane_waypoints_info>)))
  "Returns full string definition for message of type '<lane_waypoints_info>"
  (cl:format cl:nil "Header header~%~%lane_info[] point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/lane_info~%Header header~%int32 lane_id   #current lane~%int32 lane_num  #total number of lane~%float32 lane_width~%~%string[] line_pos~%~%# Right = 'R'~%# Left  = 'L'~%# Front = 'F'~%~%uint32[] line_type~%~%# EMPTY = 0~%# WHITE_DASHED_LINE = 1~%# WHITE_SOLID_LINE = 2~%# WHITE_DOUBLE_LINE = 3~%# YELLOW_DASHED_LINE~%# YELLOW_SOLID_LINE~%# YELLOW_DOUBLE_LINE~%# RED_SOLID_LINE~%# STRAIGHT_ARROW~%# TURN_LEFT_ARROW~%# TURN_RIGHT_ARROW~%# STRAIGHT_OR_RIGHT_ARROW~%# STRAIGHT_OR_LEFT_ARROW~%# TURN_RIGHT_ONLY~%# STOP_LINE~%# LONGER_BUMP~%# SHORTER_BUMP~%# SLOWDOWN~%# YIELD~%# STOP_SIGN~%# SPEED_LIMIT_20KPH~%# SPEED_LIMIT_30KPH~%# SPEED_LIMIT_50KPH~%# SCOOTER_PARKING_PLACE~%# PARKING_SPACE~%~%float64 front_line_dis~%~%bool[] on_route_hint~%int32[] traffic_stop_line~%int32[] bumper~%int32[] start_right_turn~%int32[] end_right_turn~%int32[] start_left_turn~%int32[] end_left_turn~%~%Waypoint front_marker_point~%~%StationInfo[] stations~%string station_msg~%~%float64 remind_distance~%int32 remind_time~%~%int32 turn_type~%float64 length_to_turn~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: itri_msgs/StationInfo~%string name~%bool isPass~%Waypoint location~%int32 nearPointIndex~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'lane_waypoints_info)))
  "Returns full string definition for message of type 'lane_waypoints_info"
  (cl:format cl:nil "Header header~%~%lane_info[] point~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/lane_info~%Header header~%int32 lane_id   #current lane~%int32 lane_num  #total number of lane~%float32 lane_width~%~%string[] line_pos~%~%# Right = 'R'~%# Left  = 'L'~%# Front = 'F'~%~%uint32[] line_type~%~%# EMPTY = 0~%# WHITE_DASHED_LINE = 1~%# WHITE_SOLID_LINE = 2~%# WHITE_DOUBLE_LINE = 3~%# YELLOW_DASHED_LINE~%# YELLOW_SOLID_LINE~%# YELLOW_DOUBLE_LINE~%# RED_SOLID_LINE~%# STRAIGHT_ARROW~%# TURN_LEFT_ARROW~%# TURN_RIGHT_ARROW~%# STRAIGHT_OR_RIGHT_ARROW~%# STRAIGHT_OR_LEFT_ARROW~%# TURN_RIGHT_ONLY~%# STOP_LINE~%# LONGER_BUMP~%# SHORTER_BUMP~%# SLOWDOWN~%# YIELD~%# STOP_SIGN~%# SPEED_LIMIT_20KPH~%# SPEED_LIMIT_30KPH~%# SPEED_LIMIT_50KPH~%# SCOOTER_PARKING_PLACE~%# PARKING_SPACE~%~%float64 front_line_dis~%~%bool[] on_route_hint~%int32[] traffic_stop_line~%int32[] bumper~%int32[] start_right_turn~%int32[] end_right_turn~%int32[] start_left_turn~%int32[] end_left_turn~%~%Waypoint front_marker_point~%~%StationInfo[] stations~%string station_msg~%~%float64 remind_distance~%int32 remind_time~%~%int32 turn_type~%float64 length_to_turn~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: itri_msgs/StationInfo~%string name~%bool isPass~%Waypoint location~%int32 nearPointIndex~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <lane_waypoints_info>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'point) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <lane_waypoints_info>))
  "Converts a ROS message object to a list"
  (cl:list 'lane_waypoints_info
    (cl:cons ':header (header msg))
    (cl:cons ':point (point msg))
))
