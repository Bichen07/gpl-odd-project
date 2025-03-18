; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude StationInfoArray.msg.html

(cl:defclass <StationInfoArray> (roslisp-msg-protocol:ros-message)
  ((stations
    :reader stations
    :initarg :stations
    :type (cl:vector itri_msgs-msg:StationInfo)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:StationInfo :initial-element (cl:make-instance 'itri_msgs-msg:StationInfo))))
)

(cl:defclass StationInfoArray (<StationInfoArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StationInfoArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StationInfoArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<StationInfoArray> is deprecated: use itri_msgs-msg:StationInfoArray instead.")))

(cl:ensure-generic-function 'stations-val :lambda-list '(m))
(cl:defmethod stations-val ((m <StationInfoArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:stations-val is deprecated.  Use itri_msgs-msg:stations instead.")
  (stations m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StationInfoArray>) ostream)
  "Serializes a message object of type '<StationInfoArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'stations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'stations))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StationInfoArray>) istream)
  "Deserializes a message object of type '<StationInfoArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'stations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'stations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:StationInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StationInfoArray>)))
  "Returns string type for a message object of type '<StationInfoArray>"
  "itri_msgs/StationInfoArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StationInfoArray)))
  "Returns string type for a message object of type 'StationInfoArray"
  "itri_msgs/StationInfoArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StationInfoArray>)))
  "Returns md5sum for a message object of type '<StationInfoArray>"
  "a7c51c88473a82f58580c70915f0eac3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StationInfoArray)))
  "Returns md5sum for a message object of type 'StationInfoArray"
  "a7c51c88473a82f58580c70915f0eac3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StationInfoArray>)))
  "Returns full string definition for message of type '<StationInfoArray>"
  (cl:format cl:nil "StationInfo[] stations~%================================================================================~%MSG: itri_msgs/StationInfo~%string name~%bool isPass~%Waypoint location~%int32 nearPointIndex~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StationInfoArray)))
  "Returns full string definition for message of type 'StationInfoArray"
  (cl:format cl:nil "StationInfo[] stations~%================================================================================~%MSG: itri_msgs/StationInfo~%string name~%bool isPass~%Waypoint location~%int32 nearPointIndex~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StationInfoArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'stations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StationInfoArray>))
  "Converts a ROS message object to a list"
  (cl:list 'StationInfoArray
    (cl:cons ':stations (stations msg))
))
