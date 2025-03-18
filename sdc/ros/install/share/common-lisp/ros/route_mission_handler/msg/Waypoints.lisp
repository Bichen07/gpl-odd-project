; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude Waypoints.msg.html

(cl:defclass <Waypoints> (roslisp-msg-protocol:ros-message)
  ((laneId
    :reader laneId
    :initarg :laneId
    :type cl:integer
    :initform 0)
   (pointId
    :reader pointId
    :initarg :pointId
    :type cl:integer
    :initform 0)
   (roadWidth
    :reader roadWidth
    :initarg :roadWidth
    :type cl:float
    :initform 0.0)
   (distToRightLine
    :reader distToRightLine
    :initarg :distToRightLine
    :type cl:float
    :initform 0.0)
   (distToLeftLine
    :reader distToLeftLine
    :initarg :distToLeftLine
    :type cl:float
    :initform 0.0)
   (right_road_bound
    :reader right_road_bound
    :initarg :right_road_bound
    :type cl:float
    :initform 0.0)
   (left_road_bound
    :reader left_road_bound
    :initarg :left_road_bound
    :type cl:float
    :initform 0.0)
   (curve
    :reader curve
    :initarg :curve
    :type cl:float
    :initform 0.0)
   (slope
    :reader slope
    :initarg :slope
    :type cl:float
    :initform 0.0)
   (bank_angle
    :reader bank_angle
    :initarg :bank_angle
    :type cl:float
    :initform 0.0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (markerIds
    :reader markerIds
    :initarg :markerIds
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (markerTypes
    :reader markerTypes
    :initarg :markerTypes
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass Waypoints (<Waypoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Waypoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Waypoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<Waypoints> is deprecated: use route_mission_handler-msg:Waypoints instead.")))

(cl:ensure-generic-function 'laneId-val :lambda-list '(m))
(cl:defmethod laneId-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:laneId-val is deprecated.  Use route_mission_handler-msg:laneId instead.")
  (laneId m))

(cl:ensure-generic-function 'pointId-val :lambda-list '(m))
(cl:defmethod pointId-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointId-val is deprecated.  Use route_mission_handler-msg:pointId instead.")
  (pointId m))

(cl:ensure-generic-function 'roadWidth-val :lambda-list '(m))
(cl:defmethod roadWidth-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:roadWidth-val is deprecated.  Use route_mission_handler-msg:roadWidth instead.")
  (roadWidth m))

(cl:ensure-generic-function 'distToRightLine-val :lambda-list '(m))
(cl:defmethod distToRightLine-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:distToRightLine-val is deprecated.  Use route_mission_handler-msg:distToRightLine instead.")
  (distToRightLine m))

(cl:ensure-generic-function 'distToLeftLine-val :lambda-list '(m))
(cl:defmethod distToLeftLine-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:distToLeftLine-val is deprecated.  Use route_mission_handler-msg:distToLeftLine instead.")
  (distToLeftLine m))

(cl:ensure-generic-function 'right_road_bound-val :lambda-list '(m))
(cl:defmethod right_road_bound-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:right_road_bound-val is deprecated.  Use route_mission_handler-msg:right_road_bound instead.")
  (right_road_bound m))

(cl:ensure-generic-function 'left_road_bound-val :lambda-list '(m))
(cl:defmethod left_road_bound-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:left_road_bound-val is deprecated.  Use route_mission_handler-msg:left_road_bound instead.")
  (left_road_bound m))

(cl:ensure-generic-function 'curve-val :lambda-list '(m))
(cl:defmethod curve-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:curve-val is deprecated.  Use route_mission_handler-msg:curve instead.")
  (curve m))

(cl:ensure-generic-function 'slope-val :lambda-list '(m))
(cl:defmethod slope-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:slope-val is deprecated.  Use route_mission_handler-msg:slope instead.")
  (slope m))

(cl:ensure-generic-function 'bank_angle-val :lambda-list '(m))
(cl:defmethod bank_angle-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:bank_angle-val is deprecated.  Use route_mission_handler-msg:bank_angle instead.")
  (bank_angle m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pose-val is deprecated.  Use route_mission_handler-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'markerIds-val :lambda-list '(m))
(cl:defmethod markerIds-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:markerIds-val is deprecated.  Use route_mission_handler-msg:markerIds instead.")
  (markerIds m))

(cl:ensure-generic-function 'markerTypes-val :lambda-list '(m))
(cl:defmethod markerTypes-val ((m <Waypoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:markerTypes-val is deprecated.  Use route_mission_handler-msg:markerTypes instead.")
  (markerTypes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Waypoints>) ostream)
  "Serializes a message object of type '<Waypoints>"
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'roadWidth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distToRightLine))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'distToLeftLine))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'right_road_bound))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'left_road_bound))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'curve))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'slope))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'bank_angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'markerIds))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'markerIds))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'markerTypes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'markerTypes))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Waypoints>) istream)
  "Deserializes a message object of type '<Waypoints>"
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'roadWidth) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distToRightLine) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distToLeftLine) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'right_road_bound) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'left_road_bound) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'curve) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'slope) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'bank_angle) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'markerIds) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'markerIds)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'markerTypes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'markerTypes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Waypoints>)))
  "Returns string type for a message object of type '<Waypoints>"
  "route_mission_handler/Waypoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Waypoints)))
  "Returns string type for a message object of type 'Waypoints"
  "route_mission_handler/Waypoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Waypoints>)))
  "Returns md5sum for a message object of type '<Waypoints>"
  "2b80f75c6328a6dc05af65a457e56008")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Waypoints)))
  "Returns md5sum for a message object of type 'Waypoints"
  "2b80f75c6328a6dc05af65a457e56008")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Waypoints>)))
  "Returns full string definition for message of type '<Waypoints>"
  (cl:format cl:nil "int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Waypoints)))
  "Returns full string definition for message of type 'Waypoints"
  (cl:format cl:nil "int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Waypoints>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
     4
     4
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'markerIds) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'markerTypes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Waypoints>))
  "Converts a ROS message object to a list"
  (cl:list 'Waypoints
    (cl:cons ':laneId (laneId msg))
    (cl:cons ':pointId (pointId msg))
    (cl:cons ':roadWidth (roadWidth msg))
    (cl:cons ':distToRightLine (distToRightLine msg))
    (cl:cons ':distToLeftLine (distToLeftLine msg))
    (cl:cons ':right_road_bound (right_road_bound msg))
    (cl:cons ':left_road_bound (left_road_bound msg))
    (cl:cons ':curve (curve msg))
    (cl:cons ':slope (slope msg))
    (cl:cons ':bank_angle (bank_angle msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':markerIds (markerIds msg))
    (cl:cons ':markerTypes (markerTypes msg))
))
