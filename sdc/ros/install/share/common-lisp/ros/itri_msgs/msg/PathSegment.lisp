; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude PathSegment.msg.html

(cl:defclass <PathSegment> (roslisp-msg-protocol:ros-message)
  ((laneId
    :reader laneId
    :initarg :laneId
    :type cl:integer
    :initform 0)
   (startPoint
    :reader startPoint
    :initarg :startPoint
    :type cl:integer
    :initform 0)
   (endPoint
    :reader endPoint
    :initarg :endPoint
    :type cl:integer
    :initform 0))
)

(cl:defclass PathSegment (<PathSegment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PathSegment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PathSegment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<PathSegment> is deprecated: use itri_msgs-msg:PathSegment instead.")))

(cl:ensure-generic-function 'laneId-val :lambda-list '(m))
(cl:defmethod laneId-val ((m <PathSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:laneId-val is deprecated.  Use itri_msgs-msg:laneId instead.")
  (laneId m))

(cl:ensure-generic-function 'startPoint-val :lambda-list '(m))
(cl:defmethod startPoint-val ((m <PathSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:startPoint-val is deprecated.  Use itri_msgs-msg:startPoint instead.")
  (startPoint m))

(cl:ensure-generic-function 'endPoint-val :lambda-list '(m))
(cl:defmethod endPoint-val ((m <PathSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:endPoint-val is deprecated.  Use itri_msgs-msg:endPoint instead.")
  (endPoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PathSegment>) ostream)
  "Serializes a message object of type '<PathSegment>"
  (cl:let* ((signed (cl:slot-value msg 'laneId)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'startPoint)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'endPoint)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PathSegment>) istream)
  "Deserializes a message object of type '<PathSegment>"
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
      (cl:setf (cl:slot-value msg 'startPoint) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'endPoint) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PathSegment>)))
  "Returns string type for a message object of type '<PathSegment>"
  "itri_msgs/PathSegment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PathSegment)))
  "Returns string type for a message object of type 'PathSegment"
  "itri_msgs/PathSegment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PathSegment>)))
  "Returns md5sum for a message object of type '<PathSegment>"
  "6ef80e49d1cec715d0fab363071a33fa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PathSegment)))
  "Returns md5sum for a message object of type 'PathSegment"
  "6ef80e49d1cec715d0fab363071a33fa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PathSegment>)))
  "Returns full string definition for message of type '<PathSegment>"
  (cl:format cl:nil "int32 laneId~%int32 startPoint~%int32 endPoint~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PathSegment)))
  "Returns full string definition for message of type 'PathSegment"
  (cl:format cl:nil "int32 laneId~%int32 startPoint~%int32 endPoint~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PathSegment>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PathSegment>))
  "Converts a ROS message object to a list"
  (cl:list 'PathSegment
    (cl:cons ':laneId (laneId msg))
    (cl:cons ':startPoint (startPoint msg))
    (cl:cons ':endPoint (endPoint msg))
))
