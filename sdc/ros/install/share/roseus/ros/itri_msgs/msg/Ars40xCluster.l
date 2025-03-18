;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Ars40xCluster)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Ars40xCluster (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ARS40XCLUSTER")
  (make-package "ITRI_MSGS::ARS40XCLUSTER"))

(in-package "ROS")
;;//! \htmlinclude Ars40xCluster.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*MOVING*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*MOVING* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*MOVING* 0)
(intern "*STATIONARY*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*STATIONARY* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*STATIONARY* 1)
(intern "*ONCOMING*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*ONCOMING* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*ONCOMING* 2)
(intern "*STATIONARY_CANDIDATE*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*STATIONARY_CANDIDATE* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*STATIONARY_CANDIDATE* 3)
(intern "*UNKNOWN*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*UNKNOWN* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*UNKNOWN* 4)
(intern "*CROSSING_STATIONARY*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*CROSSING_STATIONARY* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*CROSSING_STATIONARY* 5)
(intern "*CROSSING_MOVING*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*CROSSING_MOVING* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*CROSSING_MOVING* 6)
(intern "*STOPPED*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*STOPPED* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*STOPPED* 7)
(intern "*INVALID*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID* 0)
(intern "*AMBIGUOUS*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*AMBIGUOUS* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*AMBIGUOUS* 1)
(intern "*STAGGERED_RAMP*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*STAGGERED_RAMP* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*STAGGERED_RAMP* 2)
(intern "*UNAMBIGUOUS*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*UNAMBIGUOUS* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*UNAMBIGUOUS* 3)
(intern "*STATIONARY_CANDIDATES*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*STATIONARY_CANDIDATES* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*STATIONARY_CANDIDATES* 4)
(intern "*VALID*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID* 0)
(intern "*INVALID_DUE_TO_LOW_RCS*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_DUE_TO_LOW_RCS* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_DUE_TO_LOW_RCS* 1)
(intern "*INVALID_DUE_TO_NEAR_FIELD_ARTEFACT*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_DUE_TO_NEAR_FIELD_ARTEFACT* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_DUE_TO_NEAR_FIELD_ARTEFACT* 2)
(intern "*INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_IN_FAR_RANGE_BECAUSE_NOT_CONFIRMED_IN_NEAR_RANGE* 3)
(intern "*VALID_WITH_LOW_RCS*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_LOW_RCS* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_LOW_RCS* 4)
(intern "*INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_DUE_TO_HIGH_MIRROR_PROBABILITY* 6)
(intern "*INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_BECAUSE_OUTSIDE_FIELD_OF_VIEW* 7)
(intern "*VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_AZIMUTH_CORRECTION_DUE_TO_ELEVATION* 8)
(intern "*VALID_WITH_HIGH_CHILD_PROB*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_HIGH_CHILD_PROB* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_HIGH_CHILD_PROB* 9)
(intern "*VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_HIGH_PROB_OF_BEING_A_50DEG_ARTEFACT* 10)
(intern "*VALID_BUT_NO_LOCAL_MAXIMUM*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_BUT_NO_LOCAL_MAXIMUM* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_BUT_NO_LOCAL_MAXIMUM* 11)
(intern "*VALID_WITH_HIGH_ARTEFACT_PROB*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_HIGH_ARTEFACT_PROB* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_HIGH_ARTEFACT_PROB* 12)
(intern "*INVALID_BECAUSE_IT_IS_HARMONIC*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*INVALID_BECAUSE_IT_IS_HARMONIC* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*INVALID_BECAUSE_IT_IS_HARMONIC* 14)
(intern "*VALID_ABOVE_95M_IN_NEAR_RANGE*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_ABOVE_95M_IN_NEAR_RANGE* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_ABOVE_95M_IN_NEAR_RANGE* 15)
(intern "*VALID_WITH_HIGH_MULTI_TARGET_PROB*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_HIGH_MULTI_TARGET_PROB* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_HIGH_MULTI_TARGET_PROB* 16)
(intern "*VALID_WITH_SUSPICIOUS_ANGLE*" (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(shadow '*VALID_WITH_SUSPICIOUS_ANGLE* (find-package "ITRI_MSGS::ARS40XCLUSTER"))
(defconstant itri_msgs::Ars40xCluster::*VALID_WITH_SUSPICIOUS_ANGLE* 17)
(defclass itri_msgs::Ars40xCluster
  :super ros::object
  :slots (_id _pose _velocity _radar_cross_section _dynamic _ambiguity _validity _probability _is_near ))

(defmethod itri_msgs::Ars40xCluster
  (:init
   (&key
    ((:id __id) 0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:velocity __velocity) (instance geometry_msgs::Twist :init))
    ((:radar_cross_section __radar_cross_section) 0.0)
    ((:dynamic __dynamic) 0)
    ((:ambiguity __ambiguity) 0)
    ((:validity __validity) 0)
    ((:probability __probability) 0.0)
    ((:is_near __is_near) nil)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _pose __pose)
   (setq _velocity __velocity)
   (setq _radar_cross_section (float __radar_cross_section))
   (setq _dynamic (round __dynamic))
   (setq _ambiguity (round __ambiguity))
   (setq _validity (round __validity))
   (setq _probability (float __probability))
   (setq _is_near __is_near)
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:velocity
   (&rest __velocity)
   (if (keywordp (car __velocity))
       (send* _velocity __velocity)
     (progn
       (if __velocity (setq _velocity (car __velocity)))
       _velocity)))
  (:radar_cross_section
   (&optional __radar_cross_section)
   (if __radar_cross_section (setq _radar_cross_section __radar_cross_section)) _radar_cross_section)
  (:dynamic
   (&optional __dynamic)
   (if __dynamic (setq _dynamic __dynamic)) _dynamic)
  (:ambiguity
   (&optional __ambiguity)
   (if __ambiguity (setq _ambiguity __ambiguity)) _ambiguity)
  (:validity
   (&optional __validity)
   (if __validity (setq _validity __validity)) _validity)
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:is_near
   (&optional __is_near)
   (if __is_near (setq _is_near __is_near)) _is_near)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/Twist _velocity
    (send _velocity :serialization-length)
    ;; float32 _radar_cross_section
    4
    ;; uint8 _dynamic
    1
    ;; uint8 _ambiguity
    1
    ;; uint8 _validity
    1
    ;; float32 _probability
    4
    ;; bool _is_near
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; geometry_msgs/Twist _velocity
       (send _velocity :serialize s)
     ;; float32 _radar_cross_section
       (sys::poke _radar_cross_section (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _dynamic
       (write-byte _dynamic s)
     ;; uint8 _ambiguity
       (write-byte _ambiguity s)
     ;; uint8 _validity
       (write-byte _validity s)
     ;; float32 _probability
       (sys::poke _probability (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _is_near
       (if _is_near (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/Twist _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; float32 _radar_cross_section
     (setq _radar_cross_section (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _dynamic
     (setq _dynamic (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _ambiguity
     (setq _ambiguity (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _validity
     (setq _validity (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _probability
     (setq _probability (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _is_near
     (setq _is_near (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get itri_msgs::Ars40xCluster :md5sum-) "04db439c9c17d17c68474bb1a9a0c1c8")
(setf (get itri_msgs::Ars40xCluster :datatype-) "itri_msgs/Ars40xCluster")
(setf (get itri_msgs::Ars40xCluster :definition-)
      "uint8 id

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



(provide :itri_msgs/Ars40xCluster "04db439c9c17d17c68474bb1a9a0c1c8")


