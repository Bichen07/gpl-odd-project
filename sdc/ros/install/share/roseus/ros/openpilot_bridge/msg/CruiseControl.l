;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CruiseControl)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CruiseControl (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CRUISECONTROL")
  (make-package "OPENPILOT_BRIDGE::CRUISECONTROL"))

(in-package "ROS")
;;//! \htmlinclude CruiseControl.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CruiseControl
  :super ros::object
  :slots (_header _cancel _override _speedOverride _accelOverride ))

(defmethod openpilot_bridge::CruiseControl
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:cancel __cancel) nil)
    ((:override __override) nil)
    ((:speedOverride __speedOverride) 0.0)
    ((:accelOverride __accelOverride) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _cancel __cancel)
   (setq _override __override)
   (setq _speedOverride (float __speedOverride))
   (setq _accelOverride (float __accelOverride))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:cancel
   (&optional __cancel)
   (if __cancel (setq _cancel __cancel)) _cancel)
  (:override
   (&optional __override)
   (if __override (setq _override __override)) _override)
  (:speedOverride
   (&optional __speedOverride)
   (if __speedOverride (setq _speedOverride __speedOverride)) _speedOverride)
  (:accelOverride
   (&optional __accelOverride)
   (if __accelOverride (setq _accelOverride __accelOverride)) _accelOverride)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _cancel
    1
    ;; bool _override
    1
    ;; float32 _speedOverride
    4
    ;; float32 _accelOverride
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _cancel
       (if _cancel (write-byte -1 s) (write-byte 0 s))
     ;; bool _override
       (if _override (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speedOverride
       (sys::poke _speedOverride (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _accelOverride
       (sys::poke _accelOverride (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _cancel
     (setq _cancel (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _override
     (setq _override (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speedOverride
     (setq _speedOverride (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _accelOverride
     (setq _accelOverride (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::CruiseControl :md5sum-) "08f6bd5b4e57f59d4c99b2a0ea459283")
(setf (get openpilot_bridge::CruiseControl :datatype-) "openpilot_bridge/CruiseControl")
(setf (get openpilot_bridge::CruiseControl :definition-)
      "Header header

bool cancel
bool override
float32 speedOverride
float32 accelOverride

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



(provide :openpilot_bridge/CruiseControl "08f6bd5b4e57f59d4c99b2a0ea459283")


