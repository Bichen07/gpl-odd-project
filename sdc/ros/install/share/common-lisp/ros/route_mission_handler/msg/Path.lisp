; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude Path.msg.html

(cl:defclass <Path> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (nroads
    :reader nroads
    :initarg :nroads
    :type (cl:vector route_mission_handler-msg:Croad)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Croad :initial-element (cl:make-instance 'route_mission_handler-msg:Croad)))
   (lanes
    :reader lanes
    :initarg :lanes
    :type (cl:vector route_mission_handler-msg:Lane)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Lane :initial-element (cl:make-instance 'route_mission_handler-msg:Lane)))
   (opposite_lanes
    :reader opposite_lanes
    :initarg :opposite_lanes
    :type (cl:vector route_mission_handler-msg:Lane)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Lane :initial-element (cl:make-instance 'route_mission_handler-msg:Lane)))
   (parkinglots
    :reader parkinglots
    :initarg :parkinglots
    :type (cl:vector route_mission_handler-msg:ParkingLot)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingLot :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingLot))))
)

(cl:defclass Path (<Path>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Path>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Path)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<Path> is deprecated: use route_mission_handler-msg:Path instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Path>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:name-val is deprecated.  Use route_mission_handler-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'nroads-val :lambda-list '(m))
(cl:defmethod nroads-val ((m <Path>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:nroads-val is deprecated.  Use route_mission_handler-msg:nroads instead.")
  (nroads m))

(cl:ensure-generic-function 'lanes-val :lambda-list '(m))
(cl:defmethod lanes-val ((m <Path>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lanes-val is deprecated.  Use route_mission_handler-msg:lanes instead.")
  (lanes m))

(cl:ensure-generic-function 'opposite_lanes-val :lambda-list '(m))
(cl:defmethod opposite_lanes-val ((m <Path>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:opposite_lanes-val is deprecated.  Use route_mission_handler-msg:opposite_lanes instead.")
  (opposite_lanes m))

(cl:ensure-generic-function 'parkinglots-val :lambda-list '(m))
(cl:defmethod parkinglots-val ((m <Path>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:parkinglots-val is deprecated.  Use route_mission_handler-msg:parkinglots instead.")
  (parkinglots m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Path>) ostream)
  "Serializes a message object of type '<Path>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'nroads))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'nroads))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lanes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'opposite_lanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'opposite_lanes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'parkinglots))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'parkinglots))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Path>) istream)
  "Deserializes a message object of type '<Path>"
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
  (cl:setf (cl:slot-value msg 'nroads) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'nroads)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Croad))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
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
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'opposite_lanes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'opposite_lanes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Lane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'parkinglots) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'parkinglots)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingLot))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Path>)))
  "Returns string type for a message object of type '<Path>"
  "route_mission_handler/Path")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Path)))
  "Returns string type for a message object of type 'Path"
  "route_mission_handler/Path")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Path>)))
  "Returns md5sum for a message object of type '<Path>"
  "a3e40f12496a914a19bbb6f3f00e47a0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Path)))
  "Returns md5sum for a message object of type 'Path"
  "a3e40f12496a914a19bbb6f3f00e47a0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Path>)))
  "Returns full string definition for message of type '<Path>"
  (cl:format cl:nil "string name~%Croad[] nroads~%Lane[] lanes~%Lane[] opposite_lanes~%ParkingLot[] parkinglots~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLot~%int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Path)))
  "Returns full string definition for message of type 'Path"
  (cl:format cl:nil "string name~%Croad[] nroads~%Lane[] lanes~%Lane[] opposite_lanes~%ParkingLot[] parkinglots~%~%================================================================================~%MSG: route_mission_handler/Croad~%int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLot~%int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Path>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'nroads) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'opposite_lanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'parkinglots) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Path>))
  "Converts a ROS message object to a list"
  (cl:list 'Path
    (cl:cons ':name (name msg))
    (cl:cons ':nroads (nroads msg))
    (cl:cons ':lanes (lanes msg))
    (cl:cons ':opposite_lanes (opposite_lanes msg))
    (cl:cons ':parkinglots (parkinglots msg))
))
