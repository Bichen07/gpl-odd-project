;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Actuators)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Actuators (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ACTUATORS")
  (make-package "OPENPILOT_BRIDGE::ACTUATORS"))

(in-package "ROS")
;;//! \htmlinclude Actuators.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Actuators
  :super ros::object
  :slots (_header _brake _gas _steerAngle _steer ))

(defmethod openpilot_bridge::Actuators
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:brake __brake) 0.0)
    ((:gas __gas) 0.0)
    ((:steerAngle __steerAngle) 0.0)
    ((:steer __steer) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _brake (float __brake))
   (setq _gas (float __gas))
   (setq _steerAngle (float __steerAngle))
   (setq _steer (float __steer))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:brake
   (&optional __brake)
   (if __brake (setq _brake __brake)) _brake)
  (:gas
   (&optional __gas)
   (if __gas (setq _gas __gas)) _gas)
  (:steerAngle
   (&optional __steerAngle)
   (if __steerAngle (setq _steerAngle __steerAngle)) _steerAngle)
  (:steer
   (&optional __steer)
   (if __steer (setq _steer __steer)) _steer)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _brake
    4
    ;; float32 _gas
    4
    ;; float32 _steerAngle
    4
    ;; float32 _steer
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _brake
       (sys::poke _brake (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _gas
       (sys::poke _gas (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steerAngle
       (sys::poke _steerAngle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _steer
       (sys::poke _steer (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _brake
     (setq _brake (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _gas
     (setq _gas (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steerAngle
     (setq _steerAngle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _steer
     (setq _steer (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::Actuators :md5sum-) "0435bf15641d212acad91b17b1a76f72")
(setf (get openpilot_bridge::Actuators :datatype-) "openpilot_bridge/Actuators")
(setf (get openpilot_bridge::Actuators :definition-)
      "Header header

float32 brake
float32 gas
float32 steerAngle
float32 steer

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



(provide :openpilot_bridge/Actuators "0435bf15641d212acad91b17b1a76f72")


