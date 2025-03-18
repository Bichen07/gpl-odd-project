; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude RoadLine.msg.html

(cl:defclass <RoadLine> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (points
    :reader points
    :initarg :points
    :type (cl:vector route_mission_handler-msg:RoadLinePoint)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:RoadLinePoint :initial-element (cl:make-instance 'route_mission_handler-msg:RoadLinePoint))))
)

(cl:defclass RoadLine (<RoadLine>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RoadLine>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RoadLine)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<RoadLine> is deprecated: use route_mission_handler-msg:RoadLine instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <RoadLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <RoadLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:points-val is deprecated.  Use route_mission_handler-msg:points instead.")
  (points m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RoadLine>) ostream)
  "Serializes a message object of type '<RoadLine>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RoadLine>) istream)
  "Deserializes a message object of type '<RoadLine>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:RoadLinePoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RoadLine>)))
  "Returns string type for a message object of type '<RoadLine>"
  "route_mission_handler/RoadLine")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RoadLine)))
  "Returns string type for a message object of type 'RoadLine"
  "route_mission_handler/RoadLine")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RoadLine>)))
  "Returns md5sum for a message object of type '<RoadLine>"
  "b3a7ceb558b583abe36490972467f60e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RoadLine)))
  "Returns md5sum for a message object of type 'RoadLine"
  "b3a7ceb558b583abe36490972467f60e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RoadLine>)))
  "Returns full string definition for message of type '<RoadLine>"
  (cl:format cl:nil "int32 id~%RoadLinePoint[] points~%~%================================================================================~%MSG: route_mission_handler/RoadLinePoint~%int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RoadLine)))
  "Returns full string definition for message of type 'RoadLine"
  (cl:format cl:nil "int32 id~%RoadLinePoint[] points~%~%================================================================================~%MSG: route_mission_handler/RoadLinePoint~%int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RoadLine>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RoadLine>))
  "Converts a ROS message object to a list"
  (cl:list 'RoadLine
    (cl:cons ':id (id msg))
    (cl:cons ':points (points msg))
))
