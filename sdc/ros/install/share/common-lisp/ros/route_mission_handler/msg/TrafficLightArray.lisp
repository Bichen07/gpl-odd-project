; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude TrafficLightArray.msg.html

(cl:defclass <TrafficLightArray> (roslisp-msg-protocol:ros-message)
  ((lights
    :reader lights
    :initarg :lights
    :type (cl:vector route_mission_handler-msg:TrafficLight)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:TrafficLight :initial-element (cl:make-instance 'route_mission_handler-msg:TrafficLight))))
)

(cl:defclass TrafficLightArray (<TrafficLightArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<TrafficLightArray> is deprecated: use route_mission_handler-msg:TrafficLightArray instead.")))

(cl:ensure-generic-function 'lights-val :lambda-list '(m))
(cl:defmethod lights-val ((m <TrafficLightArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lights-val is deprecated.  Use route_mission_handler-msg:lights instead.")
  (lights m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightArray>) ostream)
  "Serializes a message object of type '<TrafficLightArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lights))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lights))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightArray>) istream)
  "Deserializes a message object of type '<TrafficLightArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lights) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lights)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:TrafficLight))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightArray>)))
  "Returns string type for a message object of type '<TrafficLightArray>"
  "route_mission_handler/TrafficLightArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightArray)))
  "Returns string type for a message object of type 'TrafficLightArray"
  "route_mission_handler/TrafficLightArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightArray>)))
  "Returns md5sum for a message object of type '<TrafficLightArray>"
  "baac1bc15bbef8708daeb8205a8b92da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightArray)))
  "Returns md5sum for a message object of type 'TrafficLightArray"
  "baac1bc15bbef8708daeb8205a8b92da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightArray>)))
  "Returns full string definition for message of type '<TrafficLightArray>"
  (cl:format cl:nil "TrafficLight[] lights~%~%================================================================================~%MSG: route_mission_handler/TrafficLight~%int32 id~%int32[] laneIds~%int32 type~%int32 lightNum~%string vps~%string vpe~%float32 heading~%geometry_msgs/Point[] points~%string[] lights~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightArray)))
  "Returns full string definition for message of type 'TrafficLightArray"
  (cl:format cl:nil "TrafficLight[] lights~%~%================================================================================~%MSG: route_mission_handler/TrafficLight~%int32 id~%int32[] laneIds~%int32 type~%int32 lightNum~%string vps~%string vpe~%float32 heading~%geometry_msgs/Point[] points~%string[] lights~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lights) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightArray>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightArray
    (cl:cons ':lights (lights msg))
))
