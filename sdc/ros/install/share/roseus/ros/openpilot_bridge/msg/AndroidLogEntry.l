;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::AndroidLogEntry)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'AndroidLogEntry (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ANDROIDLOGENTRY")
  (make-package "OPENPILOT_BRIDGE::ANDROIDLOGENTRY"))

(in-package "ROS")
;;//! \htmlinclude AndroidLogEntry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::AndroidLogEntry
  :super ros::object
  :slots (_header _pid _ts _priority _tag _tid _message _id ))

(defmethod openpilot_bridge::AndroidLogEntry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:pid __pid) 0)
    ((:ts __ts) 0)
    ((:priority __priority) 0)
    ((:tag __tag) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:tid __tid) 0)
    ((:message __message) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:id __id) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _pid (round __pid))
   (setq _ts (round __ts))
   (setq _priority (round __priority))
   (setq _tag __tag)
   (setq _tid (round __tid))
   (setq _message __message)
   (setq _id (round __id))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:pid
   (&optional __pid)
   (if __pid (setq _pid __pid)) _pid)
  (:ts
   (&optional __ts)
   (if __ts (setq _ts __ts)) _ts)
  (:priority
   (&optional __priority)
   (if __priority (setq _priority __priority)) _priority)
  (:tag
   (&optional __tag)
   (if __tag (setq _tag __tag)) _tag)
  (:tid
   (&optional __tid)
   (if __tid (setq _tid __tid)) _tid)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _pid
    4
    ;; int64 _ts
    8
    ;; int64 _priority
    8
    ;; string[] _tag
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _tag)) 4
    ;; int32 _tid
    4
    ;; string[] _message
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _message)) 4
    ;; int64 _id
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _pid
       (write-long _pid s)
     ;; int64 _ts
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _ts (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _ts) (= (length (_ts . bv)) 2)) ;; bignum
              (write-long (ash (elt (_ts . bv) 0) 0) s)
              (write-long (ash (elt (_ts . bv) 1) -1) s))
             ((and (class _ts) (= (length (_ts . bv)) 1)) ;; big1
              (write-long (elt (_ts . bv) 0) s)
              (write-long (if (>= _ts 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _ts s)(write-long (if (>= _ts 0) 0 #xffffffff) s)))
     ;; int64 _priority
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _priority (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _priority) (= (length (_priority . bv)) 2)) ;; bignum
              (write-long (ash (elt (_priority . bv) 0) 0) s)
              (write-long (ash (elt (_priority . bv) 1) -1) s))
             ((and (class _priority) (= (length (_priority . bv)) 1)) ;; big1
              (write-long (elt (_priority . bv) 0) s)
              (write-long (if (>= _priority 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _priority s)(write-long (if (>= _priority 0) 0 #xffffffff) s)))
     ;; string[] _tag
     (write-long (length _tag) s)
     (dolist (elem _tag)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32 _tid
       (write-long _tid s)
     ;; string[] _message
     (write-long (length _message) s)
     (dolist (elem _message)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _id
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _id (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _id) (= (length (_id . bv)) 2)) ;; bignum
              (write-long (ash (elt (_id . bv) 0) 0) s)
              (write-long (ash (elt (_id . bv) 1) -1) s))
             ((and (class _id) (= (length (_id . bv)) 1)) ;; big1
              (write-long (elt (_id . bv) 0) s)
              (write-long (if (>= _id 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _id s)(write-long (if (>= _id 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _pid
     (setq _pid (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _ts
#+(or :alpha :irix6 :x86_64)
      (setf _ts (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _ts (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _priority
#+(or :alpha :irix6 :x86_64)
      (setf _priority (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _priority (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _tag
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _tag (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _tag i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32 _tid
     (setq _tid (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string[] _message
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _message (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _message i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _id
#+(or :alpha :irix6 :x86_64)
      (setf _id (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _id (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::AndroidLogEntry :md5sum-) "4b124521ab088e83f9d361692dbf5495")
(setf (get openpilot_bridge::AndroidLogEntry :datatype-) "openpilot_bridge/AndroidLogEntry")
(setf (get openpilot_bridge::AndroidLogEntry :definition-)
      "Header header

int32 pid
int64 ts
int64 priority
string[] tag
int32 tid
string[] message
int64 id

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



(provide :openpilot_bridge/AndroidLogEntry "4b124521ab088e83f9d361692dbf5495")


