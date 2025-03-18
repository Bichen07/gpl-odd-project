; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude LaneNavgRoad.msg.html

(cl:defclass <LaneNavgRoad> (roslisp-msg-protocol:ros-message)
  ((lane_id
    :reader lane_id
    :initarg :lane_id
    :type cl:integer
    :initform 0)
   (laneno
    :reader laneno
    :initarg :laneno
    :type cl:integer
    :initform 0)
   (navgroad1
    :reader navgroad1
    :initarg :navgroad1
    :type cl:integer
    :initform 0)
   (isPositive1
    :reader isPositive1
    :initarg :isPositive1
    :type cl:boolean
    :initform cl:nil)
   (navgroad2
    :reader navgroad2
    :initarg :navgroad2
    :type cl:integer
    :initform 0)
   (isPositive2
    :reader isPositive2
    :initarg :isPositive2
    :type cl:boolean
    :initform cl:nil)
   (seqner
    :reader seqner
    :initarg :seqner
    :type cl:string
    :initform ""))
)

(cl:defclass LaneNavgRoad (<LaneNavgRoad>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneNavgRoad>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneNavgRoad)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<LaneNavgRoad> is deprecated: use route_mission_handler-msg:LaneNavgRoad instead.")))

(cl:ensure-generic-function 'lane_id-val :lambda-list '(m))
(cl:defmethod lane_id-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lane_id-val is deprecated.  Use route_mission_handler-msg:lane_id instead.")
  (lane_id m))

(cl:ensure-generic-function 'laneno-val :lambda-list '(m))
(cl:defmethod laneno-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:laneno-val is deprecated.  Use route_mission_handler-msg:laneno instead.")
  (laneno m))

(cl:ensure-generic-function 'navgroad1-val :lambda-list '(m))
(cl:defmethod navgroad1-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:navgroad1-val is deprecated.  Use route_mission_handler-msg:navgroad1 instead.")
  (navgroad1 m))

(cl:ensure-generic-function 'isPositive1-val :lambda-list '(m))
(cl:defmethod isPositive1-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:isPositive1-val is deprecated.  Use route_mission_handler-msg:isPositive1 instead.")
  (isPositive1 m))

(cl:ensure-generic-function 'navgroad2-val :lambda-list '(m))
(cl:defmethod navgroad2-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:navgroad2-val is deprecated.  Use route_mission_handler-msg:navgroad2 instead.")
  (navgroad2 m))

(cl:ensure-generic-function 'isPositive2-val :lambda-list '(m))
(cl:defmethod isPositive2-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:isPositive2-val is deprecated.  Use route_mission_handler-msg:isPositive2 instead.")
  (isPositive2 m))

(cl:ensure-generic-function 'seqner-val :lambda-list '(m))
(cl:defmethod seqner-val ((m <LaneNavgRoad>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:seqner-val is deprecated.  Use route_mission_handler-msg:seqner instead.")
  (seqner m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneNavgRoad>) ostream)
  "Serializes a message object of type '<LaneNavgRoad>"
  (cl:let* ((signed (cl:slot-value msg 'lane_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'laneno)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'navgroad1)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isPositive1) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'navgroad2)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isPositive2) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'seqner))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'seqner))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneNavgRoad>) istream)
  "Deserializes a message object of type '<LaneNavgRoad>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lane_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'laneno) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'navgroad1) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'isPositive1) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'navgroad2) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'isPositive2) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'seqner) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'seqner) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneNavgRoad>)))
  "Returns string type for a message object of type '<LaneNavgRoad>"
  "route_mission_handler/LaneNavgRoad")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneNavgRoad)))
  "Returns string type for a message object of type 'LaneNavgRoad"
  "route_mission_handler/LaneNavgRoad")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneNavgRoad>)))
  "Returns md5sum for a message object of type '<LaneNavgRoad>"
  "49966345243e73df88bc1cde32e2f8f0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneNavgRoad)))
  "Returns md5sum for a message object of type 'LaneNavgRoad"
  "49966345243e73df88bc1cde32e2f8f0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneNavgRoad>)))
  "Returns full string definition for message of type '<LaneNavgRoad>"
  (cl:format cl:nil "int32 lane_id~%int32 laneno~%int32 navgroad1~%bool isPositive1~%int32 navgroad2~%bool isPositive2~%string seqner~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneNavgRoad)))
  "Returns full string definition for message of type 'LaneNavgRoad"
  (cl:format cl:nil "int32 lane_id~%int32 laneno~%int32 navgroad1~%bool isPositive1~%int32 navgroad2~%bool isPositive2~%string seqner~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneNavgRoad>))
  (cl:+ 0
     4
     4
     4
     1
     4
     1
     4 (cl:length (cl:slot-value msg 'seqner))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneNavgRoad>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneNavgRoad
    (cl:cons ':lane_id (lane_id msg))
    (cl:cons ':laneno (laneno msg))
    (cl:cons ':navgroad1 (navgroad1 msg))
    (cl:cons ':isPositive1 (isPositive1 msg))
    (cl:cons ':navgroad2 (navgroad2 msg))
    (cl:cons ':isPositive2 (isPositive2 msg))
    (cl:cons ':seqner (seqner msg))
))
