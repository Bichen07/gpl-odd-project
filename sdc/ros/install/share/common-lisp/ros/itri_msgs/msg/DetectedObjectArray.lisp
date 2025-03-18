; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude DetectedObjectArray.msg.html

(cl:defclass <DetectedObjectArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector itri_msgs-msg:DetectedObject)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:DetectedObject :initial-element (cl:make-instance 'itri_msgs-msg:DetectedObject)))
   (sensor_type
    :reader sensor_type
    :initarg :sensor_type
    :type cl:integer
    :initform 0))
)

(cl:defclass DetectedObjectArray (<DetectedObjectArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedObjectArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedObjectArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<DetectedObjectArray> is deprecated: use itri_msgs-msg:DetectedObjectArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DetectedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <DetectedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:objects-val is deprecated.  Use itri_msgs-msg:objects instead.")
  (objects m))

(cl:ensure-generic-function 'sensor_type-val :lambda-list '(m))
(cl:defmethod sensor_type-val ((m <DetectedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:sensor_type-val is deprecated.  Use itri_msgs-msg:sensor_type instead.")
  (sensor_type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedObjectArray>) ostream)
  "Serializes a message object of type '<DetectedObjectArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sensor_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sensor_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sensor_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sensor_type)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedObjectArray>) istream)
  "Deserializes a message object of type '<DetectedObjectArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'itri_msgs-msg:DetectedObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sensor_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sensor_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sensor_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sensor_type)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedObjectArray>)))
  "Returns string type for a message object of type '<DetectedObjectArray>"
  "itri_msgs/DetectedObjectArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedObjectArray)))
  "Returns string type for a message object of type 'DetectedObjectArray"
  "itri_msgs/DetectedObjectArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedObjectArray>)))
  "Returns md5sum for a message object of type '<DetectedObjectArray>"
  "276d607237a4270f49c5de8f71694bfa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedObjectArray)))
  "Returns md5sum for a message object of type 'DetectedObjectArray"
  "276d607237a4270f49c5de8f71694bfa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedObjectArray>)))
  "Returns full string definition for message of type '<DetectedObjectArray>"
  (cl:format cl:nil "std_msgs/Header header~%DetectedObject[] objects~%uint32 sensor_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/DetectedObject~%std_msgs/Header header~%~%uint32 id~%string label~%float32 score~%std_msgs/ColorRGBA color~%float64 trackedPeriod~%~%geometry_msgs/Pose pose~%geometry_msgs/Vector3 dimensions~%geometry_msgs/Vector3 variance~%geometry_msgs/Twist velocity~%geometry_msgs/Twist abs_velocity~%~%geometry_msgs/PolygonStamped convex_hull~%~%bool pose_reliable~%bool velocity_reliable~%~%sensor_msgs/PointCloud2 pointcloud~%~%string image_frame~%int32 x~%int32 y~%int32 width~%int32 height~%float32 angle~%~%string space_frame~%~%# Behavior State of the Detected Object~%# FORWARD_STATE			= 0~%# STOPPING_STATE 		= 1~%# BRANCH_LEFT_STATE		= 2~%# BRANCH_RIGHT_STATE	= 3~%# YIELDING_STATE		= 4~%# ACCELERATING_STATE	= 5~%# SLOWDOWN_STATE 		= 6~%~%uint32 behavior_state~%~%geometry_msgs/Point[] history_path~%geometry_msgs/Point[] predicted_poses~%geometry_msgs/Point[] predicted_variance~%~%PredictedPath[] predicted_paths~%geometry_msgs/Twist acceleration~%~%Ars40xClusters radarFusionPoints~%CameraObjectFrustum cameraObjectFrustum~%int32 overlapObjectsNumber~%geometry_msgs/PolygonStamped visibleSegments~%geometry_msgs/PolygonStamped image2Dcube~%bool isMoving~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: itri_msgs/Ars40xClusters~%Header header~%Ars40xCluster[] clusters~%================================================================================~%MSG: itri_msgs/Ars40xCluster~%uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: itri_msgs/CameraObjectFrustum~%geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedObjectArray)))
  "Returns full string definition for message of type 'DetectedObjectArray"
  (cl:format cl:nil "std_msgs/Header header~%DetectedObject[] objects~%uint32 sensor_type~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: itri_msgs/DetectedObject~%std_msgs/Header header~%~%uint32 id~%string label~%float32 score~%std_msgs/ColorRGBA color~%float64 trackedPeriod~%~%geometry_msgs/Pose pose~%geometry_msgs/Vector3 dimensions~%geometry_msgs/Vector3 variance~%geometry_msgs/Twist velocity~%geometry_msgs/Twist abs_velocity~%~%geometry_msgs/PolygonStamped convex_hull~%~%bool pose_reliable~%bool velocity_reliable~%~%sensor_msgs/PointCloud2 pointcloud~%~%string image_frame~%int32 x~%int32 y~%int32 width~%int32 height~%float32 angle~%~%string space_frame~%~%# Behavior State of the Detected Object~%# FORWARD_STATE			= 0~%# STOPPING_STATE 		= 1~%# BRANCH_LEFT_STATE		= 2~%# BRANCH_RIGHT_STATE	= 3~%# YIELDING_STATE		= 4~%# ACCELERATING_STATE	= 5~%# SLOWDOWN_STATE 		= 6~%~%uint32 behavior_state~%~%geometry_msgs/Point[] history_path~%geometry_msgs/Point[] predicted_poses~%geometry_msgs/Point[] predicted_variance~%~%PredictedPath[] predicted_paths~%geometry_msgs/Twist acceleration~%~%Ars40xClusters radarFusionPoints~%CameraObjectFrustum cameraObjectFrustum~%int32 overlapObjectsNumber~%geometry_msgs/PolygonStamped visibleSegments~%geometry_msgs/PolygonStamped image2Dcube~%bool isMoving~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: itri_msgs/Ars40xClusters~%Header header~%Ars40xCluster[] clusters~%================================================================================~%MSG: itri_msgs/Ars40xCluster~%uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: itri_msgs/CameraObjectFrustum~%geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedObjectArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedObjectArray>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedObjectArray
    (cl:cons ':header (header msg))
    (cl:cons ':objects (objects msg))
    (cl:cons ':sensor_type (sensor_type msg))
))
