;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Process)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Process (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::PROCESS")
  (make-package "OPENPILOT_BRIDGE::PROCESS"))

(in-package "ROS")
;;//! \htmlinclude Process.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Process
  :super ros::object
  :slots (_header _exe _name _cmdline _cpuUser _numThreads _memRss _pid _memVms _priority _cpuSystem _state _startTime _nice _cpuChildrenUser _ppid _processor _cpuChildrenSystem ))

(defmethod openpilot_bridge::Process
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:exe __exe) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:name __name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:cmdline __cmdline) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:cpuUser __cpuUser) 0.0)
    ((:numThreads __numThreads) 0)
    ((:memRss __memRss) 0)
    ((:pid __pid) 0)
    ((:memVms __memVms) 0)
    ((:priority __priority) 0)
    ((:cpuSystem __cpuSystem) 0.0)
    ((:state __state) 0)
    ((:startTime __startTime) 0.0)
    ((:nice __nice) 0)
    ((:cpuChildrenUser __cpuChildrenUser) 0.0)
    ((:ppid __ppid) 0)
    ((:processor __processor) 0)
    ((:cpuChildrenSystem __cpuChildrenSystem) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _exe __exe)
   (setq _name __name)
   (setq _cmdline __cmdline)
   (setq _cpuUser (float __cpuUser))
   (setq _numThreads (round __numThreads))
   (setq _memRss (round __memRss))
   (setq _pid (round __pid))
   (setq _memVms (round __memVms))
   (setq _priority (round __priority))
   (setq _cpuSystem (float __cpuSystem))
   (setq _state (round __state))
   (setq _startTime (float __startTime))
   (setq _nice (round __nice))
   (setq _cpuChildrenUser (float __cpuChildrenUser))
   (setq _ppid (round __ppid))
   (setq _processor (round __processor))
   (setq _cpuChildrenSystem (float __cpuChildrenSystem))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:exe
   (&optional __exe)
   (if __exe (setq _exe __exe)) _exe)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:cmdline
   (&optional __cmdline)
   (if __cmdline (setq _cmdline __cmdline)) _cmdline)
  (:cpuUser
   (&optional __cpuUser)
   (if __cpuUser (setq _cpuUser __cpuUser)) _cpuUser)
  (:numThreads
   (&optional __numThreads)
   (if __numThreads (setq _numThreads __numThreads)) _numThreads)
  (:memRss
   (&optional __memRss)
   (if __memRss (setq _memRss __memRss)) _memRss)
  (:pid
   (&optional __pid)
   (if __pid (setq _pid __pid)) _pid)
  (:memVms
   (&optional __memVms)
   (if __memVms (setq _memVms __memVms)) _memVms)
  (:priority
   (&optional __priority)
   (if __priority (setq _priority __priority)) _priority)
  (:cpuSystem
   (&optional __cpuSystem)
   (if __cpuSystem (setq _cpuSystem __cpuSystem)) _cpuSystem)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:startTime
   (&optional __startTime)
   (if __startTime (setq _startTime __startTime)) _startTime)
  (:nice
   (&optional __nice)
   (if __nice (setq _nice __nice)) _nice)
  (:cpuChildrenUser
   (&optional __cpuChildrenUser)
   (if __cpuChildrenUser (setq _cpuChildrenUser __cpuChildrenUser)) _cpuChildrenUser)
  (:ppid
   (&optional __ppid)
   (if __ppid (setq _ppid __ppid)) _ppid)
  (:processor
   (&optional __processor)
   (if __processor (setq _processor __processor)) _processor)
  (:cpuChildrenSystem
   (&optional __cpuChildrenSystem)
   (if __cpuChildrenSystem (setq _cpuChildrenSystem __cpuChildrenSystem)) _cpuChildrenSystem)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _exe
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _exe)) 4
    ;; string[] _name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _name)) 4
    ;; string[] _cmdline
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _cmdline)) 4
    ;; float32 _cpuUser
    4
    ;; int32 _numThreads
    4
    ;; int64 _memRss
    8
    ;; int32 _pid
    4
    ;; int64 _memVms
    8
    ;; int32 _priority
    4
    ;; float32 _cpuSystem
    4
    ;; int64 _state
    8
    ;; float32 _startTime
    4
    ;; int32 _nice
    4
    ;; float32 _cpuChildrenUser
    4
    ;; int32 _ppid
    4
    ;; int32 _processor
    4
    ;; float32 _cpuChildrenSystem
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _exe
     (write-long (length _exe) s)
     (dolist (elem _exe)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _name
     (write-long (length _name) s)
     (dolist (elem _name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _cmdline
     (write-long (length _cmdline) s)
     (dolist (elem _cmdline)
       (write-long (length elem) s) (princ elem s)
       )
     ;; float32 _cpuUser
       (sys::poke _cpuUser (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _numThreads
       (write-long _numThreads s)
     ;; int64 _memRss
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _memRss (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _memRss) (= (length (_memRss . bv)) 2)) ;; bignum
              (write-long (ash (elt (_memRss . bv) 0) 0) s)
              (write-long (ash (elt (_memRss . bv) 1) -1) s))
             ((and (class _memRss) (= (length (_memRss . bv)) 1)) ;; big1
              (write-long (elt (_memRss . bv) 0) s)
              (write-long (if (>= _memRss 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _memRss s)(write-long (if (>= _memRss 0) 0 #xffffffff) s)))
     ;; int32 _pid
       (write-long _pid s)
     ;; int64 _memVms
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _memVms (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _memVms) (= (length (_memVms . bv)) 2)) ;; bignum
              (write-long (ash (elt (_memVms . bv) 0) 0) s)
              (write-long (ash (elt (_memVms . bv) 1) -1) s))
             ((and (class _memVms) (= (length (_memVms . bv)) 1)) ;; big1
              (write-long (elt (_memVms . bv) 0) s)
              (write-long (if (>= _memVms 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _memVms s)(write-long (if (>= _memVms 0) 0 #xffffffff) s)))
     ;; int32 _priority
       (write-long _priority s)
     ;; float32 _cpuSystem
       (sys::poke _cpuSystem (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int64 _state
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _state (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _state) (= (length (_state . bv)) 2)) ;; bignum
              (write-long (ash (elt (_state . bv) 0) 0) s)
              (write-long (ash (elt (_state . bv) 1) -1) s))
             ((and (class _state) (= (length (_state . bv)) 1)) ;; big1
              (write-long (elt (_state . bv) 0) s)
              (write-long (if (>= _state 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _state s)(write-long (if (>= _state 0) 0 #xffffffff) s)))
     ;; float32 _startTime
       (sys::poke _startTime (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _nice
       (write-long _nice s)
     ;; float32 _cpuChildrenUser
       (sys::poke _cpuChildrenUser (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _ppid
       (write-long _ppid s)
     ;; int32 _processor
       (write-long _processor s)
     ;; float32 _cpuChildrenSystem
       (sys::poke _cpuChildrenSystem (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _exe
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _exe (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _exe i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _cmdline
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cmdline (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _cmdline i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; float32 _cpuUser
     (setq _cpuUser (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _numThreads
     (setq _numThreads (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _memRss
#+(or :alpha :irix6 :x86_64)
      (setf _memRss (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _memRss (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _pid
     (setq _pid (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _memVms
#+(or :alpha :irix6 :x86_64)
      (setf _memVms (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _memVms (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int32 _priority
     (setq _priority (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _cpuSystem
     (setq _cpuSystem (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int64 _state
#+(or :alpha :irix6 :x86_64)
      (setf _state (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _state (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _startTime
     (setq _startTime (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _nice
     (setq _nice (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _cpuChildrenUser
     (setq _cpuChildrenUser (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _ppid
     (setq _ppid (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _processor
     (setq _processor (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _cpuChildrenSystem
     (setq _cpuChildrenSystem (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get openpilot_bridge::Process :md5sum-) "85ebf2bd3669f9306e0aaee2bcc598b2")
(setf (get openpilot_bridge::Process :datatype-) "openpilot_bridge/Process")
(setf (get openpilot_bridge::Process :definition-)
      "Header header

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



(provide :openpilot_bridge/Process "85ebf2bd3669f9306e0aaee2bcc598b2")


