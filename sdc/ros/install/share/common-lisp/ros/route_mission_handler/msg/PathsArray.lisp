; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude PathsArray.msg.html

(cl:defclass <PathsArray> (roslisp-msg-protocol:ros-message)
  ((paths
    :reader paths
    :initarg :paths
    :type (cl:vector route_mission_handler-msg:Paths)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Paths :initial-element (cl:make-instance 'route_mission_handler-msg:Paths))))
)

(cl:defclass PathsArray (<PathsArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PathsArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PathsArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<PathsArray> is deprecated: use route_mission_handler-msg:PathsArray instead.")))

(cl:ensure-generic-function 'paths-val :lambda-list '(m))
(cl:defmethod paths-val ((m <PathsArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:paths-val is deprecated.  Use route_mission_handler-msg:paths instead.")
  (paths m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PathsArray>) ostream)
  "Serializes a message object of type '<PathsArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'paths))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'paths))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PathsArray>) istream)
  "Deserializes a message object of type '<PathsArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'paths) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'paths)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Paths))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PathsArray>)))
  "Returns string type for a message object of type '<PathsArray>"
  "route_mission_handler/PathsArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathsArray)))
  "Returns string type for a message object of type 'PathsArray"
  "route_mission_handler/PathsArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PathsArray>)))
  "Returns md5sum for a message object of type '<PathsArray>"
  "41d15ff121904e5150d2e5a68706b573")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PathsArray)))
  "Returns md5sum for a message object of type 'PathsArray"
  "41d15ff121904e5150d2e5a68706b573")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PathsArray>)))
  "Returns full string definition for message of type '<PathsArray>"
  (cl:format cl:nil "Paths[] paths~%~%================================================================================~%MSG: route_mission_handler/Paths~%string name~%string handdrive~%Lanes[] lanes~%float64[] distances~%uint32[] directions~%bool isParkingPath~%~%================================================================================~%MSG: route_mission_handler/Lanes~%int32 type~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 id~%bool isTurn~%bool direction~%int32 laneno~%int32[] nexts~%int32[] roadLineIds~%Waypoints[] points~%int32 max_speed_limit~%int32 roadType~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PathsArray)))
  "Returns full string definition for message of type 'PathsArray"
  (cl:format cl:nil "Paths[] paths~%~%================================================================================~%MSG: route_mission_handler/Paths~%string name~%string handdrive~%Lanes[] lanes~%float64[] distances~%uint32[] directions~%bool isParkingPath~%~%================================================================================~%MSG: route_mission_handler/Lanes~%int32 type~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 id~%bool isTurn~%bool direction~%int32 laneno~%int32[] nexts~%int32[] roadLineIds~%Waypoints[] points~%int32 max_speed_limit~%int32 roadType~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PathsArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'paths) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PathsArray>))
  "Converts a ROS message object to a list"
  (cl:list 'PathsArray
    (cl:cons ':paths (paths msg))
))
