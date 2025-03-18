; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude PredictedPathArray.msg.html

(cl:defclass <PredictedPathArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (object_id
    :reader object_id
    :initarg :object_id
    :type cl:integer
    :initform 0)
   (predicted_paths
    :reader predicted_paths
    :initarg :predicted_paths
    :type (cl:vector itri_msgs-msg:PredictedPath)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:PredictedPath :initial-element (cl:make-instance 'itri_msgs-msg:PredictedPath)))
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (convex_hull
    :reader convex_hull
    :initarg :convex_hull
    :type geometry_msgs-msg:PolygonStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PolygonStamped)))
)

(cl:defclass PredictedPathArray (<PredictedPathArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PredictedPathArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PredictedPathArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<PredictedPathArray> is deprecated: use itri_msgs-msg:PredictedPathArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PredictedPathArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <PredictedPathArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:object_id-val is deprecated.  Use itri_msgs-msg:object_id instead.")
  (object_id m))

(cl:ensure-generic-function 'predicted_paths-val :lambda-list '(m))
(cl:defmethod predicted_paths-val ((m <PredictedPathArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_paths-val is deprecated.  Use itri_msgs-msg:predicted_paths instead.")
  (predicted_paths m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <PredictedPathArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'convex_hull-val :lambda-list '(m))
(cl:defmethod convex_hull-val ((m <PredictedPathArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:convex_hull-val is deprecated.  Use itri_msgs-msg:convex_hull instead.")
  (convex_hull m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PredictedPathArray>) ostream)
  "Serializes a message object of type '<PredictedPathArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'object_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'object_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'object_id)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_paths))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_paths))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'convex_hull) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PredictedPathArray>) istream)
  "Deserializes a message object of type '<PredictedPathArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'object_id)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'predicted_paths) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'predicted_paths)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:PredictedPath))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'convex_hull) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PredictedPathArray>)))
  "Returns string type for a message object of type '<PredictedPathArray>"
  "itri_msgs/PredictedPathArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PredictedPathArray)))
  "Returns string type for a message object of type 'PredictedPathArray"
  "itri_msgs/PredictedPathArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PredictedPathArray>)))
  "Returns md5sum for a message object of type '<PredictedPathArray>"
  "9088baf61351d7ac6f023061071921dd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PredictedPathArray)))
  "Returns md5sum for a message object of type 'PredictedPathArray"
  "9088baf61351d7ac6f023061071921dd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PredictedPathArray>)))
  "Returns full string definition for message of type '<PredictedPathArray>"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 object_id~%PredictedPath[] predicted_paths~%geometry_msgs/Pose pose~%geometry_msgs/PolygonStamped convex_hull~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PredictedPathArray)))
  "Returns full string definition for message of type 'PredictedPathArray"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 object_id~%PredictedPath[] predicted_paths~%geometry_msgs/Pose pose~%geometry_msgs/PolygonStamped convex_hull~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PredictedPathArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_paths) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'convex_hull))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PredictedPathArray>))
  "Converts a ROS message object to a list"
  (cl:list 'PredictedPathArray
    (cl:cons ':header (header msg))
    (cl:cons ':object_id (object_id msg))
    (cl:cons ':predicted_paths (predicted_paths msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':convex_hull (convex_hull msg))
))
