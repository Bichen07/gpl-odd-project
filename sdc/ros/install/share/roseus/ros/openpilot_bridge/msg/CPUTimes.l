;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CPUTimes)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CPUTimes (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CPUTIMES")
  (make-package "OPENPILOT_BRIDGE::CPUTIMES"))

(in-package "ROS")
;;//! \htmlinclude CPUTimes.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CPUTimes
  :super ros::object
  :slots (_header _softirq _iowait _system _cpuNum _idle _user _irq _nice ))

(defmethod openpilot_bridge::CPUTimes
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:softirq __softirq) 0.0)
    ((:iowait __iowait) 0.0)
    ((:system __system) 0.0)
    ((:cpuNum __cpuNum) 0)
    ((:idle __idle) 0.0)
    ((:user __user) 0.0)
    ((:irq __irq) 0.0)
    ((:nice __nice) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _softirq (float __softirq))
   (setq _iowait (float __iowait))
   (setq _system (float __system))
   (setq _cpuNum (round __cpuNum))
   (setq _idle (float __idle))
   (setq _user (float __user))
   (setq _irq (float __irq))
   (setq _nice (float __nice))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:softirq
   (&optional __softirq)
   (if __softirq (setq _softirq __softirq)) _softirq)
  (:iowait
   (&optional __iowait)
   (if __iowait (setq _iowait __iowait)) _iowait)
  (:system
   (&optional __system)
   (if __system (setq _system __system)) _system)
  (:cpuNum
   (&optional __cpuNum)
   (if __cpuNum (setq _cpuNum __cpuNum)) _cpuNum)
  (:idle
   (&optional __idle)
   (if __idle (setq _idle __idle)) _idle)
  (:user
   (&optional __user)
   (if __user (setq _user __user)) _user)
  (:irq
   (&optional __irq)
   (if __irq (setq _irq __irq)) _irq)
  (:nice
   (&optional __nice)
   (if __nice (setq _nice __nice)) _nice)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; float32 _softirq
    4
    ;; float32 _iowait
    4
    ;; float32 _system
    4
    ;; int32 _cpuNum
    4
    ;; float32 _idle
    4
    ;; float32 _user
    4
    ;; float32 _irq
    4
    ;; float32 _nice
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; float32 _softirq
       (sys::poke _softirq (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _iowait
       (sys::poke _iowait (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _system
       (sys::poke _system (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _cpuNum
       (write-long _cpuNum s)
     ;; float32 _idle
       (sys::poke _idle (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _user
       (sys::poke _user (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _irq
       (sys::poke _irq (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _nice
       (sys::poke _nice (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; float32 _softirq
     (setq _softirq (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _iowait
     (setq _iowait (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _system
     (setq _system (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _cpuNum
     (setq _cpuNum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _idle
     (setq _idle (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _user
     (setq _user (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _irq
     (setq _irq (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _nice
     (setq _nice (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::CPUTimes :md5sum-) "dc9d293549a3f253ed6668df60faa73d")
(setf (get openpilot_bridge::CPUTimes :datatype-) "openpilot_bridge/CPUTimes")
(setf (get openpilot_bridge::CPUTimes :definition-)
      "Header header

float32 softirq
float32 iowait
float32 system
int32 cpuNum
float32 idle
float32 user
float32 irq
float32 nice

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



(provide :openpilot_bridge/CPUTimes "dc9d293549a3f253ed6668df60faa73d")


