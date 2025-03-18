;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LateralINDITuning)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LateralINDITuning (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LATERALINDITUNING")
  (make-package "OPENPILOT_BRIDGE::LATERALINDITUNING"))

(in-package "ROS")
;;//! \htmlinclude LateralINDITuning.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LateralINDITuning
  :super ros::object
  :slots (_header _actuatorEffectiveness _outerLoopGain _innerLoopGain _timeConstant ))

(defmethod openpilot_bridge::LateralINDITuning
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:actuatorEffectiveness __actuatorEffectiveness) 0.0)
    ((:outerLoopGain __outerLoopGain) 0.0)
    ((:innerLoopGain __innerLoopGain) 0.0)
    ((:timeConstant __timeConstant) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _actuatorEffectiveness (float __actuatorEffectiveness))
   (setq _outerLoopGain (float __outerLoopGain))
   (setq _innerLoopGain (float __innerLoopGain))
   (setq _timeConstant (float __timeConstant))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:actuatorEffectiveness
   (&optional __actuatorEffectiveness)
   (if __actuatorEffectiveness (setq _actuatorEffectiveness __actuatorEffectiveness)) _actuatorEffectiveness)
  (:outerLoopGain
   (&optional __outerLoopGain)
   (if __outerLoopGain (setq _outerLoopGain __outerLoopGain)) _outerLoopGain)
  (:innerLoopGain
   (&optional __innerLoopGain)
   (if __innerLoopGain (setq _innerLoopGain __innerLoopGain)) _innerLoopGain)
  (:timeConstant
   (&optional __timeConstant)
   (if __timeConstant (setq _timeConstant __timeConstant)) _timeConstant)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _actuatorEffectiveness
    4
    ;; float32 _outerLoopGain
    4
    ;; float32 _innerLoopGain
    4
    ;; float32 _timeConstant
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _actuatorEffectiveness
       (sys::poke _actuatorEffectiveness (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _outerLoopGain
       (sys::poke _outerLoopGain (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _innerLoopGain
       (sys::poke _innerLoopGain (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _timeConstant
       (sys::poke _timeConstant (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _actuatorEffectiveness
     (setq _actuatorEffectiveness (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _outerLoopGain
     (setq _outerLoopGain (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _innerLoopGain
     (setq _innerLoopGain (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _timeConstant
     (setq _timeConstant (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::LateralINDITuning :md5sum-) "9ff2e2f4cb8a2e149864fcfa0d8adca2")
(setf (get openpilot_bridge::LateralINDITuning :datatype-) "openpilot_bridge/LateralINDITuning")
(setf (get openpilot_bridge::LateralINDITuning :definition-)
      "Header header

float32 actuatorEffectiveness
float32 outerLoopGain
float32 innerLoopGain
float32 timeConstant

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



(provide :openpilot_bridge/LateralINDITuning "9ff2e2f4cb8a2e149864fcfa0d8adca2")


