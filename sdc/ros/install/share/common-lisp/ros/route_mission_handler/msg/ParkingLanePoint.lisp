; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingLanePoint.msg.html

(cl:defclass <ParkingLanePoint> (roslisp-msg-protocol:ros-message)
  ((laneId
    :reader laneId
    :initarg :laneId
    :type cl:integer
    :initform 0)
   (pointId
    :reader pointId
    :initarg :pointId
    :type cl:integer
    :initform 0))
)

(cl:defclass ParkingLanePoint (<ParkingLanePoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingLanePoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingLanePoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingLanePoint> is deprecated: use route_mission_handler-msg:ParkingLanePoint instead.")))

(cl:ensure-generic-function 'laneId-val :lambda-list '(m))
(cl:defmethod laneId-val ((m <ParkingLanePoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:laneId-val is deprecated.  Use route_mission_handler-msg:laneId instead.")
  (laneId m))

(cl:ensure-generic-function 'pointId-val :lambda-list '(m))
(cl:defmethod pointId-val ((m <ParkingLanePoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId-val is deprecated.  Use route_mission_handler-msg:pointId instead.")
  (pointId m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingLanePoint>) ostream)
  "Serializes a message object of type '<ParkingLanePoint>"
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingLanePoint>) istream)
  "Deserializes a message object of type '<ParkingLanePoint>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingLanePoint>)))
  "Returns string type for a message object of type '<ParkingLanePoint>"
  "route_mission_handler/ParkingLanePoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingLanePoint)))
  "Returns string type for a message object of type 'ParkingLanePoint"
  "route_mission_handler/ParkingLanePoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingLanePoint>)))
  "Returns md5sum for a message object of type '<ParkingLanePoint>"
  "6691fee89f0c6fc6322a781cc640418b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingLanePoint)))
  "Returns md5sum for a message object of type 'ParkingLanePoint"
  "6691fee89f0c6fc6322a781cc640418b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingLanePoint>)))
  "Returns full string definition for message of type '<ParkingLanePoint>"
  (cl:format cl:nil "int32 laneId~%int32 pointId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingLanePoint)))
  "Returns full string definition for message of type 'ParkingLanePoint"
  (cl:format cl:nil "int32 laneId~%int32 pointId~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingLanePoint>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingLanePoint>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingLanePoint
    (cl:cons ':laneId (laneId msg))
    (cl:cons ':pointId (pointId msg))
))
