;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::LidarPts)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'LidarPts (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::LIDARPTS")
  (make-package "OPENPILOT_BRIDGE::LIDARPTS"))

(in-package "ROS")
;;//! \htmlinclude LidarPts.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::LidarPts
  :super ros::object
  :slots (_header _reflect _theta _r _pkt _idx ))

(defmethod openpilot_bridge::LidarPts
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:reflect __reflect) (make-array 0 :initial-element 0 :element-type :integer))
    ((:theta __theta) (make-array 0 :initial-element 0 :element-type :integer))
    ((:r __r) (make-array 0 :initial-element 0 :element-type :integer))
    ((:pkt __pkt) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:idx __idx) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _reflect __reflect)
   (setq _theta __theta)
   (setq _r __r)
   (setq _pkt __pkt)
   (setq _idx (round __idx))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:reflect
   (&optional __reflect)
   (if __reflect (setq _reflect __reflect)) _reflect)
  (:theta
   (&optional __theta)
   (if __theta (setq _theta __theta)) _theta)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:pkt
   (&optional __pkt)
   (if __pkt (setq _pkt __pkt)) _pkt)
  (:idx
   (&optional __idx)
   (if __idx (setq _idx __idx)) _idx)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64[] _reflect
    (* 8    (length _reflect)) 4
    ;; int64[] _theta
    (* 8    (length _theta)) 4
    ;; int64[] _r
    (* 8    (length _r)) 4
    ;; string[] _pkt
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _pkt)) 4
    ;; int64 _idx
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64[] _reflect
     (write-long (length _reflect) s)
     (dotimes (i (length _reflect))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _reflect i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _reflect i)) (= (length ((elt _reflect i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _reflect i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _reflect i) . bv) 1) -1) s))
             ((and (class (elt _reflect i)) (= (length ((elt _reflect i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _reflect i) . bv) 0) s)
              (write-long (if (>= (elt _reflect i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _reflect i) s)(write-long (if (>= (elt _reflect i) 0) 0 #xffffffff) s)))
       )
     ;; int64[] _theta
     (write-long (length _theta) s)
     (dotimes (i (length _theta))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _theta i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _theta i)) (= (length ((elt _theta i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _theta i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _theta i) . bv) 1) -1) s))
             ((and (class (elt _theta i)) (= (length ((elt _theta i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _theta i) . bv) 0) s)
              (write-long (if (>= (elt _theta i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _theta i) s)(write-long (if (>= (elt _theta i) 0) 0 #xffffffff) s)))
       )
     ;; int64[] _r
     (write-long (length _r) s)
     (dotimes (i (length _r))
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke (elt _r i) (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class (elt _r i)) (= (length ((elt _r i) . bv)) 2)) ;; bignum
              (write-long (ash (elt ((elt _r i) . bv) 0) 0) s)
              (write-long (ash (elt ((elt _r i) . bv) 1) -1) s))
             ((and (class (elt _r i)) (= (length ((elt _r i) . bv)) 1)) ;; big1
              (write-long (elt ((elt _r i) . bv) 0) s)
              (write-long (if (>= (elt _r i) 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long (elt _r i) s)(write-long (if (>= (elt _r i) 0) 0 #xffffffff) s)))
       )
     ;; string[] _pkt
     (write-long (length _pkt) s)
     (dolist (elem _pkt)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int64 _idx
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _idx (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _idx) (= (length (_idx . bv)) 2)) ;; bignum
              (write-long (ash (elt (_idx . bv) 0) 0) s)
              (write-long (ash (elt (_idx . bv) 1) -1) s))
             ((and (class _idx) (= (length (_idx . bv)) 1)) ;; big1
              (write-long (elt (_idx . bv) 0) s)
              (write-long (if (>= _idx 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _idx s)(write-long (if (>= _idx 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64[] _reflect
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _reflect (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _reflect i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _reflect i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64[] _theta
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _theta (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _theta i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _theta i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; int64[] _r
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _r (instantiate integer-vector n))
     (dotimes (i n)
#+(or :alpha :irix6 :x86_64)
      (setf (elt _r i) (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf (elt _r i) (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
     ))
   ;; string[] _pkt
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _pkt (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _pkt i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int64 _idx
#+(or :alpha :irix6 :x86_64)
      (setf _idx (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _idx (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::LidarPts :md5sum-) "da97df91c5556c584248994eba8b3d23")
(setf (get openpilot_bridge::LidarPts :datatype-) "openpilot_bridge/LidarPts")
(setf (get openpilot_bridge::LidarPts :definition-)
      "Header header

int64[] reflect
int64[] theta
int64[] r
string[] pkt
int64 idx

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



(provide :openpilot_bridge/LidarPts "da97df91c5556c584248994eba8b3d23")


