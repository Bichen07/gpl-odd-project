; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingLane.msg.html

(cl:defclass <ParkingLane> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (parkingLotId
    :reader parkingLotId
    :initarg :parkingLotId
    :type cl:integer
    :initform 0)
   (points
    :reader points
    :initarg :points
    :type (cl:vector route_mission_handler-msg:ParkingLanePoint)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingLanePoint :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingLanePoint)))
   (waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector route_mission_handler-msg:Waypoints)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Waypoints :initial-element (cl:make-instance 'route_mission_handler-msg:Waypoints))))
)

(cl:defclass ParkingLane (<ParkingLane>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingLane>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingLane)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingLane> is deprecated: use route_mission_handler-msg:ParkingLane instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ParkingLane>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'parkingLotId-val :lambda-list '(m))
(cl:defmethod parkingLotId-val ((m <ParkingLane>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:parkingLotId-val is deprecated.  Use route_mission_handler-msg:parkingLotId instead.")
  (parkingLotId m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <ParkingLane>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:points-val is deprecated.  Use route_mission_handler-msg:points instead.")
  (points m))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <ParkingLane>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:waypoints-val is deprecated.  Use route_mission_handler-msg:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingLane>) ostream)
  "Serializes a message object of type '<ParkingLane>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'parkingLotId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'waypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingLane>) istream)
  "Deserializes a message object of type '<ParkingLane>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'parkingLotId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingLanePoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Waypoints))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingLane>)))
  "Returns string type for a message object of type '<ParkingLane>"
  "route_mission_handler/ParkingLane")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingLane)))
  "Returns string type for a message object of type 'ParkingLane"
  "route_mission_handler/ParkingLane")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingLane>)))
  "Returns md5sum for a message object of type '<ParkingLane>"
  "0e1aa0913f8aac2613da9735cb478990")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingLane)))
  "Returns md5sum for a message object of type 'ParkingLane"
  "0e1aa0913f8aac2613da9735cb478990")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingLane>)))
  "Returns full string definition for message of type '<ParkingLane>"
  (cl:format cl:nil "int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingLane)))
  "Returns full string definition for message of type 'ParkingLane"
  (cl:format cl:nil "int32 id~%int32 parkingLotId~%ParkingLanePoint[] points~%Waypoints[] waypoints~%~%================================================================================~%MSG: route_mission_handler/ParkingLanePoint~%int32 laneId~%int32 pointId~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingLane>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingLane>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingLane
    (cl:cons ':id (id msg))
    (cl:cons ':parkingLotId (parkingLotId msg))
    (cl:cons ':points (points msg))
    (cl:cons ':waypoints (waypoints msg))
))
