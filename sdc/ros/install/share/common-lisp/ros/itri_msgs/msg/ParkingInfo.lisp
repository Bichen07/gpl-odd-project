; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ParkingInfo.msg.html

(cl:defclass <ParkingInfo> (roslisp-msg-protocol:ros-message)
  ((totalParkingPathCount
    :reader totalParkingPathCount
    :initarg :totalParkingPathCount
    :type cl:integer
    :initform 0)
   (currentPathNumber
    :reader currentPathNumber
    :initarg :currentPathNumber
    :type cl:integer
    :initform 0))
)

(cl:defclass ParkingInfo (<ParkingInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ParkingInfo> is deprecated: use itri_msgs-msg:ParkingInfo instead.")))

(cl:ensure-generic-function 'totalParkingPathCount-val :lambda-list '(m))
(cl:defmethod totalParkingPathCount-val ((m <ParkingInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:totalParkingPathCount-val is deprecated.  Use itri_msgs-msg:totalParkingPathCount instead.")
  (totalParkingPathCount m))

(cl:ensure-generic-function 'currentPathNumber-val :lambda-list '(m))
(cl:defmethod currentPathNumber-val ((m <ParkingInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:currentPathNumber-val is deprecated.  Use itri_msgs-msg:currentPathNumber instead.")
  (currentPathNumber m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingInfo>) ostream)
  "Serializes a message object of type '<ParkingInfo>"
  (cl:let* ((signed (cl:slot-value msg 'totalParkingPathCount)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'currentPathNumber)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingInfo>) istream)
  "Deserializes a message object of type '<ParkingInfo>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'totalParkingPathCount) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'currentPathNumber) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingInfo>)))
  "Returns string type for a message object of type '<ParkingInfo>"
  "itri_msgs/ParkingInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingInfo)))
  "Returns string type for a message object of type 'ParkingInfo"
  "itri_msgs/ParkingInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingInfo>)))
  "Returns md5sum for a message object of type '<ParkingInfo>"
  "4ee64eeb93cd6229d15145ec3ca31a85")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingInfo)))
  "Returns md5sum for a message object of type 'ParkingInfo"
  "4ee64eeb93cd6229d15145ec3ca31a85")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingInfo>)))
  "Returns full string definition for message of type '<ParkingInfo>"
  (cl:format cl:nil "int32 totalParkingPathCount~%int32 currentPathNumber~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingInfo)))
  "Returns full string definition for message of type 'ParkingInfo"
  (cl:format cl:nil "int32 totalParkingPathCount~%int32 currentPathNumber~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingInfo>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingInfo
    (cl:cons ':totalParkingPathCount (totalParkingPathCount msg))
    (cl:cons ':currentPathNumber (currentPathNumber msg))
))
