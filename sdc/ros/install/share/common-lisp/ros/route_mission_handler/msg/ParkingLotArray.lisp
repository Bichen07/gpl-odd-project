; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingLotArray.msg.html

(cl:defclass <ParkingLotArray> (roslisp-msg-protocol:ros-message)
  ((lots
    :reader lots
    :initarg :lots
    :type (cl:vector route_mission_handler-msg:ParkingLot)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingLot :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingLot))))
)

(cl:defclass ParkingLotArray (<ParkingLotArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingLotArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingLotArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingLotArray> is deprecated: use route_mission_handler-msg:ParkingLotArray instead.")))

(cl:ensure-generic-function 'lots-val :lambda-list '(m))
(cl:defmethod lots-val ((m <ParkingLotArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lots-val is deprecated.  Use route_mission_handler-msg:lots instead.")
  (lots m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingLotArray>) ostream)
  "Serializes a message object of type '<ParkingLotArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lots))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lots))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingLotArray>) istream)
  "Deserializes a message object of type '<ParkingLotArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lots) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lots)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingLot))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingLotArray>)))
  "Returns string type for a message object of type '<ParkingLotArray>"
  "route_mission_handler/ParkingLotArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingLotArray)))
  "Returns string type for a message object of type 'ParkingLotArray"
  "route_mission_handler/ParkingLotArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingLotArray>)))
  "Returns md5sum for a message object of type '<ParkingLotArray>"
  "4c437145053afac28f11d22149a5aaf7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingLotArray)))
  "Returns md5sum for a message object of type 'ParkingLotArray"
  "4c437145053afac28f11d22149a5aaf7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingLotArray>)))
  "Returns full string definition for message of type '<ParkingLotArray>"
  (cl:format cl:nil "ParkingLot[] lots~%~%================================================================================~%MSG: route_mission_handler/ParkingLot~%int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingLotArray)))
  "Returns full string definition for message of type 'ParkingLotArray"
  (cl:format cl:nil "ParkingLot[] lots~%~%================================================================================~%MSG: route_mission_handler/ParkingLot~%int32 id~%string name~%bool croad1_positive~%bool croad2_positive~%int32 nav_croad_id~%int32 pointId1~%int32 nav_croad_id2~%int32 pointId2~%ParkingSpaceArray space_list~%LaneArray lot_lines~%ParkingLane[] lanes~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpaceArray~%ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: route_mission_handler/LaneArray~%Lane[] lanes~%~%================================================================================~%MSG: route_mission_handler/Lane~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 lane_id~%int32[] nroad_ids~%bool is_intersection~%bool is_positive~%Waypoint[] waypoints~%int32[] next_lanes~%int32[] left_lanes~%int32[] right_lanes~%int32 max_speed_limit~%uint32 order~%int32 roadType~%int32 type~%~%================================================================================~%MSG: route_mission_handler/Waypoint~%int32 lane_id~%int32 point_id~%int32 nroad_id~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curvature~%float32 heading~%geometry_msgs/Point point~%int32[] markerIds~%int32[] markerTypes~%int32 parkingLotId~%int32 parkingLotLaneId~%~%================================================================================~%MSG: route_mission_handler/ParkingLane~%int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingLotArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lots) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingLotArray>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingLotArray
    (cl:cons ':lots (lots msg))
))
