;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Mem)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Mem (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::MEM")
  (make-package "OPENPILOT_BRIDGE::MEM"))

(in-package "ROS")
;;//! \htmlinclude Mem.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Mem
  :super ros::object
  :slots (_header _available _cached _free _inactive _active _shared _total _buffers ))

(defmethod openpilot_bridge::Mem
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:available __available) 0)
    ((:cached __cached) 0)
    ((:free __free) 0)
    ((:inactive __inactive) 0)
    ((:active __active) 0)
    ((:shared __shared) 0)
    ((:total __total) 0)
    ((:buffers __buffers) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _available (round __available))
   (setq _cached (round __cached))
   (setq _free (round __free))
   (setq _inactive (round __inactive))
   (setq _active (round __active))
   (setq _shared (round __shared))
   (setq _total (round __total))
   (setq _buffers (round __buffers))
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
  (:cached
   (&optional __cached)
   (if __cached (setq _cached __cached)) _cached)
  (:free
   (&optional __free)
   (if __free (setq _free __free)) _free)
  (:inactive
   (&optional __inactive)
   (if __inactive (setq _inactive __inactive)) _inactive)
  (:active
   (&optional __active)
   (if __active (setq _active __active)) _active)
  (:shared
   (&optional __shared)
   (if __shared (setq _shared __shared)) _shared)
  (:total
   (&optional __total)
   (if __total (setq _total __total)) _total)
  (:buffers
   (&optional __buffers)
   (if __buffers (setq _buffers __buffers)) _buffers)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _available
    8
    ;; int64 _cached
    8
    ;; int64 _free
    8
    ;; int64 _inactive
    8
    ;; int64 _active
    8
    ;; int64 _shared
    8
    ;; int64 _total
    8
    ;; int64 _buffers
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _available
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _available (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _available) (= (length (_available . bv)) 2)) ;; bignum
              (write-long (ash (elt (_available . bv) 0) 0) s)
              (write-long (ash (elt (_available . bv) 1) -1) s))
             ((and (class _available) (= (length (_available . bv)) 1)) ;; big1
              (write-long (elt (_available . bv) 0) s)
              (write-long (if (>= _available 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _available s)(write-long (if (>= _available 0) 0 #xffffffff) s)))
     ;; int64 _cached
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _cached (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _cached) (= (length (_cached . bv)) 2)) ;; bignum
              (write-long (ash (elt (_cached . bv) 0) 0) s)
              (write-long (ash (elt (_cached . bv) 1) -1) s))
             ((and (class _cached) (= (length (_cached . bv)) 1)) ;; big1
              (write-long (elt (_cached . bv) 0) s)
              (write-long (if (>= _cached 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _cached s)(write-long (if (>= _cached 0) 0 #xffffffff) s)))
     ;; int64 _free
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _free (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _free) (= (length (_free . bv)) 2)) ;; bignum
              (write-long (ash (elt (_free . bv) 0) 0) s)
              (write-long (ash (elt (_free . bv) 1) -1) s))
             ((and (class _free) (= (length (_free . bv)) 1)) ;; big1
              (write-long (elt (_free . bv) 0) s)
              (write-long (if (>= _free 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _free s)(write-long (if (>= _free 0) 0 #xffffffff) s)))
     ;; int64 _inactive
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _inactive (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _inactive) (= (length (_inactive . bv)) 2)) ;; bignum
              (write-long (ash (elt (_inactive . bv) 0) 0) s)
              (write-long (ash (elt (_inactive . bv) 1) -1) s))
             ((and (class _inactive) (= (length (_inactive . bv)) 1)) ;; big1
              (write-long (elt (_inactive . bv) 0) s)
              (write-long (if (>= _inactive 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _inactive s)(write-long (if (>= _inactive 0) 0 #xffffffff) s)))
     ;; int64 _active
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _active (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _active) (= (length (_active . bv)) 2)) ;; bignum
              (write-long (ash (elt (_active . bv) 0) 0) s)
              (write-long (ash (elt (_active . bv) 1) -1) s))
             ((and (class _active) (= (length (_active . bv)) 1)) ;; big1
              (write-long (elt (_active . bv) 0) s)
              (write-long (if (>= _active 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _active s)(write-long (if (>= _active 0) 0 #xffffffff) s)))
     ;; int64 _shared
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _shared (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _shared) (= (length (_shared . bv)) 2)) ;; bignum
              (write-long (ash (elt (_shared . bv) 0) 0) s)
              (write-long (ash (elt (_shared . bv) 1) -1) s))
             ((and (class _shared) (= (length (_shared . bv)) 1)) ;; big1
              (write-long (elt (_shared . bv) 0) s)
              (write-long (if (>= _shared 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _shared s)(write-long (if (>= _shared 0) 0 #xffffffff) s)))
     ;; int64 _total
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _total (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _total) (= (length (_total . bv)) 2)) ;; bignum
              (write-long (ash (elt (_total . bv) 0) 0) s)
              (write-long (ash (elt (_total . bv) 1) -1) s))
             ((and (class _total) (= (length (_total . bv)) 1)) ;; big1
              (write-long (elt (_total . bv) 0) s)
              (write-long (if (>= _total 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _total s)(write-long (if (>= _total 0) 0 #xffffffff) s)))
     ;; int64 _buffers
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _buffers (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _buffers) (= (length (_buffers . bv)) 2)) ;; bignum
              (write-long (ash (elt (_buffers . bv) 0) 0) s)
              (write-long (ash (elt (_buffers . bv) 1) -1) s))
             ((and (class _buffers) (= (length (_buffers . bv)) 1)) ;; big1
              (write-long (elt (_buffers . bv) 0) s)
              (write-long (if (>= _buffers 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _buffers s)(write-long (if (>= _buffers 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _available
#+(or :alpha :irix6 :x86_64)
      (setf _available (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _available (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _cached
#+(or :alpha :irix6 :x86_64)
      (setf _cached (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _cached (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _free
#+(or :alpha :irix6 :x86_64)
      (setf _free (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _free (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _inactive
#+(or :alpha :irix6 :x86_64)
      (setf _inactive (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _inactive (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _active
#+(or :alpha :irix6 :x86_64)
      (setf _active (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _active (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _shared
#+(or :alpha :irix6 :x86_64)
      (setf _shared (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _shared (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _total
#+(or :alpha :irix6 :x86_64)
      (setf _total (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _total (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _buffers
#+(or :alpha :irix6 :x86_64)
      (setf _buffers (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _buffers (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(setf (get openpilot_bridge::Mem :md5sum-) "37047380061a5ca52ba6cf08ff779e8e")
(setf (get openpilot_bridge::Mem :datatype-) "openpilot_bridge/Mem")
(setf (get openpilot_bridge::Mem :definition-)
      "Header header

int64 available
int64 cached
int64 free
int64 inactive
int64 active
int64 shared
int64 total
int64 buffers

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



(provide :openpilot_bridge/Mem "37047380061a5ca52ba6cf08ff779e8e")


