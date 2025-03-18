;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CruiseState)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CruiseState (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CRUISESTATE")
  (make-package "OPENPILOT_BRIDGE::CRUISESTATE"))

(in-package "ROS")
;;//! \htmlinclude CruiseState.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CruiseState
  :super ros::object
  :slots (_header _available _speed _speedOffset _enabled _standstill ))

(defmethod openpilot_bridge::CruiseState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:available __available) nil)
    ((:speed __speed) 0.0)
    ((:speedOffset __speedOffset) 0.0)
    ((:enabled __enabled) nil)
    ((:standstill __standstill) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _available __available)
   (setq _speed (float __speed))
   (setq _speedOffset (float __speedOffset))
   (setq _enabled __enabled)
   (setq _standstill __standstill)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:available
   (&optional __available)
   (if __available (setq _available __available)) _available)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:speedOffset
   (&optional __speedOffset)
   (if __speedOffset (setq _speedOffset __speedOffset)) _speedOffset)
  (:enabled
   (&optional __enabled)
   (if __enabled (setq _enabled __enabled)) _enabled)
  (:standstill
   (&optional __standstill)
   (if __standstill (setq _standstill __standstill)) _standstill)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; bool _available
    1
    ;; float32 _speed
    4
    ;; float32 _speedOffset
    4
    ;; bool _enabled
    1
    ;; bool _standstill
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; bool _available
       (if _available (write-byte -1 s) (write-byte 0 s))
     ;; float32 _speed
       (sys::poke _speed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _speedOffset
       (sys::poke _speedOffset (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _enabled
       (if _enabled (write-byte -1 s) (write-byte 0 s))
     ;; bool _standstill
       (if _standstill (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; bool _available
     (setq _available (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _speed
     (setq _speed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _speedOffset
     (setq _speedOffset (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _enabled
     (setq _enabled (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _standstill
     (setq _standstill (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get openpilot_bridge::CruiseState :md5sum-) "28f2062975649fc54f74bcb3056b4d2e")
(setf (get openpilot_bridge::CruiseState :datatype-) "openpilot_bridge/CruiseState")
(setf (get openpilot_bridge::CruiseState :definition-)
      "Header header

bool available
float32 speed
float32 speedOffset
bool enabled
bool standstill

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



(provide :openpilot_bridge/CruiseState "28f2062975649fc54f74bcb3056b4d2e")


