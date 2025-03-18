;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::PredictedPathArray)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'PredictedPathArray (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::PREDICTEDPATHARRAY")
  (make-package "ITRI_MSGS::PREDICTEDPATHARRAY"))

(in-package "ROS")
;;//! \htmlinclude PredictedPathArray.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::PredictedPathArray
  :super ros::object
  :slots (_header _object_id _predicted_paths _pose _convex_hull ))

(defmethod itri_msgs::PredictedPathArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:object_id __object_id) 0)
    ((:predicted_paths __predicted_paths) (let (r) (dotimes (i 0) (push (instance itri_msgs::PredictedPath :init) r)) r))
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:convex_hull __convex_hull) (instance geometry_msgs::PolygonStamped :init))
    )
   (send-super :init)
   (setq _header __header)
   (setq _object_id (round __object_id))
   (setq _predicted_paths __predicted_paths)
   (setq _pose __pose)
   (setq _convex_hull __convex_hull)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:predicted_paths
   (&rest __predicted_paths)
   (if (keywordp (car __predicted_paths))
       (send* _predicted_paths __predicted_paths)
     (progn
       (if __predicted_paths (setq _predicted_paths (car __predicted_paths)))
       _predicted_paths)))
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:convex_hull
   (&rest __convex_hull)
   (if (keywordp (car __convex_hull))
       (send* _convex_hull __convex_hull)
     (progn
       (if __convex_hull (setq _convex_hull (car __convex_hull)))
       _convex_hull)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint32 _object_id
    4
    ;; itri_msgs/PredictedPath[] _predicted_paths
    (apply #'+ (send-all _predicted_paths :serialization-length)) 4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/PolygonStamped _convex_hull
    (send _convex_hull :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint32 _object_id
       (write-long _object_id s)
     ;; itri_msgs/PredictedPath[] _predicted_paths
     (write-long (length _predicted_paths) s)
     (dolist (elem _predicted_paths)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; geometry_msgs/PolygonStamped _convex_hull
       (send _convex_hull :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint32 _object_id
     (setq _object_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; itri_msgs/PredictedPath[] _predicted_paths
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _predicted_paths (let (r) (dotimes (i n) (push (instance itri_msgs::PredictedPath :init) r)) r))
     (dolist (elem- _predicted_paths)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/PolygonStamped _convex_hull
     (send _convex_hull :deserialize buf ptr-) (incf ptr- (send _convex_hull :serialization-length))
   ;;
   self)
  )

(setf (get itri_msgs::PredictedPathArray :md5sum-) "9088baf61351d7ac6f023061071921dd")
(setf (get itri_msgs::PredictedPathArray :datatype-) "itri_msgs/PredictedPathArray")
(setf (get itri_msgs::PredictedPathArray :definition-)
      "std_msgs/Header header

uint32 object_id
PredictedPath[] predicted_paths
geometry_msgs/Pose pose
geometry_msgs/PolygonStamped convex_hull

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
MSG: itri_msgs/PredictedPath
float32 probability
geometry_msgs/Point[] predicted_path
geometry_msgs/Point[] predicted_velocity

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

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
")



(provide :itri_msgs/PredictedPathArray "9088baf61351d7ac6f023061071921dd")


