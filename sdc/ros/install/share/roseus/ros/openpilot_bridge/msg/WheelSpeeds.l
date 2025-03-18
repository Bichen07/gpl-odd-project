;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::WheelSpeeds)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'WheelSpeeds (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::WHEELSPEEDS")
  (make-package "OPENPILOT_BRIDGE::WHEELSPEEDS"))

(in-package "ROS")
;;//! \htmlinclude WheelSpeeds.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::WheelSpeeds
  :super ros::object
  :slots (_header _rl _fr _fl _rr ))

(defmethod openpilot_bridge::WheelSpeeds
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:rl __rl) 0.0)
    ((:fr __fr) 0.0)
    ((:fl __fl) 0.0)
    ((:rr __rr) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _rl (float __rl))
   (setq _fr (float __fr))
   (setq _fl (float __fl))
   (setq _rr (float __rr))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:rl
   (&optional __rl)
   (if __rl (setq _rl __rl)) _rl)
  (:fr
   (&optional __fr)
   (if __fr (setq _fr __fr)) _fr)
  (:fl
   (&optional __fl)
   (if __fl (setq _fl __fl)) _fl)
  (:rr
   (&optional __rr)
   (if __rr (setq _rr __rr)) _rr)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _rl
    4
    ;; float32 _fr
    4
    ;; float32 _fl
    4
    ;; float32 _rr
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _rl
       (sys::poke _rl (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fr
       (sys::poke _fr (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fl
       (sys::poke _fl (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rr
       (sys::poke _rr (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _rl
     (setq _rl (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fr
     (setq _fr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fl
     (setq _fl (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rr
     (setq _rr (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::WheelSpeeds :md5sum-) "835b7f85819edc320a2569cabd6d06bb")
(setf (get openpilot_bridge::WheelSpeeds :datatype-) "openpilot_bridge/WheelSpeeds")
(setf (get openpilot_bridge::WheelSpeeds :definition-)
      "Header header

float32 rl
float32 fr
float32 fl
float32 rr

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



(provide :openpilot_bridge/WheelSpeeds "835b7f85819edc320a2569cabd6d06bb")


