;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ECEFPoint)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ECEFPoint (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ECEFPOINT")
  (make-package "OPENPILOT_BRIDGE::ECEFPOINT"))

(in-package "ROS")
;;//! \htmlinclude ECEFPoint.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ECEFPoint
  :super ros::object
  :slots (_header _y _x _z ))

(defmethod openpilot_bridge::ECEFPoint
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:y __y) 0.0)
    ((:x __x) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _y (float __y))
   (setq _x (float __x))
   (setq _z (float __z))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _y
    4
    ;; float32 _x
    4
    ;; float32 _z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::ECEFPoint :md5sum-) "0baf29b1acf78c16191abea07e5306fe")
(setf (get openpilot_bridge::ECEFPoint :datatype-) "openpilot_bridge/ECEFPoint")
(setf (get openpilot_bridge::ECEFPoint :definition-)
      "Header header

float32 y
float32 x
float32 z

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

")



(provide :openpilot_bridge/ECEFPoint "0baf29b1acf78c16191abea07e5306fe")


