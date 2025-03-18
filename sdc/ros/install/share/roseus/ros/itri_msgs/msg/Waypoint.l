;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Waypoint)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Waypoint (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::WAYPOINT")
  (make-package "ITRI_MSGS::WAYPOINT"))

(in-package "ROS")
;;//! \htmlinclude Waypoint.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass itri_msgs::Waypoint
  :super ros::object
  :slots (_pose _twist _laneId _pointId _point _heading _curvature _speed_limit _point_id _lane_id _nroad_id _s _d _left_space _right_space _width _road_type ))

(defmethod itri_msgs::Waypoint
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::PoseStamped :init))
    ((:twist __twist) (instance geometry_msgs::TwistStamped :init))
    ((:laneId __laneId) 0)
    ((:pointId __pointId) 0)
    ((:point __point) (instance geometry_msgs::Point :init))
    ((:heading __heading) 0.0)
    ((:curvature __curvature) 0.0)
    ((:speed_limit __speed_limit) 0.0)
    ((:point_id __point_id) 0)
    ((:lane_id __lane_id) 0)
    ((:nroad_id __nroad_id) 0)
    ((:s __s) 0.0)
    ((:d __d) 0.0)
    ((:left_space __left_space) 0.0)
    ((:right_space __right_space) 0.0)
    ((:width __width) 0.0)
    ((:road_type __road_type) 0)
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _twist __twist)
   (setq _laneId (round __laneId))
   (setq _pointId (round __pointId))
   (setq _point __point)
   (setq _heading (float __heading))
   (setq _curvature (float __curvature))
   (setq _speed_limit (float __speed_limit))
   (setq _point_id (round __point_id))
   (setq _lane_id (round __lane_id))
   (setq _nroad_id (round __nroad_id))
   (setq _s (float __s))
   (setq _d (float __d))
   (setq _left_space (float __left_space))
   (setq _right_space (float __right_space))
   (setq _width (float __width))
   (setq _road_type (round __road_type))
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:twist
   (&rest __twist)
   (if (keywordp (car __twist))
       (send* _twist __twist)
     (progn
       (if __twist (setq _twist (car __twist)))
       _twist)))
  (:laneId
   (&optional __laneId)
   (if __laneId (setq _laneId __laneId)) _laneId)
  (:pointId
   (&optional __pointId)
   (if __pointId (setq _pointId __pointId)) _pointId)
  (:point
   (&rest __point)
   (if (keywordp (car __point))
       (send* _point __point)
     (progn
       (if __point (setq _point (car __point)))
       _point)))
  (:heading
   (&optional __heading)
   (if __heading (setq _heading __heading)) _heading)
  (:curvature
   (&optional __curvature)
   (if __curvature (setq _curvature __curvature)) _curvature)
  (:speed_limit
   (&optional __speed_limit)
   (if __speed_limit (setq _speed_limit __speed_limit)) _speed_limit)
  (:point_id
   (&optional __point_id)
   (if __point_id (setq _point_id __point_id)) _point_id)
  (:lane_id
   (&optional __lane_id)
   (if __lane_id (setq _lane_id __lane_id)) _lane_id)
  (:nroad_id
   (&optional __nroad_id)
   (if __nroad_id (setq _nroad_id __nroad_id)) _nroad_id)
  (:s
   (&optional __s)
   (if __s (setq _s __s)) _s)
  (:d
   (&optional __d)
   (if __d (setq _d __d)) _d)
  (:left_space
   (&optional __left_space)
   (if __left_space (setq _left_space __left_space)) _left_space)
  (:right_space
   (&optional __right_space)
   (if __right_space (setq _right_space __right_space)) _right_space)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:road_type
   (&optional __road_type)
   (if __road_type (setq _road_type __road_type)) _road_type)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/PoseStamped _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/TwistStamped _twist
    (send _twist :serialization-length)
    ;; int32 _laneId
    4
    ;; int32 _pointId
    4
    ;; geometry_msgs/Point _point
    (send _point :serialization-length)
    ;; float32 _heading
    4
    ;; float32 _curvature
    4
    ;; float32 _speed_limit
    4
    ;; int32 _point_id
    4
    ;; int32 _lane_id
    4
    ;; int32 _nroad_id
    4
    ;; float32 _s
    4
    ;; float32 _d
    4
    ;; float32 _left_space
    4
    ;; float32 _right_space
    4
    ;; float32 _width
    4
    ;; int32 _road_type
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/PoseStamped _pose
       (send _pose :serialize s)
     ;; geometry_msgs/TwistStamped _twist
       (send _twist :serialize s)
     ;; int32 _laneId
       (write-long _laneId s)
     ;; int32 _pointId
       (write-long _pointId s)
     ;; geometry_msgs/Point _point
       (send _point :serialize s)
     ;; float32 _heading
       (sys::poke _heading (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _curvature
       (sys::poke _curvature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speed_limit
       (sys::poke _speed_limit (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _point_id
       (write-long _point_id s)
     ;; int32 _lane_id
       (write-long _lane_id s)
     ;; int32 _nroad_id
       (write-long _nroad_id s)
     ;; float32 _s
       (sys::poke _s (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _d
       (sys::poke _d (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _left_space
       (sys::poke _left_space (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _right_space
       (sys::poke _right_space (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _road_type
       (write-long _road_type s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/PoseStamped _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/TwistStamped _twist
     (send _twist :deserialize buf ptr-) (incf ptr- (send _twist :serialization-length))
   ;; int32 _laneId
     (setq _laneId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pointId
     (setq _pointId (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _point
     (send _point :deserialize buf ptr-) (incf ptr- (send _point :serialization-length))
   ;; float32 _heading
     (setq _heading (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _curvature
     (setq _curvature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speed_limit
     (setq _speed_limit (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _point_id
     (setq _point_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lane_id
     (setq _lane_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _nroad_id
     (setq _nroad_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _s
     (setq _s (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _d
     (setq _d (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _left_space
     (setq _left_space (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _right_space
     (setq _right_space (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _road_type
     (setq _road_type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::Waypoint :md5sum-) "6a22ab0ae1bcbcabcacf956439f4fd96")
(setf (get itri_msgs::Waypoint :datatype-) "itri_msgs/Waypoint")
(setf (get itri_msgs::Waypoint :definition-)
      "geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
int32 laneId
int32 pointId
geometry_msgs/Point point
float32 heading
float32 curvature
float32 speed_limit
int32 point_id
int32 lane_id
int32 nroad_id
float32 s
float32 d
float32 left_space
float32 right_space
float32 width
int32 road_type

================================================================================
MSG: geometry_msgs/PoseStamped
# A Pose with reference coordinate frame and timestamp
Header header
Pose pose

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
MSG: geometry_msgs/TwistStamped
# A twist with reference coordinate frame and timestamp
Header header
Twist twist

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

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
")



(provide :itri_msgs/Waypoint "6a22ab0ae1bcbcabcacf956439f4fd96")


