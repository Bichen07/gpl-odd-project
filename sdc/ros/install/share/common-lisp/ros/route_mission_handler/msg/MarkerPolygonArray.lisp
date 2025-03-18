; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude MarkerPolygonArray.msg.html

(cl:defclass <MarkerPolygonArray> (roslisp-msg-protocol:ros-message)
  ((markers
    :reader markers
    :initarg :markers
    :type (cl:vector route_mission_handler-msg:MarkerPolygon)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:MarkerPolygon :initial-element (cl:make-instance 'route_mission_handler-msg:MarkerPolygon))))
)

(cl:defclass MarkerPolygonArray (<MarkerPolygonArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MarkerPolygonArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MarkerPolygonArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<MarkerPolygonArray> is deprecated: use route_mission_handler-msg:MarkerPolygonArray instead.")))

(cl:ensure-generic-function 'markers-val :lambda-list '(m))
(cl:defmethod markers-val ((m <MarkerPolygonArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:markers-val is deprecated.  Use route_mission_handler-msg:markers instead.")
  (markers m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MarkerPolygonArray>) ostream)
  "Serializes a message object of type '<MarkerPolygonArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'markers))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'markers))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MarkerPolygonArray>) istream)
  "Deserializes a message object of type '<MarkerPolygonArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'markers) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'markers)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:MarkerPolygon))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MarkerPolygonArray>)))
  "Returns string type for a message object of type '<MarkerPolygonArray>"
  "route_mission_handler/MarkerPolygonArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MarkerPolygonArray)))
  "Returns string type for a message object of type 'MarkerPolygonArray"
  "route_mission_handler/MarkerPolygonArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MarkerPolygonArray>)))
  "Returns md5sum for a message object of type '<MarkerPolygonArray>"
  "19ddbcf9494b79bc31ba9be72cf01eee")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MarkerPolygonArray)))
  "Returns md5sum for a message object of type 'MarkerPolygonArray"
  "19ddbcf9494b79bc31ba9be72cf01eee")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MarkerPolygonArray>)))
  "Returns full string definition for message of type '<MarkerPolygonArray>"
  (cl:format cl:nil "MarkerPolygon[] markers~%================================================================================~%MSG: route_mission_handler/MarkerPolygon~%int32 id~%int32 type~%int32 navgId~%Pair[] pairs~%geometry_msgs/Point center_point~%geometry_msgs/Point[] corner_points~%bool on~%string value~%~%================================================================================~%MSG: route_mission_handler/Pair~%int32 laneId~%int32[] pointIds~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MarkerPolygonArray)))
  "Returns full string definition for message of type 'MarkerPolygonArray"
  (cl:format cl:nil "MarkerPolygon[] markers~%================================================================================~%MSG: route_mission_handler/MarkerPolygon~%int32 id~%int32 type~%int32 navgId~%Pair[] pairs~%geometry_msgs/Point center_point~%geometry_msgs/Point[] corner_points~%bool on~%string value~%~%================================================================================~%MSG: route_mission_handler/Pair~%int32 laneId~%int32[] pointIds~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MarkerPolygonArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'markers) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MarkerPolygonArray>))
  "Converts a ROS message object to a list"
  (cl:list 'MarkerPolygonArray
    (cl:cons ':markers (markers msg))
))
