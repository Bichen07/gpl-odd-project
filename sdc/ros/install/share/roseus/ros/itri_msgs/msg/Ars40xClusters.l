;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Ars40xClusters)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Ars40xClusters (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ARS40XCLUSTERS")
  (make-package "ITRI_MSGS::ARS40XCLUSTERS"))

(in-package "ROS")
;;//! \htmlinclude Ars40xClusters.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::Ars40xClusters
  :super ros::object
  :slots (_header _clusters ))

(defmethod itri_msgs::Ars40xClusters
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:clusters __clusters) (let (r) (dotimes (i 0) (push (instance itri_msgs::Ars40xCluster :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _clusters __clusters)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:clusters
   (&rest __clusters)
   (if (keywordp (car __clusters))
       (send* _clusters __clusters)
     (progn
       (if __clusters (setq _clusters (car __clusters)))
       _clusters)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; itri_msgs/Ars40xCluster[] _clusters
    (apply #'+ (send-all _clusters :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; itri_msgs/Ars40xCluster[] _clusters
     (write-long (length _clusters) s)
     (dolist (elem _clusters)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; itri_msgs/Ars40xCluster[] _clusters
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _clusters (let (r) (dotimes (i n) (push (instance itri_msgs::Ars40xCluster :init) r)) r))
     (dolist (elem- _clusters)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get itri_msgs::Ars40xClusters :md5sum-) "9e30dcb8c03a99114825665a399d4d4b")
(setf (get itri_msgs::Ars40xClusters :datatype-) "itri_msgs/Ars40xClusters")
(setf (get itri_msgs::Ars40xClusters :definition-)
      "Header header
Ars40xCluster[] clusters
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



(provide :itri_msgs/Ars40xClusters "9e30dcb8c03a99114825665a399d4d4b")


