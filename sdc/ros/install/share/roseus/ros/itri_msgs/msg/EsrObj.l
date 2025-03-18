;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::EsrObj)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'EsrObj (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::ESROBJ")
  (make-package "ITRI_MSGS::ESROBJ"))

(in-package "ROS")
;;//! \htmlinclude EsrObj.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass itri_msgs::EsrObj
  :super ros::object
  :slots (_trackId _status _medRangeMode _pose _twist _oncoming _isBridge _groupingChanged _width _rangeAccel ))

(defmethod itri_msgs::EsrObj
  (:init
   (&key
    ((:trackId __trackId) 0)
    ((:status __status) 0)
    ((:medRangeMode __medRangeMode) 0)
    ((:pose __pose) (instance geometry_msgs::PoseStamped :init))
    ((:twist __twist) (instance geometry_msgs::TwistStamped :init))
    ((:oncoming __oncoming) nil)
    ((:isBridge __isBridge) nil)
    ((:groupingChanged __groupingChanged) nil)
    ((:width __width) 0.0)
    ((:rangeAccel __rangeAccel) 0.0)
    )
   (send-super :init)
   (setq _trackId (round __trackId))
   (setq _status (round __status))
   (setq _medRangeMode (round __medRangeMode))
   (setq _pose __pose)
   (setq _twist __twist)
   (setq _oncoming __oncoming)
   (setq _isBridge __isBridge)
   (setq _groupingChanged __groupingChanged)
   (setq _width (float __width))
   (setq _rangeAccel (float __rangeAccel))
   self)
  (:trackId
   (&optional __trackId)
   (if __trackId (setq _trackId __trackId)) _trackId)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:medRangeMode
   (&optional __medRangeMode)
   (if __medRangeMode (setq _medRangeMode __medRangeMode)) _medRangeMode)
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
  (:oncoming
   (&optional __oncoming)
   (if __oncoming (setq _oncoming __oncoming)) _oncoming)
  (:isBridge
   (&optional __isBridge)
   (if __isBridge (setq _isBridge __isBridge)) _isBridge)
  (:groupingChanged
   (&optional __groupingChanged)
   (if __groupingChanged (setq _groupingChanged __groupingChanged)) _groupingChanged)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:rangeAccel
   (&optional __rangeAccel)
   (if __rangeAccel (setq _rangeAccel __rangeAccel)) _rangeAccel)
  (:serialization-length
   ()
   (+
    ;; uint8 _trackId
    1
    ;; uint8 _status
    1
    ;; uint8 _medRangeMode
    1
    ;; geometry_msgs/PoseStamped _pose
    (send _pose :serialization-length)
    ;; geometry_msgs/TwistStamped _twist
    (send _twist :serialization-length)
    ;; bool _oncoming
    1
    ;; bool _isBridge
    1
    ;; bool _groupingChanged
    1
    ;; float32 _width
    4
    ;; float32 _rangeAccel
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _trackId
       (write-byte _trackId s)
     ;; uint8 _status
       (write-byte _status s)
     ;; uint8 _medRangeMode
       (write-byte _medRangeMode s)
     ;; geometry_msgs/PoseStamped _pose
       (send _pose :serialize s)
     ;; geometry_msgs/TwistStamped _twist
       (send _twist :serialize s)
     ;; bool _oncoming
       (if _oncoming (write-byte -1 s) (write-byte 0 s))
     ;; bool _isBridge
       (if _isBridge (write-byte -1 s) (write-byte 0 s))
     ;; bool _groupingChanged
       (if _groupingChanged (write-byte -1 s) (write-byte 0 s))
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rangeAccel
       (sys::poke _rangeAccel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _trackId
     (setq _trackId (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _status
     (setq _status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _medRangeMode
     (setq _medRangeMode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; geometry_msgs/PoseStamped _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; geometry_msgs/TwistStamped _twist
     (send _twist :deserialize buf ptr-) (incf ptr- (send _twist :serialization-length))
   ;; bool _oncoming
     (setq _oncoming (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _isBridge
     (setq _isBridge (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _groupingChanged
     (setq _groupingChanged (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rangeAccel
     (setq _rangeAccel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::EsrObj :md5sum-) "42716c128968ac8bfa26684b875a1ee1")
(setf (get itri_msgs::EsrObj :datatype-) "itri_msgs/EsrObj")
(setf (get itri_msgs::EsrObj :definition-)
      "uint8 trackId
uint8 status
uint8 medRangeMode
geometry_msgs/PoseStamped pose
geometry_msgs/TwistStamped twist
bool oncoming
bool isBridge
bool groupingChanged
float32 width
float32 rangeAccel

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



(provide :itri_msgs/EsrObj "42716c128968ac8bfa26684b875a1ee1")


