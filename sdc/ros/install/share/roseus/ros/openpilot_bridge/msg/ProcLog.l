;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::ProcLog)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'ProcLog (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PROCLOG")
  (make-package "OPENPILOT_BRIDGE::PROCLOG"))

(in-package "ROS")
;;//! \htmlinclude ProcLog.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::ProcLog
  :super ros::object
  :slots (_header _cpuTimes _mem _procs ))

(defmethod openpilot_bridge::ProcLog
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:cpuTimes __cpuTimes) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::CPUTimes :init) r)) r))
    ((:mem __mem) (instance openpilot_bridge::Mem :init))
    ((:procs __procs) (let (r) (dotimes (i 0) (push (instance openpilot_bridge::Process :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _cpuTimes __cpuTimes)
   (setq _mem __mem)
   (setq _procs __procs)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:cpuTimes
   (&rest __cpuTimes)
   (if (keywordp (car __cpuTimes))
       (send* _cpuTimes __cpuTimes)
     (progn
       (if __cpuTimes (setq _cpuTimes (car __cpuTimes)))
       _cpuTimes)))
  (:mem
   (&rest __mem)
   (if (keywordp (car __mem))
       (send* _mem __mem)
     (progn
       (if __mem (setq _mem (car __mem)))
       _mem)))
  (:procs
   (&rest __procs)
   (if (keywordp (car __procs))
       (send* _procs __procs)
     (progn
       (if __procs (setq _procs (car __procs)))
       _procs)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; openpilot_bridge/CPUTimes[] _cpuTimes
    (apply #'+ (send-all _cpuTimes :serialization-length)) 4
    ;; openpilot_bridge/Mem _mem
    (send _mem :serialization-length)
    ;; openpilot_bridge/Process[] _procs
    (apply #'+ (send-all _procs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; openpilot_bridge/CPUTimes[] _cpuTimes
     (write-long (length _cpuTimes) s)
     (dolist (elem _cpuTimes)
       (send elem :serialize s)
       )
     ;; openpilot_bridge/Mem _mem
       (send _mem :serialize s)
     ;; openpilot_bridge/Process[] _procs
     (write-long (length _procs) s)
     (dolist (elem _procs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; openpilot_bridge/CPUTimes[] _cpuTimes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cpuTimes (let (r) (dotimes (i n) (push (instance openpilot_bridge::CPUTimes :init) r)) r))
     (dolist (elem- _cpuTimes)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; openpilot_bridge/Mem _mem
     (send _mem :deserialize buf ptr-) (incf ptr- (send _mem :serialization-length))
   ;; openpilot_bridge/Process[] _procs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _procs (let (r) (dotimes (i n) (push (instance openpilot_bridge::Process :init) r)) r))
     (dolist (elem- _procs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::ProcLog :md5sum-) "21eae07decb56f4048af9c9c8680083d")
(setf (get openpilot_bridge::ProcLog :datatype-) "openpilot_bridge/ProcLog")
(setf (get openpilot_bridge::ProcLog :definition-)
      "Header header

CPUTimes[] cpuTimes
Mem mem
Process[] procs

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
MSG: openpilot_bridge/CPUTimes
Header header

float32 softirq
float32 iowait
float32 system
int32 cpuNum
float32 idle
float32 user
float32 irq
float32 nice

================================================================================
MSG: openpilot_bridge/Mem
Header header

int64 available
int64 cached
int64 free
int64 inactive
int64 active
int64 shared
int64 total
int64 buffers

================================================================================
MSG: openpilot_bridge/Process
Header header

string[] exe
string[] name
string[] cmdline
float32 cpuUser
int32 numThreads
int64 memRss
int32 pid
int64 memVms
int32 priority
float32 cpuSystem
int64 state
float32 startTime
int32 nice
float32 cpuChildrenUser
int32 ppid
int32 processor
float32 cpuChildrenSystem

")



(provide :openpilot_bridge/ProcLog "21eae07decb56f4048af9c9c8680083d")


