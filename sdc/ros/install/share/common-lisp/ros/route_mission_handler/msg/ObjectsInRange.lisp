; Auto-generated. Do not edit!


(cl:in-package route_mission_handler-msg)


;//! \htmlinclude ObjectsInRange.msg.html

(cl:defclass <ObjectsInRange> (roslisp-msg-protocol:ros-message)
  ((changed
    :reader changed
    :initarg :changed
    :type cl:boolean
    :initform cl:nil)
   (range
    :reader range
    :initarg :range
    :type geometry_msgs-msg:Polygon
    :initform (cl:make-instance 'geometry_msgs-msg:Polygon))
   (lanes
    :reader lanes
    :initarg :lanes
    :type (cl:vector route_mission_handler-msg:Lanes)
   :initform (cl:make-array 0 :element-type 'route_mission_handler-msg:Lanes :initial-element (cl:make-instance 'route_mission_handler-msg:Lanes)))
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector geometry_msgs-msg:Polygon)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Polygon :initial-element (cl:make-instance 'geometry_msgs-msg:Polygon))))
)

(cl:defclass ObjectsInRange (<ObjectsInRange>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectsInRange>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectsInRange)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name route_mission_handler-msg:<ObjectsInRange> is deprecated: use route_mission_handler-msg:ObjectsInRange instead.")))

(cl:ensure-generic-function 'changed-val :lambda-list '(m))
(cl:defmethod changed-val ((m <ObjectsInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:changed-val is deprecated.  Use route_mission_handler-msg:changed instead.")
  (changed m))

(cl:ensure-generic-function 'range-val :lambda-list '(m))
(cl:defmethod range-val ((m <ObjectsInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:range-val is deprecated.  Use route_mission_handler-msg:range instead.")
  (range m))

(cl:ensure-generic-function 'lanes-val :lambda-list '(m))
(cl:defmethod lanes-val ((m <ObjectsInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:lanes-val is deprecated.  Use route_mission_handler-msg:lanes instead.")
  (lanes m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <ObjectsInRange>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader route_mission_handler-msg:objects-val is deprecated.  Use route_mission_handler-msg:objects instead.")
  (objects m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectsInRange>) ostream)
  "Serializes a message object of type '<ObjectsInRange>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'changed) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'range) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lanes))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lanes))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectsInRange>) istream)
  "Deserializes a message object of type '<ObjectsInRange>"
    (cl:setf (cl:slot-value msg 'changed) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'range) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lanes) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lanes)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'route_mission_handler-msg:Lanes))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Polygon))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectsInRange>)))
  "Returns string type for a message object of type '<ObjectsInRange>"
  "route_mission_handler/ObjectsInRange")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectsInRange)))
  "Returns string type for a message object of type 'ObjectsInRange"
  "route_mission_handler/ObjectsInRange")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectsInRange>)))
  "Returns md5sum for a message object of type '<ObjectsInRange>"
  "23414e3f925d00431df85f0ca877074c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectsInRange)))
  "Returns md5sum for a message object of type 'ObjectsInRange"
  "23414e3f925d00431df85f0ca877074c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectsInRange>)))
  "Returns full string definition for message of type '<ObjectsInRange>"
  (cl:format cl:nil "bool changed~%geometry_msgs/Polygon range~%route_mission_handler/Lanes[] lanes~%geometry_msgs/Polygon[] objects~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: route_mission_handler/Lanes~%int32 type~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 id~%bool isTurn~%bool direction~%int32 laneno~%int32[] nexts~%int32[] roadLineIds~%Waypoints[] points~%int32 max_speed_limit~%int32 roadType~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectsInRange)))
  "Returns full string definition for message of type 'ObjectsInRange"
  (cl:format cl:nil "bool changed~%geometry_msgs/Polygon range~%route_mission_handler/Lanes[] lanes~%geometry_msgs/Polygon[] objects~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: route_mission_handler/Lanes~%int32 type~%int32 NORMAL=0~%int32 SPLIT_LEFT=1~%int32 SPLIT_RIGHT=2~%int32 MERGE_TO_RIGHT=3~%int32 MERGE_TO_LEFT=4~%int32 TOBE_MERGED=5~%int32 SPLIT_STRAIGHT=6~%~%int32 id~%bool isTurn~%bool direction~%int32 laneno~%int32[] nexts~%int32[] roadLineIds~%Waypoints[] points~%int32 max_speed_limit~%int32 roadType~%~%================================================================================~%MSG: route_mission_handler/Waypoints~%int32 laneId~%int32 pointId~%float32 roadWidth~%float32 distToRightLine~%float32 distToLeftLine~%float32 right_road_bound~%float32 left_road_bound~%float32 curve~%float32 slope~%float32 bank_angle~%geometry_msgs/Pose pose~%int32[] markerIds~%int32[] markerTypes~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectsInRange>))
  (cl:+ 0
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'range))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lanes) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectsInRange>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectsInRange
    (cl:cons ':changed (changed msg))
    (cl:cons ':range (range msg))
    (cl:cons ':lanes (lanes msg))
    (cl:cons ':objects (objects msg))
))
