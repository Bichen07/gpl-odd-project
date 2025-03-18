; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude Croad.msg.html

(cl:defclass <Croad> (roslisp-msg-protocol:ros-message)
  ((nroad_id
    :reader nroad_id
    :initarg :nroad_id
    :type cl:integer
    :initform 0)
   (isPositive
    :reader isPositive
    :initarg :isPositive
    :type cl:boolean
    :initform cl:nil)
   (point_id
    :reader point_id
    :initarg :point_id
    :type cl:integer
    :initform 0)
   (lane_ids
    :reader lane_ids
    :initarg :lane_ids
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (points
    :reader points
    :initarg :points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (fixed
    :reader fixed
    :initarg :fixed
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Croad (<Croad>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Croad>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Croad)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<Croad> is deprecated: use route_mission_handler-msg:Croad instead.")))

(cl:ensure-generic-function 'nroad_id-val :lambda-list '(m))
(cl:defmethod nroad_id-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:nroad_id-val is deprecated.  Use route_mission_handler-msg:nroad_id instead.")
  (nroad_id m))

(cl:ensure-generic-function 'isPositive-val :lambda-list '(m))
(cl:defmethod isPositive-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:isPositive-val is deprecated.  Use route_mission_handler-msg:isPositive instead.")
  (isPositive m))

(cl:ensure-generic-function 'point_id-val :lambda-list '(m))
(cl:defmethod point_id-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:point_id-val is deprecated.  Use route_mission_handler-msg:point_id instead.")
  (point_id m))

(cl:ensure-generic-function 'lane_ids-val :lambda-list '(m))
(cl:defmethod lane_ids-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lane_ids-val is deprecated.  Use route_mission_handler-msg:lane_ids instead.")
  (lane_ids m))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:points-val is deprecated.  Use route_mission_handler-msg:points instead.")
  (points m))

(cl:ensure-generic-function 'fixed-val :lambda-list '(m))
(cl:defmethod fixed-val ((m <Croad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:fixed-val is deprecated.  Use route_mission_handler-msg:fixed instead.")
  (fixed m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Croad>) ostream)
  "Serializes a message object of type '<Croad>"
  (cl:let* ((signed (cl:slot-value msg 'nroad_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isPositive) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'point_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lane_ids))))
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
   (cl:slot-value msg 'lane_ids))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fixed) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Croad>) istream)
  "Deserializes a message object of type '<Croad>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nroad_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'isPositive) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'point_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lane_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lane_ids)))
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
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:slot-value msg 'fixed) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Croad>)))
  "Returns string type for a message object of type '<Croad>"
  "route_mission_handler/Croad")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Croad)))
  "Returns string type for a message object of type 'Croad"
  "route_mission_handler/Croad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Croad>)))
  "Returns md5sum for a message object of type '<Croad>"
  "e73c05c21378699cef67e9582f6575b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Croad)))
  "Returns md5sum for a message object of type 'Croad"
  "e73c05c21378699cef67e9582f6575b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Croad>)))
  "Returns full string definition for message of type '<Croad>"
  (cl:format cl:nil "int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Croad)))
  "Returns full string definition for message of type 'Croad"
  (cl:format cl:nil "int32 nroad_id~%bool isPositive~%int32 point_id~%int32[] lane_ids~%geometry_msgs/Point[] points~%bool fixed~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Croad>))
  (cl:+ 0
     4
     1
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lane_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Croad>))
  "Converts a ROS message object to a list"
  (cl:list 'Croad
    (cl:cons ':nroad_id (nroad_id msg))
    (cl:cons ':isPositive (isPositive msg))
    (cl:cons ':point_id (point_id msg))
    (cl:cons ':lane_ids (lane_ids msg))
    (cl:cons ':points (points msg))
    (cl:cons ':fixed (fixed msg))
))
