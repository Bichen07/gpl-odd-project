; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ConnectedNavgRoad.msg.html

(cl:defclass <ConnectedNavgRoad> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (pointId
    :reader pointId
    :initarg :pointId
    :type cl:integer
    :initform 0)
   (length
    :reader length
    :initarg :length
    :type cl:float
    :initform 0.0))
)

(cl:defclass ConnectedNavgRoad (<ConnectedNavgRoad>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ConnectedNavgRoad>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ConnectedNavgRoad)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ConnectedNavgRoad> is deprecated: use route_mission_handler-msg:ConnectedNavgRoad instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ConnectedNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'pointId-val :lambda-list '(m))
(cl:defmethod pointId-val ((m <ConnectedNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId-val is deprecated.  Use route_mission_handler-msg:pointId instead.")
  (pointId m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <ConnectedNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:length-val is deprecated.  Use route_mission_handler-msg:length instead.")
  (length m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ConnectedNavgRoad>) ostream)
  "Serializes a message object of type '<ConnectedNavgRoad>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ConnectedNavgRoad>) istream)
  "Deserializes a message object of type '<ConnectedNavgRoad>"
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
      (cl:setf (cl:slot-value msg 'pointId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'length) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ConnectedNavgRoad>)))
  "Returns string type for a message object of type '<ConnectedNavgRoad>"
  "route_mission_handler/ConnectedNavgRoad")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ConnectedNavgRoad)))
  "Returns string type for a message object of type 'ConnectedNavgRoad"
  "route_mission_handler/ConnectedNavgRoad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ConnectedNavgRoad>)))
  "Returns md5sum for a message object of type '<ConnectedNavgRoad>"
  "28d69e6e69d7145b1fab1ae5d4c70e8a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ConnectedNavgRoad)))
  "Returns md5sum for a message object of type 'ConnectedNavgRoad"
  "28d69e6e69d7145b1fab1ae5d4c70e8a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ConnectedNavgRoad>)))
  "Returns full string definition for message of type '<ConnectedNavgRoad>"
  (cl:format cl:nil "int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ConnectedNavgRoad)))
  "Returns full string definition for message of type 'ConnectedNavgRoad"
  (cl:format cl:nil "int32 id~%int32 pointId~%float32 length~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ConnectedNavgRoad>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ConnectedNavgRoad>))
  "Converts a ROS message object to a list"
  (cl:list 'ConnectedNavgRoad
    (cl:cons ':id (id msg))
    (cl:cons ':pointId (pointId msg))
    (cl:cons ':length (length msg))
))
