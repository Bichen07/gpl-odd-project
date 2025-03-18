; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude LaneNavgRoadArray.msg.html

(cl:defclass <LaneNavgRoadArray> (roslisp-msg-protocol:ros-message)
  ((lanenavgroads
    :reader lanenavgroads
    :initarg :lanenavgroads
    :type (cl:vector route_mission_handler-msg:LaneNavgRoad)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:LaneNavgRoad :initial-element (cl:make-instance 'route_mission_handler-msg:LaneNavgRoad))))
)

(cl:defclass LaneNavgRoadArray (<LaneNavgRoadArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneNavgRoadArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneNavgRoadArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<LaneNavgRoadArray> is deprecated: use route_mission_handler-msg:LaneNavgRoadArray instead.")))

(cl:ensure-generic-function 'lanenavgroads-val :lambda-list '(m))
(cl:defmethod lanenavgroads-val ((m <LaneNavgRoadArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lanenavgroads-val is deprecated.  Use route_mission_handler-msg:lanenavgroads instead.")
  (lanenavgroads m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneNavgRoadArray>) ostream)
  "Serializes a message object of type '<LaneNavgRoadArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lanenavgroads))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lanenavgroads))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneNavgRoadArray>) istream)
  "Deserializes a message object of type '<LaneNavgRoadArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lanenavgroads) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lanenavgroads)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:LaneNavgRoad))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneNavgRoadArray>)))
  "Returns string type for a message object of type '<LaneNavgRoadArray>"
  "route_mission_handler/LaneNavgRoadArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneNavgRoadArray)))
  "Returns string type for a message object of type 'LaneNavgRoadArray"
  "route_mission_handler/LaneNavgRoadArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneNavgRoadArray>)))
  "Returns md5sum for a message object of type '<LaneNavgRoadArray>"
  "9dd8b7cd48bd0df0290a75d6bb5b2e91")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneNavgRoadArray)))
  "Returns md5sum for a message object of type 'LaneNavgRoadArray"
  "9dd8b7cd48bd0df0290a75d6bb5b2e91")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneNavgRoadArray>)))
  "Returns full string definition for message of type '<LaneNavgRoadArray>"
  (cl:format cl:nil "LaneNavgRoad[] lanenavgroads~%~%================================================================================~%MSG: route_mission_handler/LaneNavgRoad~%int32 lane_id~%int32 laneno~%int32 navgroad1~%bool isPositive1~%int32 navgroad2~%bool isPositive2~%string seqner~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneNavgRoadArray)))
  "Returns full string definition for message of type 'LaneNavgRoadArray"
  (cl:format cl:nil "LaneNavgRoad[] lanenavgroads~%~%================================================================================~%MSG: route_mission_handler/LaneNavgRoad~%int32 lane_id~%int32 laneno~%int32 navgroad1~%bool isPositive1~%int32 navgroad2~%bool isPositive2~%string seqner~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneNavgRoadArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lanenavgroads) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneNavgRoadArray>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneNavgRoadArray
    (cl:cons ':lanenavgroads (lanenavgroads msg))
))
