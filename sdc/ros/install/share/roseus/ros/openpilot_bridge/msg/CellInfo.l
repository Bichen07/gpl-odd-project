;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::CellInfo)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'CellInfo (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::CELLINFO")
  (make-package "OPENPILOT_BRIDGE::CELLINFO"))

(in-package "ROS")
;;//! \htmlinclude CellInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::CellInfo
  :super ros::object
  :slots (_header _timestamp _repr ))

(defmethod openpilot_bridge::CellInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:timestamp __timestamp) 0)
    ((:repr __repr) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _timestamp (round __timestamp))
   (setq _repr __repr)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:repr
   (&optional __repr)
   (if __repr (setq _repr __repr)) _repr)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _timestamp
    8
    ;; string[] _repr
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _repr)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _timestamp
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _timestamp (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _timestamp) (= (length (_timestamp . bv)) 2)) ;; bignum
              (write-long (ash (elt (_timestamp . bv) 0) 0) s)
              (write-long (ash (elt (_timestamp . bv) 1) -1) s))
             ((and (class _timestamp) (= (length (_timestamp . bv)) 1)) ;; big1
              (write-long (elt (_timestamp . bv) 0) s)
              (write-long (if (>= _timestamp 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _timestamp s)(write-long (if (>= _timestamp 0) 0 #xffffffff) s)))
     ;; string[] _repr
     (write-long (length _repr) s)
     (dolist (elem _repr)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _timestamp
#+(or :alpha :irix6 :x86_64)
      (setf _timestamp (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _timestamp (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; string[] _repr
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _repr (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _repr i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get openpilot_bridge::CellInfo :md5sum-) "df506af7751f0cd30e1b2e25c998d0a0")
(setf (get openpilot_bridge::CellInfo :datatype-) "openpilot_bridge/CellInfo")
(setf (get openpilot_bridge::CellInfo :definition-)
      "Header header

int64 timestamp
string[] repr

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



(provide :openpilot_bridge/CellInfo "df506af7751f0cd30e1b2e25c998d0a0")


