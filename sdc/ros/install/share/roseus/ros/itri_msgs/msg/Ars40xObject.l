;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::Ars40xObject)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'Ars40xObject (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ARS40XOBJECT")
  (make-package "ITRI_MSGS::ARS40XOBJECT"))

(in-package "ROS")
;;//! \htmlinclude Ars40xObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(intern "*POINT*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*POINT* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*POINT* 0)
(intern "*CAR*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*CAR* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*CAR* 1)
(intern "*TRUCK*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*TRUCK* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*TRUCK* 2)
(intern "*MOTORCYCLE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*MOTORCYCLE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*MOTORCYCLE* 4)
(intern "*BICYCLE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*BICYCLE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*BICYCLE* 5)
(intern "*WIDE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*WIDE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*WIDE* 6)
(intern "*MOVING*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*MOVING* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*MOVING* 0)
(intern "*STATIONARY*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*STATIONARY* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*STATIONARY* 1)
(intern "*ONCOMING*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*ONCOMING* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*ONCOMING* 2)
(intern "*STATIONARY_CANDIDATE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*STATIONARY_CANDIDATE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*STATIONARY_CANDIDATE* 3)
(intern "*UNKNOWN*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*UNKNOWN* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*UNKNOWN* 4)
(intern "*CROSSING_STATIONARY*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*CROSSING_STATIONARY* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*CROSSING_STATIONARY* 5)
(intern "*CROSSING_MOVING*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*CROSSING_MOVING* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*CROSSING_MOVING* 6)
(intern "*STOPPED*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*STOPPED* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*STOPPED* 7)
(intern "*DELETED*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*DELETED* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*DELETED* 0)
(intern "*NEW_CREATED*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*NEW_CREATED* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*NEW_CREATED* 1)
(intern "*MEASURED*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*MEASURED* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*MEASURED* 2)
(intern "*PREDICTED*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*PREDICTED* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*PREDICTED* 3)
(intern "*DELETED_FOR_MERGE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*DELETED_FOR_MERGE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*DELETED_FOR_MERGE* 4)
(intern "*NEW_FROM_MERGE*" (find-package "ITRI_MSGS::ARS40XOBJECT"))
(shadow '*NEW_FROM_MERGE* (find-package "ITRI_MSGS::ARS40XOBJECT"))
(defconstant itri_msgs::Ars40xObject::*NEW_FROM_MERGE* 5)
(defclass itri_msgs::Ars40xObject
  :super ros::object
  :slots (_id _width _length _pose _velocity _acceleration _radar_cross_section _Class _dynamic _measurment _probability ))

(defmethod itri_msgs::Ars40xObject
  (:init
   (&key
    ((:id __id) 0)
    ((:width __width) 0.0)
    ((:length __length) 0.0)
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:velocity __velocity) (instance geometry_msgs::Twist :init))
    ((:acceleration __acceleration) (instance geometry_msgs::Accel :init))
    ((:radar_cross_section __radar_cross_section) 0.0)
    ((:Class __Class) 0)
    ((:dynamic __dynamic) 0)
    ((:measurment __measurment) 0)
    ((:probability __probability) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _width (float __width))
   (setq _length (float __length))
   (setq _pose __pose)
   (setq _velocity __velocity)
   (setq _acceleration __acceleration)
   (setq _radar_cross_section (float __radar_cross_section))
   (setq _Class (round __Class))
   (setq _dynamic (round __dynamic))
   (setq _measurment (round __measurment))
   (setq _probability (float __probability))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:length
   (&optional __length)
   (if __length (setq _length __length)) _length)
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
  (:acceleration
   (&rest __acceleration)
   (if (keywordp (car __acceleration))
       (send* _acceleration __acceleration)
     (progn
       (if __acceleration (setq _acceleration (car __acceleration)))
       _acceleration)))
  (:radar_cross_section
   (&optional __radar_cross_section)
   (if __radar_cross_section (setq _radar_cross_section __radar_cross_section)) _radar_cross_section)
  (:Class
   (&optional __Class)
   (if __Class (setq _Class __Class)) _Class)
  (:dynamic
   (&optional __dynamic)
   (if __dynamic (setq _dynamic __dynamic)) _dynamic)
  (:measurment
   (&optional __measurment)
   (if __measurment (setq _measurment __measurment)) _measurment)
  (:probability
   (&optional __probability)
   (if __probability (setq _probability __probability)) _probability)
  (:serialization-length
   ()
   (+
    ;; uint8 _id
    1
    ;; float32 _width
    4
    ;; float32 _length
    4
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/Twist _velocity
    (send _velocity :serialization-length)
    ;; geometry_msgs/Accel _acceleration
    (send _acceleration :serialization-length)
    ;; float32 _radar_cross_section
    4
    ;; uint8 _Class
    1
    ;; uint8 _dynamic
    1
    ;; uint8 _measurment
    1
    ;; float32 _probability
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _id
       (write-byte _id s)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _length
       (sys::poke _length (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; geometry_msgs/Twist _velocity
       (send _velocity :serialize s)
     ;; geometry_msgs/Accel _acceleration
       (send _acceleration :serialize s)
     ;; float32 _radar_cross_section
       (sys::poke _radar_cross_section (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint8 _Class
       (write-byte _Class s)
     ;; uint8 _dynamic
       (write-byte _dynamic s)
     ;; uint8 _measurment
       (write-byte _measurment s)
     ;; float32 _probability
       (sys::poke _probability (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _id
     (setq _id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _length
     (setq _length (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/Twist _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; geometry_msgs/Accel _acceleration
     (send _acceleration :deserialize buf ptr-) (incf ptr- (send _acceleration :serialization-length))
   ;; float32 _radar_cross_section
     (setq _radar_cross_section (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint8 _Class
     (setq _Class (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _dynamic
     (setq _dynamic (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _measurment
     (setq _measurment (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _probability
     (setq _probability (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::Ars40xObject :md5sum-) "0f77a1c96789bbc33d08f7bf24542202")
(setf (get itri_msgs::Ars40xObject :datatype-) "itri_msgs/Ars40xObject")
(setf (get itri_msgs::Ars40xObject :definition-)
      "# while persists in consecutive messages - it is the same object, if disappears and appears again - new one
uint8 id

float32 width
float32 length

geometry_msgs/Pose pose
geometry_msgs/Twist velocity
geometry_msgs/Accel acceleration

# dBm^2
float32 radar_cross_section

uint8 POINT = 0
uint8 CAR = 1
uint8 TRUCK = 2
uint8 MOTORCYCLE = 4
uint8 BICYCLE = 5
uint8 WIDE = 6
uint8 Class

uint8 MOVING = 0
uint8 STATIONARY = 1
uint8 ONCOMING = 2
uint8 STATIONARY_CANDIDATE = 3
uint8 UNKNOWN = 4
uint8 CROSSING_STATIONARY = 5
uint8 CROSSING_MOVING = 6
uint8 STOPPED = 7
uint8 dynamic

uint8 DELETED = 0
uint8 NEW_CREATED = 1
uint8 MEASURED = 2
uint8 PREDICTED = 3
uint8 DELETED_FOR_MERGE = 4
uint8 NEW_FROM_MERGE = 5
uint8 measurment

# probability of existence, percentage
float32 probability
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
================================================================================
MSG: geometry_msgs/Accel
# This expresses acceleration in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

")



(provide :itri_msgs/Ars40xObject "0f77a1c96789bbc33d08f7bf24542202")


