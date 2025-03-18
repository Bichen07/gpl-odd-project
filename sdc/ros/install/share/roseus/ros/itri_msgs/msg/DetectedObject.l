;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::DetectedObject)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'DetectedObject (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::DETECTEDOBJECT")
  (make-package "ITRI_MSGS::DETECTEDOBJECT"))

(in-package "ROS")
;;//! \htmlinclude DetectedObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::DetectedObject
  :super ros::object
  :slots (_header _id _label _score _color _trackedPeriod _pose _dimensions _variance _velocity _abs_velocity _convex_hull _pose_reliable _velocity_reliable _pointcloud _image_frame _x _y _width _height _angle _space_frame _behavior_state _history_path _predicted_poses _predicted_variance _predicted_paths _acceleration _radarFusionPoints _cameraObjectFrustum _overlapObjectsNumber _visibleSegments _image2Dcube _isMoving ))

(defmethod itri_msgs::DetectedObject
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:id __id) 0)
    ((:label __label) "")
    ((:score __score) 0.0)
    ((:color __color) (instance std_msgs::ColorRGBA :init))
    ((:trackedPeriod __trackedPeriod) 0.0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:dimensions __dimensions) (instance geometry_msgs::Vector3 :init))
    ((:variance __variance) (instance geometry_msgs::Vector3 :init))
    ((:velocity __velocity) (instance geometry_msgs::Twist :init))
    ((:abs_velocity __abs_velocity) (instance geometry_msgs::Twist :init))
    ((:convex_hull __convex_hull) (instance geometry_msgs::PolygonStamped :init))
    ((:pose_reliable __pose_reliable) nil)
    ((:velocity_reliable __velocity_reliable) nil)
    ((:pointcloud __pointcloud) (instance sensor_msgs::PointCloud2 :init))
    ((:image_frame __image_frame) "")
    ((:x __x) 0)
    ((:y __y) 0)
    ((:width __width) 0)
    ((:height __height) 0)
    ((:angle __angle) 0.0)
    ((:space_frame __space_frame) "")
    ((:behavior_state __behavior_state) 0)
    ((:history_path __history_path) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:predicted_poses __predicted_poses) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:predicted_variance __predicted_variance) (let (r) (dotimes (i 0) (push (instance geometry_msgs::Point :init) r)) r))
    ((:predicted_paths __predicted_paths) (let (r) (dotimes (i 0) (push (instance itri_msgs::PredictedPath :init) r)) r))
    ((:acceleration __acceleration) (instance geometry_msgs::Twist :init))
    ((:radarFusionPoints __radarFusionPoints) (instance itri_msgs::Ars40xClusters :init))
    ((:cameraObjectFrustum __cameraObjectFrustum) (instance itri_msgs::CameraObjectFrustum :init))
    ((:overlapObjectsNumber __overlapObjectsNumber) 0)
    ((:visibleSegments __visibleSegments) (instance geometry_msgs::PolygonStamped :init))
    ((:image2Dcube __image2Dcube) (instance geometry_msgs::PolygonStamped :init))
    ((:isMoving __isMoving) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _id (round __id))
   (setq _label (string __label))
   (setq _score (float __score))
   (setq _color __color)
   (setq _trackedPeriod (float __trackedPeriod))
   (setq _pose __pose)
   (setq _dimensions __dimensions)
   (setq _variance __variance)
   (setq _velocity __velocity)
   (setq _abs_velocity __abs_velocity)
   (setq _convex_hull __convex_hull)
   (setq _pose_reliable __pose_reliable)
   (setq _velocity_reliable __velocity_reliable)
   (setq _pointcloud __pointcloud)
   (setq _image_frame (string __image_frame))
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _width (round __width))
   (setq _height (round __height))
   (setq _angle (float __angle))
   (setq _space_frame (string __space_frame))
   (setq _behavior_state (round __behavior_state))
   (setq _history_path __history_path)
   (setq _predicted_poses __predicted_poses)
   (setq _predicted_variance __predicted_variance)
   (setq _predicted_paths __predicted_paths)
   (setq _acceleration __acceleration)
   (setq _radarFusionPoints __radarFusionPoints)
   (setq _cameraObjectFrustum __cameraObjectFrustum)
   (setq _overlapObjectsNumber (round __overlapObjectsNumber))
   (setq _visibleSegments __visibleSegments)
   (setq _image2Dcube __image2Dcube)
   (setq _isMoving __isMoving)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:label
   (&optional __label)
   (if __label (setq _label __label)) _label)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:color
   (&rest __color)
   (if (keywordp (car __color))
       (send* _color __color)
     (progn
       (if __color (setq _color (car __color)))
       _color)))
  (:trackedPeriod
   (&optional __trackedPeriod)
   (if __trackedPeriod (setq _trackedPeriod __trackedPeriod)) _trackedPeriod)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:dimensions
   (&rest __dimensions)
   (if (keywordp (car __dimensions))
       (send* _dimensions __dimensions)
     (progn
       (if __dimensions (setq _dimensions (car __dimensions)))
       _dimensions)))
  (:variance
   (&rest __variance)
   (if (keywordp (car __variance))
       (send* _variance __variance)
     (progn
       (if __variance (setq _variance (car __variance)))
       _variance)))
  (:velocity
   (&rest __velocity)
   (if (keywordp (car __velocity))
       (send* _velocity __velocity)
     (progn
       (if __velocity (setq _velocity (car __velocity)))
       _velocity)))
  (:abs_velocity
   (&rest __abs_velocity)
   (if (keywordp (car __abs_velocity))
       (send* _abs_velocity __abs_velocity)
     (progn
       (if __abs_velocity (setq _abs_velocity (car __abs_velocity)))
       _abs_velocity)))
  (:convex_hull
   (&rest __convex_hull)
   (if (keywordp (car __convex_hull))
       (send* _convex_hull __convex_hull)
     (progn
       (if __convex_hull (setq _convex_hull (car __convex_hull)))
       _convex_hull)))
  (:pose_reliable
   (&optional __pose_reliable)
   (if __pose_reliable (setq _pose_reliable __pose_reliable)) _pose_reliable)
  (:velocity_reliable
   (&optional __velocity_reliable)
   (if __velocity_reliable (setq _velocity_reliable __velocity_reliable)) _velocity_reliable)
  (:pointcloud
   (&rest __pointcloud)
   (if (keywordp (car __pointcloud))
       (send* _pointcloud __pointcloud)
     (progn
       (if __pointcloud (setq _pointcloud (car __pointcloud)))
       _pointcloud)))
  (:image_frame
   (&optional __image_frame)
   (if __image_frame (setq _image_frame __image_frame)) _image_frame)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:angle
   (&optional __angle)
   (if __angle (setq _angle __angle)) _angle)
  (:space_frame
   (&optional __space_frame)
   (if __space_frame (setq _space_frame __space_frame)) _space_frame)
  (:behavior_state
   (&optional __behavior_state)
   (if __behavior_state (setq _behavior_state __behavior_state)) _behavior_state)
  (:history_path
   (&rest __history_path)
   (if (keywordp (car __history_path))
       (send* _history_path __history_path)
     (progn
       (if __history_path (setq _history_path (car __history_path)))
       _history_path)))
  (:predicted_poses
   (&rest __predicted_poses)
   (if (keywordp (car __predicted_poses))
       (send* _predicted_poses __predicted_poses)
     (progn
       (if __predicted_poses (setq _predicted_poses (car __predicted_poses)))
       _predicted_poses)))
  (:predicted_variance
   (&rest __predicted_variance)
   (if (keywordp (car __predicted_variance))
       (send* _predicted_variance __predicted_variance)
     (progn
       (if __predicted_variance (setq _predicted_variance (car __predicted_variance)))
       _predicted_variance)))
  (:predicted_paths
   (&rest __predicted_paths)
   (if (keywordp (car __predicted_paths))
       (send* _predicted_paths __predicted_paths)
     (progn
       (if __predicted_paths (setq _predicted_paths (car __predicted_paths)))
       _predicted_paths)))
  (:acceleration
   (&rest __acceleration)
   (if (keywordp (car __acceleration))
       (send* _acceleration __acceleration)
     (progn
       (if __acceleration (setq _acceleration (car __acceleration)))
       _acceleration)))
  (:radarFusionPoints
   (&rest __radarFusionPoints)
   (if (keywordp (car __radarFusionPoints))
       (send* _radarFusionPoints __radarFusionPoints)
     (progn
       (if __radarFusionPoints (setq _radarFusionPoints (car __radarFusionPoints)))
       _radarFusionPoints)))
  (:cameraObjectFrustum
   (&rest __cameraObjectFrustum)
   (if (keywordp (car __cameraObjectFrustum))
       (send* _cameraObjectFrustum __cameraObjectFrustum)
     (progn
       (if __cameraObjectFrustum (setq _cameraObjectFrustum (car __cameraObjectFrustum)))
       _cameraObjectFrustum)))
  (:overlapObjectsNumber
   (&optional __overlapObjectsNumber)
   (if __overlapObjectsNumber (setq _overlapObjectsNumber __overlapObjectsNumber)) _overlapObjectsNumber)
  (:visibleSegments
   (&rest __visibleSegments)
   (if (keywordp (car __visibleSegments))
       (send* _visibleSegments __visibleSegments)
     (progn
       (if __visibleSegments (setq _visibleSegments (car __visibleSegments)))
       _visibleSegments)))
  (:image2Dcube
   (&rest __image2Dcube)
   (if (keywordp (car __image2Dcube))
       (send* _image2Dcube __image2Dcube)
     (progn
       (if __image2Dcube (setq _image2Dcube (car __image2Dcube)))
       _image2Dcube)))
  (:isMoving
   (&optional __isMoving)
   (if __isMoving (setq _isMoving __isMoving)) _isMoving)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _id
    4
    ;; string _label
    4 (length _label)
    ;; float32 _score
    4
    ;; std_msgs/ColorRGBA _color
    (send _color :serialization-length)
    ;; float64 _trackedPeriod
    8
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/Vector3 _dimensions
    (send _dimensions :serialization-length)
    ;; geometry_msgs/Vector3 _variance
    (send _variance :serialization-length)
    ;; geometry_msgs/Twist _velocity
    (send _velocity :serialization-length)
    ;; geometry_msgs/Twist _abs_velocity
    (send _abs_velocity :serialization-length)
    ;; geometry_msgs/PolygonStamped _convex_hull
    (send _convex_hull :serialization-length)
    ;; bool _pose_reliable
    1
    ;; bool _velocity_reliable
    1
    ;; sensor_msgs/PointCloud2 _pointcloud
    (send _pointcloud :serialization-length)
    ;; string _image_frame
    4 (length _image_frame)
    ;; int32 _x
    4
    ;; int32 _y
    4
    ;; int32 _width
    4
    ;; int32 _height
    4
    ;; float32 _angle
    4
    ;; string _space_frame
    4 (length _space_frame)
    ;; uint32 _behavior_state
    4
    ;; geometry_msgs/Point[] _history_path
    (apply #'+ (send-all _history_path :serialization-length)) 4
    ;; geometry_msgs/Point[] _predicted_poses
    (apply #'+ (send-all _predicted_poses :serialization-length)) 4
    ;; geometry_msgs/Point[] _predicted_variance
    (apply #'+ (send-all _predicted_variance :serialization-length)) 4
    ;; itri_msgs/PredictedPath[] _predicted_paths
    (apply #'+ (send-all _predicted_paths :serialization-length)) 4
    ;; geometry_msgs/Twist _acceleration
    (send _acceleration :serialization-length)
    ;; itri_msgs/Ars40xClusters _radarFusionPoints
    (send _radarFusionPoints :serialization-length)
    ;; itri_msgs/CameraObjectFrustum _cameraObjectFrustum
    (send _cameraObjectFrustum :serialization-length)
    ;; int32 _overlapObjectsNumber
    4
    ;; geometry_msgs/PolygonStamped _visibleSegments
    (send _visibleSegments :serialization-length)
    ;; geometry_msgs/PolygonStamped _image2Dcube
    (send _image2Dcube :serialization-length)
    ;; bool _isMoving
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _id
       (write-long _id s)
     ;; string _label
       (write-long (length _label) s) (princ _label s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; std_msgs/ColorRGBA _color
       (send _color :serialize s)
     ;; float64 _trackedPeriod
       (sys::poke _trackedPeriod (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; geometry_msgs/Vector3 _dimensions
       (send _dimensions :serialize s)
     ;; geometry_msgs/Vector3 _variance
       (send _variance :serialize s)
     ;; geometry_msgs/Twist _velocity
       (send _velocity :serialize s)
     ;; geometry_msgs/Twist _abs_velocity
       (send _abs_velocity :serialize s)
     ;; geometry_msgs/PolygonStamped _convex_hull
       (send _convex_hull :serialize s)
     ;; bool _pose_reliable
       (if _pose_reliable (write-byte -1 s) (write-byte 0 s))
     ;; bool _velocity_reliable
       (if _velocity_reliable (write-byte -1 s) (write-byte 0 s))
     ;; sensor_msgs/PointCloud2 _pointcloud
       (send _pointcloud :serialize s)
     ;; string _image_frame
       (write-long (length _image_frame) s) (princ _image_frame s)
     ;; int32 _x
       (write-long _x s)
     ;; int32 _y
       (write-long _y s)
     ;; int32 _width
       (write-long _width s)
     ;; int32 _height
       (write-long _height s)
     ;; float32 _angle
       (sys::poke _angle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _space_frame
       (write-long (length _space_frame) s) (princ _space_frame s)
     ;; uint32 _behavior_state
       (write-long _behavior_state s)
     ;; geometry_msgs/Point[] _history_path
     (write-long (length _history_path) s)
     (dolist (elem _history_path)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _predicted_poses
     (write-long (length _predicted_poses) s)
     (dolist (elem _predicted_poses)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _predicted_variance
     (write-long (length _predicted_variance) s)
     (dolist (elem _predicted_variance)
       (send elem :serialize s)
       )
     ;; itri_msgs/PredictedPath[] _predicted_paths
     (write-long (length _predicted_paths) s)
     (dolist (elem _predicted_paths)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Twist _acceleration
       (send _acceleration :serialize s)
     ;; itri_msgs/Ars40xClusters _radarFusionPoints
       (send _radarFusionPoints :serialize s)
     ;; itri_msgs/CameraObjectFrustum _cameraObjectFrustum
       (send _cameraObjectFrustum :serialize s)
     ;; int32 _overlapObjectsNumber
       (write-long _overlapObjectsNumber s)
     ;; geometry_msgs/PolygonStamped _visibleSegments
       (send _visibleSegments :serialize s)
     ;; geometry_msgs/PolygonStamped _image2Dcube
       (send _image2Dcube :serialize s)
     ;; bool _isMoving
       (if _isMoving (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _label
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _label (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; std_msgs/ColorRGBA _color
     (send _color :deserialize buf ptr-) (incf ptr- (send _color :serialization-length))
   ;; float64 _trackedPeriod
     (setq _trackedPeriod (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/Vector3 _dimensions
     (send _dimensions :deserialize buf ptr-) (incf ptr- (send _dimensions :serialization-length))
   ;; geometry_msgs/Vector3 _variance
     (send _variance :deserialize buf ptr-) (incf ptr- (send _variance :serialization-length))
   ;; geometry_msgs/Twist _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; geometry_msgs/Twist _abs_velocity
     (send _abs_velocity :deserialize buf ptr-) (incf ptr- (send _abs_velocity :serialization-length))
   ;; geometry_msgs/PolygonStamped _convex_hull
     (send _convex_hull :deserialize buf ptr-) (incf ptr- (send _convex_hull :serialization-length))
   ;; bool _pose_reliable
     (setq _pose_reliable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _velocity_reliable
     (setq _velocity_reliable (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; sensor_msgs/PointCloud2 _pointcloud
     (send _pointcloud :deserialize buf ptr-) (incf ptr- (send _pointcloud :serialization-length))
   ;; string _image_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _image_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _x
     (setq _x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y
     (setq _y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _angle
     (setq _angle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _space_frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _space_frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint32 _behavior_state
     (setq _behavior_state (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _history_path
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _history_path (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _history_path)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _predicted_poses
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_poses (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _predicted_poses)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _predicted_variance
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_variance (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _predicted_variance)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; itri_msgs/PredictedPath[] _predicted_paths
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_paths (let (r) (dotimes (i n) (push (instance itri_msgs::PredictedPath :init) r)) r))
     (dolist (elem- _predicted_paths)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Twist _acceleration
     (send _acceleration :deserialize buf ptr-) (incf ptr- (send _acceleration :serialization-length))
   ;; itri_msgs/Ars40xClusters _radarFusionPoints
     (send _radarFusionPoints :deserialize buf ptr-) (incf ptr- (send _radarFusionPoints :serialization-length))
   ;; itri_msgs/CameraObjectFrustum _cameraObjectFrustum
     (send _cameraObjectFrustum :deserialize buf ptr-) (incf ptr- (send _cameraObjectFrustum :serialization-length))
   ;; int32 _overlapObjectsNumber
     (setq _overlapObjectsNumber (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/PolygonStamped _visibleSegments
     (send _visibleSegments :deserialize buf ptr-) (incf ptr- (send _visibleSegments :serialization-length))
   ;; geometry_msgs/PolygonStamped _image2Dcube
     (send _image2Dcube :deserialize buf ptr-) (incf ptr- (send _image2Dcube :serialization-length))
   ;; bool _isMoving
     (setq _isMoving (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::DetectedObject :md5sum-) "10228fe6703d131d34e20f1a96859644")
(setf (get itri_msgs::DetectedObject :datatype-) "itri_msgs/DetectedObject")
(setf (get itri_msgs::DetectedObject :definition-)
      "std_msgs/Header header

uint32 id
string label
float32 score
std_msgs/ColorRGBA color
float64 trackedPeriod

geometry_msgs/Pose pose
geometry_msgs/Vector3 dimensions
geometry_msgs/Vector3 variance
geometry_msgs/Twist velocity
geometry_msgs/Twist abs_velocity

geometry_msgs/PolygonStamped convex_hull

bool pose_reliable
bool velocity_reliable

sensor_msgs/PointCloud2 pointcloud

string image_frame
int32 x
int32 y
int32 width
int32 height
float32 angle

string space_frame

# Behavior State of the Detected Object
# FORWARD_STATE			= 0
# STOPPING_STATE 		= 1
# BRANCH_LEFT_STATE		= 2
# BRANCH_RIGHT_STATE	= 3
# YIELDING_STATE		= 4
# ACCELERATING_STATE	= 5
# SLOWDOWN_STATE 		= 6

uint32 behavior_state

geometry_msgs/Point[] history_path
geometry_msgs/Point[] predicted_poses
geometry_msgs/Point[] predicted_variance

PredictedPath[] predicted_paths
geometry_msgs/Twist acceleration

Ars40xClusters radarFusionPoints
CameraObjectFrustum cameraObjectFrustum
int32 overlapObjectsNumber
geometry_msgs/PolygonStamped visibleSegments
geometry_msgs/PolygonStamped image2Dcube
bool isMoving

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: std_msgs/ColorRGBA
float32 r
float32 g
float32 b
float32 a

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

================================================================================
MSG: geometry_msgs/PolygonStamped
# This represents a Polygon with reference coordinate frame and timestamp
Header header
Polygon polygon

================================================================================
MSG: geometry_msgs/Polygon
#A specification of a polygon where the first and last points are assumed to be connected
Point32[] points

================================================================================
MSG: geometry_msgs/Point32
# This contains the position of a point in free space(with 32 bits of precision).
# It is recommeded to use Point wherever possible instead of Point32.  
# 
# This recommendation is to promote interoperability.  
#
# This message is designed to take up less space when sending
# lots of points at once, as in the case of a PointCloud.  

float32 x
float32 y
float32 z
================================================================================
MSG: sensor_msgs/PointCloud2
# This message holds a collection of N-dimensional points, which may
# contain additional information such as normals, intensity, etc. The
# point data is stored as a binary blob, its layout described by the
# contents of the \"fields\" array.

# The point cloud data may be organized 2d (image-like) or 1d
# (unordered). Point clouds organized as 2d images may be produced by
# camera depth sensors such as stereo or time-of-flight.

# Time of sensor data acquisition, and the coordinate frame ID (for 3d
# points).
Header header

# 2D structure of the point cloud. If the cloud is unordered, height is
# 1 and width is the length of the point cloud.
uint32 height
uint32 width

# Describes the channels and their layout in the binary data blob.
PointField[] fields

bool    is_bigendian # Is this data bigendian?
uint32  point_step   # Length of a point in bytes
uint32  row_step     # Length of a row in bytes
uint8[] data         # Actual point data, size is (row_step*height)

bool is_dense        # True if there are no invalid points

================================================================================
MSG: sensor_msgs/PointField
# This message holds the description of one point entry in the
# PointCloud2 message format.
uint8 INT8    = 1
uint8 UINT8   = 2
uint8 INT16   = 3
uint8 UINT16  = 4
uint8 INT32   = 5
uint8 UINT32  = 6
uint8 FLOAT32 = 7
uint8 FLOAT64 = 8

string name      # Name of field
uint32 offset    # Offset from start of point struct
uint8  datatype  # Datatype enumeration, see above
uint32 count     # How many elements in the field

================================================================================
MSG: itri_msgs/PredictedPath
float32 probability
geometry_msgs/Point[] predicted_path
geometry_msgs/Point[] predicted_velocity

================================================================================
MSG: itri_msgs/Ars40xClusters
Header header
Ars40xCluster[] clusters
================================================================================
MSG: itri_msgs/Ars40xCluster
uint8 id

geometry_msgs/Pose pose
geometry_msgs/Twist velocity

# dBm^2
float32 radar_cross_section

uint8 MOVING = 0
uint8 STATIONARY = 1
uint8 ONCOMING = 2
uint8 STATIONARY_CANDIDATE = 3
uint8 UNKNOWN = 4
uint8 CROSSING_STATIONARY = 5
uint8 CROSSING_MOVING = 6
uint8 STOPPED = 7
uint8 dynamic

uint8 INVALID = 0
uint8 AMBIGUOUS = 1
uint8 STAGGERED_RAMP = 2
uint8 UNAMBIGUOUS = 3
uint8 STATIONARY_CANDIDATES = 4
uint8 ambiguity

uint8 VALID = 0
uint8 INVALID_DUE_TO_LOW_RCS = 1
uint8 INVALID_DUE_TO_NEAR_FIELD_ARTEFACT = 2
uint8 INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE = 3
uint8 VALID_WITH_LOW_RCS = 4
uint8 INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY = 6
uint8 INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW = 7
uint8 VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION = 8
uint8 VALID_WITH_HIGH_CHILD_PROB = 9
uint8 VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT = 10
uint8 VALID_BUT_NO_LOCAL_MAXIMUM = 11
uint8 VALID_WITH_HIGH_ARTEFACT_PROB = 12
uint8 INVALID_BECAUSE_IT_IS_HARMONIC = 14
uint8 VALID_ABOVE_95M_IN_NEAR_RANGE = 15
uint8 VALID_WITH_HIGH_MULTI_TARGET_PROB = 16
uint8 VALID_WITH_SUSPICIOUS_ANGLE = 17
uint8 validity

# false alarm probability, percentage
float32 probability

bool is_near
================================================================================
MSG: itri_msgs/CameraObjectFrustum
geometry_msgs/Point[] Points
geometry_msgs/Quaternion[] FaceInsidePlanesNorm
")



(provide :itri_msgs/DetectedObject "10228fe6703d131d34e20f1a96859644")


