; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude MarkerPolygon.msg.html

(cl:defclass <MarkerPolygon> (roslisp-msg-protocol:ros-message)
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
   (navgId
    :reader navgId
    :initarg :navgId
    :type cl:integer
    :initform 0)
   (pairs
    :reader pairs
    :initarg :pairs
    :type (cl:vector route_mission_handler-msg:Pair)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Pair :initial-element (cl:make-instance 'route_mission_handler-msg:Pair)))
   (center_point
    :reader center_point
    :initarg :center_point
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (corner_points
    :reader corner_points
    :initarg :corner_points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (on
    :reader on
    :initarg :on
    :type cl:boolean
    :initform cl:nil)
   (value
    :reader value
    :initarg :value
    :type cl:string
    :initform ""))
)

(cl:defclass MarkerPolygon (<MarkerPolygon>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerPolygon>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerPolygon)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<MarkerPolygon> is deprecated: use route_mission_handler-msg:MarkerPolygon instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:id-val is deprecated.  Use route_mission_handler-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:type-val is deprecated.  Use route_mission_handler-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'navgId-val :lambda-list '(m))
(cl:defmethod navgId-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:navgId-val is deprecated.  Use route_mission_handler-msg:navgId instead.")
  (navgId m))

(cl:ensure-generic-function 'pairs-val :lambda-list '(m))
(cl:defmethod pairs-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pairs-val is deprecated.  Use route_mission_handler-msg:pairs instead.")
  (pairs m))

(cl:ensure-generic-function 'center_point-val :lambda-list '(m))
(cl:defmethod center_point-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:center_point-val is deprecated.  Use route_mission_handler-msg:center_point instead.")
  (center_point m))

(cl:ensure-generic-function 'corner_points-val :lambda-list '(m))
(cl:defmethod corner_points-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:corner_points-val is deprecated.  Use route_mission_handler-msg:corner_points instead.")
  (corner_points m))

(cl:ensure-generic-function 'on-val :lambda-list '(m))
(cl:defmethod on-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:on-val is deprecated.  Use route_mission_handler-msg:on instead.")
  (on m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <MarkerPolygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:value-val is deprecated.  Use route_mission_handler-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerPolygon>) ostream)
  "Serializes a message object of type '<MarkerPolygon>"
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
  (cl:let* ((signed (cl:slot-value msg 'navgId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pairs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pairs))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'center_point) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'corner_points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'corner_points))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'on) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerPolygon>) istream)
  "Deserializes a message object of type '<MarkerPolygon>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'navgId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pairs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pairs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Pair))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'center_point) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'corner_points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'corner_points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'on) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerPolygon>)))
  "Returns string type for a message object of type '<MarkerPolygon>"
  "route_mission_handler/MarkerPolygon")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerPolygon)))
  "Returns string type for a message object of type 'MarkerPolygon"
  "route_mission_handler/MarkerPolygon")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerPolygon>)))
  "Returns md5sum for a message object of type '<MarkerPolygon>"
  "040152815f20ff5033794b4d0e7f012f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerPolygon)))
  "Returns md5sum for a message object of type 'MarkerPolygon"
  "040152815f20ff5033794b4d0e7f012f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerPolygon>)))
  "Returns full string definition for message of type '<MarkerPolygon>"
  (cl:format cl:nil "int32 id~%int32 type~%int32 navgId~%Pair[] pairs~%geometry_msgs/Point center_point~%geometry_msgs/Point[] corner_points~%bool on~%string value~%~%================================================================================~%MSG: route_mission_handler/Pair~%int32 laneId~%int32[] pointIds~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerPolygon)))
  "Returns full string definition for message of type 'MarkerPolygon"
  (cl:format cl:nil "int32 id~%int32 type~%int32 navgId~%Pair[] pairs~%geometry_msgs/Point center_point~%geometry_msgs/Point[] corner_points~%bool on~%string value~%~%================================================================================~%MSG: route_mission_handler/Pair~%int32 laneId~%int32[] pointIds~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerPolygon>))
  (cl:+ 0
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pairs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'center_point))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'corner_points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
     4 (cl:length (cl:slot-value msg 'value))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerPolygon>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerPolygon
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':navgId (navgId msg))
    (cl:cons ':pairs (pairs msg))
    (cl:cons ':center_point (center_point msg))
    (cl:cons ':corner_points (corner_points msg))
    (cl:cons ':on (on msg))
    (cl:cons ':value (value msg))
))
