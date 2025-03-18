;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::Boot)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'Boot (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::BOOT")
  (make-package "OPENPILOT_BRIDGE::BOOT"))

(in-package "ROS")
;;//! \htmlinclude Boot.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::Boot
  :super ros::object
  :slots (_header _wallTimeNanos _lastKmsg _lastPmsg ))

(defmethod openpilot_bridge::Boot
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:wallTimeNanos __wallTimeNanos) 0)
    ((:lastKmsg __lastKmsg) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:lastPmsg __lastPmsg) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _wallTimeNanos (round __wallTimeNanos))
   (setq _lastKmsg __lastKmsg)
   (setq _lastPmsg __lastPmsg)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:wallTimeNanos
   (&optional __wallTimeNanos)
   (if __wallTimeNanos (setq _wallTimeNanos __wallTimeNanos)) _wallTimeNanos)
  (:lastKmsg
   (&optional __lastKmsg)
   (if __lastKmsg (setq _lastKmsg __lastKmsg)) _lastKmsg)
  (:lastPmsg
   (&optional __lastPmsg)
   (if __lastPmsg (setq _lastPmsg __lastPmsg)) _lastPmsg)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _wallTimeNanos
    8
    ;; string[] _lastKmsg
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _lastKmsg)) 4
    ;; string[] _lastPmsg
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _lastPmsg)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
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
     ;; string[] _lastKmsg
     (write-long (length _lastKmsg) s)
     (dolist (elem _lastKmsg)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _lastPmsg
     (write-long (length _lastPmsg) s)
     (dolist (elem _lastPmsg)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
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
   ;; string[] _lastKmsg
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lastKmsg (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _lastKmsg i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _lastPmsg
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lastPmsg (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _lastPmsg i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::Boot :md5sum-) "7d01aef315d1640ba9089c1530d651c3")
(setf (get openpilot_bridge::Boot :datatype-) "openpilot_bridge/Boot")
(setf (get openpilot_bridge::Boot :definition-)
      "Header header

int64 wallTimeNanos
string[] lastKmsg
string[] lastPmsg

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



(provide :openpilot_bridge/Boot "7d01aef315d1640ba9089c1530d651c3")


