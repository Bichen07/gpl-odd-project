; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingLot.msg.html

(cl:defclass <ParkingLot> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (croad1_positive
    :reader croad1_positive
    :initarg :croad1_positive
    :type cl:boolean
    :initform cl:nil)
   (croad2_positive
    :reader croad2_positive
    :initarg :croad2_positive
    :type cl:boolean
    :initform cl:nil)
   (nav_croad_id
    :reader nav_croad_id
    :initarg :nav_croad_id
    :type cl:integer
    :initform 0)
   (pointId1
    :reader pointId1
    :initarg :pointId1
    :type cl:integer
    :initform 0)
   (nav_croad_id2
    :reader nav_croad_id2
    :initarg :nav_croad_id2
    :type cl:integer
    :initform 0)
   (pointId2
    :reader pointId2
    :initarg :pointId2
    :type cl:integer
    :initform 0)
   (space_list
    :reader space_list
    :initarg :space_list
    :type route_mission_handler-msg:ParkingSpaceArray
    :initform (cl:make-instance 'route_mission_handler-msg:ParkingSpaceArray))
   (lot_lines
    :reader lot_lines
    :initarg :lot_lines
    :type route_mission_handler-msg:LaneArray
    :initform (cl:make-instance 'route_mission_handler-msg:LaneArray))
   (lanes
    :reader lanes
    :initarg :lanes
    :type (cl:vector route_mission_handler-msg:ParkingLane)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingLane :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingLane)))
   (spaces
    :reader spaces
    :initarg :spaces
    :type (cl:vector route_mission_handler-msg:ParkingSpace)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingSpace :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingSpace))))
)

(cl:defclass ParkingLot (<ParkingLot>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingLot>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingLot)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingLot> is deprecated: use route_mission_handler-msg:ParkingLot instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:name-val is deprecated.  Use route_mission_handler-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'croad1_positive-val :lambda-list '(m))
(cl:defmethod croad1_positive-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:croad1_positive-val is deprecated.  Use route_mission_handler-msg:croad1_positive instead.")
  (croad1_positive m))

(cl:ensure-generic-function 'croad2_positive-val :lambda-list '(m))
(cl:defmethod croad2_positive-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:croad2_positive-val is deprecated.  Use route_mission_handler-msg:croad2_positive instead.")
  (croad2_positive m))

(cl:ensure-generic-function 'nav_croad_id-val :lambda-list '(m))
(cl:defmethod nav_croad_id-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:nav_croad_id-val is deprecated.  Use route_mission_handler-msg:nav_croad_id instead.")
  (nav_croad_id m))

(cl:ensure-generic-function 'pointId1-val :lambda-list '(m))
(cl:defmethod pointId1-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId1-val is deprecated.  Use route_mission_handler-msg:pointId1 instead.")
  (pointId1 m))

(cl:ensure-generic-function 'nav_croad_id2-val :lambda-list '(m))
(cl:defmethod nav_croad_id2-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:nav_croad_id2-val is deprecated.  Use route_mission_handler-msg:nav_croad_id2 instead.")
  (nav_croad_id2 m))

(cl:ensure-generic-function 'pointId2-val :lambda-list '(m))
(cl:defmethod pointId2-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId2-val is deprecated.  Use route_mission_handler-msg:pointId2 instead.")
  (pointId2 m))

(cl:ensure-generic-function 'space_list-val :lambda-list '(m))
(cl:defmethod space_list-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:space_list-val is deprecated.  Use route_mission_handler-msg:space_list instead.")
  (space_list m))

(cl:ensure-generic-function 'lot_lines-val :lambda-list '(m))
(cl:defmethod lot_lines-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lot_lines-val is deprecated.  Use route_mission_handler-msg:lot_lines instead.")
  (lot_lines m))

(cl:ensure-generic-function 'lanes-val :lambda-list '(m))
(cl:defmethod lanes-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lanes-val is deprecated.  Use route_mission_handler-msg:lanes instead.")
  (lanes m))

(cl:ensure-generic-function 'spaces-val :lambda-list '(m))
(cl:defmethod spaces-val ((m <ParkingLot>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:spaces-val is deprecated.  Use route_mission_handler-msg:spaces instead.")
  (spaces m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingLot>) ostream)
  "Serializes a message object of type '<ParkingLot>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'croad1_positive) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'croad2_positive) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'nav_croad_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pointId1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'nav_croad_id2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pointId2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'space_list) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lot_lines) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lanes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'spaces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'spaces))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingLot>) istream)
  "Deserializes a message object of type '<ParkingLot>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'croad1_positive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'croad2_positive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nav_croad_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pointId1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nav_croad_id2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pointId2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'space_list) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lot_lines) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lanes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lanes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingLane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'spaces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'spaces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingSpace))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingLot>)))
  "Returns string type for a message object of type '<ParkingLot>"
  "route_mission_handler/ParkingLot")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingLot)))
  "Returns string type for a message object of type 'ParkingLot"
  "route_mission_handler/ParkingLot")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingLot>)))
  "Returns md5sum for a message object of type '<ParkingLot>"
  "232125321c146d4640eb356f707cd0da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingLot)))
  "Returns md5sum for a message object of type 'ParkingLot"
  "232125321c146d4640eb356f707cd0da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingLot>)))
  "Returns full string definition for message of type '<ParkingLot>"
  (cl:format cl:nil "int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingLot)))
  "Returns full string definition for message of type 'ParkingLot"
  (cl:format cl:nil "int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingLot>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'name))
     1
     1
     4
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'space_list))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lot_lines))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'spaces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingLot>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingLot
    (cl:cons ':id (id msg))
    (cl:cons ':name (name msg))
    (cl:cons ':croad1_positive (croad1_positive msg))
    (cl:cons ':croad2_positive (croad2_positive msg))
    (cl:cons ':nav_croad_id (nav_croad_id msg))
    (cl:cons ':pointId1 (pointId1 msg))
    (cl:cons ':nav_croad_id2 (nav_croad_id2 msg))
    (cl:cons ':pointId2 (pointId2 msg))
    (cl:cons ':space_list (space_list msg))
    (cl:cons ':lot_lines (lot_lines msg))
    (cl:cons ':lanes (lanes msg))
    (cl:cons ':spaces (spaces msg))
))
