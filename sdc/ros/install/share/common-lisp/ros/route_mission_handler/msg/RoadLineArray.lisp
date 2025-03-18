; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude RoadLineArray.msg.html

(cl:defclass <RoadLineArray> (roslisp-msg-protocol:ros-message)
  ((lines
    :reader lines
    :initarg :lines
    :type (cl:vector route_mission_handler-msg:RoadLine)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:RoadLine :initial-element (cl:make-instance 'route_mission_handler-msg:RoadLine))))
)

(cl:defclass RoadLineArray (<RoadLineArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RoadLineArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RoadLineArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<RoadLineArray> is deprecated: use route_mission_handler-msg:RoadLineArray instead.")))

(cl:ensure-generic-function 'lines-val :lambda-list '(m))
(cl:defmethod lines-val ((m <RoadLineArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lines-val is deprecated.  Use route_mission_handler-msg:lines instead.")
  (lines m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RoadLineArray>) ostream)
  "Serializes a message object of type '<RoadLineArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lines))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lines))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RoadLineArray>) istream)
  "Deserializes a message object of type '<RoadLineArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lines) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lines)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:RoadLine))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RoadLineArray>)))
  "Returns string type for a message object of type '<RoadLineArray>"
  "route_mission_handler/RoadLineArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RoadLineArray)))
  "Returns string type for a message object of type 'RoadLineArray"
  "route_mission_handler/RoadLineArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RoadLineArray>)))
  "Returns md5sum for a message object of type '<RoadLineArray>"
  "328e2a15a161447b2069ea6540b246dc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RoadLineArray)))
  "Returns md5sum for a message object of type 'RoadLineArray"
  "328e2a15a161447b2069ea6540b246dc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RoadLineArray>)))
  "Returns full string definition for message of type '<RoadLineArray>"
  (cl:format cl:nil "RoadLine[] lines~%~%================================================================================~%MSG: route_mission_handler/RoadLine~%int32 id~%RoadLinePoint[] points~%~%================================================================================~%MSG: route_mission_handler/RoadLinePoint~%int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RoadLineArray)))
  "Returns full string definition for message of type 'RoadLineArray"
  (cl:format cl:nil "RoadLine[] lines~%~%================================================================================~%MSG: route_mission_handler/RoadLine~%int32 id~%RoadLinePoint[] points~%~%================================================================================~%MSG: route_mission_handler/RoadLinePoint~%int32 id~%int32 type~%geometry_msgs/Point position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RoadLineArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lines) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RoadLineArray>))
  "Converts a ROS message object to a list"
  (cl:list 'RoadLineArray
    (cl:cons ':lines (lines msg))
))
