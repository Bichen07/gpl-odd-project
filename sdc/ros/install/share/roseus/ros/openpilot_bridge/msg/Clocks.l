;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Clocks)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Clocks (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CLOCKS")
  (make-package "OPENPILOT_BRIDGE::CLOCKS"))

(in-package "ROS")
;;//! \htmlinclude Clocks.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Clocks
  :super ros::object
  :slots (_header _modemUptimeMillis _wallTimeNanos _bootTimeNanos _monotonicRawNanos _monotonicNanos ))

(defmethod openpilot_bridge::Clocks
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:modemUptimeMillis __modemUptimeMillis) 0)
    ((:wallTimeNanos __wallTimeNanos) 0)
    ((:bootTimeNanos __bootTimeNanos) 0)
    ((:monotonicRawNanos __monotonicRawNanos) 0)
    ((:monotonicNanos __monotonicNanos) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _modemUptimeMillis (round __modemUptimeMillis))
   (setq _wallTimeNanos (round __wallTimeNanos))
   (setq _bootTimeNanos (round __bootTimeNanos))
   (setq _monotonicRawNanos (round __monotonicRawNanos))
   (setq _monotonicNanos (round __monotonicNanos))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:modemUptimeMillis
   (&optional __modemUptimeMillis)
   (if __modemUptimeMillis (setq _modemUptimeMillis __modemUptimeMillis)) _modemUptimeMillis)
  (:wallTimeNanos
   (&optional __wallTimeNanos)
   (if __wallTimeNanos (setq _wallTimeNanos __wallTimeNanos)) _wallTimeNanos)
  (:bootTimeNanos
   (&optional __bootTimeNanos)
   (if __bootTimeNanos (setq _bootTimeNanos __bootTimeNanos)) _bootTimeNanos)
  (:monotonicRawNanos
   (&optional __monotonicRawNanos)
   (if __monotonicRawNanos (setq _monotonicRawNanos __monotonicRawNanos)) _monotonicRawNanos)
  (:monotonicNanos
   (&optional __monotonicNanos)
   (if __monotonicNanos (setq _monotonicNanos __monotonicNanos)) _monotonicNanos)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _modemUptimeMillis
    8
    ;; int64 _wallTimeNanos
    8
    ;; int64 _bootTimeNanos
    8
    ;; int64 _monotonicRawNanos
    8
    ;; int64 _monotonicNanos
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _modemUptimeMillis
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _modemUptimeMillis (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _modemUptimeMillis) (= (length (_modemUptimeMillis . bv)) 2)) ;; bignum
              (write-long (ash (elt (_modemUptimeMillis . bv) 0) 0) s)
              (write-long (ash (elt (_modemUptimeMillis . bv) 1) -1) s))
             ((and (class _modemUptimeMillis) (= (length (_modemUptimeMillis . bv)) 1)) ;; big1
              (write-long (elt (_modemUptimeMillis . bv) 0) s)
              (write-long (if (>= _modemUptimeMillis 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _modemUptimeMillis s)(write-long (if (>= _modemUptimeMillis 0) 0 #xffffffff) s)))
     ;; int64 _wallTimeNanos
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _wallTimeNanos (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _wallTimeNanos) (= (length (_wallTimeNanos . bv)) 2)) ;; bignum
              (write-long (ash (elt (_wallTimeNanos . bv) 0) 0) s)
              (write-long (ash (elt (_wallTimeNanos . bv) 1) -1) s))
             ((and (class _wallTimeNanos) (= (length (_wallTimeNanos . bv)) 1)) ;; big1
              (write-long (elt (_wallTimeNanos . bv) 0) s)
              (write-long (if (>= _wallTimeNanos 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _wallTimeNanos s)(write-long (if (>= _wallTimeNanos 0) 0 #xffffffff) s)))
     ;; int64 _bootTimeNanos
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _bootTimeNanos (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _bootTimeNanos) (= (length (_bootTimeNanos . bv)) 2)) ;; bignum
              (write-long (ash (elt (_bootTimeNanos . bv) 0) 0) s)
              (write-long (ash (elt (_bootTimeNanos . bv) 1) -1) s))
             ((and (class _bootTimeNanos) (= (length (_bootTimeNanos . bv)) 1)) ;; big1
              (write-long (elt (_bootTimeNanos . bv) 0) s)
              (write-long (if (>= _bootTimeNanos 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _bootTimeNanos s)(write-long (if (>= _bootTimeNanos 0) 0 #xffffffff) s)))
     ;; int64 _monotonicRawNanos
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _monotonicRawNanos (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _monotonicRawNanos) (= (length (_monotonicRawNanos . bv)) 2)) ;; bignum
              (write-long (ash (elt (_monotonicRawNanos . bv) 0) 0) s)
              (write-long (ash (elt (_monotonicRawNanos . bv) 1) -1) s))
             ((and (class _monotonicRawNanos) (= (length (_monotonicRawNanos . bv)) 1)) ;; big1
              (write-long (elt (_monotonicRawNanos . bv) 0) s)
              (write-long (if (>= _monotonicRawNanos 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _monotonicRawNanos s)(write-long (if (>= _monotonicRawNanos 0) 0 #xffffffff) s)))
     ;; int64 _monotonicNanos
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _monotonicNanos (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _monotonicNanos) (= (length (_monotonicNanos . bv)) 2)) ;; bignum
              (write-long (ash (elt (_monotonicNanos . bv) 0) 0) s)
              (write-long (ash (elt (_monotonicNanos . bv) 1) -1) s))
             ((and (class _monotonicNanos) (= (length (_monotonicNanos . bv)) 1)) ;; big1
              (write-long (elt (_monotonicNanos . bv) 0) s)
              (write-long (if (>= _monotonicNanos 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _monotonicNanos s)(write-long (if (>= _monotonicNanos 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _modemUptimeMillis
#+(or :alpha :irix6 :x86_64)
      (setf _modemUptimeMillis (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _modemUptimeMillis (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _wallTimeNanos
#+(or :alpha :irix6 :x86_64)
      (setf _wallTimeNanos (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _wallTimeNanos (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _bootTimeNanos
#+(or :alpha :irix6 :x86_64)
      (setf _bootTimeNanos (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _bootTimeNanos (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _monotonicRawNanos
#+(or :alpha :irix6 :x86_64)
      (setf _monotonicRawNanos (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _monotonicRawNanos (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _monotonicNanos
#+(or :alpha :irix6 :x86_64)
      (setf _monotonicNanos (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _monotonicNanos (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::Clocks :md5sum-) "a00c35b464cff74388a274b01c607034")
(setf (get openpilot_bridge::Clocks :datatype-) "openpilot_bridge/Clocks")
(setf (get openpilot_bridge::Clocks :definition-)
      "Header header

int64 modemUptimeMillis
int64 wallTimeNanos
int64 bootTimeNanos
int64 monotonicRawNanos
int64 monotonicNanos

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



(provide :openpilot_bridge/Clocks "a00c35b464cff74388a274b01c607034")


