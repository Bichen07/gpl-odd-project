; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude Pair.msg.html

(cl:defclass <Pair> (roslisp-msg-protocol:ros-message)
  ((laneId
    :reader laneId
    :initarg :laneId
    :type cl:integer
    :initform 0)
   (pointIds
    :reader pointIds
    :initarg :pointIds
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass Pair (<Pair>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pair>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pair)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<Pair> is deprecated: use route_mission_handler-msg:Pair instead.")))

(cl:ensure-generic-function 'laneId-val :lambda-list '(m))
(cl:defmethod laneId-val ((m <Pair>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:laneId-val is deprecated.  Use route_mission_handler-msg:laneId instead.")
  (laneId m))

(cl:ensure-generic-function 'pointIds-val :lambda-list '(m))
(cl:defmethod pointIds-val ((m <Pair>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:pointIds-val is deprecated.  Use route_mission_handler-msg:pointIds instead.")
  (pointIds m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pair>) ostream)
  "Serializes a message object of type '<Pair>"
  (cl:let* ((signed (cl:slot-value msg 'laneId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pointIds))))
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
   (cl:slot-value msg 'pointIds))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pair>) istream)
  "Deserializes a message object of type '<Pair>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'laneId) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pointIds) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pointIds)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pair>)))
  "Returns string type for a message object of type '<Pair>"
  "route_mission_handler/Pair")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pair)))
  "Returns string type for a message object of type 'Pair"
  "route_mission_handler/Pair")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pair>)))
  "Returns md5sum for a message object of type '<Pair>"
  "9c79f7b537dfd0f3480010c95f09d489")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pair)))
  "Returns md5sum for a message object of type 'Pair"
  "9c79f7b537dfd0f3480010c95f09d489")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pair>)))
  "Returns full string definition for message of type '<Pair>"
  (cl:format cl:nil "int32 laneId~%int32[] pointIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pair)))
  "Returns full string definition for message of type 'Pair"
  (cl:format cl:nil "int32 laneId~%int32[] pointIds~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pair>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pointIds) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pair>))
  "Converts a ROS message object to a list"
  (cl:list 'Pair
    (cl:cons ':laneId (laneId msg))
    (cl:cons ':pointIds (pointIds msg))
))
