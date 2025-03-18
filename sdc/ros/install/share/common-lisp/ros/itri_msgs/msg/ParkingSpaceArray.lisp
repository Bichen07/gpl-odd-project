; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ParkingSpaceArray.msg.html

(cl:defclass <ParkingSpaceArray> (roslisp-msg-protocol:ros-message)
  ((spaces
    :reader spaces
    :initarg :spaces
    :type (cl:vector itri_msgs-msg:ParkingSpace)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:ParkingSpace :initial-element (cl:make-instance 'itri_msgs-msg:ParkingSpace))))
)

(cl:defclass ParkingSpaceArray (<ParkingSpaceArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingSpaceArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingSpaceArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ParkingSpaceArray> is deprecated: use itri_msgs-msg:ParkingSpaceArray instead.")))

(cl:ensure-generic-function 'spaces-val :lambda-list '(m))
(cl:defmethod spaces-val ((m <ParkingSpaceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:spaces-val is deprecated.  Use itri_msgs-msg:spaces instead.")
  (spaces m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingSpaceArray>) ostream)
  "Serializes a message object of type '<ParkingSpaceArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'spaces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'spaces))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingSpaceArray>) istream)
  "Deserializes a message object of type '<ParkingSpaceArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'spaces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'spaces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:ParkingSpace))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingSpaceArray>)))
  "Returns string type for a message object of type '<ParkingSpaceArray>"
  "itri_msgs/ParkingSpaceArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingSpaceArray)))
  "Returns string type for a message object of type 'ParkingSpaceArray"
  "itri_msgs/ParkingSpaceArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingSpaceArray>)))
  "Returns md5sum for a message object of type '<ParkingSpaceArray>"
  "560ded1967ea6933ff0a5db78942a991")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingSpaceArray)))
  "Returns md5sum for a message object of type 'ParkingSpaceArray"
  "560ded1967ea6933ff0a5db78942a991")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingSpaceArray>)))
  "Returns full string definition for message of type '<ParkingSpaceArray>"
  (cl:format cl:nil "ParkingSpace[] spaces~%================================================================================~%MSG: itri_msgs/ParkingSpace~%Header header~%~%int32 id~%int32 type~%WaypointArray array~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingSpaceArray)))
  "Returns full string definition for message of type 'ParkingSpaceArray"
  (cl:format cl:nil "ParkingSpace[] spaces~%================================================================================~%MSG: itri_msgs/ParkingSpace~%Header header~%~%int32 id~%int32 type~%WaypointArray array~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/WaypointArray~%Header header~%~%uint8 FORWARD = 0~%uint8 BACKWARD = 1~%uint8 direction~%~%uint8 REGULAR = 0~%uint8 RRT = 1~%uint8 NONE = 2~%uint8 type~%~%Waypoint[] waypoints~%~%uint8 updateId~%float32 prob~%~%================================================================================~%MSG: itri_msgs/Waypoint~%geometry_msgs/PoseStamped pose~%geometry_msgs/TwistStamped twist~%int32 laneId~%int32 pointId~%geometry_msgs/Point point~%float32 heading~%float32 curvature~%float32 speed_limit~%int32 point_id~%int32 lane_id~%int32 nroad_id~%float32 s~%float32 d~%float32 left_space~%float32 right_space~%float32 width~%int32 road_type~%~%================================================================================~%MSG: geometry_msgs/PoseStamped~%# A Pose with reference coordinate frame and timestamp~%Header header~%Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/TwistStamped~%# A twist with reference coordinate frame and timestamp~%Header header~%Twist twist~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingSpaceArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'spaces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingSpaceArray>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingSpaceArray
    (cl:cons ':spaces (spaces msg))
))
