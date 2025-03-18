;; Auto-generated. Do not edit!


(when (boundp 'openpilot_bridge::OrbOdometry)
  (if (not (find-package "OPENPILOT_BRIDGE"))
    (make-package "OPENPILOT_BRIDGE"))
  (shadow 'OrbOdometry (find-package "OPENPILOT_BRIDGE")))
(unless (find-package "OPENPILOT_BRIDGE::ORBODOMETRY")
  (make-package "OPENPILOT_BRIDGE::ORBODOMETRY"))

(in-package "ROS")
;;//! \htmlinclude OrbOdometry.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass openpilot_bridge::OrbOdometry
  :super ros::object
  :slots (_header _endMonoTime _err _f _matches _inliers _startMonoTime ))

(defmethod openpilot_bridge::OrbOdometry
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:endMonoTime __endMonoTime) 0)
    ((:err __err) 0.0)
    ((:f __f) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:matches __matches) (make-array 0 :initial-element 0 :element-type :integer))
    ((:inliers __inliers) 0)
    ((:startMonoTime __startMonoTime) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _endMonoTime (round __endMonoTime))
   (setq _err (float __err))
   (setq _f __f)
   (setq _matches __matches)
   (setq _inliers (round __inliers))
   (setq _startMonoTime (round __startMonoTime))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:endMonoTime
   (&optional __endMonoTime)
   (if __endMonoTime (setq _endMonoTime __endMonoTime)) _endMonoTime)
  (:err
   (&optional __err)
   (if __err (setq _err __err)) _err)
  (:f
   (&optional __f)
   (if __f (setq _f __f)) _f)
  (:matches
   (&optional __matches)
   (if __matches (setq _matches __matches)) _matches)
  (:inliers
   (&optional __inliers)
   (if __inliers (setq _inliers __inliers)) _inliers)
  (:startMonoTime
   (&optional __startMonoTime)
   (if __startMonoTime (setq _startMonoTime __startMonoTime)) _startMonoTime)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int64 _endMonoTime
    8
    ;; float32 _err
    4
    ;; float32[] _f
    (* 4    (length _f)) 4
    ;; int32[] _matches
    (* 4    (length _matches)) 4
    ;; int32 _inliers
    4
    ;; int64 _startMonoTime
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int64 _endMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _endMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _endMonoTime) (= (length (_endMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_endMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_endMonoTime . bv) 1) -1) s))
             ((and (class _endMonoTime) (= (length (_endMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_endMonoTime . bv) 0) s)
              (write-long (if (>= _endMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _endMonoTime s)(write-long (if (>= _endMonoTime 0) 0 #xffffffff) s)))
     ;; float32 _err
       (sys::poke _err (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _f
     (write-long (length _f) s)
     (dotimes (i (length _f))
       (sys::poke (elt _f i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32[] _matches
     (write-long (length _matches) s)
     (dotimes (i (length _matches))
       (write-long (elt _matches i) s)
       )
     ;; int32 _inliers
       (write-long _inliers s)
     ;; int64 _startMonoTime
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _startMonoTime (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _startMonoTime) (= (length (_startMonoTime . bv)) 2)) ;; bignum
              (write-long (ash (elt (_startMonoTime . bv) 0) 0) s)
              (write-long (ash (elt (_startMonoTime . bv) 1) -1) s))
             ((and (class _startMonoTime) (= (length (_startMonoTime . bv)) 1)) ;; big1
              (write-long (elt (_startMonoTime . bv) 0) s)
              (write-long (if (>= _startMonoTime 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _startMonoTime s)(write-long (if (>= _startMonoTime 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int64 _endMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _endMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _endMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _err
     (setq _err (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _f
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _f (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _f i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32[] _matches
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _matches (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _matches i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; int32 _inliers
     (setq _inliers (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int64 _startMonoTime
#+(or :alpha :irix6 :x86_64)
      (setf _startMonoTime (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _startMonoTime (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
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

(setf (get openpilot_bridge::OrbOdometry :md5sum-) "36d7f564012932b3e82132f0ca864b87")
(setf (get openpilot_bridge::OrbOdometry :datatype-) "openpilot_bridge/OrbOdometry")
(setf (get openpilot_bridge::OrbOdometry :definition-)
      "Header header

int64 endMonoTime
float32 err
float32[] f
int32[] matches
int32 inliers
int64 startMonoTime

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



(provide :openpilot_bridge/OrbOdometry "36d7f564012932b3e82132f0ca864b87")


