;; Auto-generated. Do not edit!


(when (boundp 'itri_msgs::LanePoly)
  (if (not (find-package "ITRI_MSGS"))
    (make-package "ITRI_MSGS"))
  (shadow 'LanePoly (find-package "ITRI_MSGS")))
(unless (find-package "ITRI_MSGS::LANEPOLY")
  (make-package "ITRI_MSGS::LANEPOLY"))

(in-package "ROS")
;;//! \htmlinclude LanePoly.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass itri_msgs::LanePoly
  :super ros::object
  :slots (_header _c0 _c1 _c2 _c3 _confidentScore _distance _width _right_bound _left_bound _prob ))

(defmethod itri_msgs::LanePoly
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:c0 __c0) 0.0)
    ((:c1 __c1) 0.0)
    ((:c2 __c2) 0.0)
    ((:c3 __c3) 0.0)
    ((:confidentScore __confidentScore) 0)
    ((:distance __distance) 0.0)
    ((:width __width) 0.0)
    ((:right_bound __right_bound) 0.0)
    ((:left_bound __left_bound) 0.0)
    ((:prob __prob) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _c0 (float __c0))
   (setq _c1 (float __c1))
   (setq _c2 (float __c2))
   (setq _c3 (float __c3))
   (setq _confidentScore (round __confidentScore))
   (setq _distance (float __distance))
   (setq _width (float __width))
   (setq _right_bound (float __right_bound))
   (setq _left_bound (float __left_bound))
   (setq _prob (float __prob))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:c0
   (&optional __c0)
   (if __c0 (setq _c0 __c0)) _c0)
  (:c1
   (&optional __c1)
   (if __c1 (setq _c1 __c1)) _c1)
  (:c2
   (&optional __c2)
   (if __c2 (setq _c2 __c2)) _c2)
  (:c3
   (&optional __c3)
   (if __c3 (setq _c3 __c3)) _c3)
  (:confidentScore
   (&optional __confidentScore)
   (if __confidentScore (setq _confidentScore __confidentScore)) _confidentScore)
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:right_bound
   (&optional __right_bound)
   (if __right_bound (setq _right_bound __right_bound)) _right_bound)
  (:left_bound
   (&optional __left_bound)
   (if __left_bound (setq _left_bound __left_bound)) _left_bound)
  (:prob
   (&optional __prob)
   (if __prob (setq _prob __prob)) _prob)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _c0
    4
    ;; float32 _c1
    4
    ;; float32 _c2
    4
    ;; float32 _c3
    4
    ;; uint16 _confidentScore
    2
    ;; float32 _distance
    4
    ;; float32 _width
    4
    ;; float32 _right_bound
    4
    ;; float32 _left_bound
    4
    ;; float32 _prob
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _c0
       (sys::poke _c0 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _c1
       (sys::poke _c1 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _c2
       (sys::poke _c2 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _c3
       (sys::poke _c3 (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; uint16 _confidentScore
       (write-word _confidentScore s)
     ;; float32 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _width
       (sys::poke _width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _right_bound
       (sys::poke _right_bound (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _left_bound
       (sys::poke _left_bound (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _prob
       (sys::poke _prob (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _c0
     (setq _c0 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _c1
     (setq _c1 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _c2
     (setq _c2 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _c3
     (setq _c3 (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; uint16 _confidentScore
     (setq _confidentScore (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; float32 _distance
     (setq _distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _width
     (setq _width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _right_bound
     (setq _right_bound (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _left_bound
     (setq _left_bound (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _prob
     (setq _prob (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get itri_msgs::LanePoly :md5sum-) "e989af5a3e269fb4013d6d80ce03fad4")
(setf (get itri_msgs::LanePoly :datatype-) "itri_msgs/LanePoly")
(setf (get itri_msgs::LanePoly :definition-)
      "std_msgs/Header header
float32 c0
float32 c1
float32 c2
float32 c3

uint16 confidentScore
float32 distance
float32 width
float32 right_bound
float32 left_bound
float32 prob

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



(provide :itri_msgs/LanePoly "e989af5a3e269fb4013d6d80ce03fad4")


