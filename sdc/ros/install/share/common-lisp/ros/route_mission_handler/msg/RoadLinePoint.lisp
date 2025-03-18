; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude RoadLinePoint.msg.html

(cl:defclass <RoadLinePoint> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass RoadLinePoint (<RoadLinePoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RoadLinePoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RoadLinePoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<RoadLinePoint> is deprecated: use route_mission_handler-msg:RoadLinePoint instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <RoadLinePoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <RoadLinePoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:type-val is deprecated.  Use route_mission_handler-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <RoadLinePoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:position-val is deprecated.  Use route_mission_handler-msg:position instead.")
  (position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RoadLinePoint>) ostream)
  "Serializes a message object of type '<RoadLinePoint>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RoadLinePoint>) istream)
  "Deserializes a message object of type '<RoadLinePoint>"
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
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RoadLinePoint>)))
  "Returns string type for a message object of type '<RoadLinePoint>"
  "route_mission_handler/RoadLinePoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RoadLinePoint)))
  "Returns string type for a message object of type 'RoadLinePoint"
  "route_mission_handler/RoadLinePoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RoadLinePoint>)))
  "Returns md5sum for a message object of type '<RoadLinePoint>"
  "09388098fb16fa8fbcb4f4f1d9b54fc9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RoadLinePoint)))
  "Returns md5sum for a message object of type 'RoadLinePoint"
  "09388098fb16fa8fbcb4f4f1d9b54fc9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RoadLinePoint>)))
  "Returns full string definition for message of type '<RoadLinePoint>"
  (cl:format cl:nil "int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RoadLinePoint)))
  "Returns full string definition for message of type 'RoadLinePoint"
  (cl:format cl:nil "int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RoadLinePoint>))
  (cl:+ 0
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RoadLinePoint>))
  "Converts a ROS message object to a list"
  (cl:list 'RoadLinePoint
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':position (position msg))
))
