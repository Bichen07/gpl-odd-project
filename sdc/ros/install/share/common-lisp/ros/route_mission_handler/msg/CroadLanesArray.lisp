; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude CroadLanesArray.msg.html

(cl:defclass <CroadLanesArray> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (clanes
    :reader clanes
    :initarg :clanes
    :type (cl:vector route_mission_handler-msg:CroadLanes)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:CroadLanes :initial-element (cl:make-instance 'route_mission_handler-msg:CroadLanes))))
)

(cl:defclass CroadLanesArray (<CroadLanesArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CroadLanesArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CroadLanesArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<CroadLanesArray> is deprecated: use route_mission_handler-msg:CroadLanesArray instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <CroadLanesArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:name-val is deprecated.  Use route_mission_handler-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'clanes-val :lambda-list '(m))
(cl:defmethod clanes-val ((m <CroadLanesArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:clanes-val is deprecated.  Use route_mission_handler-msg:clanes instead.")
  (clanes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CroadLanesArray>) ostream)
  "Serializes a message object of type '<CroadLanesArray>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'clanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'clanes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CroadLanesArray>) istream)
  "Deserializes a message object of type '<CroadLanesArray>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'clanes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'clanes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:CroadLanes))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CroadLanesArray>)))
  "Returns string type for a message object of type '<CroadLanesArray>"
  "route_mission_handler/CroadLanesArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CroadLanesArray)))
  "Returns string type for a message object of type 'CroadLanesArray"
  "route_mission_handler/CroadLanesArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CroadLanesArray>)))
  "Returns md5sum for a message object of type '<CroadLanesArray>"
  "498cf78e2ebab6d12896dc763a3009fe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CroadLanesArray)))
  "Returns md5sum for a message object of type 'CroadLanesArray"
  "498cf78e2ebab6d12896dc763a3009fe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CroadLanesArray>)))
  "Returns full string definition for message of type '<CroadLanesArray>"
  (cl:format cl:nil "string name~%CroadLanes[] clanes~%~%================================================================================~%MSG: route_mission_handler/CroadLanes~%Croad cr1~%Croad cr2~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CroadLanesArray)))
  "Returns full string definition for message of type 'CroadLanesArray"
  (cl:format cl:nil "string name~%CroadLanes[] clanes~%~%================================================================================~%MSG: route_mission_handler/CroadLanes~%Croad cr1~%Croad cr2~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CroadLanesArray>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'clanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CroadLanesArray>))
  "Converts a ROS message object to a list"
  (cl:list 'CroadLanesArray
    (cl:cons ':name (name msg))
    (cl:cons ':clanes (clanes msg))
))
