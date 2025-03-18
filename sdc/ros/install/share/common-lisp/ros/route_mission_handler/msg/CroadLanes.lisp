; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude CroadLanes.msg.html

(cl:defclass <CroadLanes> (roslisp-msg-protocol:ros-message)
  ((cr1
    :reader cr1
    :initarg :cr1
    :type route_mission_handler-msg:Croad
    :initform (cl:make-instance 'route_mission_handler-msg:Croad))
   (cr2
    :reader cr2
    :initarg :cr2
    :type route_mission_handler-msg:Croad
    :initform (cl:make-instance 'route_mission_handler-msg:Croad))
   (lanes
    :reader lanes
    :initarg :lanes
    :type (cl:vector route_mission_handler-msg:Lane)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Lane :initial-element (cl:make-instance 'route_mission_handler-msg:Lane))))
)

(cl:defclass CroadLanes (<CroadLanes>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CroadLanes>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CroadLanes)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<CroadLanes> is deprecated: use route_mission_handler-msg:CroadLanes instead.")))

(cl:ensure-generic-function 'cr1-val :lambda-list '(m))
(cl:defmethod cr1-val ((m <CroadLanes>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:cr1-val is deprecated.  Use route_mission_handler-msg:cr1 instead.")
  (cr1 m))

(cl:ensure-generic-function 'cr2-val :lambda-list '(m))
(cl:defmethod cr2-val ((m <CroadLanes>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:cr2-val is deprecated.  Use route_mission_handler-msg:cr2 instead.")
  (cr2 m))

(cl:ensure-generic-function 'lanes-val :lambda-list '(m))
(cl:defmethod lanes-val ((m <CroadLanes>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lanes-val is deprecated.  Use route_mission_handler-msg:lanes instead.")
  (lanes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CroadLanes>) ostream)
  "Serializes a message object of type '<CroadLanes>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cr1) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cr2) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lanes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CroadLanes>) istream)
  "Deserializes a message object of type '<CroadLanes>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cr1) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cr2) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lanes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lanes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Lane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CroadLanes>)))
  "Returns string type for a message object of type '<CroadLanes>"
  "route_mission_handler/CroadLanes")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CroadLanes)))
  "Returns string type for a message object of type 'CroadLanes"
  "route_mission_handler/CroadLanes")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CroadLanes>)))
  "Returns md5sum for a message object of type '<CroadLanes>"
  "76bd09f0a71aa15a96f5051885537a03")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CroadLanes)))
  "Returns md5sum for a message object of type 'CroadLanes"
  "76bd09f0a71aa15a96f5051885537a03")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CroadLanes>)))
  "Returns full string definition for message of type '<CroadLanes>"
  (cl:format cl:nil "Croad cr1~%Croad cr2~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CroadLanes)))
  "Returns full string definition for message of type 'CroadLanes"
  (cl:format cl:nil "Croad cr1~%Croad cr2~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CroadLanes>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cr1))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cr2))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CroadLanes>))
  "Converts a ROS message object to a list"
  (cl:list 'CroadLanes
    (cl:cons ':cr1 (cr1 msg))
    (cl:cons ':cr2 (cr2 msg))
    (cl:cons ':lanes (lanes msg))
))
