; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ParkingSpaceArray.msg.html

(cl:defclass <ParkingSpaceArray> (roslisp-msg-protocol:ros-message)
  ((spaces
    :reader spaces
    :initarg :spaces
    :type (cl:vector route_mission_handler-msg:ParkingSpace)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:ParkingSpace :initial-element (cl:make-instance 'route_mission_handler-msg:ParkingSpace))))
)

(cl:defclass ParkingSpaceArray (<ParkingSpaceArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ParkingSpaceArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ParkingSpaceArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ParkingSpaceArray> is deprecated: use route_mission_handler-msg:ParkingSpaceArray instead.")))

(cl:ensure-generic-function 'spaces-val :lambda-list '(m))
(cl:defmethod spaces-val ((m <ParkingSpaceArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:spaces-val is deprecated.  Use route_mission_handler-msg:spaces instead.")
  (spaces m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ParkingSpaceArray>) ostream)
  "Serializes a message object of type '<ParkingSpaceArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'spaces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'spaces))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ParkingSpaceArray>) istream)
  "Deserializes a message object of type '<ParkingSpaceArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'spaces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'spaces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:ParkingSpace))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ParkingSpaceArray>)))
  "Returns string type for a message object of type '<ParkingSpaceArray>"
  "route_mission_handler/ParkingSpaceArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ParkingSpaceArray)))
  "Returns string type for a message object of type 'ParkingSpaceArray"
  "route_mission_handler/ParkingSpaceArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ParkingSpaceArray>)))
  "Returns md5sum for a message object of type '<ParkingSpaceArray>"
  "b8e941ec972f8a9821ad740811fc6845")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ParkingSpaceArray)))
  "Returns md5sum for a message object of type 'ParkingSpaceArray"
  "b8e941ec972f8a9821ad740811fc6845")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ParkingSpaceArray>)))
  "Returns full string definition for message of type '<ParkingSpaceArray>"
  (cl:format cl:nil "ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ParkingSpaceArray)))
  "Returns full string definition for message of type 'ParkingSpaceArray"
  (cl:format cl:nil "ParkingSpace[] spaces~%~%================================================================================~%MSG: route_mission_handler/ParkingSpace~%int32 type~%int32 VERTICAL=0~%int32 PARALLEL=1~%int32 OBLIQUE=2~%~%int32 side~%int32 RIGHT=0~%int32 LEFT=1~%~%int32 id~%int32 parkingLotId~%int32 laneId~%int32 pointId~%int32 orderType~%geometry_msgs/Point[] points~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ParkingSpaceArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'spaces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ParkingSpaceArray>))
  "Converts a ROS message object to a list"
  (cl:list 'ParkingSpaceArray
    (cl:cons ':spaces (spaces msg))
))
