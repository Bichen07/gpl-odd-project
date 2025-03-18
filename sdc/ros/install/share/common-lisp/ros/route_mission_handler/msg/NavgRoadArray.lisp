; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude NavgRoadArray.msg.html

(cl:defclass <NavgRoadArray> (roslisp-msg-protocol:ros-message)
  ((navgroads
    :reader navgroads
    :initarg :navgroads
    :type (cl:vector route_mission_handler-msg:NavgRoad)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:NavgRoad :initial-element (cl:make-instance 'route_mission_handler-msg:NavgRoad))))
)

(cl:defclass NavgRoadArray (<NavgRoadArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NavgRoadArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NavgRoadArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<NavgRoadArray> is deprecated: use route_mission_handler-msg:NavgRoadArray instead.")))

(cl:ensure-generic-function 'navgroads-val :lambda-list '(m))
(cl:defmethod navgroads-val ((m <NavgRoadArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:navgroads-val is deprecated.  Use route_mission_handler-msg:navgroads instead.")
  (navgroads m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NavgRoadArray>) ostream)
  "Serializes a message object of type '<NavgRoadArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'navgroads))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'navgroads))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NavgRoadArray>) istream)
  "Deserializes a message object of type '<NavgRoadArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'navgroads) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'navgroads)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:NavgRoad))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NavgRoadArray>)))
  "Returns string type for a message object of type '<NavgRoadArray>"
  "route_mission_handler/NavgRoadArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NavgRoadArray)))
  "Returns string type for a message object of type 'NavgRoadArray"
  "route_mission_handler/NavgRoadArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NavgRoadArray>)))
  "Returns md5sum for a message object of type '<NavgRoadArray>"
  "f4863e0e051c2896d5fc07e0c9811ff2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NavgRoadArray)))
  "Returns md5sum for a message object of type 'NavgRoadArray"
  "f4863e0e051c2896d5fc07e0c9811ff2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NavgRoadArray>)))
  "Returns full string definition for message of type '<NavgRoadArray>"
  (cl:format cl:nil "NavgRoad[] navgroads~%================================================================================~%MSG: route_mission_handler/NavgRoad~%int32 ITRI_AREA=5~%int32 EXPRESS_WAY=8~%int32 EXIT_GATEWAY=20~%int32 ENTRY_GATEWAY=21~%~%int32 id~%int32 positiveLaneNum~%int32 negativeLaneNum~%bool twoWay~%int32[] positiveLaneIds~%int32[] negativeLaneIds~%int32 mode~%int32 r_class~%int32 routing~%float32 n_as~%float32 n_kph~%float32 p_as~%float32 p_kph~%float32 length~%ItriPoint[] points~%ConnectedNavgRoad[] heads~%ConnectedNavgRoad[] tails~%int32 type~%~%================================================================================~%MSG: route_mission_handler/ItriPoint~%int32 id~%int32 belongId~%int32 pointId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: route_mission_handler/ConnectedNavgRoad~%int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NavgRoadArray)))
  "Returns full string definition for message of type 'NavgRoadArray"
  (cl:format cl:nil "NavgRoad[] navgroads~%================================================================================~%MSG: route_mission_handler/NavgRoad~%int32 ITRI_AREA=5~%int32 EXPRESS_WAY=8~%int32 EXIT_GATEWAY=20~%int32 ENTRY_GATEWAY=21~%~%int32 id~%int32 positiveLaneNum~%int32 negativeLaneNum~%bool twoWay~%int32[] positiveLaneIds~%int32[] negativeLaneIds~%int32 mode~%int32 r_class~%int32 routing~%float32 n_as~%float32 n_kph~%float32 p_as~%float32 p_kph~%float32 length~%ItriPoint[] points~%ConnectedNavgRoad[] heads~%ConnectedNavgRoad[] tails~%int32 type~%~%================================================================================~%MSG: route_mission_handler/ItriPoint~%int32 id~%int32 belongId~%int32 pointId~%geometry_msgs/Pose pose~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: route_mission_handler/ConnectedNavgRoad~%int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NavgRoadArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'navgroads) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NavgRoadArray>))
  "Converts a ROS message object to a list"
  (cl:list 'NavgRoadArray
    (cl:cons ':navgroads (navgroads msg))
))
