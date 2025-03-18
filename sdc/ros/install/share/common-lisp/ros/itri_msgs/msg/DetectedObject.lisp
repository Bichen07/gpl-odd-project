; Auto-generated. Do not edit!


(cl:in-package itri_msgs-msg)


;//! \htmlinclude DetectedObject.msg.html

(cl:defclass <DetectedObject> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (label
    :reader label
    :initarg :label
    :type cl:string
    :initform "")
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (color
    :reader color
    :initarg :color
    :type std_msgs-msg:ColorRGBA
    :initform (cl:make-instance 'std_msgs-msg:ColorRGBA))
   (trackedPeriod
    :reader trackedPeriod
    :initarg :trackedPeriod
    :type cl:float
    :initform 0.0)
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (dimensions
    :reader dimensions
    :initarg :dimensions
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (variance
    :reader variance
    :initarg :variance
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (velocity
    :reader velocity
    :initarg :velocity
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (abs_velocity
    :reader abs_velocity
    :initarg :abs_velocity
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (convex_hull
    :reader convex_hull
    :initarg :convex_hull
    :type geometry_msgs-msg:PolygonStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PolygonStamped))
   (pose_reliable
    :reader pose_reliable
    :initarg :pose_reliable
    :type cl:boolean
    :initform cl:nil)
   (velocity_reliable
    :reader velocity_reliable
    :initarg :velocity_reliable
    :type cl:boolean
    :initform cl:nil)
   (pointcloud
    :reader pointcloud
    :initarg :pointcloud
    :type sensor_msgs-msg:PointCloud2
    :initform (cl:make-instance 'sensor_msgs-msg:PointCloud2))
   (image_frame
    :reader image_frame
    :initarg :image_frame
    :type cl:string
    :initform "")
   (x
    :reader x
    :initarg :x
    :type cl:integer
    :initform 0)
   (y
    :reader y
    :initarg :y
    :type cl:integer
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:integer
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:integer
    :initform 0)
   (angle
    :reader angle
    :initarg :angle
    :type cl:float
    :initform 0.0)
   (space_frame
    :reader space_frame
    :initarg :space_frame
    :type cl:string
    :initform "")
   (behavior_state
    :reader behavior_state
    :initarg :behavior_state
    :type cl:integer
    :initform 0)
   (history_path
    :reader history_path
    :initarg :history_path
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (predicted_poses
    :reader predicted_poses
    :initarg :predicted_poses
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (predicted_variance
    :reader predicted_variance
    :initarg :predicted_variance
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (predicted_paths
    :reader predicted_paths
    :initarg :predicted_paths
    :type (cl:vector itri_msgs-msg:PredictedPath)
   :initform (cl:make-array 0 :element-type 'itri_msgs-msg:PredictedPath :initial-element (cl:make-instance 'itri_msgs-msg:PredictedPath)))
   (acceleration
    :reader acceleration
    :initarg :acceleration
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (radarFusionPoints
    :reader radarFusionPoints
    :initarg :radarFusionPoints
    :type itri_msgs-msg:Ars40xClusters
    :initform (cl:make-instance 'itri_msgs-msg:Ars40xClusters))
   (cameraObjectFrustum
    :reader cameraObjectFrustum
    :initarg :cameraObjectFrustum
    :type itri_msgs-msg:CameraObjectFrustum
    :initform (cl:make-instance 'itri_msgs-msg:CameraObjectFrustum))
   (overlapObjectsNumber
    :reader overlapObjectsNumber
    :initarg :overlapObjectsNumber
    :type cl:integer
    :initform 0)
   (visibleSegments
    :reader visibleSegments
    :initarg :visibleSegments
    :type geometry_msgs-msg:PolygonStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PolygonStamped))
   (image2Dcube
    :reader image2Dcube
    :initarg :image2Dcube
    :type geometry_msgs-msg:PolygonStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PolygonStamped))
   (isMoving
    :reader isMoving
    :initarg :isMoving
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass DetectedObject (<DetectedObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name itri_msgs-msg:<DetectedObject> is deprecated: use itri_msgs-msg:DetectedObject instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:header-val is deprecated.  Use itri_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:id-val is deprecated.  Use itri_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'label-val :lambda-list '(m))
(cl:defmethod label-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:label-val is deprecated.  Use itri_msgs-msg:label instead.")
  (label m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:score-val is deprecated.  Use itri_msgs-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:color-val is deprecated.  Use itri_msgs-msg:color instead.")
  (color m))

(cl:ensure-generic-function 'trackedPeriod-val :lambda-list '(m))
(cl:defmethod trackedPeriod-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:trackedPeriod-val is deprecated.  Use itri_msgs-msg:trackedPeriod instead.")
  (trackedPeriod m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose-val is deprecated.  Use itri_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'dimensions-val :lambda-list '(m))
(cl:defmethod dimensions-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:dimensions-val is deprecated.  Use itri_msgs-msg:dimensions instead.")
  (dimensions m))

(cl:ensure-generic-function 'variance-val :lambda-list '(m))
(cl:defmethod variance-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:variance-val is deprecated.  Use itri_msgs-msg:variance instead.")
  (variance m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocity-val is deprecated.  Use itri_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'abs_velocity-val :lambda-list '(m))
(cl:defmethod abs_velocity-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:abs_velocity-val is deprecated.  Use itri_msgs-msg:abs_velocity instead.")
  (abs_velocity m))

(cl:ensure-generic-function 'convex_hull-val :lambda-list '(m))
(cl:defmethod convex_hull-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:convex_hull-val is deprecated.  Use itri_msgs-msg:convex_hull instead.")
  (convex_hull m))

(cl:ensure-generic-function 'pose_reliable-val :lambda-list '(m))
(cl:defmethod pose_reliable-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pose_reliable-val is deprecated.  Use itri_msgs-msg:pose_reliable instead.")
  (pose_reliable m))

(cl:ensure-generic-function 'velocity_reliable-val :lambda-list '(m))
(cl:defmethod velocity_reliable-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:velocity_reliable-val is deprecated.  Use itri_msgs-msg:velocity_reliable instead.")
  (velocity_reliable m))

(cl:ensure-generic-function 'pointcloud-val :lambda-list '(m))
(cl:defmethod pointcloud-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:pointcloud-val is deprecated.  Use itri_msgs-msg:pointcloud instead.")
  (pointcloud m))

(cl:ensure-generic-function 'image_frame-val :lambda-list '(m))
(cl:defmethod image_frame-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:image_frame-val is deprecated.  Use itri_msgs-msg:image_frame instead.")
  (image_frame m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:x-val is deprecated.  Use itri_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:y-val is deprecated.  Use itri_msgs-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:width-val is deprecated.  Use itri_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:height-val is deprecated.  Use itri_msgs-msg:height instead.")
  (height m))

(cl:ensure-generic-function 'angle-val :lambda-list '(m))
(cl:defmethod angle-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:angle-val is deprecated.  Use itri_msgs-msg:angle instead.")
  (angle m))

(cl:ensure-generic-function 'space_frame-val :lambda-list '(m))
(cl:defmethod space_frame-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:space_frame-val is deprecated.  Use itri_msgs-msg:space_frame instead.")
  (space_frame m))

(cl:ensure-generic-function 'behavior_state-val :lambda-list '(m))
(cl:defmethod behavior_state-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:behavior_state-val is deprecated.  Use itri_msgs-msg:behavior_state instead.")
  (behavior_state m))

(cl:ensure-generic-function 'history_path-val :lambda-list '(m))
(cl:defmethod history_path-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:history_path-val is deprecated.  Use itri_msgs-msg:history_path instead.")
  (history_path m))

(cl:ensure-generic-function 'predicted_poses-val :lambda-list '(m))
(cl:defmethod predicted_poses-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_poses-val is deprecated.  Use itri_msgs-msg:predicted_poses instead.")
  (predicted_poses m))

(cl:ensure-generic-function 'predicted_variance-val :lambda-list '(m))
(cl:defmethod predicted_variance-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_variance-val is deprecated.  Use itri_msgs-msg:predicted_variance instead.")
  (predicted_variance m))

(cl:ensure-generic-function 'predicted_paths-val :lambda-list '(m))
(cl:defmethod predicted_paths-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:predicted_paths-val is deprecated.  Use itri_msgs-msg:predicted_paths instead.")
  (predicted_paths m))

(cl:ensure-generic-function 'acceleration-val :lambda-list '(m))
(cl:defmethod acceleration-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:acceleration-val is deprecated.  Use itri_msgs-msg:acceleration instead.")
  (acceleration m))

(cl:ensure-generic-function 'radarFusionPoints-val :lambda-list '(m))
(cl:defmethod radarFusionPoints-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:radarFusionPoints-val is deprecated.  Use itri_msgs-msg:radarFusionPoints instead.")
  (radarFusionPoints m))

(cl:ensure-generic-function 'cameraObjectFrustum-val :lambda-list '(m))
(cl:defmethod cameraObjectFrustum-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:cameraObjectFrustum-val is deprecated.  Use itri_msgs-msg:cameraObjectFrustum instead.")
  (cameraObjectFrustum m))

(cl:ensure-generic-function 'overlapObjectsNumber-val :lambda-list '(m))
(cl:defmethod overlapObjectsNumber-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:overlapObjectsNumber-val is deprecated.  Use itri_msgs-msg:overlapObjectsNumber instead.")
  (overlapObjectsNumber m))

(cl:ensure-generic-function 'visibleSegments-val :lambda-list '(m))
(cl:defmethod visibleSegments-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:visibleSegments-val is deprecated.  Use itri_msgs-msg:visibleSegments instead.")
  (visibleSegments m))

(cl:ensure-generic-function 'image2Dcube-val :lambda-list '(m))
(cl:defmethod image2Dcube-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:image2Dcube-val is deprecated.  Use itri_msgs-msg:image2Dcube instead.")
  (image2Dcube m))

(cl:ensure-generic-function 'isMoving-val :lambda-list '(m))
(cl:defmethod isMoving-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader itri_msgs-msg:isMoving-val is deprecated.  Use itri_msgs-msg:isMoving instead.")
  (isMoving m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedObject>) ostream)
  "Serializes a message object of type '<DetectedObject>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'label))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'label))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'color) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'trackedPeriod))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'dimensions) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'variance) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'abs_velocity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'convex_hull) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'pose_reliable) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'velocity_reliable) 1 0)) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pointcloud) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'image_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'image_frame))
  (cl:let* ((signed (cl:slot-value msg 'x)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'y)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'width)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'height)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'space_frame))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'space_frame))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'behavior_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'behavior_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'behavior_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'behavior_state)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'history_path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'history_path))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_poses))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_poses))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_variance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_variance))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'predicted_paths))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'predicted_paths))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'acceleration) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'radarFusionPoints) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cameraObjectFrustum) ostream)
  (cl:let* ((signed (cl:slot-value msg 'overlapObjectsNumber)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'visibleSegments) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image2Dcube) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isMoving) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedObject>) istream)
  "Deserializes a message object of type '<DetectedObject>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'label) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'label) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'color) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'trackedPeriod) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'dimensions) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'variance) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'abs_velocity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'convex_hull) istream)
    (cl:setf (cl:slot-value msg 'pose_reliable) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'velocity_reliable) (cl:not (cl:zerop (cl:read-byte istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pointcloud) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'image_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'image_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'x) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'y) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'width) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'height) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angle) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'space_frame) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'space_frame) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'behavior_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'behavior_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'behavior_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'behavior_state)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'history_path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'history_path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'predicted_poses) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'predicted_poses)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'predicted_variance) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'predicted_variance)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'acceleration) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'radarFusionPoints) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cameraObjectFrustum) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'overlapObjectsNumber) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'visibleSegments) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image2Dcube) istream)
    (cl:setf (cl:slot-value msg 'isMoving) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedObject>)))
  "Returns string type for a message object of type '<DetectedObject>"
  "itri_msgs/DetectedObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedObject)))
  "Returns string type for a message object of type 'DetectedObject"
  "itri_msgs/DetectedObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedObject>)))
  "Returns md5sum for a message object of type '<DetectedObject>"
  "10228fe6703d131d34e20f1a96859644")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedObject)))
  "Returns md5sum for a message object of type 'DetectedObject"
  "10228fe6703d131d34e20f1a96859644")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedObject>)))
  "Returns full string definition for message of type '<DetectedObject>"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 id~%string label~%float32 score~%std_msgs/ColorRGBA color~%float64 trackedPeriod~%~%geometry_msgs/Pose pose~%geometry_msgs/Vector3 dimensions~%geometry_msgs/Vector3 variance~%geometry_msgs/Twist velocity~%geometry_msgs/Twist abs_velocity~%~%geometry_msgs/PolygonStamped convex_hull~%~%bool pose_reliable~%bool velocity_reliable~%~%sensor_msgs/PointCloud2 pointcloud~%~%string image_frame~%int32 x~%int32 y~%int32 width~%int32 height~%float32 angle~%~%string space_frame~%~%# Behavior State of the Detected Object~%# FORWARD_STATE			= 0~%# STOPPING_STATE 		= 1~%# BRANCH_LEFT_STATE		= 2~%# BRANCH_RIGHT_STATE	= 3~%# YIELDING_STATE		= 4~%# ACCELERATING_STATE	= 5~%# SLOWDOWN_STATE 		= 6~%~%uint32 behavior_state~%~%geometry_msgs/Point[] history_path~%geometry_msgs/Point[] predicted_poses~%geometry_msgs/Point[] predicted_variance~%~%PredictedPath[] predicted_paths~%geometry_msgs/Twist acceleration~%~%Ars40xClusters radarFusionPoints~%CameraObjectFrustum cameraObjectFrustum~%int32 overlapObjectsNumber~%geometry_msgs/PolygonStamped visibleSegments~%geometry_msgs/PolygonStamped image2Dcube~%bool isMoving~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: itri_msgs/Ars40xClusters~%Header header~%Ars40xCluster[] clusters~%================================================================================~%MSG: itri_msgs/Ars40xCluster~%uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: itri_msgs/CameraObjectFrustum~%geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedObject)))
  "Returns full string definition for message of type 'DetectedObject"
  (cl:format cl:nil "std_msgs/Header header~%~%uint32 id~%string label~%float32 score~%std_msgs/ColorRGBA color~%float64 trackedPeriod~%~%geometry_msgs/Pose pose~%geometry_msgs/Vector3 dimensions~%geometry_msgs/Vector3 variance~%geometry_msgs/Twist velocity~%geometry_msgs/Twist abs_velocity~%~%geometry_msgs/PolygonStamped convex_hull~%~%bool pose_reliable~%bool velocity_reliable~%~%sensor_msgs/PointCloud2 pointcloud~%~%string image_frame~%int32 x~%int32 y~%int32 width~%int32 height~%float32 angle~%~%string space_frame~%~%# Behavior State of the Detected Object~%# FORWARD_STATE			= 0~%# STOPPING_STATE 		= 1~%# BRANCH_LEFT_STATE		= 2~%# BRANCH_RIGHT_STATE	= 3~%# YIELDING_STATE		= 4~%# ACCELERATING_STATE	= 5~%# SLOWDOWN_STATE 		= 6~%~%uint32 behavior_state~%~%geometry_msgs/Point[] history_path~%geometry_msgs/Point[] predicted_poses~%geometry_msgs/Point[] predicted_variance~%~%PredictedPath[] predicted_paths~%geometry_msgs/Twist acceleration~%~%Ars40xClusters radarFusionPoints~%CameraObjectFrustum cameraObjectFrustum~%int32 overlapObjectsNumber~%geometry_msgs/PolygonStamped visibleSegments~%geometry_msgs/PolygonStamped image2Dcube~%bool isMoving~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: std_msgs/ColorRGBA~%float32 r~%float32 g~%float32 b~%float32 a~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/PolygonStamped~%# This represents a Polygon with reference coordinate frame and timestamp~%Header header~%Polygon polygon~%~%================================================================================~%MSG: geometry_msgs/Polygon~%#A specification of a polygon where the first and last points are assumed to be connected~%Point32[] points~%~%================================================================================~%MSG: geometry_msgs/Point32~%# This contains the position of a point in free space(with 32 bits of precision).~%# It is recommeded to use Point wherever possible instead of Point32.  ~%# ~%# This recommendation is to promote interoperability.  ~%#~%# This message is designed to take up less space when sending~%# lots of points at once, as in the case of a PointCloud.  ~%~%float32 x~%float32 y~%float32 z~%================================================================================~%MSG: sensor_msgs/PointCloud2~%# This message holds a collection of N-dimensional points, which may~%# contain additional information such as normals, intensity, etc. The~%# point data is stored as a binary blob, its layout described by the~%# contents of the \"fields\" array.~%~%# The point cloud data may be organized 2d (image-like) or 1d~%# (unordered). Point clouds organized as 2d images may be produced by~%# camera depth sensors such as stereo or time-of-flight.~%~%# Time of sensor data acquisition, and the coordinate frame ID (for 3d~%# points).~%Header header~%~%# 2D structure of the point cloud. If the cloud is unordered, height is~%# 1 and width is the length of the point cloud.~%uint32 height~%uint32 width~%~%# Describes the channels and their layout in the binary data blob.~%PointField[] fields~%~%bool    is_bigendian # Is this data bigendian?~%uint32  point_step   # Length of a point in bytes~%uint32  row_step     # Length of a row in bytes~%uint8[] data         # Actual point data, size is (row_step*height)~%~%bool is_dense        # True if there are no invalid points~%~%================================================================================~%MSG: sensor_msgs/PointField~%# This message holds the description of one point entry in the~%# PointCloud2 message format.~%uint8 INT8    = 1~%uint8 UINT8   = 2~%uint8 INT16   = 3~%uint8 UINT16  = 4~%uint8 INT32   = 5~%uint8 UINT32  = 6~%uint8 FLOAT32 = 7~%uint8 FLOAT64 = 8~%~%string name      # Name of field~%uint32 offset    # Offset from start of point struct~%uint8  datatype  # Datatype enumeration, see above~%uint32 count     # How many elements in the field~%~%================================================================================~%MSG: itri_msgs/PredictedPath~%float32 probability~%geometry_msgs/Point[] predicted_path~%geometry_msgs/Point[] predicted_velocity~%~%================================================================================~%MSG: itri_msgs/Ars40xClusters~%Header header~%Ars40xCluster[] clusters~%================================================================================~%MSG: itri_msgs/Ars40xCluster~%uint8 id~%~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%~%# dBm^2~%float32 radar_cross_section~%~%uint8 MOVING = 0~%uint8 STATIONARY = 1~%uint8 ONCOMING = 2~%uint8 STATIONARY_CANDIDATE = 3~%uint8 UNKNOWN = 4~%uint8 CROSSING_STATIONARY = 5~%uint8 CROSSING_MOVING = 6~%uint8 STOPPED = 7~%uint8 dynamic~%~%uint8 INVALID = 0~%uint8 AMBIGUOUS = 1~%uint8 STAGGERED_RAMP = 2~%uint8 UNAMBIGUOUS = 3~%uint8 STATIONARY_CANDIDATES = 4~%uint8 ambiguity~%~%uint8 VALID = 0~%uint8 INVALID_DUE_TO_LOW_RCS = 1~%uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2~%uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3~%uint8 VALID_WITH_LOW_RCS = 4~%uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6~%uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7~%uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8~%uint8 VALID_WITH_HIGH_CHILD_PROB = 9~%uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10~%uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11~%uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12~%uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14~%uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15~%uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16~%uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17~%uint8 validity~%~%# false alarm probability, percentage~%float32 probability~%~%bool is_near~%================================================================================~%MSG: itri_msgs/CameraObjectFrustum~%geometry_msgs/Point[] Points~%geometry_msgs/Quaternion[] FaceInsidePlanesNorm~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedObject>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4 (cl:length (cl:slot-value msg 'label))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'color))
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'dimensions))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'variance))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'abs_velocity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'convex_hull))
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pointcloud))
     4 (cl:length (cl:slot-value msg 'image_frame))
     4
     4
     4
     4
     4
     4 (cl:length (cl:slot-value msg 'space_frame))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'history_path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_poses) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_variance) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'predicted_paths) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'acceleration))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'radarFusionPoints))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cameraObjectFrustum))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'visibleSegments))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image2Dcube))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedObject>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedObject
    (cl:cons ':header (header msg))
    (cl:cons ':id (id msg))
    (cl:cons ':label (label msg))
    (cl:cons ':score (score msg))
    (cl:cons ':color (color msg))
    (cl:cons ':trackedPeriod (trackedPeriod msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':dimensions (dimensions msg))
    (cl:cons ':variance (variance msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':abs_velocity (abs_velocity msg))
    (cl:cons ':convex_hull (convex_hull msg))
    (cl:cons ':pose_reliable (pose_reliable msg))
    (cl:cons ':velocity_reliable (velocity_reliable msg))
    (cl:cons ':pointcloud (pointcloud msg))
    (cl:cons ':image_frame (image_frame msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':width (width msg))
    (cl:cons ':height (height msg))
    (cl:cons ':angle (angle msg))
    (cl:cons ':space_frame (space_frame msg))
    (cl:cons ':behavior_state (behavior_state msg))
    (cl:cons ':history_path (history_path msg))
    (cl:cons ':predicted_poses (predicted_poses msg))
    (cl:cons ':predicted_variance (predicted_variance msg))
    (cl:cons ':predicted_paths (predicted_paths msg))
    (cl:cons ':acceleration (acceleration msg))
    (cl:cons ':radarFusionPoints (radarFusionPoints msg))
    (cl:cons ':cameraObjectFrustum (cameraObjectFrustum msg))
    (cl:cons ':overlapObjectsNumber (overlapObjectsNumber msg))
    (cl:cons ':visibleSegments (visibleSegments msg))
    (cl:cons ':image2Dcube (image2Dcube msg))
    (cl:cons ':isMoving (isMoving msg))
))
