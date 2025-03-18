; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude ObjectPathPrediction.msg.html

(cl:defclass <ObjectPathPrediction> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector itri_msgs-msg:PredictedPathArray)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:PredictedPathArray :initial-element (cl:make-instance 'itri_msgs-msg:PredictedPathArray))))
)

(cl:defclass ObjectPathPrediction (<ObjectPathPrediction>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectPathPrediction>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectPathPrediction)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<ObjectPathPrediction> is deprecated: use itri_msgs-msg:ObjectPathPrediction instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ObjectPathPrediction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <ObjectPathPrediction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:objects-val is deprecated.  Use itri_msgs-msg:objects instead.")
  (objects m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectPathPrediction>) ostream)
  "Serializes a message object of type '<ObjectPathPrediction>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectPathPrediction>) istream)
  "Deserializes a message object of type '<ObjectPathPrediction>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:PredictedPathArray))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectPathPrediction>)))
  "Returns string type for a message object of type '<ObjectPathPrediction>"
  "itri_msgs/ObjectPathPrediction")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectPathPrediction)))
  "Returns string type for a message object of type 'ObjectPathPrediction"
  "itri_msgs/ObjectPathPrediction")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectPathPrediction>)))
  "Returns md5sum for a message object of type '<ObjectPathPrediction>"
  "5c658b214b0781b4aa1b02c40ed051d9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectPathPrediction)))
  "Returns md5sum for a message object of type 'ObjectPathPrediction"
  "5c658b214b0781b4aa1b02c40ed051d9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectPathPrediction>)))
  "Returns full string definition for message of type '<ObjectPathPrediction>"
  (cl:format cl:nil "std_msgs/Header header~%~%PredictedPathArray[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PredictedPathArray~%std_msgs/Header header~%~%uint32 object_id~%PredictedPath[] predicted_paths~%geometry_msgs/Pose pose~%geometry_msgs/PolygonStamped convex_hull~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectPathPrediction)))
  "Returns full string definition for message of type 'ObjectPathPrediction"
  (cl:format cl:nil "std_msgs/Header header~%~%PredictedPathArray[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PredictedPathArray~%std_msgs/Header header~%~%uint32 object_id~%PredictedPath[] predicted_paths~%geometry_msgs/Pose pose~%geometry_msgs/PolygonStamped convex_hull~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectPathPrediction>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectPathPrediction>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectPathPrediction
    (cl:cons ':header (header msg))
    (cl:cons ':objects (objects msg))
))
