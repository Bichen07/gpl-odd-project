; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingSpace.msg.html

(cl:defclass <ParkingSpace> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (side
    :reader side
    :initarg :side
    :type cl:integer
    :initform 0)
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (parkingLotId
    :reader parkingLotId
    :initarg :parkingLotId
    :type cl:integer
    :initform 0)
   (laneId
    :reader laneId
    :initarg :laneId
    :type cl:integer
    :initform 0)
   (pointId
    :reader pointId
    :initarg :pointId
    :type cl:integer
    :initform 0)
   (orderType
    :reader orderType
    :initarg :orderType
    :type cl:integer
    :initform 0)
   (points
    :reader points
    :initarg :points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass ParkingSpace (<ParkingSpace>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingSpace>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingSpace)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingSpace> is deprecated: use route_mission_handler-msg:ParkingSpace instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:type-val is deprecated.  Use route_mission_handler-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'side-val :lambda-list '(m))
(cl:defmethod side-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:side-val is deprecated.  Use route_mission_handler-msg:side instead.")
  (side m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'parkingLotId-val :lambda-list '(m))
(cl:defmethod parkingLotId-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:parkingLotId-val is deprecated.  Use route_mission_handler-msg:parkingLotId instead.")
  (parkingLotId m))

(cl:ensure-generic-function 'laneId-val :lambda-list '(m))
(cl:defmethod laneId-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:laneId-val is deprecated.  Use route_mission_handler-msg:laneId instead.")
  (laneId m))

(cl:ensure-generic-function 'pointId-val :lambda-list '(m))
(cl:defmethod pointId-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId-val is deprecated.  Use route_mission_handler-msg:pointId instead.")
  (pointId m))

(cl:ensure-generic-function 'orderType-val :lambda-list '(m))
(cl:defmethod orderType-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:orderType-val is deprecated.  Use route_mission_handler-msg:orderType instead.")
  (orderType m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <ParkingSpace>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:points-val is deprecated.  Use route_mission_handler-msg:points instead.")
  (points m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<ParkingSpace>)))
    "Constants for message type '<ParkingSpace>"
  '((:VERTICAL . 0)
    (:PARALLEL . 1)
    (:OBLIQUE . 2)
    (:RIGHT . 0)
    (:LEFT . 1))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'ParkingSpace)))
    "Constants for message type 'ParkingSpace"
  '((:VERTICAL . 0)
    (:PARALLEL . 1)
    (:OBLIQUE . 2)
    (:RIGHT . 0)
    (:LEFT . 1))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingSpace>) ostream)
  "Serializes a message object of type '<ParkingSpace>"
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'side)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
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
  (cl:let* ((signed (cl:slot-value msg 'laneId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pointId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'orderType)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingSpace>) istream)
  "Deserializes a message object of type '<ParkingSpace>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'side) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'laneId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pointId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'orderType) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingSpace>)))
  "Returns string type for a message object of type '<ParkingSpace>"
  "route_mission_handler/ParkingSpace")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingSpace)))
  "Returns string type for a message object of type 'ParkingSpace"
  "route_mission_handler/ParkingSpace")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingSpace>)))
  "Returns md5sum for a message object of type '<ParkingSpace>"
  "98fbce91faa2b53804e2c7e966c04f2d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingSpace)))
  "Returns md5sum for a message object of type 'ParkingSpace"
  "98fbce91faa2b53804e2c7e966c04f2d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingSpace>)))
  "Returns full string definition for message of type '<ParkingSpace>"
  (cl:format cl:nil "int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingSpace)))
  "Returns full string definition for message of type 'ParkingSpace"
  (cl:format cl:nil "int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingSpace>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingSpace>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingSpace
    (cl:cons ':type (type msg))
    (cl:cons ':side (side msg))
    (cl:cons ':id (id msg))
    (cl:cons ':parkingLotId (parkingLotId msg))
    (cl:cons ':laneId (laneId msg))
    (cl:cons ':pointId (pointId msg))
    (cl:cons ':orderType (orderType msg))
    (cl:cons ':points (points msg))
))
